unit ufrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Dialogs,
  Vcl.ImgList, Vcl.Graphics, Vcl.Menus, System.Math,
  System.Rtti, System.TypInfo,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Combobox,
  Ths.Erp.Helper.Memo,

  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.SysGridColWidth;

const
  WM_AFTER_SHOW = WM_USER + 300; // custom message
  WM_AFTER_CREATE = WM_USER + 301; // custom message

const
  COLUMN_GRID_OBJECT = 0;

type
  TInputFormMod = (ifmNone, ifmNewRecord, ifmRewiev, ifmUpdate, ifmReadOnly, ifmCopyNewRecord);
  TInputFormViewMod = (ivmNormal, ivmSort);
  TFormOndalikMod = (fomAlis, fomSatis, fomStok, fomNormal);

  //forward declaration
  TfrmConfirmation = class
  end;

type
  TfrmBase = class(TForm)
    pnlBottom: TPanel;
    pnlMain: TPanel;
    AppEvntsBase: TApplicationEvents;
    btnSpin: TSpinButton;
    btnAccept: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    stbBase: TStatusBar;
    procedure btnAcceptClick(Sender: TObject);virtual;
    procedure btnDeleteClick(Sender: TObject);virtual;
    procedure btnCloseClick(Sender: TObject);virtual;
    procedure btnSpinUpClick(Sender: TObject);virtual;
    procedure btnSpinDownClick(Sender: TObject);virtual;
    procedure FormDestroy(Sender: TObject);virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);virtual;
    procedure FormKeyPress(Sender: TObject; var Key: Char);virtual;
    procedure FormCreate(Sender: TObject);virtual;
    procedure FormResize(Sender: TObject);virtual;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);virtual;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);virtual;
    procedure FormShow(Sender: TObject);virtual;
    procedure FormPaint(Sender: TObject);virtual;
    procedure AppEvntsBaseShortCut(var Msg: TWMKey; var Handled: Boolean);

    procedure WmAfterShow(var Msg: TMessage); message WM_AFTER_SHOW;
    procedure WmAfterCreate(var Msg: TMessage); message WM_AFTER_CREATE;
    procedure stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect); virtual;
  private
    FTable: TTable;
    FTableHelper: TTable;
    FFormMode: TInputFormMod;
    FFormViewMode: TInputFormViewMod;
    FFormOndalikMod: TFormOndalikMod;
    FWithCommitTransaction: Boolean;
    FWithRollbackTransaction: Boolean;
    FDefaultSelectFilter: string;
    FIsPermissionControlForm: Boolean;
    FParentForm: TForm;

    FMesajFormClose: string;
    FMesajTitleFormClose: string;

    FfrmConfirmation: TfrmConfirmation;
  protected
    function ValidateInput(panel_groupbox_pagecontrol_tabsheet: TWinControl = nil):boolean;virtual;
    procedure fillComboBoxData(var pControl: TCombobox;
        pTable: TTable; const pFieldName, pFilter: string;
        pWithObject: Boolean = False; pAddEmptyOne: Boolean = False);
  public
    property Table: TTable read FTable write FTable;
    property FormMode: TInputFormMod read FFormMode write FFormMode;
    property FormViewMode: TInputFormViewMod read FFormViewMode write FFormViewMode;
    property FormOndalikMod: TFormOndalikMod read FFormOndalikMod write FFormOndalikMod;
    property WithCommitTransaction: Boolean read FWithCommitTransaction write FWithCommitTransaction;
    property WithRollbackTransaction: Boolean read FWithRollbackTransaction write FWithRollbackTransaction;
    property DefaultSelectFilter: string read FDefaultSelectFilter write FDefaultSelectFilter;
    property IsPermissionControlForm: Boolean read FIsPermissionControlForm write FIsPermissionControlForm;
    property ParentForm: TForm read FParentForm write FParentForm;
    property TableHelper: TTable read FTableHelper write FTableHelper;
    property MesajFormClose: string read FMesajFormClose write FMesajFormClose;
    property MesajTitleFormClose: string read FMesajTitleFormClose write FMesajTitleFormClose;
    property frmConfirmation: TfrmConfirmation read FfrmConfirmation write FfrmConfirmation;

    constructor Create(AOwner: TComponent; pParentForm: TForm=nil;
        pTable: TTable=nil; pIsPermissionControl: Boolean=False;
        pFormMode: TInputFormMod=ifmNone;
        pFormOndalikMode: TFormOndalikMod=fomNormal;
        pFormViewMode: TInputFormViewMod=ivmNormal);reintroduce;overload;virtual;
    function FocusedFirstControl(panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean; virtual;
    procedure RepaintThsEditComboForHelperProcessSing(vPanelGroupboxPagecontrolTabsheet: TWinControl);
//    procedure SetControlProperty(pControl: TWinControl; pCharCaseDegistir: Boolean);
//    procedure SetInputControlProperty(pCharCaseDegistir: Boolean);

    procedure SetButtonImages32(pButton: TButton; pImageNo: Integer);
    procedure SetButtonImages16(pButton: TButton; pImageNo: Integer);

    procedure CreateLangGuiContentFormforFormCaption();
  end;

implementation

uses
  Vcl.Styles.Utils.SystemMenu,
  Ths.Erp.Functions,
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  ufrmSysLangGuiContent, Ths.Erp.Database.Table.SysLangGuiContent;

{$R *.dfm}

{ TfrmBase }

constructor TfrmBase.Create(AOwner: TComponent; pParentForm: TForm=nil;
  pTable: TTable=nil; pIsPermissionControl: Boolean=False;
  pFormMode: TInputFormMod=ifmNone;
  pFormOndalikMode: TFormOndalikMod=fomNormal;
  pFormViewMode: TInputFormViewMod=ivmNormal);
begin
  FWithCommitTransaction := True;
  FWithRollbackTransaction := True;

  FParentForm := pParentForm;
  FFormMode := pFormMode;
  FFormViewMode := pFormViewMode;
  FFormOndalikMod := pFormOndalikMode;
  FTable := pTable;
  IsPermissionControlForm := pIsPermissionControl;

  inherited Create(AOwner);
end;

procedure TfrmBase.CreateLangGuiContentFormforFormCaption;
var
  vSysLangGuiContent: TSysLangGuiContent;
begin
  vSysLangGuiContent := TSysLangGuiContent.Create(TSingletonDB.GetInstance.DataBase);

  vSysLangGuiContent.Lang.Value := TSingletonDB.GetInstance.DataBase.ConnSetting.Language;
  vSysLangGuiContent.Code.Value := Self.Name;
  vSysLangGuiContent.ContentType.Value := LngFormCaption;
  vSysLangGuiContent.TableName1.Value := '';
  vSysLangGuiContent.Val.Value := Self.Caption;

  TfrmSysLangGuiContent.Create(Self, nil, vSysLangGuiContent, True, ifmCopyNewRecord, fomNormal, ivmSort).ShowModal;
  Self.Caption := getFormCaptionByLang(Self.Name, Self.Caption);
end;

procedure TfrmBase.AppEvntsBaseShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
//  if (Handled) and (Msg.CharCode = VK_ESCAPE) then
//    btnCloseClick(btnClose);
//  if Msg.CharCode = VK_RETURN then
//    SelectNext(Screen.ActiveControl, not Bool(GetKeyState(VK_SHIFT) and $80), True);
end;

procedure TfrmBase.btnAcceptClick(Sender: TObject);
begin
//
end;

procedure TfrmBase.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmBase.btnDeleteClick(Sender: TObject);
begin
//
end;

procedure TfrmBase.fillComboBoxData(var pControl: TCombobox;
  pTable: TTable; const pFieldName, pFilter: string;
  pWithObject: Boolean; pAddEmptyOne: Boolean);
var
  n1: Integer;
  ctx: TRttiContext;
  typ: TRttiType;
  fld: TRttiField;
  AValue: TValue;
  AObject: TObject;
begin
  pTable.SelectToList(pFilter, False, False);
  pControl.Clear;
  pControl.Items.BeginUpdate;
  try
    if pAddEmptyOne then
      pControl.Items.Add('');

    for n1 := 0 to pTable.List.Count - 1 do
    begin
      typ := ctx.GetType(TTable(pTable.List[n1]).ClassInfo);

      if Assigned(typ) then
      begin
        for fld in typ.GetFields do
        begin
          if Assigned(fld) then
          begin
            if fld.FieldType is TRttiInstanceType then
            begin
              //TFieldDB olup olmadýðýný burada kontrol edebileceðimiz gibi aþaðýda da kontrol edebilirdik.
              if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TFieldDB) then
              begin
                AValue := fld.GetValue(TTable(pTable.List[n1]));
                AObject := nil;
                if not AValue.IsEmpty then
                  AObject := AValue.AsObject;

                if Assigned(AObject) then
                begin
                  //TFieldDB olup olmadýðýný burada da kontrol edebiliriz.
                  if AObject.InheritsFrom(TFieldDB) then
                  begin
                    if TFieldDB(AObject).FieldName = pFieldName then
                    begin
                      if pWithObject then
                        pControl.AddItem(TFieldDB(AObject).Value, TTable(pTable.List[n1]))
                      else
                        pControl.Items.Add(TFieldDB(AObject).Value);
                      Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  finally
    if pControl.Items.Count > 0 then
      pControl.ItemIndex := 0;

    pControl.Items.EndUpdate;
  end;
end;

function TfrmBase.FocusedFirstControl(panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean;
var
  nIndex, nProcessCount: Integer;
  PanelContainer: TWinControl;
begin
  nProcessCount := 0;
  nProcessCount := nProcessCount + 1;
  PanelContainer := nil;

  Result := False;
  if nProcessCount = 1 then
    Result := False;

  if panel_groupbox_pagecontrol_tabsheet = nil then
    PanelContainer := pnlMain
  else
  begin
    if panel_groupbox_pagecontrol_tabsheet.ClassType = TPanel then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TPanel
    else if panel_groupbox_pagecontrol_tabsheet.ClassType = TGroupBox then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TGroupBox
    else if panel_groupbox_pagecontrol_tabsheet.ClassType = TPageControl then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TPageControl
    else if panel_groupbox_pagecontrol_tabsheet.ClassType = TTabSheet then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TTabSheet;
  end;

  for nIndex := 0 to PanelContainer.ControlCount-1 do
  begin
    if Result then
      Exit;

    if PanelContainer.Controls[nIndex].ClassType = TPanel then
      Result := FocusedFirstControl(PanelContainer.Controls[nIndex] as TPanel)
    else if PanelContainer.Controls[nIndex].ClassType = TGroupBox then
      Result := FocusedFirstControl(PanelContainer.Controls[nIndex] as TGroupBox)
    else if PanelContainer.Controls[nIndex].ClassType = TPageControl then
      Result := FocusedFirstControl(PanelContainer.Controls[nIndex] as TPageControl)
    else if PanelContainer.Controls[nIndex].ClassType = TTabSheet then
    begin
      if PanelContainer is TPageControl then
      begin
        if TPageControl(PanelContainer).ActivePageIndex = TTabSheet(PanelContainer.Controls[nIndex]).TabIndex then
          Result := FocusedFirstControl(PanelContainer.Controls[nIndex] as TTabSheet)
      end
      else
        Result := FocusedFirstControl(PanelContainer.Controls[nIndex] as TTabSheet)
    end
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TCheckBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioGroup)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioButton)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TComboBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TMemo)
    then
    begin

      if  Self.Visible
      and TControl(TControl(PanelContainer.Controls[nIndex]).Parent).Visible
      and TControl(PanelContainer.Controls[nIndex]).Enabled
      and TControl(PanelContainer.Controls[nIndex]).Visible
      then
      begin
        TWinControl(PanelContainer.Controls[nIndex]).SetFocus;
        Result := True;
        break;
      end;
    end;
  end;
end;

procedure TfrmBase.RepaintThsEditComboForHelperProcessSing(vPanelGroupboxPagecontrolTabsheet: TWinControl);
var
  nIndex: Integer;
  PanelContainer: TWinControl;
begin
  PanelContainer := nil;

  if vPanelGroupboxPagecontrolTabsheet = nil then
    PanelContainer := pnlMain
  else
  begin
    if vPanelGroupboxPagecontrolTabsheet.ClassType = TPanel then
      PanelContainer := vPanelGroupboxPagecontrolTabsheet as TPanel
    else if vPanelGroupboxPagecontrolTabsheet.ClassType = TGroupBox then
      PanelContainer := vPanelGroupboxPagecontrolTabsheet as TGroupBox
    else if vPanelGroupboxPagecontrolTabsheet.ClassType = TPageControl then
      PanelContainer := vPanelGroupboxPagecontrolTabsheet as TPageControl
    else if vPanelGroupboxPagecontrolTabsheet.ClassType = TTabSheet then
      PanelContainer := vPanelGroupboxPagecontrolTabsheet as TTabSheet;
  end;

  for nIndex := 0 to PanelContainer.ControlCount-1 do
  begin
    if PanelContainer.Controls[nIndex].ClassType = TPanel then
      RepaintThsEditComboForHelperProcessSing(PanelContainer.Controls[nIndex] as TPanel)
    else if PanelContainer.Controls[nIndex].ClassType = TGroupBox then
      RepaintThsEditComboForHelperProcessSing(PanelContainer.Controls[nIndex] as TGroupBox)
    else if PanelContainer.Controls[nIndex].ClassType = TPageControl then
      RepaintThsEditComboForHelperProcessSing(PanelContainer.Controls[nIndex] as TPageControl)
    else if PanelContainer.Controls[nIndex].ClassType = TTabSheet then
    begin
      if PanelContainer is TPageControl then
      begin
        if TPageControl(PanelContainer).ActivePageIndex = TTabSheet(PanelContainer.Controls[nIndex]).TabIndex then
          RepaintThsEditComboForHelperProcessSing(PanelContainer.Controls[nIndex] as TTabSheet)
      end
      else
        RepaintThsEditComboForHelperProcessSing(PanelContainer.Controls[nIndex] as TTabSheet)
    end
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TCombobox)
    then
    begin
      TWinControl(PanelContainer.Controls[nIndex]).Repaint;
    end;
  end;
end;

procedure TfrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Self.Release;
end;

procedure TfrmBase.FormCreate(Sender: TObject);
//var
//  n1: Integer;
begin
  if Table <> nil then
  begin
    if Table.Id.Value > 0 then
      FDefaultSelectFilter := ' and ' + Table.TableName + '.id=' + IntToStr(Table.Id.Value);

//    if (FormMode = ifmNewRecord)
//    or (FormMode = ifmCopyNewRecord)
//    then
//      Table.Database.Connection.StartTransaction;
  end;

  if TSingletonDB.GetInstance.ImageList32 <> nil then
  begin
    btnDelete.Images := TSingletonDB.GetInstance.ImageList32;
    btnDelete.ImageIndex := IMG_REMOVE;
    btnDelete.HotImageIndex := IMG_REMOVE;

    btnAccept.Images := TSingletonDB.GetInstance.ImageList32;
    btnAccept.ImageIndex := IMG_ACCEPT;
    btnAccept.HotImageIndex := IMG_ACCEPT;

    btnClose.Images := TSingletonDB.GetInstance.ImageList32;
    btnClose.ImageIndex := IMG_CLOSE;
    btnClose.HotImageIndex := IMG_CLOSE;
  end;

  frmConfirmation := TfrmConfirmation.Create;

  btnSpin.OnDownClick := btnSpinDownClick;
  btnSpin.OnUpClick   := btnSpinUpClick;
  btnDelete.OnClick := btnDeleteClick;
  btnAccept.OnClick := btnAcceptClick;
  btnClose.OnClick := btnCloseClick;

  btnSpin.Visible := False;
  btnDelete.Visible := False;
  btnAccept.Visible := False;


  Self.Icon.LoadFromFile('Resource/formIcons/app_logo.ico');

  stbBase.Visible := False;
  //statusbar manual draw mode
//  for n1 := 0 to stbBase.Panels.Count - 1 do
//    stbBase.Panels.Items[n1].Style := psOwnerDraw;

  PostMessage(self.Handle, WM_AFTER_CREATE, 0, 0);
end;

procedure TfrmBase.FormDestroy(Sender: TObject);
begin
  if Assigned(Table) then
    Table.Destroy;

  btnSpin.Free;
  btnDelete.Free;
  btnAccept.Free;
  btnClose.Free;

  pnlBottom.Free;
  pnlMain.Free;

  frmConfirmation.Free;

  inherited;
end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
//  frmMain.RefreshStatusBar;
end;

procedure TfrmBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_ESCAPE) then
  begin
    Key := #0;
    btnCloseClick(btnClose);
  end
  else
  if Key = Char(VK_RETURN) then
  begin
    Key := #0;
    if (Sender is TWinControl) then
    begin
      if (Sender.ClassType <> TEdit)
      and (Sender.ClassType <> TMemo)
      and (Sender.ClassType <> TCombobox)
      then
       if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
          PostMessage((Sender as TWinControl).Handle, WM_NEXTDLGCTL, 1, 0)
       else
          PostMessage((Sender as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0);
    end;
  end
  else
    inherited;
//  frmMain.RefreshStatusBar;
end;

procedure TfrmBase.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  frmMain.RefreshStatusBar;

  if Key = VK_F4 then
  begin
    if btnDelete.Visible and btnDelete.Enabled and Self.Visible then
      btnDelete.Click;
  end
  else if Key = VK_F5 then
  begin
    if btnAccept.Visible and btnAccept.Enabled and Self.Visible then
      btnAccept.Click
  end
  else if Key = VK_F6 then
  begin
    if btnClose.Visible and btnClose.Enabled and Self.Visible then
      btnClose.Click;
  end
  else if Key = VK_F11 then
  begin
    Self.AlphaBlend := not Self.AlphaBlend;
    Self.AlphaBlendValue := 50;
  end;
end;

procedure TfrmBase.FormPaint(Sender: TObject);
begin
  inherited;
  RepaintThsEditComboForHelperProcessSing(pnlMain);
end;

procedure TfrmBase.FormResize(Sender: TObject);
begin
//
end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  inherited;
  FocusedFirstControl(pnlMain);

  btnClose.Caption := TranslateText('CLOSE', FrameworkLang.ButtonClose, LngButton, LngSystem);
  btnClose.Width := Canvas.TextWidth(btnClose.Caption) + 56;
  btnClose.Width := Max(100, btnClose.Width);

//  PostMessage(Self.Handle, WM_AFTER_SHOW, 0, 0);
end;

procedure TfrmBase.SetButtonImages16(pButton: TButton; pImageNo: Integer);
begin
  pButton.Images := TSingletonDB.GetInstance.ImageList16;
  pButton.HotImageIndex := pImageNo;
  pButton.ImageIndex := pImageNo;
end;

procedure TfrmBase.SetButtonImages32(pButton: TButton; pImageNo: Integer);
begin
  pButton.Images := TSingletonDB.GetInstance.ImageList32;
  pButton.HotImageIndex := pImageNo;
  pButton.ImageIndex := pImageNo;
end;

//procedure TfrmBase.SetControlProperty(pControl: TWinControl; pCharCaseDegistir: Boolean);
//var
//  vSysVisibleColumn: TSysGridColWidth;
//  vFieldName: string;
//  n1: Integer;
//begin
//  if Table <> nil then
//  begin
//    vFieldName := '';
//    if (pControl.ClassType = TEdit) then
//      vFieldName := TEdit(pControl).thsDBFieldName
//    else if (pControl.ClassType = TCombobox) then
//      vFieldName := TCombobox(pControl).thsDBFieldName
//    else if (pControl.ClassType = TMemo) then
//      vFieldName := TMemo(pControl).thsDBFieldName;
//
//    vSysVisibleColumn := TSysGridColWidth.Create(Table.Database);
//    try
//      vSysVisibleColumn.SelectToList(
//        ' and table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(Table.TableName)) +
//        ' and column_name=' + QuotedStr(ReplaceRealColOrTableNameTo(vFieldName)), False, False);
//
//      for n1 := 0 to vSysVisibleColumn.List.Count-1 do
//      begin
//        if (pControl.ClassType = TEdit) then
//        begin
//          TEdit(pControl).thsCaseUpLowSupportTr := True;
//          if pCharCaseDegistir then
//          begin
//            if TEdit(pControl).CharCase <> VCL.StdCtrls.ecLowerCase then
//              TEdit(pControl).CharCase := VCL.StdCtrls.ecUpperCase;
//          end;
//          TEdit(pControl).MaxLength := TSingletonDB.GetInstance.GetMaxLength(Table.TableName, vFieldName);
//          TEdit(pControl).thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Table.TableName, vFieldName);
//        end
//        else
//        if (pControl.ClassType = TCombobox) then
//        begin
//          TCombobox(pControl).thsCaseUpLowSupportTr := True;
//          if pCharCaseDegistir then
//          begin
//            if TCombobox(pControl).CharCase <> VCL.StdCtrls.ecLowerCase then
//              TCombobox(pControl).CharCase := VCL.StdCtrls.ecUpperCase;
//          end;
//          TCombobox(pControl).MaxLength := TSingletonDB.GetInstance.GetMaxLength(Table.TableName, vFieldName);
//          TCombobox(pControl).thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Table.TableName, vFieldName);
//        end
//        else if (pControl.ClassType = TMemo) then
//        begin
//          TMemo(pControl).thsCaseUpLowSupportTr := True;
//          if pCharCaseDegistir then
//          begin
//            if TMemo(pControl).CharCase <> VCL.StdCtrls.ecLowerCase then
//              TMemo(pControl).CharCase := VCL.StdCtrls.ecUpperCase;
//          end;
//          TMemo(pControl).MaxLength := TSingletonDB.GetInstance.GetMaxLength(Table.TableName, vFieldName);
//          TMemo(pControl).thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Table.TableName, vFieldName);
//        end;
//      end;
//    finally
//      vSysVisibleColumn.Free;
//    end;
//  end;
//end;

//procedure TfrmBase.SetInputControlProperty(pCharCaseDegistir: Boolean);
//var
//  n1: Integer;
//begin
//  for n1 := 0 to pnlMain.ControlCount-1 do
//  begin
//    if (pnlMain.Controls[n1].ClassType = TEdit)
//    or (pnlMain.Controls[n1].ClassType = TMemo)
//    or (pnlMain.Controls[n1].ClassType = TComboBox)
//    then
//    begin
//      SetControlProperty( TWinControl(pnlMain.Controls[n1]), pCharCaseDegistir );
//    end;
//  end;
//end;

procedure TfrmBase.stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
var
  vIco: Integer;
begin
//  stbBase.Font.Color  := clBlack;
//  stbBase.Brush.Color := clOlive;

  stbBase.Canvas.Font.Name := 'Tahoma';
  stbBase.Canvas.Font.Style := [fsBold];

  stbBase.Canvas.TextRect(Rect,
    Rect.Left + TSingletonDB.GetInstance.ImageList16.Width + 4,
    Rect.Top + (stbBase.Height-Canvas.TextHeight(Panel.Text)) div 2 - 2,
    Panel.Text);

  vIco := -1;
  case Panel.Index of
    STATUS_SQL_SERVER: vIco := IMG_DATABASE;
    STATUS_DATE: vIco := IMG_CALENDAR;
//    STATUS_EX_RATE_USD: vIco := IMG_SEARCH;
//    STATUS_EX_RATE_EUR: vIco := IMG_SEARCH;
    STATUS_USERNAME: vIco := IMG_USER_HE;
    STATUS_KEY_F4: vIco := IMG_FAVORITE;
    STATUS_KEY_F5: vIco := IMG_FAVORITE;
    STATUS_KEY_F6: vIco := IMG_FAVORITE;
    STATUS_KEY_F7: vIco := IMG_FAVORITE;
  end;

  if vIco > -1 then
  begin
    TSingletonDB.GetInstance.ImageList16.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, vIco);
    Panel.Width := stbBase.Canvas.TextWidth(Panel.Text)+ TSingletonDB.GetInstance.ImageList16.Width + 16;
  end;
end;

procedure TfrmBase.btnSpinDownClick(Sender: TObject);
begin
//
end;

procedure TfrmBase.btnSpinUpClick(Sender: TObject);
begin
//
end;

function TfrmBase.ValidateInput(panel_groupbox_pagecontrol_tabsheet: TWinControl): boolean;
var
  nIndex, nIndex2, nProcessCount: Integer;
  PanelContainer: TWinControl;

  function ValidateSubControls(Sender: TWinControl): Boolean;
  var
    nIndex: Integer;
  begin
    Result := True;
    if (Sender.ClassType = TEdit)
    or (Sender.ClassType = TMemo)
    or (Sender.ClassType = TCombobox)
    then
    begin
      if Sender.ClassType = TEdit then
      begin
        if (TEdit(Sender).thsRequiredData) then
          if (TEdit(Sender).Text = '') then
            Result := False;
          TEdit(Sender).Repaint;
      end
      else
      if Sender.ClassType = TMemo then
      begin
        if (TMemo(Sender).thsRequiredData) then
          if (TMemo(Sender).Text = '') then
            Result := False;
        TMemo(Sender).Repaint;
      end
      else if Sender.ClassType = TCombobox then
      begin
        if (TCombobox(Sender).thsRequiredData) then
          if (TCombobox(Sender).Text  = '') then
            Result := False;
        TCombobox(Sender).Repaint;
      end;
    end
    else
    begin
      for nIndex := 0 to Sender.ControlCount -1 do
      begin
        if Sender.Controls[nIndex].ClassType = TEdit then
        begin
          if (TEdit(Sender.Controls[nIndex]).thsRequiredData) then
            if (TEdit(Sender.Controls[nIndex]).Text = '') then
              Result := False;
          TEdit(Sender.Controls[nIndex]).Repaint;
        end
        else
        if Sender.Controls[nIndex].ClassType = TMemo then
        begin
          if (TMemo(Sender.Controls[nIndex]).thsRequiredData) then
            if (TMemo(Sender.Controls[nIndex]).Text = '') then
              Result := False;
          TMemo(Sender.Controls[nIndex]).Repaint;
        end
        else if Sender.Controls[nIndex].ClassType = TCombobox then
        begin
          if (TCombobox(Sender.Controls[nIndex]).thsRequiredData) then
            if (TCombobox(Sender.Controls[nIndex]).Text  = '') then
              Result := False;
          TCombobox(Sender.Controls[nIndex]).Repaint;
        end;
      end;
    end;
  end;

begin
  nProcessCount := 0;
  nProcessCount := nProcessCount + 1;
  Result := true;
  PanelContainer := nil;

  if panel_groupbox_pagecontrol_tabsheet = nil then
    PanelContainer := pnlMain
  else
  begin
    if panel_groupbox_pagecontrol_tabsheet.ClassType = TPanel then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TPanel
    else if panel_groupbox_pagecontrol_tabsheet.ClassType = TGroupBox then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TGroupBox
    else if panel_groupbox_pagecontrol_tabsheet.ClassType = TPageControl then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TPageControl
    else if panel_groupbox_pagecontrol_tabsheet.ClassType = TTabSheet then
      PanelContainer := panel_groupbox_pagecontrol_tabsheet as TTabSheet;
  end;

  if (FormMode=ifmUpdate) or (FormMode=ifmNewRecord) or (FormMode=ifmCopyNewRecord) then
  begin
    for nIndex := 0 to PanelContainer.ControlCount -1 do
    begin
      if PanelContainer.Controls[nIndex].ClassType = TPanel then
        if not ValidateSubControls(PanelContainer.Controls[nIndex] as TPanel) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TGroupBox then
        if not ValidateSubControls(PanelContainer.Controls[nIndex] as TGroupBox) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TPageControl then
        for nIndex2 := 0 to (PanelContainer.Controls[nIndex] as TPageControl).PageCount-1 do
          if not ValidateSubControls((PanelContainer.Controls[nIndex] as TPageControl).Pages[nIndex2]) then
            Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TTabSheet then
        if not ValidateSubControls(PanelContainer.Controls[nIndex] as TTabSheet) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TEdit then
        if not ValidateSubControls( TEdit(PanelContainer.Controls[nIndex]) ) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TMemo then
        if not ValidateSubControls(TMemo(PanelContainer.Controls[nIndex])) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TCombobox then
        if not ValidateSubControls(TCombobox(PanelContainer.Controls[nIndex])) then
          Result := False;
    end;
  end;

  if (nProcessCount=1) then
  begin
    Repaint;
    if (not Result) then
    begin
      raise Exception.Create(
          TranslateText('Can''t be empty required input controls!', FrameworkLang.ErrorRequiredData, LngMsgError, LngSystem) +
          AddLBs(2) +
          TranslateText('Red colored controls are required', FrameworkLang.ErrorRedInputsRequired, LngMsgError, LngSystem)
      );
    end;
  end;
end;

procedure TfrmBase.WmAfterShow(var Msg: TMessage);
begin
  //
end;

procedure TfrmBase.WmAfterCreate(var Msg: TMessage);
begin
//
end;

end.
