unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, System.StrUtils, thsEdit, thsComboBox;

type
  TfrmMainClassGenerator = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtUnitName: TthsEdit;
    edtClassType: TthsEdit;
    edtTableName: TthsEdit;
    edtSourceCode: TthsEdit;
    btnCreateFile: TButton;
    btnAddMemo: TButton;
    strngrdList: TStringGrid;
    btnAddField: TButton;
    btnClearLists: TButton;
    edtCaption: TthsEdit;
    lblCaption: TLabel;
    cbbFieldType: TthsCombobox;
    lblFieldType: TLabel;
    edtFieldName: TthsEdit;
    lblFieldName: TLabel;
    edtpropertyname: TthsEdit;
    lblpropertyname: TLabel;
    Memo1: TMemo;
    procedure btnClearListsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddFieldClick(Sender: TObject);
    procedure btnAddMemoClick(Sender: TObject);
    procedure btnCreateFileClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainClassGenerator: TfrmMainClassGenerator;

implementation

{$R *.dfm}

procedure TfrmMainClassGenerator.btnAddFieldClick(Sender: TObject);
begin
  strngrdList.Cells[0,strngrdList.RowCount-1] := edtpropertyname.Text;
  strngrdList.Cells[1,strngrdList.RowCount-1] := edtFieldName.Text;
  strngrdList.Cells[2,strngrdList.RowCount-1] := cbbFieldType.Text;
  strngrdList.Cells[3,strngrdList.RowCount-1] := edtCaption.Text;

  strngrdList.RowCount := strngrdList.RowCount + 1;

  edtpropertyname.Clear;
  edtFieldName.Clear;
  cbbFieldType.ItemIndex := -1;
  edtCaption.Clear;

  edtpropertyname.SetFocus;
end;

procedure TfrmMainClassGenerator.btnAddMemoClick(Sender: TObject);
var
  n1: Integer;
begin
  if strngrdList.Cells[0, strngrdList.RowCount-1] = '' then
    strngrdList.RowCount := strngrdList.RowCount-1;

  Memo1.Clear;
  Memo1.Lines.Add('unit ' + edtUnitName.Text + ';');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('interface');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('uses');
  Memo1.Lines.Add('  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,');
  Memo1.Lines.Add('  FireDAC.Stan.Param, System.Variants, Data.DB,');
  Memo1.Lines.Add('  Ths.Erp.Database,');
  Memo1.Lines.Add('  Ths.Erp.Database.Table,');
  Memo1.Lines.Add('  Ths.Erp.Database.Table.Field;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('type');
  Memo1.Lines.Add('  ' + edtClassType.Text + ' = class(TTable)');
  Memo1.Lines.Add('  private');
  for n1 := 0 to strngrdList.RowCount-1 do
  Memo1.Lines.Add('    F' + strngrdList.Cells[0,n1] + ': TFieldDB;');
  Memo1.Lines.Add('  protected');
  Memo1.Lines.Add('  published');
  Memo1.Lines.Add('    constructor Create(OwnerDatabase:TDatabase);override;');
  Memo1.Lines.Add('  public');
  Memo1.Lines.Add('    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;');
  Memo1.Lines.Add('    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;');
  Memo1.Lines.Add('    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;');
  Memo1.Lines.Add('    procedure Update(pPermissionControl: Boolean=True); override;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('    procedure Clear();override;');
  Memo1.Lines.Add('    function Clone():TTable;override;');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
  Memo1.Lines.Add('    property ' + strngrdList.Cells[0,n1] + ': TFieldDB read F' + strngrdList.Cells[0,n1] + ' write F' + strngrdList.Cells[0,n1] + ';');
  Memo1.Lines.Add('  end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('implementation');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('uses');
  Memo1.Lines.Add('  Ths.Erp.Constants;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('constructor ' + edtClassType.Text + '.Create(OwnerDatabase:TDatabase);');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  inherited Create(OwnerDatabase);');
  Memo1.Lines.Add('  TableName := ' + QuotedStr(edtTableName.Text) + ';');
  Memo1.Lines.Add('  SourceCode := ' + edtSourceCode.Text + ';');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
  begin
    if (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[0])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[1])
    then
      Memo1.Lines.Add('  F' + strngrdList.Cells[0,n1] + ' := TFieldDB.Create(' + strngrdList.Cells[1,n1] + ', ' + strngrdList.Cells[2,n1] + ', '''');')
    else
    if (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[2])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[3])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[4])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[5])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[6])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[7])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[8])
    then
      Memo1.Lines.Add('  F' + strngrdList.Cells[0,n1] + ' := TFieldDB.Create(' + strngrdList.Cells[1,n1] + ', ' + strngrdList.Cells[2,n1] + ', 0);')
    else
    if (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[9]) then
      Memo1.Lines.Add('  F' + strngrdList.Cells[0,n1] + ' := TFieldDB.Create(' + strngrdList.Cells[1,n1] + ', ' + strngrdList.Cells[2,n1] + ', False);')
  end;
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('procedure ' + edtClassType.Text + '.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  if Self.IsAuthorized(ptRead, pPermissionControl) then');
  Memo1.Lines.Add('  begin');
  Memo1.Lines.Add('    with QueryOfTable do');
  Memo1.Lines.Add('    begin');
  Memo1.Lines.Add('    Close;');
  Memo1.Lines.Add('      SQL.Clear;');
  Memo1.Lines.Add('      SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [');
  Memo1.Lines.Add('        TableName + ''.'' + Self.Id.FieldName,');
  for n1 := 0 to strngrdList.RowCount-1 do
  begin
  Memo1.Lines.Add('        TableName + ''.'' + F' + strngrdList.Cells[0,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    Memo1.Lines.Strings[Memo1.Lines.Count-1] := LeftStr(Memo1.Lines.Strings[Memo1.Lines.Count-1], Length(Memo1.Lines.Strings[Memo1.Lines.Count-1])-1);
  end;
  Memo1.Lines.Add('      ]) +');
  Memo1.Lines.Add('      ''WHERE 1=1 '' + pFilter;');
  Memo1.Lines.Add('      Open;');
	Memo1.Lines.Add('      Active := True;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := ''ID'';');
  for n1 := 0 to strngrdList.RowCount-1 do
  Memo1.Lines.Add('      Self.DataSource.DataSet.FindField(F' + strngrdList.Cells[0,n1] + '.FieldName).DisplayLabel := ''' + strngrdList.Cells[3,n1] + ''';');
  Memo1.Lines.Add('    end;');
  Memo1.Lines.Add('  end;');
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('procedure ' + edtClassType.Text + '.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  if Self.IsAuthorized(ptRead, pPermissionControl) then');
  Memo1.Lines.Add('  begin');
  Memo1.Lines.Add('    if (pLock) then');
  Memo1.Lines.Add('      pFilter := pFilter + '' FOR UPDATE NOWAIT; '';');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('    with QueryOfTable do');
  Memo1.Lines.Add('    begin');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('      SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [');
  Memo1.Lines.Add('        TableName + ''.'' + Self.Id.FieldName,');
  for n1 := 0 to strngrdList.RowCount-1 do
  begin
  Memo1.Lines.Add('        TableName + ''.'' + F' + strngrdList.Cells[0,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    Memo1.Lines.Strings[Memo1.Lines.Count-1] := LeftStr(Memo1.Lines.Strings[Memo1.Lines.Count-1], Length(Memo1.Lines.Strings[Memo1.Lines.Count-1])-1);
  end;
  Memo1.Lines.Add('      ]) +');
  Memo1.Lines.Add('      ''WHERE 1=1 '' + pFilter;');
  Memo1.Lines.Add('      Open;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      FreeListContent();');
  Memo1.Lines.Add('      List.Clear;');
  Memo1.Lines.Add('      while NOT EOF do');
  Memo1.Lines.Add('      begin');
  Memo1.Lines.Add('        Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
  Memo1.Lines.Add('        Self.F' + strngrdList.Cells[0,n1] + '.Value := FieldByName(F' + strngrdList.Cells[0,n1] + '.FieldName).AsString;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('        List.Add(Self.Clone());');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('        Next;');
  Memo1.Lines.Add('      end;');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('    end;');
  Memo1.Lines.Add('  end;');
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('procedure ' + edtClassType.Text + '.Insert(out pID: Integer; pPermissionControl: Boolean=True);');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then');
  Memo1.Lines.Add('  begin');
  Memo1.Lines.Add('    with QueryOfTable do');
  Memo1.Lines.Add('    begin');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('      SQL.Clear;');
  Memo1.Lines.Add('      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [');
  for n1 := 0 to strngrdList.RowCount-1 do
  begin
  Memo1.Lines.Add('        F' + strngrdList.Cells[0,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    Memo1.Lines.Strings[Memo1.Lines.Count-1] := LeftStr(Memo1.Lines.Strings[Memo1.Lines.Count-1], Length(Memo1.Lines.Strings[Memo1.Lines.Count-1])-1);
  end;
  Memo1.Lines.Add('      ]) +');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
    Memo1.Lines.Add('      ParamByName(F' + strngrdList.Cells[0,n1] + '.FieldName).Value := Self.F' + strngrdList.Cells[0,n1] + '.Value;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      Database.SetQueryParamsDefaultValue(QueryOfTable);');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      Open;');
  Memo1.Lines.Add('      if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.FieldName).IsNull) then');
  Memo1.Lines.Add('        pID := Fields.FieldByName(Self.Id.FieldName).AsInteger');
  Memo1.Lines.Add('      else');
  Memo1.Lines.Add('        pID := 0;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      EmptyDataSet;');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('    end;');
  Memo1.Lines.Add('    Self.notify;');
  Memo1.Lines.Add('  end;');
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('procedure ' + edtClassType.Text + '.Update(pPermissionControl: Boolean=True);');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  if Self.IsAuthorized(ptUpdate, pPermissionControl) then');
  Memo1.Lines.Add('  begin');
  Memo1.Lines.Add('    with QueryOfTable do');
  Memo1.Lines.Add('    begin');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('      SQL.Clear;');
  Memo1.Lines.Add('      SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [');
  for n1 := 0 to strngrdList.RowCount-1 do
  begin
  Memo1.Lines.Add('        F' + strngrdList.Cells[0,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    Memo1.Lines.Strings[Memo1.Lines.Count-1] := LeftStr(Memo1.Lines.Strings[Memo1.Lines.Count-1], Length(Memo1.Lines.Strings[Memo1.Lines.Count-1])-1);
  end;
  Memo1.Lines.Add('      ]) +');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
    Memo1.Lines.Add('      ParamByName(F' + strngrdList.Cells[0,n1] + '.FieldName).Value := Self.F' + strngrdList.Cells[0,n1] + '.Value;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      Database.SetQueryParamsDefaultValue(QueryOfTable);');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      ExecSQL;');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('    end;');
  Memo1.Lines.Add('  Self.notify;');
  Memo1.Lines.Add('  end;');
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('procedure ' + edtClassType.Text + '.Update(pPermissionControl: Boolean=True);');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  if Self.IsAuthorized(ptUpdate, pPermissionControl) then');
  Memo1.Lines.Add('  begin');
  Memo1.Lines.Add('    with QueryOfTable do');
  Memo1.Lines.Add('    begin');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('      SQL.Clear;');
  Memo1.Lines.Add('      SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [');
  for n1 := 0 to strngrdList.RowCount-1 do
  begin
  Memo1.Lines.Add('        F' + strngrdList.Cells[0,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    Memo1.Lines.Strings[Memo1.Lines.Count-1] := LeftStr(Memo1.Lines.Strings[Memo1.Lines.Count-1], Length(Memo1.Lines.Strings[Memo1.Lines.Count-1])-1);
  end;
  Memo1.Lines.Add('      ]) +');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
    Memo1.Lines.Add('      ParamByName(F' + strngrdList.Cells[0,n1] + '.FieldName).Value := Self.F' + strngrdList.Cells[0,n1] + '.Value;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      Database.SetQueryParamsDefaultValue(QueryOfTable);');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('      ExecSQL;');
  Memo1.Lines.Add('      Close;');
  Memo1.Lines.Add('    end;');
  Memo1.Lines.Add('  Self.notify;');
  Memo1.Lines.Add('  end;');
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('procedure ' + edtClassType.Text + '.Clear();');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  inherited;');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
  begin
    if (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[0])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[1])
    then
      Memo1.Lines.Add('  Self.F' + strngrdList.Cells[0, n1] + ' := ' + ''''';')
    else
    if (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[2])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[3])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[4])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[5])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[6])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[7])
    or (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[8])
    then
      Memo1.Lines.Add('  F' + strngrdList.Cells[0, n1] + ' := ' + '''0'';')
    else
    if (strngrdList.Cells[2, n1] = cbbFieldType.Items.Strings[9]) then
      Memo1.Lines.Add('  F' + strngrdList.Cells[0, n1] + ' := ' + 'False;')
  end;
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('function ' + edtClassType.Text + '.Clone():TTable;');
  Memo1.Lines.Add('begin');
  Memo1.Lines.Add('  Result := ' + edtClassType.Text + '.Create(Database);');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('  Self.Id.Clone(' + edtClassType.Text + '(Result).Id);');
  Memo1.Lines.Add('');
  for n1 := 0 to strngrdList.RowCount-1 do
  Memo1.Lines.Add('  Self.F' + strngrdList.Cells[0,n1] + '.Clone(' + edtClassType.Text + '(Result).F' + strngrdList.Cells[0,n1] + ');');
  Memo1.Lines.Add('end;');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('end.');
end;

procedure TfrmMainClassGenerator.btnClearListsClick(Sender: TObject);
begin
  strngrdList.RowCount := 1;
  strngrdList.Cells[0,0].Empty;
  strngrdList.Cells[1,0].Empty;
  strngrdList.Cells[2,0].Empty;
  strngrdList.Cells[3,0].Empty;
end;

procedure TfrmMainClassGenerator.btnCreateFileClick(Sender: TObject);
var
  vSaveDlg: TSaveDialog;
begin
  vSaveDlg := TSaveDialog.Create(nil);
  try
    if not vSaveDlg.Execute then
      Memo1.Lines.SaveToFile(vSaveDlg.FileName);
  finally
    vSaveDlg.Free;
  end;
end;

procedure TfrmMainClassGenerator.FormCreate(Sender: TObject);
begin
  strngrdList.RowCount := 1;
end;

procedure TfrmMainClassGenerator.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  if GetKeyState( VK_CONTROL ) < 0 then
  begin
    Memo1.SelectAll;
    Key := #0;
  end;
end;

end.
