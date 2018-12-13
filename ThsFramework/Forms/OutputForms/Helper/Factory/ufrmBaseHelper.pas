unit ufrmBaseHelper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Option,

  Ths.Erp.Helper.Edit,

  ufrmBaseDBGrid,
  ufrmBase,

  Ths.Erp.Database.Table;

type
  TfrmBaseHelper = class(TfrmBaseDBGrid)
    lblFilter: TLabel;
    edtFilter: TEdit;
    procedure edtFilterChange(Sender: TObject);
    procedure edtFilterKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FDataAktar: Boolean;
    FFilterQuick: string;
    FFilterStringFields: TStringList;
    FFilterNumericFields: TStringList;
    FFilterDateFields: TStringList;
    FFilterBoolFields: TStringList;
  public
    property DataAktar: Boolean read FDataAktar write FDataAktar;

  published
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
    procedure dbgrdBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure FormKeyPress(Sender: TObject; var Key: Char); override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure dbgrdBaseDblClick(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
    procedure SelectCurrentRecord();
    procedure WmAfterShow(var Msg: TMessage); override;
    function getFilterEditData(): string; virtual;
  end;

implementation

uses
  Ths.Erp.Functions
//  , Ths.Erp.Database.Singleton
  , ufrmBaseInputDB
  ;

{$R *.dfm}

procedure TfrmBaseHelper.dbgrdBaseDblClick(Sender: TObject);
begin
  SelectCurrentRecord;
end;

procedure TfrmBaseHelper.dbgrdBaseKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

procedure TfrmBaseHelper.edtFilterChange(Sender: TObject);
var
  n1: Integer;
  vValInt: Integer;
  vValDbl: Double;
  vValBool: Boolean;
  vValDateTime: TDateTime;
  vFilter: string;
begin
  vFilter := '';
  dbgrdBase.DataSource.DataSet.Filter := vFilter;
  dbgrdBase.DataSource.DataSet.Filtered := False;

  if edtFilter.Text <> '' then
  begin
    if CheckString(edtFilter.Text) then
    begin
      for n1 := 0 to FFilterStringFields.Count-1 do
      begin
        if vFilter <> '' then
          vFilter := vFilter + ' OR ';
        vFilter := vFilter + FFilterStringFields.Strings[n1] + ' LIKE ' + QuotedStr('%' + TFunctions.UpperCaseTr(edtFilter.Text) + '%');
        vFilter := vFilter + ' OR ' + FFilterStringFields.Strings[n1] + ' LIKE ' + QuotedStr('%' + TFunctions.LowerCaseTr(edtFilter.Text) + '%');
      end;
    end
    else
    if TryStrToInt(edtFilter.Text, vValInt) then
    begin

    end
    else
    if TryStrToFloat(edtFilter.Text, vValDbl) then
    begin

    end
    else
    if TryStrToBool(edtFilter.Text, vValBool) then
    begin

    end
    else
    if TryStrToDate(edtFilter.Text, vValDateTime) then
    begin

    end
    else
    if TryStrToTime(edtFilter.Text, vValDateTime) then
    begin

    end
    else
    if TryStrToDateTime(edtFilter.Text, vValDateTime) then
    begin

    end;

    dbgrdBase.DataSource.DataSet.Filter := vFilter;
    dbgrdBase.DataSource.DataSet.Filtered := True;
  end;
  WriteRecordCount(Table.DataSource.DataSet.RecordCount);
end;

procedure TfrmBaseHelper.edtFilterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  //helper için aþaðý yukarýda key up eventte sadece grid hareket etsin.
  //aþaðý yukarý yönler edit içinde selstart position deðiþimi yapmasýn
//  edtFilter.SelStart := Length(edtFilter.Text);
end;

procedure TfrmBaseHelper.edtFilterKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_DOWN) then
    dbgrdBase.DataSource.DataSet.Next
  else if (Key = VK_UP) or (Key = VK_UP) then
    dbgrdBase.DataSource.DataSet.Prior
  else
    inherited;
  //helper için aþaðý yukarýda key up eventte sadece grid hareket etsin.
  //aþaðý yukarý yönler edit içinde selstart position deðiþimi yapmasýn
//  edtFilter.SelStart := Length(edtFilter.Text);
end;

procedure TfrmBaseHelper.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataAktar then
  begin
    if Owner.ClassType = TEdit then
    begin
      if ParentForm.ClassParent = TfrmBaseInputDB then
      begin
        if ((ParentForm as TfrmBaseInputDB).FormMode = ifmNewRecord)
        or ((ParentForm as TfrmBaseInputDB).FormMode = ifmCopyNewRecord)
        or ((ParentForm as TfrmBaseInputDB).FormMode = ifmUpdate)
        then
        begin
          TEdit(Owner).Text := getFilterEditData;
          TEdit(Owner).SelStart := Length(TEdit(Owner).Text);
        end;
      end;
    end;
    inherited;
  end
  else
    inherited;
end;

procedure TfrmBaseHelper.FormCreate(Sender: TObject);
begin
  Table.QueryOfDS.FetchOptions.Mode := fmOnDemand;
  inherited;
  pnlHeader.Visible := True;
  lblFilter.Caption := 'Filter';
  edtFilter.Clear;
end;

procedure TfrmBaseHelper.FormDestroy(Sender: TObject);
begin
  TableHelper.Free;
  FFilterStringFields.Free;
  FFilterNumericFields.Free;
  FFilterDateFields.Free;
  FFilterBoolFields.Free;
  inherited;
end;

procedure TfrmBaseHelper.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F7 then
  begin
//    Key := 0;
  end
  else
    inherited;
end;

procedure TfrmBaseHelper.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(VK_RETURN)) then //Enter (Return)
  begin
    Key := #0;
    SelectCurrentRecord;
  end
  else if (Key = Char(VK_ESCAPE)) then //Escape (Close dont do any process)
  begin
    Key := #0;
    FDataAktar := False;
    btnCloseClick(btnClose);
  end
  else
    inherited;
end;

procedure TfrmBaseHelper.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
//
end;

procedure TfrmBaseHelper.FormShow(Sender: TObject);
var
  n1: Integer;
  vFilter: string;
begin
  FFilterQuick := '';
  FFilterStringFields := TStringList.Create;
  FFilterNumericFields := TStringList.Create;
  FFilterDateFields := TStringList.Create;
  FFilterBoolFields := TStringList.Create;

  if Assigned(Owner) then
  begin
    if Owner is TEdit then
    begin
      vFilter := TEdit(Owner).Text;
      edtFilter.Text := vFilter;
    end;
  end;

  inherited;
  edtFilter.SetFocus;
  dbgrdBase.PopupMenu := nil;
  dbgrdBase.TabStop := False;
  pnlButtons.Visible := False;
  FDataAktar := False;

  for n1 := 0 to dbgrdBase.Columns.Grid.FieldCount-1 do
  begin
    if (dbgrdBase.Columns.Grid.Fields[n1].DataType = ftString)
    or (dbgrdBase.Columns.Grid.Fields[n1].DataType = ftWideString)
    or (dbgrdBase.Columns.Grid.Fields[n1].DataType = ftMemo)
    or (dbgrdBase.Columns.Grid.Fields[n1].DataType = ftWideMemo)
    then
    begin
      FFilterStringFields.Add(dbgrdBase.Columns.Grid.Fields[n1].FieldName);
    end;
  end;

  edtFilter.OnChange := edtFilterChange;
end;

function TfrmBaseHelper.getFilterEditData: string;
begin
  Result := '';
end;

procedure TfrmBaseHelper.SelectCurrentRecord;
begin
  FDataAktar := True;
  SetSelectedItem;
  TableHelper := Table.Clone;
  btnCloseClick(btnClose);
end;

procedure TfrmBaseHelper.WmAfterShow(var Msg: TMessage);
begin
  edtFilterChange(edtFilter);
end;

end.
