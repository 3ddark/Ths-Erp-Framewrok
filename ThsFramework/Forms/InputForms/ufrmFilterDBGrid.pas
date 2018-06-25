unit ufrmFilterDBGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBase, Vcl.StdCtrls, Data.DB, thsEdit,
  Vcl.CheckLst, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin;

type
  TFieldName = class
  private
    FFieldName: string;
    FDataType: TFieldType;
  public
    property FieldName: string read FFieldName write FFieldName;
    property DataType: TFieldType read FDataType write FDataType;

    constructor Create(AValue: string; ADataType: TFieldType);
  end;

type
  TfrmFilterDBGrid = class(TfrmBase)
    lblFields: TLabel;
    chklstFields: TCheckListBox;
    edtFilter: TthsEdit;
    lblFilterKeyValue: TLabel;
    rgFilterCriter: TRadioGroup;
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  published
    procedure FormShow(Sender: TObject); override;
    procedure btnAcceptClick(Sender: TObject); override;
  end;

implementation

uses
  ufrmBaseDBGrid;

{$R *.dfm}

{ TFieldName }

constructor TFieldName.Create(AValue: string; ADataType: TFieldType);
begin
  FFieldName := AValue;
  FDataType:= ADataType;
end;

procedure TfrmFilterDBGrid.btnAcceptClick(Sender: TObject);
var
  n1: Integer;
  vFilter, vFilterCriter: string;
  vStartLike, vEndLike: string;
begin
  if edtFilter.Text <> '' then
  begin
    vFilter := '';
    vFilterCriter := '';
    vStartLike := '';
    vEndLike := '';

    case rgFilterCriter.ItemIndex of
      0: vFilterCriter := ' = ';
      1: begin vFilterCriter := ' LIKE '; vStartLike := '%'; vEndLike := '%'; end;
      2: begin vFilterCriter := ' NOT LIKE '; vStartLike := '%'; vEndLike := '%'; end;
      3: begin vFilterCriter := ' LIKE '; vStartLike := '%'; end;
      4: begin vFilterCriter := ' LIKE '; vEndLike := '%'; end;
      5: vFilterCriter := ' <> ';
      6: vFilterCriter := ' > ';
      7: vFilterCriter := ' < ';
      8: vFilterCriter := ' >= ';
      9: vFilterCriter := ' <= ';
    end;


    for n1 := 0 to chklstFields.Items.Count-1 do
    begin
      if chklstFields.Checked[n1] then
      begin
        if Assigned(chklstFields.Items.Objects[n1]) then
        begin
          if TFieldName(chklstFields.Items.Objects[n1]).FieldName <> '' then
          begin
            if vFilter <> '' then
              vFilter := vFilter + ' OR ';

            if (TFieldName(chklstFields.Items.Objects[n1]).DataType = ftString)
            or (TFieldName(chklstFields.Items.Objects[n1]).DataType = ftMemo)
            or (TFieldName(chklstFields.Items.Objects[n1]).DataType = ftFmtMemo)
            or (TFieldName(chklstFields.Items.Objects[n1]).DataType = ftFixedChar)
            or (TFieldName(chklstFields.Items.Objects[n1]).DataType = ftWideString)
            or (TFieldName(chklstFields.Items.Objects[n1]).DataType = ftWideMemo)
            or (TFieldName(chklstFields.Items.Objects[n1]).DataType = ftMemo)
            then
            begin
              vFilter := vFilter +
                         TFieldName(chklstFields.Items.Objects[n1]).FieldName +
                         vFilterCriter +
                         QuotedStr(vStartLike + edtFilter.Text + vEndLike);
            end;
          end;
        end;
      end;
    end;

    TfrmBaseDBGrid(ParentForm).FilterGrid := TfrmBaseDBGrid(ParentForm).FilterGrid + vFilter;

    Close;
  end;
end;

procedure TfrmFilterDBGrid.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  inherited;

  btnAccept.Visible := True;
  edtFilter.Clear;

  for n1 := 0 to TfrmBaseDBGrid(ParentForm).dbgrdBase.Columns.Count-1 do
  begin
    chklstFields.AddItem(
        TfrmBaseDBGrid(ParentForm).dbgrdBase.Columns[n1].Title.Caption,
        TFieldName.Create(TfrmBaseDBGrid(ParentForm).dbgrdBase.Columns[n1].FieldName,
                          TfrmBaseDBGrid(ParentForm).dbgrdBase.Columns[n1].Field.DataType) );
  end;
end;

procedure TfrmFilterDBGrid.FormShow(Sender: TObject);
begin
  inherited;
  btnAccept.Caption := 'FILTER';
end;

procedure TfrmFilterDBGrid.FormDestroy(Sender: TObject);
var
  n1: Integer;
begin
  for n1 := 0 to chklstFields.Items.Count-1 do
    if Assigned(chklstFields.Items.Objects[n1]) then
      chklstFields.Items.Objects[n1].Free;

  inherited;
end;

end.
