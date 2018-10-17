unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, System.StrUtils, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo;

const
  PROJECT_UNITNAME = 'Ths.Erp.Database.Table.';

  COL_ROW_NO = 0;
  COL_PROPERTY_NAME = 1;
  COL_FIELD_NAME = 2;
  COL_FIELD_TYPE = 3;
  COL_GRID_COL_CAPTION = 4;
  COL_INPUT_LABEL_CAPTION = 5;
  COL_GUI_CONTROL = 6;
  COL_CONTROL_TYPE = 7;

type
  TfrmMainClassGenerator = class(TForm)
    pnlTop: TPanel;
    strngrdList: TStringGrid;
    pgcMemos: TPageControl;
    tsClass: TTabSheet;
    mmoClass: TMemo;
    tsOutput: TTabSheet;
    tsInput: TTabSheet;
    pnlClass: TPanel;
    btnAddClassToMemo: TButton;
    pnlOutputDFM: TPanel;
    mmoOutputDFM: TMemo;
    pnlOutputBottomDFM: TPanel;
    btnAddOutputDFMToMemo: TButton;
    Splitter1: TSplitter;
    pnlOutputPAS: TPanel;
    mmoOutputPAS: TMemo;
    pnlOutputBottomPAS: TPanel;
    btnAddOutputPASToMemo: TButton;
    pnlInputDFM: TPanel;
    mmoInputDFM: TMemo;
    pnlInputBottomDFM: TPanel;
    btnAddInputDFMToMemo: TButton;
    Splitter2: TSplitter;
    pnlInputPAS: TPanel;
    mmoInputPAS: TMemo;
    pnlInputBottomPAS: TPanel;
    btnAddInputPASToMemo: TButton;
    Splitter3: TSplitter;
    pmBase: TPopupMenu;
    mniDeleteRow: TMenuItem;
    mniSaveToFile: TMenuItem;
    mniLoadFromFile: TMenuItem;
    pnlLeft: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblCaption: TLabel;
    lblFieldName: TLabel;
    lblFieldType: TLabel;
    lblpropertyname: TLabel;
    Label5: TLabel;
    lblOutputFormCaption: TLabel;
    lblOutputFormName: TLabel;
    lblInputFormName: TLabel;
    lblIsGUIControl: TLabel;
    lblControlType: TLabel;
    lblInputFormCaption: TLabel;
    lblInputLabelCaption: TLabel;
    edtMainProjectDirectory: TEdit;
    edtClassType: TEdit;
    edtTableName: TEdit;
    edtSourceCode: TEdit;
    edtOutputFormName: TEdit;
    edtOutputFormCaption: TEdit;
    edtInputFormName: TEdit;
    edtInputFormCaption: TEdit;
    edtpropertyname: TEdit;
    edtFieldName: TEdit;
    cbbFieldType: TComboBox;
    edtCaption: TEdit;
    chkIsGUIControl: TCheckBox;
    cbbControlType: TComboBox;
    btnAddField: TButton;
    btnClearLists: TButton;
    btnSaveToFiles: TButton;
    edtInputLabelCaption: TEdit;
    btnEditField: TButton;
    procedure btnClearListsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddFieldClick(Sender: TObject);
    procedure btnAddClassToMemoClick(Sender: TObject);
    procedure btnSaveToFilesClick(Sender: TObject);
    procedure edtMainProjectDirectoryDblClick(Sender: TObject);
    procedure btnAddOutputDFMToMemoClick(Sender: TObject);
    procedure mmoClassKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAddOutputPASToMemoClick(Sender: TObject);
    procedure btnAddInputDFMToMemoClick(Sender: TObject);
    procedure btnAddInputPASToMemoClick(Sender: TObject);
    procedure mniDeleteRowClick(Sender: TObject);
    procedure strngrdListRowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure chkIsGUIControlClick(Sender: TObject);
    procedure strngrdListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mniSaveToFileClick(Sender: TObject);
    procedure mniLoadFromFileClick(Sender: TObject);
    procedure strngrdListDblClick(Sender: TObject);
    procedure btnEditFieldClick(Sender: TObject);
  private
    FRowNo: Integer;

    procedure ReFillAndSort();
    procedure ClearGridList;
  public
    { Public declarations }
  end;

var
  frmMainClassGenerator: TfrmMainClassGenerator;

implementation

{$R *.dfm}

procedure TfrmMainClassGenerator.btnAddFieldClick(Sender: TObject);
begin
  strngrdList.Cells[COL_ROW_NO,strngrdList.RowCount-1] := (strngrdList.RowCount-1).ToString;
  strngrdList.Cells[COL_PROPERTY_NAME,strngrdList.RowCount-1] := edtpropertyname.Text;
  strngrdList.Cells[COL_FIELD_NAME,strngrdList.RowCount-1] := edtFieldName.Text;
  strngrdList.Cells[COL_FIELD_TYPE,strngrdList.RowCount-1] := cbbFieldType.Text;
  strngrdList.Cells[COL_GRID_COL_CAPTION,strngrdList.RowCount-1] := edtCaption.Text;
  strngrdList.Cells[COL_INPUT_LABEL_CAPTION,strngrdList.RowCount-1] := edtInputLabelCaption.Text;
  if chkIsGUIControl.Checked then
    strngrdList.Cells[COL_GUI_CONTROL,strngrdList.RowCount-1] := 'Yes'
  else
    strngrdList.Cells[COL_GUI_CONTROL,strngrdList.RowCount-1] := 'No';
  strngrdList.Cells[COL_CONTROL_TYPE,strngrdList.RowCount-1] := cbbControlType.Text;

  strngrdList.RowCount := strngrdList.RowCount + 1;

  edtpropertyname.Clear;
  edtFieldName.Clear;
  cbbFieldType.ItemIndex := -1;
  edtCaption.Clear;
  edtInputLabelCaption.Clear;
  chkIsGUIControl.Checked := False;
  chkIsGUIControlClick(chkIsGUIControl);
  cbbControlType.ItemIndex := -1;

  edtpropertyname.SetFocus;

  strngrdList.Top := strngrdList.RowCount-1;
  btnEditField.Enabled := False;
  FRowNo := -1;
end;

procedure TfrmMainClassGenerator.btnAddInputDFMToMemoClick(Sender: TObject);
var
  n1, vMaxCaptionLenght, vGuiCount, vOrder: Integer;

  function GetMaxCaptionLength(): Integer;
  var
    n2: Integer;
    vDump: Integer;
  begin
    Result := 0;
    for n2 := 1 to strngrdList.RowCount-1 do
    begin
      if strngrdList.Cells[COL_GUI_CONTROL, n2] = 'Yes' then
      begin
        vDump := Canvas.TextWidth(LowerCase(strngrdList.Cells[COL_GRID_COL_CAPTION, n2]));
        if Result < vDump then
          Result := vDump;
      end;
    end;
  end;

  function GetGuiControlCount(): Integer;
  var
    n2: Integer;
  begin
    Result := 0;
    for n2 := 1 to strngrdList.RowCount-1 do
    begin
      if strngrdList.Cells[COL_GUI_CONTROL, n2] = 'Yes' then
      begin
        Inc(Result);
      end;
    end;
  end;

begin
  vOrder := 0;
  vMaxCaptionLenght := GetMaxCaptionLength;
  vGuiCount := GetGuiControlCount;

  mmoInputDFM.Lines.Clear;
  mmoInputDFM.Lines.BeginUpdate;
  mmoInputDFM.Lines.Add('inherited frm' + edtInputFormName.Text + ': Tfrm' + edtInputFormName.Text);
  mmoInputDFM.Lines.Add('  Left = 501');
  mmoInputDFM.Lines.Add('  Top = 443');
  mmoInputDFM.Lines.Add('  ActiveControl = btnClose');
  mmoInputDFM.Lines.Add('  BorderIcons = [biSystemMenu, biMinimize]');
  mmoInputDFM.Lines.Add('  BorderStyle = bsSingle');
  mmoInputDFM.Lines.Add('  Caption = ' + QuotedStr(edtInputFormCaption.Text));
  mmoInputDFM.Lines.Add('  ClientHeight = ' + IntToStr(70 + vGuiCount * 25) );
  mmoInputDFM.Lines.Add('  ClientWidth = ' + IntToStr( 32 + vMaxCaptionLenght + 16 + 4 + 200 + 16 ));
  mmoInputDFM.Lines.Add('  Font.Name = ''MS Sans Serif''');
  mmoInputDFM.Lines.Add('  Position = poOwnerFormCenter');
  mmoInputDFM.Lines.Add('  ExplicitWidth = 383');
  mmoInputDFM.Lines.Add('  ExplicitHeight = 162');
  mmoInputDFM.Lines.Add('  PixelsPerInch = 96');
  mmoInputDFM.Lines.Add('  TextHeight = 13');
  mmoInputDFM.Lines.Add('  inherited pnlMain: TPanel');
  mmoInputDFM.Lines.Add('    Width = 357');
  mmoInputDFM.Lines.Add('    Height = 67');
  mmoInputDFM.Lines.Add('    Color = clWindow');
  mmoInputDFM.Lines.Add('    ParentBackground = True');
  mmoInputDFM.Lines.Add('    ExplicitWidth = 373');
  mmoInputDFM.Lines.Add('    ExplicitHeight = 67');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if strngrdList.Cells[COL_GUI_CONTROL, n1] = 'Yes' then
    begin
      mmoInputDFM.Lines.Add('    object lbl' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TLabel');
      mmoInputDFM.Lines.Add('      Left = ' + IntToStr(32 + vMaxCaptionLenght-Canvas.TextWidth( strngrdList.Cells[COL_INPUT_LABEL_CAPTION, n1] )) );
      mmoInputDFM.Lines.Add('      Top = ' + (6+(vOrder*22)).ToString);
      mmoInputDFM.Lines.Add('      Width = ' + IntToStr(Canvas.TextWidth(strngrdList.Cells[COL_INPUT_LABEL_CAPTION, n1]) + 16) );
      mmoInputDFM.Lines.Add('      Height = 13');
      mmoInputDFM.Lines.Add('      Alignment = taRightJustify');
      mmoInputDFM.Lines.Add('      BiDiMode = bdLeftToRight');
      mmoInputDFM.Lines.Add('      Caption = ' + QuotedStr(strngrdList.Cells[COL_INPUT_LABEL_CAPTION, n1]) );
      mmoInputDFM.Lines.Add('      Font.Charset = DEFAULT_CHARSET');
      mmoInputDFM.Lines.Add('      Font.Color = clWindowText');
      mmoInputDFM.Lines.Add('      Font.Height = -11');
      mmoInputDFM.Lines.Add('      Font.Name = ''MS Sans Serif''');
      mmoInputDFM.Lines.Add('      Font.Style = [fsBold]');
      mmoInputDFM.Lines.Add('      ParentBiDiMode = False');
      mmoInputDFM.Lines.Add('      ParentFont = False');
      mmoInputDFM.Lines.Add('    end');

      Inc(vOrder);
    end;
  end;

  vOrder := 0;
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if strngrdList.Cells[COL_GUI_CONTROL, n1] = 'Yes' then
    begin
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Edit') then
      begin
        mmoInputDFM.Lines.Add('    object edt' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TEdit');
        mmoInputDFM.Lines.Add('      Height = 21');
      end
      else
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Memo') then
      begin
        mmoInputDFM.Lines.Add('    object mmo' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TMemo');
        mmoInputDFM.Lines.Add('      Height = 21');
      end
      else
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'ComboBox') then
      begin
        mmoInputDFM.Lines.Add('    object cbb' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TComboBox');
        mmoInputDFM.Lines.Add('      Height = 21');
      end
      else
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'CheckBox') then
      begin
        mmoInputDFM.Lines.Add('    object chk' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TCheckBox');
        mmoInputDFM.Lines.Add('      Height = 17');
      end;

      mmoInputDFM.Lines.Add('      Left = ' + IntToStr(32 + vMaxCaptionLenght + 16 + 4));
      mmoInputDFM.Lines.Add('      Width = 200');
      mmoInputDFM.Lines.Add('      TabOrder = ' + vOrder.ToString);

      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'CheckBox') then
      begin
        mmoInputDFM.Lines.Add('      Top = ' + (3+(vOrder*23)).ToString);
        mmoInputDFM.Lines.Add('    end');
      end
      else
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] <> 'CheckBox') then
      begin
        mmoInputDFM.Lines.Add('      Top = ' + (3+(vOrder*22)).ToString);
        mmoInputDFM.Lines.Add('      thsAlignment = taLeftJustify');
        mmoInputDFM.Lines.Add('      thsColorActive = clSkyBlue');
        mmoInputDFM.Lines.Add('      thsColorRequiredData = 7367916');
        mmoInputDFM.Lines.Add('      thsTabEnterKeyJump = True');

        if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[0])
        or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[1])
        then
          mmoInputDFM.Lines.Add('      thsInputDataType = itString')
        else
        if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[2])
        or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[3])
        or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[4])
        then
          mmoInputDFM.Lines.Add('      thsInputDataType = itInteger')
        else
        if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[5])
        or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[6])
        then
          mmoInputDFM.Lines.Add('      thsInputDataType = itFloat')
        else
        if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[7])
        or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[8])
        or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[9])
        then
          mmoInputDFM.Lines.Add('      thsInputDataType = itFloat');

        mmoInputDFM.Lines.Add('      thsCaseUpLowSupportTr = True');
        mmoInputDFM.Lines.Add('      thsDecimalDigit = 4');
        mmoInputDFM.Lines.Add('      thsRequiredData = True');
        mmoInputDFM.Lines.Add('      thsDoTrim = True');
        mmoInputDFM.Lines.Add('      thsActiveYear = 2018');
        mmoInputDFM.Lines.Add('    end');
      end;

      Inc(vOrder);
    end;
  end;
  mmoInputDFM.Lines.Add('  end');
  mmoInputDFM.Lines.Add('  inherited pnlBottom: TPanel');
  mmoInputDFM.Lines.Add('    Top = 71');
  mmoInputDFM.Lines.Add('    Width = 373');
  mmoInputDFM.Lines.Add('    ExplicitTop = 71');
  mmoInputDFM.Lines.Add('    ExplicitWidth = 373');
  mmoInputDFM.Lines.Add('    inherited btnAccept: TButton');
  mmoInputDFM.Lines.Add('      Left = 164');
  mmoInputDFM.Lines.Add('      ExplicitLeft = 164');
  mmoInputDFM.Lines.Add('    end');
  mmoInputDFM.Lines.Add('    inherited btnDelete: TButton');
  mmoInputDFM.Lines.Add('      Left = 60');
  mmoInputDFM.Lines.Add('      ExplicitLeft = 60');
  mmoInputDFM.Lines.Add('    end');
  mmoInputDFM.Lines.Add('    inherited btnClose: TButton');
  mmoInputDFM.Lines.Add('      Left = 268');
  mmoInputDFM.Lines.Add('      ExplicitLeft = 268');
  mmoInputDFM.Lines.Add('    end');
  mmoInputDFM.Lines.Add('  end');
  mmoInputDFM.Lines.Add('  inherited stbBase: TStatusBar');
  mmoInputDFM.Lines.Add('    Top = 115');
  mmoInputDFM.Lines.Add('    Width = 377');
  mmoInputDFM.Lines.Add('    ExplicitTop = 115');
  mmoInputDFM.Lines.Add('    ExplicitWidth = 377');
  mmoInputDFM.Lines.Add('  end');
  mmoInputDFM.Lines.Add('end');
  mmoInputDFM.Lines.EndUpdate;
end;

procedure TfrmMainClassGenerator.btnAddInputPASToMemoClick(Sender: TObject);
var
  n1: Integer;
begin
  mmoInputPAS.Lines.Clear;
  mmoInputPAS.Lines.BeginUpdate;
  mmoInputPAS.Lines.Add('unit ufrm' + edtClassType.Text + ';');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('interface');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('uses');
  mmoInputPAS.Lines.Add('  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,');
  mmoInputPAS.Lines.Add('  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,');
  mmoInputPAS.Lines.Add('  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('  Ths.Erp.Helper.BaseTypes,');
  mmoInputPAS.Lines.Add('  Ths.Erp.Helper.Edit,');
  mmoInputPAS.Lines.Add('  Ths.Erp.Helper.ComboBox,');
  mmoInputPAS.Lines.Add('  Ths.Erp.Helper.Memo,');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('  ufrmBase, ufrmBaseInputDB;');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('type');
  mmoInputPAS.Lines.Add('  Tfrm' + edtInputFormName.Text + ' = class(TfrmBaseInputDB)');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if strngrdList.Cells[COL_GUI_CONTROL, n1] = 'Yes' then
    begin
      mmoInputPAS.Lines.Add('    lbl' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TLabel;');
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Edit') then
        mmoInputPAS.Lines.Add('    edt' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TEdit;')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Memo') then
        mmoInputPAS.Lines.Add('    mmo' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TMemo;')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'ComboBox') then
        mmoInputPAS.Lines.Add('    cbb' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TComboBox;')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'CheckBox') then
        mmoInputPAS.Lines.Add('    chk' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ': TCheckBox;');
    end;
  end;
  mmoInputPAS.Lines.Add('    procedure FormCreate(Sender: TObject);override;');
  mmoInputPAS.Lines.Add('    procedure RefreshData();override;');
  mmoInputPAS.Lines.Add('    procedure btnAcceptClick(Sender: TObject);override;');
  mmoInputPAS.Lines.Add('  private');
  mmoInputPAS.Lines.Add('  public');
  mmoInputPAS.Lines.Add('  protected');
  mmoInputPAS.Lines.Add('  published');
  mmoInputPAS.Lines.Add('  end;');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('implementation');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('uses');
  mmoInputPAS.Lines.Add('  Ths.Erp.Database.Singleton,');
  mmoInputPAS.Lines.Add('  ' + PROJECT_UNITNAME + edtClassType.Text + ';');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('{$R *.dfm}');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('procedure Tfrm' + edtInputFormName.Text + '.FormCreate(Sender: TObject);');
  mmoInputPAS.Lines.Add('begin');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if strngrdList.Cells[COL_GUI_CONTROL, n1] = 'Yes' then
    begin
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Edit') then
        mmoInputPAS.Lines.Add('  T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.SetControlProperty(Table.TableName, edt' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ');')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Memo') then
        mmoInputPAS.Lines.Add('  T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.SetControlProperty(Table.TableName, mmo' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ');')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'ComboBox') then
        mmoInputPAS.Lines.Add('  T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.SetControlProperty(Table.TableName, cbb' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + ');');
    end;
  end;
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('  inherited;');
  mmoInputPAS.Lines.Add('end;');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('procedure Tfrm' + edtInputFormName.Text + '.RefreshData();');
  mmoInputPAS.Lines.Add('begin');
  mmoInputPAS.Lines.Add('  //control içeriðini table class ile doldur');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if strngrdList.Cells[COL_GUI_CONTROL, n1] = 'Yes' then
    begin
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Edit') then
        mmoInputPAS.Lines.Add('  edt' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Text := ' +
          'FormatedVariantVal(T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.FieldType, T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value);')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Memo') then
        mmoInputPAS.Lines.Add('  mmo' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Text := ' +
          'FormatedVariantVal(T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.FieldType, T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value);')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'ComboBox') then
        mmoInputPAS.Lines.Add('  cbb' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Text := ' +
          'FormatedVariantVal(T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.FieldType, T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value);')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'CheckBox') then
        mmoInputPAS.Lines.Add('  chk' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Checked := ' +
          'FormatedVariantVal(T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.FieldType, T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value);')
    end;
  end;
  mmoInputPAS.Lines.Add('end;');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('procedure Tfrm' + edtInputFormName.Text + '.btnAcceptClick(Sender: TObject);');
  mmoInputPAS.Lines.Add('begin');
  mmoInputPAS.Lines.Add('  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then');
  mmoInputPAS.Lines.Add('  begin');
  mmoInputPAS.Lines.Add('    if (ValidateInput) then');
  mmoInputPAS.Lines.Add('    begin');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if strngrdList.Cells[COL_GUI_CONTROL, n1] = 'Yes' then
    begin
      if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Edit') then
        mmoInputPAS.Lines.Add('      T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value := edt' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Text;')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'Memo') then
        mmoInputPAS.Lines.Add('      T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value := mmo' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Text;')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'ComboBox') then
        mmoInputPAS.Lines.Add('      T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value := cbb' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Text;')
      else if (strngrdList.Cells[COL_CONTROL_TYPE, n1] = 'CheckBox') then
        mmoInputPAS.Lines.Add('      T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value := chk' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Checked;')
    end;
  end;
  mmoInputPAS.Lines.Add('      inherited;');
  mmoInputPAS.Lines.Add('    end;');
  mmoInputPAS.Lines.Add('  end');
  mmoInputPAS.Lines.Add('  else');
  mmoInputPAS.Lines.Add('    inherited;');
  mmoInputPAS.Lines.Add('end;');
  mmoInputPAS.Lines.Add('');
  mmoInputPAS.Lines.Add('end.');

  mmoInputPAS.Lines.EndUpdate;
end;

procedure TfrmMainClassGenerator.btnAddOutputDFMToMemoClick(Sender: TObject);
begin
  mmoOutputDFM.Clear;
  mmoOutputDFM.Lines.BeginUpdate;
  mmoOutputDFM.Lines.Add('inherited frm' + edtOutputFormName.Text + ': Tfrm' + edtOutputFormName.Text);
  mmoOutputDFM.Lines.Add('  Caption = ' + QuotedStr(edtOutputFormCaption.Text));
  mmoOutputDFM.Lines.Add('  ClientHeight = 311');
  mmoOutputDFM.Lines.Add('  ClientWidth = 548');
  mmoOutputDFM.Lines.Add('  ExplicitWidth = 564');
  mmoOutputDFM.Lines.Add('  ExplicitHeight = 350');
  mmoOutputDFM.Lines.Add('  PixelsPerInch = 96');
  mmoOutputDFM.Lines.Add('  TextHeight = 13');
  mmoOutputDFM.Lines.Add('  inherited pnlMain: TPanel');
  mmoOutputDFM.Lines.Add('    Width = 544');
  mmoOutputDFM.Lines.Add('    Height = 245');
  mmoOutputDFM.Lines.Add('    ExplicitWidth = 544');
  mmoOutputDFM.Lines.Add('    ExplicitHeight = 245');
  mmoOutputDFM.Lines.Add('    inherited splLeft: TSplitter');
  mmoOutputDFM.Lines.Add('      Height = 128');
  mmoOutputDFM.Lines.Add('      ExplicitHeight = 219');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('    inherited splHeader: TSplitter');
  mmoOutputDFM.Lines.Add('      Width = 542');
  mmoOutputDFM.Lines.Add('      ExplicitWidth = 554');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('    inherited pnlLeft: TPanel');
  mmoOutputDFM.Lines.Add('      Height = 125');
  mmoOutputDFM.Lines.Add('      ExplicitHeight = 125');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('    inherited pnlHeader: TPanel');
  mmoOutputDFM.Lines.Add('      Width = 538');
  mmoOutputDFM.Lines.Add('      ExplicitWidth = 538');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('    inherited pnlContent: TPanel');
  mmoOutputDFM.Lines.Add('      Width = 433');
  mmoOutputDFM.Lines.Add('      Height = 125');
  mmoOutputDFM.Lines.Add('      ExplicitWidth = 433');
  mmoOutputDFM.Lines.Add('      ExplicitHeight = 125');
  mmoOutputDFM.Lines.Add('      inherited dbgrdBase: TDBGrid');
  mmoOutputDFM.Lines.Add('        Width = 431');
  mmoOutputDFM.Lines.Add('        Height = 123');
  mmoOutputDFM.Lines.Add('      end');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('    inherited pnlButtons: TPanel');
  mmoOutputDFM.Lines.Add('      Top = 165');
  mmoOutputDFM.Lines.Add('      Width = 542');
  mmoOutputDFM.Lines.Add('      ExplicitTop = 165');
  mmoOutputDFM.Lines.Add('      ExplicitWidth = 542');
  mmoOutputDFM.Lines.Add('      inherited flwpnlLeft: TFlowPanel');
  mmoOutputDFM.Lines.Add('        Width = 233');
  mmoOutputDFM.Lines.Add('        ExplicitWidth = 233');
  mmoOutputDFM.Lines.Add('      end');
  mmoOutputDFM.Lines.Add('      inherited flwpnlRight: TFlowPanel');
  mmoOutputDFM.Lines.Add('        Left = 438');
  mmoOutputDFM.Lines.Add('        Width = 104');
  mmoOutputDFM.Lines.Add('        ExplicitLeft = 438');
  mmoOutputDFM.Lines.Add('        ExplicitWidth = 104');
  mmoOutputDFM.Lines.Add('        inherited imgFilterRemove: TImage');
  mmoOutputDFM.Lines.Add('          Left = 72');
  mmoOutputDFM.Lines.Add('          ExplicitLeft = 72');
  mmoOutputDFM.Lines.Add('        end');
  mmoOutputDFM.Lines.Add('      end');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('  end');
  mmoOutputDFM.Lines.Add('  inherited pnlBottom: TPanel');
  mmoOutputDFM.Lines.Add('    Top = 249');
  mmoOutputDFM.Lines.Add('    Width = 544');
  mmoOutputDFM.Lines.Add('    ExplicitTop = 249');
  mmoOutputDFM.Lines.Add('    ExplicitWidth = 544');
  mmoOutputDFM.Lines.Add('    inherited btnAccept: TButton');
  mmoOutputDFM.Lines.Add('      Left = 335');
  mmoOutputDFM.Lines.Add('      ExplicitLeft = 335');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('    inherited btnDelete: TButton');
  mmoOutputDFM.Lines.Add('      Left = 231');
  mmoOutputDFM.Lines.Add('      ExplicitLeft = 231');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('    inherited btnClose: TButton');
  mmoOutputDFM.Lines.Add('      Left = 439');
  mmoOutputDFM.Lines.Add('      ExplicitLeft = 439');
  mmoOutputDFM.Lines.Add('    end');
  mmoOutputDFM.Lines.Add('  end');
  mmoOutputDFM.Lines.Add('  inherited stbBase: TStatusBar');
  mmoOutputDFM.Lines.Add('    Top = 293');
  mmoOutputDFM.Lines.Add('    Width = 548');
  mmoOutputDFM.Lines.Add('    ExplicitTop = 293');
  mmoOutputDFM.Lines.Add('    ExplicitWidth = 548');
  mmoOutputDFM.Lines.Add('  end');
  mmoOutputDFM.Lines.Add('end');
  mmoOutputDFM.Lines.EndUpdate;
end;

procedure TfrmMainClassGenerator.btnAddOutputPASToMemoClick(Sender: TObject);
var
  n1: Integer;
begin
  mmoOutputPAS.Lines.Clear;
  mmoOutputPAS.Lines.BeginUpdate;
  mmoOutputPAS.Lines.Add('unit ufrm' + edtOutputFormName.Text + ';');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('interface');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('uses');
  mmoOutputPAS.Lines.Add('  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,');
  mmoOutputPAS.Lines.Add('  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,');
  mmoOutputPAS.Lines.Add('  Vcl.ExtCtrls,');
  mmoOutputPAS.Lines.Add('  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,');
  mmoOutputPAS.Lines.Add('  Vcl.StdCtrls, Vcl.Grids;');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('type');
  mmoOutputPAS.Lines.Add('  Tfrm' + edtOutputFormName.Text + ' = class(TfrmBaseDBGrid)');
  mmoOutputPAS.Lines.Add('  private');
  mmoOutputPAS.Lines.Add('    { Private declarations }');
  mmoOutputPAS.Lines.Add('  protected');
  mmoOutputPAS.Lines.Add('    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;');
  mmoOutputPAS.Lines.Add('  public');
  mmoOutputPAS.Lines.Add('    procedure SetSelectedItem();override;');
  mmoOutputPAS.Lines.Add('  end;');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('implementation');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('uses');
  mmoOutputPAS.Lines.Add('  Ths.Erp.Database.Singleton,');
  mmoOutputPAS.Lines.Add('  ufrm' + edtInputFormName.Text + ',');
  mmoOutputPAS.Lines.Add('  ' + PROJECT_UNITNAME + edtClassType.Text + ';');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('{$R *.dfm}');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('{ Tfrm' + edtOutputFormName.Text + ' }');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('function Tfrm' + edtOutputFormName.Text + '.CreateInputForm(pFormMode: TInputFormMod): TForm;');
  mmoOutputPAS.Lines.Add('begin');
  mmoOutputPAS.Lines.Add('  Result:=nil;');
  mmoOutputPAS.Lines.Add('  if (pFormMode = ifmRewiev) then');
  mmoOutputPAS.Lines.Add('    Result := Tfrm' + edtInputFormName.Text + '.Create(Application, Self, Table.Clone(), True, pFormMode)');
  mmoOutputPAS.Lines.Add('  else');
  mmoOutputPAS.Lines.Add('  if (pFormMode = ifmNewRecord) then');
  mmoOutputPAS.Lines.Add('    Result := Tfrm' + edtInputFormName.Text + '.Create(Application, Self, T' + edtClassType.Text + '.Create(Table.Database), True, pFormMode)');
  mmoOutputPAS.Lines.Add('  else');
  mmoOutputPAS.Lines.Add('  if (pFormMode = ifmCopyNewRecord) then');
  mmoOutputPAS.Lines.Add('    Result := Tfrm' + edtInputFormName.Text + '.Create(Application, Self, Table.Clone(), True, pFormMode);');
  mmoOutputPAS.Lines.Add('end;');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('procedure Tfrm' + edtOutputFormName.Text + '.SetSelectedItem;');
  mmoOutputPAS.Lines.Add('begin');
  mmoOutputPAS.Lines.Add('  inherited;');
  mmoOutputPAS.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    mmoOutputPAS.Lines.Add('  T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.Value := ' +
                      'FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName).DataType, ' +
                                            'dbgrdBase.DataSource.DataSet.FindField(T' + edtClassType.Text + '(Table).' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName).Value);')
  end;
  mmoOutputPAS.Lines.Add('end;');
  mmoOutputPAS.Lines.Add('');
  mmoOutputPAS.Lines.Add('end.');
  mmoOutputPAS.Lines.EndUpdate;
end;

procedure TfrmMainClassGenerator.btnAddClassToMemoClick(Sender: TObject);
var
  n1: Integer;
begin
  mmoClass.Lines.BeginUpdate;

  if strngrdList.Cells[COL_ROW_NO, strngrdList.RowCount-1] = '' then
    strngrdList.RowCount := strngrdList.RowCount-1;

  mmoClass.Clear;
  mmoClass.Lines.Add('unit ' + PROJECT_UNITNAME + edtClassType.Text + ';');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('interface');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('uses');
  mmoClass.Lines.Add('  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,');
  mmoClass.Lines.Add('  FireDAC.Stan.Param, System.Variants, Data.DB,');
  mmoClass.Lines.Add('  Ths.Erp.Database,');
  mmoClass.Lines.Add('  Ths.Erp.Database.Table,');
  mmoClass.Lines.Add('  Ths.Erp.Database.Table.Field;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('type');
  mmoClass.Lines.Add('  T' + edtClassType.Text + ' = class(TTable)');
  mmoClass.Lines.Add('  private');
  for n1 := 1 to strngrdList.RowCount-1 do
  mmoClass.Lines.Add('    F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ': TFieldDB;');
  mmoClass.Lines.Add('  protected');
  mmoClass.Lines.Add('  published');
  mmoClass.Lines.Add('    constructor Create(OwnerDatabase:TDatabase);override;');
  mmoClass.Lines.Add('  public');
  mmoClass.Lines.Add('    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;');
  mmoClass.Lines.Add('    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;');
  mmoClass.Lines.Add('    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;');
  mmoClass.Lines.Add('    procedure Update(pPermissionControl: Boolean=True); override;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('    procedure Clear();override;');
  mmoClass.Lines.Add('    function Clone():TTable;override;');
  mmoClass.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
  mmoClass.Lines.Add('    Property ' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ': TFieldDB read F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ' write F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ';');
  mmoClass.Lines.Add('  end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('implementation');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('uses');
  mmoClass.Lines.Add('  Ths.Erp.Constants,');
  mmoClass.Lines.Add('  Ths.Erp.Database.Singleton;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('constructor T' + edtClassType.Text + '.Create(OwnerDatabase:TDatabase);');
  mmoClass.Lines.Add('begin');
  mmoClass.Lines.Add('  inherited Create(OwnerDatabase);');
  mmoClass.Lines.Add('  TableName := ' + QuotedStr(edtTableName.Text) + ';');
  mmoClass.Lines.Add('  SourceCode := ' + QuotedStr(edtSourceCode.Text) + ';');
  mmoClass.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[0])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[1])
    then
      mmoClass.Lines.Add('  F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ' := TFieldDB.Create(' + QuotedStr(strngrdList.Cells[COL_FIELD_NAME,n1]) + ', ' + strngrdList.Cells[COL_FIELD_TYPE,n1] + ', '''');')
    else
    if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[2])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[3])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[4])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[5])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[6])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[7])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[8])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[9])
    then
      mmoClass.Lines.Add('  F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ' := TFieldDB.Create(' + QuotedStr(strngrdList.Cells[COL_FIELD_NAME,n1]) + ', ' + strngrdList.Cells[COL_FIELD_TYPE,n1] + ', 0);')
    else
    if (strngrdList.Cells[3, n1] = cbbFieldType.Items.Strings[10]) then
      mmoClass.Lines.Add('  F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ' := TFieldDB.Create(' + QuotedStr(strngrdList.Cells[COL_FIELD_NAME,n1]) + ', ' + strngrdList.Cells[COL_FIELD_TYPE,n1] + ', False);')
  end;
  mmoClass.Lines.Add('end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('procedure T' + edtClassType.Text + '.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);');
  mmoClass.Lines.Add('begin');
  mmoClass.Lines.Add('  if IsAuthorized(ptRead, pPermissionControl) then');
  mmoClass.Lines.Add('  begin');
  mmoClass.Lines.Add('    with QueryOfDS do');
  mmoClass.Lines.Add('    begin');
  mmoClass.Lines.Add('      Close;');
  mmoClass.Lines.Add('      SQL.Clear;');
  mmoClass.Lines.Add('      SQL.Text := Database.GetSQLSelectCmd(TableName, [');
  mmoClass.Lines.Add('        TableName + ''.'' + Self.Id.FieldName,');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
  mmoClass.Lines.Add('        TableName + ''.'' + F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    mmoClass.Lines.Strings[mmoClass.Lines.Count-1] := LeftStr(mmoClass.Lines.Strings[mmoClass.Lines.Count-1], Length(mmoClass.Lines.Strings[mmoClass.Lines.Count-1])-1);
  end;
  mmoClass.Lines.Add('      ]) +');
  mmoClass.Lines.Add('      ''WHERE 1=1 '' + pFilter;');
  mmoClass.Lines.Add('      Open;');
	mmoClass.Lines.Add('      Active := True;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := ''ID'';');
  for n1 := 1 to strngrdList.RowCount-1 do
  mmoClass.Lines.Add('      Self.DataSource.DataSet.FindField(F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName).DisplayLabel := ''' + strngrdList.Cells[COL_GRID_COL_CAPTION,n1] + ''';');
  mmoClass.Lines.Add('    end;');
  mmoClass.Lines.Add('  end;');
  mmoClass.Lines.Add('end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('procedure T' + edtClassType.Text + '.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);');
  mmoClass.Lines.Add('begin');
  mmoClass.Lines.Add('  if IsAuthorized(ptRead, pPermissionControl) then');
  mmoClass.Lines.Add('  begin');
  mmoClass.Lines.Add('    if (pLock) then');
  mmoClass.Lines.Add('      pFilter := pFilter + '' FOR UPDATE NOWAIT; '';');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('    with QueryOfList do');
  mmoClass.Lines.Add('    begin');
  mmoClass.Lines.Add('      Close;');
  mmoClass.Lines.Add('      SQL.Text := Database.GetSQLSelectCmd(TableName, [');
  mmoClass.Lines.Add('        TableName + ''.'' + Self.Id.FieldName,');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
  mmoClass.Lines.Add('        TableName + ''.'' + F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    mmoClass.Lines.Strings[mmoClass.Lines.Count-1] := LeftStr(mmoClass.Lines.Strings[mmoClass.Lines.Count-1], Length(mmoClass.Lines.Strings[mmoClass.Lines.Count-1])-1);
  end;
  mmoClass.Lines.Add('      ]) +');
  mmoClass.Lines.Add('      ''WHERE 1=1 '' + pFilter;');
  mmoClass.Lines.Add('      Open;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('      FreeListContent();');
  mmoClass.Lines.Add('      List.Clear;');
  mmoClass.Lines.Add('      while NOT EOF do');
  mmoClass.Lines.Add('      begin');
  mmoClass.Lines.Add('        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);');
  mmoClass.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
  mmoClass.Lines.Add('        F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.Value := FormatedVariantVal(FieldByName(F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName).DataType, FieldByName(F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName).Value);');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('        List.Add(Self.Clone());');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('        Next;');
  mmoClass.Lines.Add('      end;');
  mmoClass.Lines.Add('      Close;');
  mmoClass.Lines.Add('    end;');
  mmoClass.Lines.Add('  end;');
  mmoClass.Lines.Add('end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('procedure T' + edtClassType.Text + '.Insert(out pID: Integer; pPermissionControl: Boolean=True);');
  mmoClass.Lines.Add('begin');
  mmoClass.Lines.Add('  if IsAuthorized(ptAddRecord, pPermissionControl) then');
  mmoClass.Lines.Add('  begin');
  mmoClass.Lines.Add('    with QueryOfInsert do');
  mmoClass.Lines.Add('    begin');
  mmoClass.Lines.Add('      Close;');
  mmoClass.Lines.Add('      SQL.Clear;');
  mmoClass.Lines.Add('      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
  mmoClass.Lines.Add('        F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    mmoClass.Lines.Strings[mmoClass.Lines.Count-1] := LeftStr(mmoClass.Lines.Strings[mmoClass.Lines.Count-1], Length(mmoClass.Lines.Strings[mmoClass.Lines.Count-1])-1);
  end;
  mmoClass.Lines.Add('      ]);');
  mmoClass.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
    mmoClass.Lines.Add('      NewParamForQuery(QueryOfInsert, F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ');');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('      Open;');
  mmoClass.Lines.Add('      if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.FieldName).IsNull) then');
  mmoClass.Lines.Add('        pID := Fields.FieldByName(Self.Id.FieldName).AsInteger');
  mmoClass.Lines.Add('      else');
  mmoClass.Lines.Add('        pID := 0;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('      EmptyDataSet;');
  mmoClass.Lines.Add('      Close;');
  mmoClass.Lines.Add('    end;');
  mmoClass.Lines.Add('    Self.notify;');
  mmoClass.Lines.Add('  end;');
  mmoClass.Lines.Add('end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('procedure T' + edtClassType.Text + '.Update(pPermissionControl: Boolean=True);');
  mmoClass.Lines.Add('begin');
  mmoClass.Lines.Add('  if IsAuthorized(ptUpdate, pPermissionControl) then');
  mmoClass.Lines.Add('  begin');
  mmoClass.Lines.Add('    with QueryOfUpdate do');
  mmoClass.Lines.Add('    begin');
  mmoClass.Lines.Add('      Close;');
  mmoClass.Lines.Add('      SQL.Clear;');
  mmoClass.Lines.Add('      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
  mmoClass.Lines.Add('        F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.FieldName,');
  if n1 = strngrdList.RowCount-1 then
    mmoClass.Lines.Strings[mmoClass.Lines.Count-1] := LeftStr(mmoClass.Lines.Strings[mmoClass.Lines.Count-1], Length(mmoClass.Lines.Strings[mmoClass.Lines.Count-1])-1);
  end;
  mmoClass.Lines.Add('      ]);');
  mmoClass.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
    mmoClass.Lines.Add('      NewParamForQuery(QueryOfUpdate, F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ');');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('      NewParamForQuery(QueryOfUpdate, Id);');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('      ExecSQL;');
  mmoClass.Lines.Add('      Close;');
  mmoClass.Lines.Add('    end;');
  mmoClass.Lines.Add('    Self.notify;');
  mmoClass.Lines.Add('  end;');
  mmoClass.Lines.Add('end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('procedure T' + edtClassType.Text + '.Clear();');
  mmoClass.Lines.Add('begin');
  mmoClass.Lines.Add('  inherited;');
  mmoClass.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[0])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[1])
    then
      mmoClass.Lines.Add('  F' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value := ' + ''''';')
    else
    if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[2])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[3])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[4])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[5])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[6])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[7])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[8])
    or (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[9])
    then
      mmoClass.Lines.Add('  F' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value := ' + '0;')
    else
    if (strngrdList.Cells[COL_FIELD_TYPE, n1] = cbbFieldType.Items.Strings[10]) then
      mmoClass.Lines.Add('  F' + strngrdList.Cells[COL_PROPERTY_NAME, n1] + '.Value := ' + 'False;')
  end;
  mmoClass.Lines.Add('end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('function T' + edtClassType.Text + '.Clone():TTable;');
  mmoClass.Lines.Add('begin');
  mmoClass.Lines.Add('  Result := T' + edtClassType.Text + '.Create(Database);');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('  Self.Id.Clone(T' + edtClassType.Text + '(Result).Id);');
  mmoClass.Lines.Add('');
  for n1 := 1 to strngrdList.RowCount-1 do
  mmoClass.Lines.Add('  F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + '.Clone(T' + edtClassType.Text + '(Result).F' + strngrdList.Cells[COL_PROPERTY_NAME,n1] + ');');
  mmoClass.Lines.Add('end;');
  mmoClass.Lines.Add('');
  mmoClass.Lines.Add('end.');

  mmoClass.Lines.EndUpdate;
end;

procedure TfrmMainClassGenerator.btnClearListsClick(Sender: TObject);
begin
  if MessageBox(Handle, PWideChar('Are you sure you want to clear Grid?'), PWideChar('Confirmation'), MB_YESNO) <> mrYes then
    Exit;
  ClearGridList();
end;

procedure TfrmMainClassGenerator.btnEditFieldClick(Sender: TObject);
begin
  strngrdList.Cells[COL_ROW_NO, FRowNo] := FRowNo.ToString;
  strngrdList.Cells[COL_PROPERTY_NAME, FRowNo] := edtpropertyname.Text;
  strngrdList.Cells[COL_FIELD_NAME, FRowNo] := edtFieldName.Text;
  strngrdList.Cells[COL_FIELD_TYPE, FRowNo] := cbbFieldType.Text;
  strngrdList.Cells[COL_GRID_COL_CAPTION, FRowNo] := edtCaption.Text;
  strngrdList.Cells[COL_INPUT_LABEL_CAPTION, FRowNo] := edtInputLabelCaption.Text;
  if chkIsGUIControl.Checked then
  begin
    strngrdList.Cells[COL_GUI_CONTROL, FRowNo] := 'Yes';
    strngrdList.Cells[COL_CONTROL_TYPE, FRowNo] := cbbControlType.Text;
  end
  else
  begin
    strngrdList.Cells[COL_GUI_CONTROL, FRowNo] := 'No';
    strngrdList.Cells[COL_CONTROL_TYPE, FRowNo] := '';
  end;

  edtpropertyname.Clear;
  edtFieldName.Clear;
  cbbFieldType.ItemIndex := -1;
  edtCaption.Clear;
  edtInputLabelCaption.Clear;
  chkIsGUIControl.Checked := False;
  chkIsGUIControlClick(chkIsGUIControl);
  cbbControlType.ItemIndex := -1;

  edtpropertyname.SetFocus;

  strngrdList.Top := strngrdList.RowCount-1;

  btnEditField.Enabled := False;
  FRowNo := -1;
end;

procedure TfrmMainClassGenerator.btnSaveToFilesClick(Sender: TObject);
var
  vPath, vFileNameClass, vFileNameOutput, vFileNameInput: string;
  vFileDPR: TStringList;
  n1: Integer;
begin
  if MessageBox(Handle, PWideChar('Are you sure you want to Save Content to File?'), PWideChar('Confirmation'), MB_YESNO) <> mrYes then
    Exit;

  if edtMainProjectDirectory.Text <> '' then
  begin
    btnAddClassToMemo.Click;
    btnAddOutputDFMToMemo.Click;
    btnAddOutputPASToMemo.Click;
    btnAddInputDFMToMemo.Click;
    btnAddInputPASToMemo.Click;

    vPath := ExtractFilePath(edtMainProjectDirectory.Text);
    vFileNameClass := vPath + 'BackEnd\' + PROJECT_UNITNAME + edtClassType.Text + '.pas';
    vFileNameOutput := vPath + 'Forms\OutputForms\DbGrid\ufrm' + edtOutputFormName.Text + '.pas';
    vFileNameInput := vPath + 'Forms\InputForms\ufrm' + edtInputFormName.Text + '.pas';

    mmoClass.Lines.SaveToFile(vFileNameClass);
    mmoOutputDFM.Lines.SaveToFile(vPath + 'Forms\OutputForms\DbGrid\ufrm' + edtOutputFormName.Text + '.dfm');
    mmoOutputPAS.Lines.SaveToFile(vFileNameOutput);
    mmoInputDFM.Lines.SaveToFile(vPath + 'Forms\InputForms\ufrm' + edtInputFormName.Text + '.dfm');
    mmoInputPAS.Lines.SaveToFile(vFileNameInput);

    vFileDPR := TStringList.Create;
    try
      vFileDPR.LoadFromFile(edtMainProjectDirectory.Text);
      //projede kullanýlan dosyalardan sonraki son satýr numarasýný bul
      n1 := vFileDPR.IndexOf('{$R *.res}');

      //son elemanýn noktalý virgül bilgisini virgüle çevir.
      vFileDPR.Strings[n1-2] := LeftStr(vFileDPR.Strings[n1-2], Length(vFileDPR.Strings[n1-2])-1) + ',';

      //eklenen sýnýf, output ve input formlarýný projeye dahil et
      vFileDPR.Insert(n1-1, '  ufrm' + edtInputFormName.Text + ' in ''Forms\InputForms\' + 'ufrm' + edtInputFormName.Text + '.pas'' {frm' + edtInputFormName.Text + '};');
      vFileDPR.Insert(n1-1, '  ufrm' + edtOutputFormName.Text + ' in ''Forms\OutputForms\DbGrid\' + 'ufrm' + edtOutputFormName.Text + '.pas'' {frm' + edtOutputFormName.Text + '},');
      vFileDPR.Insert(n1-1, '  ' + PROJECT_UNITNAME + edtClassType.Text + ' in ''BackEnd\' + PROJECT_UNITNAME + edtClassType.Text + '.pas'',');

      vFileDPR.SaveToFile(edtMainProjectDirectory.Text);
    finally
      vFileDPR.Free;
    end;
  end
  else
    raise Exception.Create('Main Project File *.dpr is missing');
end;

procedure TfrmMainClassGenerator.chkIsGUIControlClick(Sender: TObject);
begin
  if chkIsGUIControl.Checked then
  begin
    lblControlType.Visible := True;
    cbbControlType.Visible := True;
  end
  else
  begin
    lblControlType.Visible := False;
    cbbControlType.Visible := False;
  end;
end;

procedure TfrmMainClassGenerator.ClearGridList;
var
  nr: Integer;
  nc: Integer;
begin
  cbbFieldType.Items.Add('ftString');
  cbbFieldType.Items.Add('ftWideString');
  cbbFieldType.Items.Add('ftInteger');
  cbbFieldType.Items.Add('ftLongInt');
  cbbFieldType.Items.Add('ftWord');
  cbbFieldType.Items.Add('ftFloat');
  cbbFieldType.Items.Add('ftCurrency');
  cbbFieldType.Items.Add('ftDate');
  cbbFieldType.Items.Add('ftTime');
  cbbFieldType.Items.Add('ftDateTime');
  cbbFieldType.Items.Add('ftBoolean');

  cbbControlType.Clear;
  cbbControlType.Items.Add('Edit');
  cbbControlType.Items.Add('Memo');
  cbbControlType.Items.Add('ComboBox');
  cbbControlType.Items.Add('CheckBox');

  edtpropertyname.Clear;
  edtFieldName.Clear;
  cbbFieldType.ItemIndex := -1;
  edtCaption.Clear;
  chkIsGUIControl.Checked := False;
  chkIsGUIControlClick(chkIsGUIControl);
  cbbControlType.ItemIndex := -1;

  for nr := 0 to strngrdList.RowCount-1 do
    for nc := 0 to strngrdList.ColCount-1 do
      strngrdList.Cells[nc, nr] := '';

  strngrdList.RowCount := 2;
  strngrdList.ColCount := 8;

  strngrdList.FixedColor := clGray;
  strngrdList.FixedRows := 1;
  strngrdList.FixedColor := 1;

  strngrdList.ColWidths[COL_ROW_NO] := 25;
  strngrdList.ColWidths[COL_PROPERTY_NAME] := 140;
  strngrdList.ColWidths[COL_FIELD_NAME] := 140;
  strngrdList.ColWidths[COL_FIELD_TYPE] := 140;
  strngrdList.ColWidths[COL_GRID_COL_CAPTION] := 150;
  strngrdList.ColWidths[COL_INPUT_LABEL_CAPTION] := 150;
  strngrdList.ColWidths[COL_GUI_CONTROL] := 50;
  strngrdList.ColWidths[COL_CONTROL_TYPE] := 150;

  strngrdList.Cells[COL_ROW_NO,0] := 'No';
  strngrdList.Cells[COL_PROPERTY_NAME,0] := 'Property Name';
  strngrdList.Cells[COL_FIELD_NAME,0] := 'Field Name';
  strngrdList.Cells[COL_FIELD_TYPE,0] := 'Field Type';
  strngrdList.Cells[COL_GRID_COL_CAPTION,0] := 'Column Caption';
  strngrdList.Cells[COL_INPUT_LABEL_CAPTION,0] := 'Input Caption';
  strngrdList.Cells[COL_GUI_CONTROL,0] := 'GUI Control?';
  strngrdList.Cells[COL_CONTROL_TYPE,0] := 'Control Type';

  strngrdList.Cells[COL_ROW_NO,1] := '';
  strngrdList.Cells[COL_PROPERTY_NAME,1] := '';
  strngrdList.Cells[COL_FIELD_NAME,1] := '';
  strngrdList.Cells[COL_FIELD_TYPE,1] := '';
  strngrdList.Cells[COL_GRID_COL_CAPTION,1] := '';
  strngrdList.Cells[COL_INPUT_LABEL_CAPTION,1] := '';
  strngrdList.Cells[COL_GUI_CONTROL,1] := '';
  strngrdList.Cells[COL_CONTROL_TYPE,1] := '';
end;

procedure TfrmMainClassGenerator.edtMainProjectDirectoryDblClick(
  Sender: TObject);
var
  vOD: TOpenDialog;
begin
  vOD := TOpenDialog.Create(Self);
  try
    vOD.InitialDir := ExtractFilePath(Application.ExeName);
    vOD.Filter := 'Delphi Project File|*.dpr';
    if vOD.Execute(Self.Handle) then
    begin
      edtMainProjectDirectory.Text := vOD.FileName;
    end;
  finally
    vOD.Free;
  end;
end;

procedure TfrmMainClassGenerator.FormCreate(Sender: TObject);
  procedure AddRow(pPropName, pFieldName, pDataType, pGridCaption, pInputLabelCaption: string; pIsGUI: Boolean; pControlType: string);
  begin
    strngrdList.Cells[COL_ROW_NO,strngrdList.RowCount-1] := (strngrdList.RowCount-1).ToString;;
    strngrdList.Cells[COL_PROPERTY_NAME,strngrdList.RowCount-1] := pPropName;
    strngrdList.Cells[COL_FIELD_NAME,strngrdList.RowCount-1] := pFieldName;
    strngrdList.Cells[COL_FIELD_TYPE,strngrdList.RowCount-1] := pDataType;
    strngrdList.Cells[COL_GRID_COL_CAPTION,strngrdList.RowCount-1] := pGridCaption;
    strngrdList.Cells[COL_INPUT_LABEL_CAPTION,strngrdList.RowCount-1] := pInputLabelCaption;
    if pIsGUI then
      strngrdList.Cells[COL_GUI_CONTROL,strngrdList.RowCount-1] := 'Yes'
    else
      strngrdList.Cells[COL_GUI_CONTROL,strngrdList.RowCount-1] := 'No';
    strngrdList.Cells[COL_CONTROL_TYPE,strngrdList.RowCount-1] := pControlType;
    strngrdList.RowCount := strngrdList.RowCount + 1;
  end;
begin
  ClearGridList;
  edtMainProjectDirectory.ReadOnly := True;

  btnEditField.Enabled := False;

  mmoClass.Clear;
  mmoOutputDFM.Clear;
  mmoOutputPAS.Clear;
  mmoInputDFM.Clear;
  mmoInputPAS.Clear;
end;

procedure TfrmMainClassGenerator.mmoClassKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Sender is TMemo then
  begin
    if (Key = Word('A')) and (ssCtrl in Shift) then
      TMemo(Sender).SelectAll
    else if (Key = Word('C')) and (ssCtrl in Shift) then
      TMemo(Sender).CopyToClipboard;
  end;
end;

procedure TfrmMainClassGenerator.mniDeleteRowClick(Sender: TObject);
var
  n1: Integer;
begin
  for n1 := 0 to strngrdList.ColCount-1 do
    strngrdList.Cells[n1, strngrdList.Row] := '';

  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    strngrdList.Cells[COL_ROW_NO, n1] := '';
    if (strngrdList.Cells[COL_PROPERTY_NAME, n1] <> '') then
      strngrdList.Cells[COL_ROW_NO, n1] := n1.ToString;
  end;

  ReFillAndSort;
end;

procedure TfrmMainClassGenerator.mniLoadFromFileClick(Sender: TObject);
var
  nR: Integer;
  vXML: IXMLDocument;
  NodeRoot, NodeRow, NodeData: IXMLNode;

  function getNodeValue(vNodeName: string): string;
  begin
    NodeData := NodeRow.ChildNodes.FindNode(vNodeName);
    Result := NodeData.Text;
  end;
begin
  vXML := TXMLDocument.Create(nil);

  if FileExists(ExtractFilePath(Application.ExeName) + '\setting.xml', False) then
  begin
    vXML.LoadFromFile(ExtractFilePath(Application.ExeName) + '\setting.xml');
    vXML.Active := True;
    try
      ClearGridList;

      NodeRoot := vXML.ChildNodes.FindNode('GridSetting');
      NodeRow := NodeRoot.ChildNodes.FindNode('Header');
        edtMainProjectDirectory.Text := getNodeValue('ProjectFile');
        edtClassType.Text := getNodeValue('ClassType');
        edtTableName.Text := getNodeValue('TableName');
        edtSourceCode.Text := getNodeValue('SourceCode');
        edtOutputFormName.Text := getNodeValue('OutputFormName');
        edtOutputFormCaption.Text := getNodeValue('OutputFormCaption');
        edtInputFormName.Text := getNodeValue('InputFormName');
        edtInputFormCaption.Text := getNodeValue('InputFormCaption');

      for nR := 0 to NodeRoot.ChildNodes.Count-1 do
      begin
        if NodeRoot.ChildNodes.Get(nR).NodeName = 'Row' then
        begin
          NodeRow := NodeRoot.ChildNodes.Get(nR);
          strngrdList.Cells[COL_ROW_NO, strngrdList.Row] := getNodeValue('RowNo');
          strngrdList.Cells[COL_PROPERTY_NAME, strngrdList.Row] := getNodeValue('PropertyName');
          strngrdList.Cells[COL_FIELD_NAME, strngrdList.Row] := getNodeValue('FieldName');
          strngrdList.Cells[COL_FIELD_TYPE, strngrdList.Row] := getNodeValue('FieldType');
          strngrdList.Cells[COL_GRID_COL_CAPTION, strngrdList.Row] := getNodeValue('ColumnCaption');
          strngrdList.Cells[COL_INPUT_LABEL_CAPTION, strngrdList.Row] := getNodeValue('InputCaption');
          strngrdList.Cells[COL_GUI_CONTROL, strngrdList.Row] := getNodeValue('GuiControl');
          strngrdList.Cells[COL_CONTROL_TYPE, strngrdList.Row] := getNodeValue('ControlType');

          strngrdList.RowCount := strngrdList.RowCount+1;
          strngrdList.Row := strngrdList.Row+1;
        end;
      end;

      strngrdList.Top := strngrdList.RowCount-1;
    finally
      vXML.Active := False;
//      TXMLDocument(vXML).Destroy;
    end;

    ShowMessage('File saved succesfully');
  end;
end;

procedure TfrmMainClassGenerator.mniSaveToFileClick(Sender: TObject);
var
  nR: Integer;
  nC: Integer;
  vXML: TXMLDocument;
  NodeRoot, NodeData: IXMLNode;

  procedure AddNode(vNodeName, vValue: string);
  begin
    NodeData := vXML.CreateNode(vNodeName);
    NodeData.Text := vValue;
    NodeRoot.ChildNodes.Add(NodeData);
  end;
begin
  vXML := TXMLDocument.Create(nil);
  vXML.Options := [doNodeAutoIndent];
  vXML.Active := True;
  try
    vXML.DocumentElement := vXML.CreateNode('GridSetting', ntElement, '');
    NodeRoot := vXML.DocumentElement.AddChild('Header');
      AddNode('ProjectFile', edtMainProjectDirectory.Text);
      AddNode('ClassType', edtClassType.Text);
      AddNode('TableName', edtTableName.Text);
      AddNode('SourceCode', edtSourceCode.Text);
      AddNode('OutputFormName', edtOutputFormName.Text);
      AddNode('OutputFormCaption', edtOutputFormCaption.Text);
      AddNode('InputFormName', edtInputFormName.Text);
      AddNode('InputFormCaption', edtInputFormCaption.Text);

    for nR := 1 to strngrdList.RowCount-1 do
    begin
      if strngrdList.Cells[COL_ROW_NO, nR] <> '' then
        NodeRoot := vXML.DocumentElement.AddChild('Row');
      for nC := 0 to strngrdList.ColCount-1 do
      begin
        if strngrdList.Cells[COL_ROW_NO, nR] <> '' then
        begin
          if nC = COL_ROW_NO then               AddNode('RowNo', strngrdList.Cells[nC, nR]);
          if nC = COL_PROPERTY_NAME then        AddNode('PropertyName', strngrdList.Cells[nC, nR]);
          if nC = COL_FIELD_NAME then           AddNode('FieldName', strngrdList.Cells[nC, nR]);
          if nC = COL_FIELD_TYPE then           AddNode('FieldType', strngrdList.Cells[nC, nR]);
          if nC = COL_GRID_COL_CAPTION then     AddNode('ColumnCaption', strngrdList.Cells[nC, nR]);
          if nC = COL_INPUT_LABEL_CAPTION then  AddNode('InputCaption', strngrdList.Cells[nC, nR]);
          if nC = COL_GUI_CONTROL then          AddNode('GuiControl', strngrdList.Cells[nC, nR]);
          if nC = COL_CONTROL_TYPE then         AddNode('ControlType', strngrdList.Cells[nC, nR]);
        end;
      end;
    end;

    vXML.SaveToFile(ExtractFilePath(Application.ExeName) + '\setting.xml');

    ShowMessage('File saved succesfully');

  finally
    vXML.Active := False;
    vXML.Free;
  end;
end;

procedure TfrmMainClassGenerator.strngrdListDblClick(Sender: TObject);
begin
  if strngrdList.Row > 0 then
  begin
    if strngrdList.Cells[strngrdList.Col, strngrdList.Row] <> '' then
    begin
      edtpropertyname.Text := strngrdList.Cells[COL_PROPERTY_NAME, strngrdList.Row];
      edtFieldName.Text := strngrdList.Cells[COL_FIELD_NAME, strngrdList.Row];
      cbbFieldType.ItemIndex := cbbFieldType.Items.IndexOf(strngrdList.Cells[COL_FIELD_TYPE, strngrdList.Row]);
      edtCaption.Text := strngrdList.Cells[COL_GRID_COL_CAPTION, strngrdList.Row];
      edtInputLabelCaption.Text := strngrdList.Cells[COL_INPUT_LABEL_CAPTION, strngrdList.Row];
      chkIsGUIControl.Checked := strngrdList.Cells[COL_INPUT_LABEL_CAPTION, strngrdList.Row] = 'Yes';
      chkIsGUIControlClick(chkIsGUIControl);
      cbbControlType.ItemIndex := cbbControlType.Items.IndexOf(strngrdList.Cells[COL_CONTROL_TYPE, strngrdList.Row]);

      btnEditField.Enabled := True;

      FRowNo := strngrdList.Cells[COL_ROW_NO, strngrdList.Row].ToInteger;
    end;
  end;
end;

procedure TfrmMainClassGenerator.strngrdListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
begin
  strngrdList.MouseToCell(X, Y, Cell.X, Cell.Y);
  if (Cell.Y > 0) and (Cell.X > 0) then
  begin
    strngrdList.Row := Cell.Y;
    strngrdList.Col := Cell.X;
  end;
end;

procedure TfrmMainClassGenerator.strngrdListRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
  n1: Integer;
begin
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    strngrdList.Cells[COL_ROW_NO, n1] := '';
    if (strngrdList.Cells[COL_PROPERTY_NAME, n1] <> '') then
      strngrdList.Cells[COL_ROW_NO, n1] := n1.ToString;
  end;
  ReFillAndSort;
end;

procedure TfrmMainClassGenerator.ReFillAndSort();
var
  n1, vRow: Integer;
begin
  vRow := 0;
  for n1 := 1 to strngrdList.RowCount-1 do
  begin
    if (strngrdList.Cells[COL_ROW_NO, n1] = '') then
    begin
      if n1 < strngrdList.RowCount-1 then
      begin
        strngrdList.Cells[COL_ROW_NO, n1] := n1.ToString;

        strngrdList.Cells[COL_PROPERTY_NAME, n1] := strngrdList.Cells[COL_PROPERTY_NAME, n1+1];
        strngrdList.Cells[COL_FIELD_NAME, n1] := strngrdList.Cells[COL_FIELD_NAME, n1+1];
        strngrdList.Cells[COL_FIELD_TYPE, n1] := strngrdList.Cells[COL_FIELD_TYPE, n1+1];
        strngrdList.Cells[COL_GRID_COL_CAPTION, n1] := strngrdList.Cells[COL_GRID_COL_CAPTION, n1+1];
        strngrdList.Cells[COL_INPUT_LABEL_CAPTION, n1] := strngrdList.Cells[COL_INPUT_LABEL_CAPTION, n1+1];
        strngrdList.Cells[COL_GUI_CONTROL, n1] := strngrdList.Cells[COL_GUI_CONTROL, n1+1];
        strngrdList.Cells[COL_CONTROL_TYPE, n1] := strngrdList.Cells[COL_CONTROL_TYPE, n1+1];

        strngrdList.Cells[COL_ROW_NO, n1+1] := '';
        strngrdList.Cells[COL_PROPERTY_NAME, n1+1] := '';
        strngrdList.Cells[COL_FIELD_NAME, n1+1] := '';
        strngrdList.Cells[COL_FIELD_TYPE, n1+1] := '';
        strngrdList.Cells[COL_GRID_COL_CAPTION, n1+1] := '';
        strngrdList.Cells[COL_INPUT_LABEL_CAPTION, n1+1] := '';
        strngrdList.Cells[COL_GUI_CONTROL, n1+1] := '';
        strngrdList.Cells[COL_CONTROL_TYPE, n1+1] := '';
      end;
    end;

    if (strngrdList.Cells[COL_PROPERTY_NAME, n1] <> '') then
      Inc(vRow);
  end;

  strngrdList.RowCount := vRow+2;
  strngrdList.Cells[COL_ROW_NO, strngrdList.RowCount-1] := '';
end;

end.
