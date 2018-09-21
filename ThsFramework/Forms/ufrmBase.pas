unit ufrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Dialogs,
  Vcl.ImgList, Vcl.Graphics, Vcl.Menus,

  thsEdit, thsCombobox, thsMemo,

  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.SysGridColWidth;

const
  WM_AFTER_SHOW = WM_USER + 300; // custom message
  WM_AFTER_CREATE = WM_USER + 301; // custom message

type
  TInputFormMod = (ifmNone, ifmNewRecord, ifmRewiev, ifmUpdate, ifmReadOnly, ifmCopyNewRecord);
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
  public
    property Table: TTable read FTable write FTable;
    property FormMode: TInputFormMod read FFormMode write FFormMode;
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
        pFormOndalikMode: TFormOndalikMod=fomNormal);reintroduce;overload;virtual;
    function FocusedFirstControl(panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean; virtual;
    procedure RepaintThsEditComboForHelperProcessSing(vPanelGroupboxPagecontrolTabsheet: TWinControl);
    procedure SetControlProperty(pControl: TWinControl; pCharCaseDegistir: Boolean);
    procedure SetInputControlProperty(pCharCaseDegistir: Boolean);
  end;

implementation

uses
  Vcl.Styles.Utils.SystemMenu,
  Ths.Erp.SpecialFunctions,
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

{$R *.dfm}

{ TfrmBase }

constructor TfrmBase.Create(AOwner: TComponent; pParentForm: TForm=nil;
  pTable: TTable=nil; pIsPermissionControl: Boolean=False;
  pFormMode: TInputFormMod=ifmNone;
  pFormOndalikMode: TFormOndalikMod=fomNormal);
begin
  FWithCommitTransaction := True;
  FWithRollbackTransaction := True;

  FParentForm := pParentForm;
  FFormMode := pFormMode;
  FFormOndalikMod := pFormOndalikMode;
  FTable := pTable;
  IsPermissionControlForm := pIsPermissionControl;

  inherited Create(AOwner);
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
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsCombobox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TComboBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsMemo)
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
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsCombobox)
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
var
  n1: Integer;
begin
  if Table <> nil then
  begin
    FDefaultSelectFilter := ' and ' + Table.TableName + '.id=' + IntToStr(Table.Id.Value);

    if (FormMode = ifmNewRecord)
    or (FormMode = ifmCopyNewRecord)
    then
      Table.Database.Connection.StartTransaction;
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

  stbBase.Visible := False;

  //statusbar manual draw mode
  for n1 := 0 to stbBase.Panels.Count - 1 do
    stbBase.Panels.Items[n1].Style := psOwnerDraw;

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
      if (Sender.ClassType <> TthsEdit)
      and (Sender.ClassType <> TthsMemo)
      and (Sender.ClassType <> TthsCombobox)
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
    if btnDelete.Visible and btnDelete.Enabled then
      btnDelete.Click;
  end
  else if Key = VK_F5 then
  begin
    if btnAccept.Visible and btnAccept.Enabled then
      btnAccept.Click
  end
  else if Key = VK_F6 then
  begin
    if btnClose.Visible and btnClose.Enabled then
      btnClose.Click;
  end
  else if Key = VK_F11 then
  begin
    Self.AlphaBlend := not Self.AlphaBlend;
    Self.AlphaBlendValue := 70;
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

  if stbBase.Panels.Count >= STATUS_SQL_SERVER+1 then
    if TSingletonDB.GetInstance.DataBase.Connection.Connected then
      stbBase.Panels.Items[STATUS_SQL_SERVER].Text :=
          TSingletonDB.GetInstance.DataBase.Connection.Params.Values['Server'];

  if stbBase.Panels.Count >= STATUS_DATE+1 then
    if TSingletonDB.GetInstance.DataBase.Connection.Connected then
      stbBase.Panels.Items[STATUS_DATE].Text :=
          DateToStr(TSingletonDB.GetInstance.DataBase.GetToday(False));

  if stbBase.Panels.Count >= STATUS_EX_RATE_USD+1 then
    stbBase.Panels.Items[STATUS_EX_RATE_USD].Text := FloatToStr(4.1234);

  if stbBase.Panels.Count >= STATUS_EX_RATE_EUR+1 then
    stbBase.Panels.Items[STATUS_EX_RATE_EUR].Text := FloatToStr(5.3214);

  if stbBase.Panels.Count >= STATUS_USERNAME+1 then
    if TSingletonDB.GetInstance.DataBase.Connection.Connected then
      stbBase.Panels.Items[STATUS_USERNAME].Text := TSingletonDB.GetInstance.User.UserName.Value;


  if stbBase.Panels.Count >= STATUS_KEY_F4+1 then
    stbBase.Panels.Items[STATUS_KEY_F4].Text := 'F4 ' + TranslateText('DELETE', FrameworkLang.StatusDelete, LngStatus, LngSystem);
  if stbBase.Panels.Count >= STATUS_KEY_F5+1 then
    stbBase.Panels.Items[STATUS_KEY_F5].Text := 'F5 ' + TranslateText('CONFIRM', FrameworkLang.StatusAccept, LngStatus, LngSystem);
  if stbBase.Panels.Count >= STATUS_KEY_F6+1 then
    stbBase.Panels.Items[STATUS_KEY_F6].Text := 'F6 ' + TranslateText('CANCEL', FrameworkLang.StatusCancel, LngStatus, LngSystem);
  if stbBase.Panels.Count >= STATUS_KEY_F7+1 then
    stbBase.Panels.Items[STATUS_KEY_F7].Text := 'F7 ' + TranslateText('ADD RECORD', FrameworkLang.StatusAdd, LngStatus, LngSystem);

  btnClose.Caption := TranslateText('CLOSE', FrameworkLang.ButtonClose, LngButton, LngSystem);


  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
    if TSingletonDB.GetInstance.User.IsSuperUser.Value then
      TVclStylesSystemMenu.Create(Self);

  PostMessage(Self.Handle, WM_AFTER_SHOW, 0, 0);
end;

procedure TfrmBase.SetControlProperty(pControl: TWinControl; pCharCaseDegistir: Boolean);
var
  vSysVisibleColumn: TSysGridColWidth;
  vFieldName: string;
  n1: Integer;
begin
  if Table <> nil then
  begin
    vFieldName := '';
    if (pControl.ClassType = TthsEdit) then
      vFieldName := TthsEdit(pControl).thsDBFieldName
    else if (pControl.ClassType = TthsCombobox) then
      vFieldName := TthsCombobox(pControl).thsDBFieldName
    else if (pControl.ClassType = TthsMemo) then
      vFieldName := TthsMemo(pControl).thsDBFieldName;

    vSysVisibleColumn := TSysGridColWidth.Create(Table.Database);
    try
      vSysVisibleColumn.SelectToList(
        ' and table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(Table.TableName)) +
        ' and column_name=' + QuotedStr(ReplaceRealColOrTableNameTo(vFieldName)), False, False);

      for n1 := 0 to vSysVisibleColumn.List.Count-1 do
      begin
        if (pControl.ClassType = TthsEdit) then
        begin
          TthsEdit(pControl).thsCaseUpLowSupportTr := True;
          if pCharCaseDegistir then
          begin
            if TthsEdit(pControl).CharCase <> VCL.StdCtrls.ecLowerCase then
              TthsEdit(pControl).CharCase := VCL.StdCtrls.ecUpperCase;
          end;
          TthsEdit(pControl).MaxLength := TSingletonDB.GetInstance.GetMaxLength(Table.TableName, vFieldName);
          TthsEdit(pControl).thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Table.TableName, vFieldName);
        end
        else
        if (pControl.ClassType = TthsCombobox) then
        begin
          TthsCombobox(pControl).thsCaseUpLowSupportTr := True;
          if pCharCaseDegistir then
          begin
            if TthsCombobox(pControl).CharCase <> VCL.StdCtrls.ecLowerCase then
              TthsCombobox(pControl).CharCase := VCL.StdCtrls.ecUpperCase;
          end;
          TthsCombobox(pControl).MaxLength := TSingletonDB.GetInstance.GetMaxLength(Table.TableName, vFieldName);
          TthsCombobox(pControl).thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Table.TableName, vFieldName);
        end
        else if (pControl.ClassType = TthsMemo) then
        begin
          TthsMemo(pControl).thsCaseUpLowSupportTr := True;
          if pCharCaseDegistir then
          begin
            if TthsMemo(pControl).CharCase <> VCL.StdCtrls.ecLowerCase then
              TthsMemo(pControl).CharCase := VCL.StdCtrls.ecUpperCase;
          end;
          TthsMemo(pControl).MaxLength := TSingletonDB.GetInstance.GetMaxLength(Table.TableName, vFieldName);
          TthsMemo(pControl).thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Table.TableName, vFieldName);
        end;
      end;
    finally
      vSysVisibleColumn.Free;
    end;
  end;
end;

procedure TfrmBase.SetInputControlProperty(pCharCaseDegistir: Boolean);
var
  n1: Integer;
begin
  for n1 := 0 to pnlMain.ControlCount-1 do
  begin
    if (pnlMain.Controls[n1].ClassType = TEditS)
    or (pnlMain.Controls[n1].ClassType = TEdit)
    or (pnlMain.Controls[n1].ClassType = TMemo)
    or (pnlMain.Controls[n1].ClassType = TComboBox)
    or (pnlMain.Controls[n1].ClassType = TthsEdit)
    or (pnlMain.Controls[n1].ClassType = TthsMemo)
    or (pnlMain.Controls[n1].ClassType = TthsCombobox)
    then
      SetControlProperty( TWinControl(pnlMain.Controls[n1]), pCharCaseDegistir );
  end;
end;

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
    STATUS_EX_RATE_USD: vIco := IMG_SEARCH;
    STATUS_EX_RATE_EUR: vIco := IMG_SEARCH;
    STATUS_USERNAME: vIco := IMG_USER_HE;
    STATUS_KEY_F4: vIco := IMG_FAVORITE;
    STATUS_KEY_F5: vIco := IMG_FAVORITE;
    STATUS_KEY_F6: vIco := IMG_FAVORITE;
    STATUS_KEY_F7: vIco := IMG_FAVORITE;
  end;

  if vIco > -1 then
  begin
    TSingletonDB.GetInstance.ImageList16.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, vIco);
    Panel.Width := stbBase.Canvas.TextWidth(Panel.Text)+ TSingletonDB.GetInstance.ImageList16.Width + 8;
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
    if (Sender.ClassType = TthsEdit)
    or (Sender.ClassType = TthsMemo)
    or (Sender.ClassType = TthsCombobox)
    then
    begin
      if Sender.ClassType = TthsEdit then
      begin
        if (TthsEdit(Sender).thsRequiredData) then
          if (TthsEdit(Sender).Text = '') then
            Result := False;
          TthsEdit(Sender).Repaint;
      end
      else
      if Sender.ClassType = TthsMemo then
      begin
        if (TthsMemo(Sender).thsRequiredData) then
          if (TthsMemo(Sender).Text = '') then
            Result := False;
        TthsMemo(Sender).Repaint;
      end
      else if Sender.ClassType = TthsCombobox then
      begin
        if (TthsCombobox(Sender).thsRequiredData) then
          if (TthsCombobox(Sender).Text  = '') then
            Result := False;
        TthsCombobox(Sender).Repaint;
      end;
    end
    else
    begin
      for nIndex := 0 to Sender.ControlCount -1 do
      begin
        if Sender.Controls[nIndex].ClassType = TthsEdit then
        begin
          if (TthsEdit(Sender.Controls[nIndex]).thsRequiredData) then
            if (TthsEdit(Sender.Controls[nIndex]).Text = '') then
              Result := False;
          TthsEdit(Sender.Controls[nIndex]).Repaint;
        end
        else
        if Sender.Controls[nIndex].ClassType = TthsMemo then
        begin
          if (TthsMemo(Sender.Controls[nIndex]).thsRequiredData) then
            if (TthsMemo(Sender.Controls[nIndex]).Text = '') then
              Result := False;
          TthsMemo(Sender.Controls[nIndex]).Repaint;
        end
        else if Sender.Controls[nIndex].ClassType = TthsCombobox then
        begin
          if (TthsCombobox(Sender.Controls[nIndex]).thsRequiredData) then
            if (TthsCombobox(Sender.Controls[nIndex]).Text  = '') then
              Result := False;
          TthsCombobox(Sender.Controls[nIndex]).Repaint;
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

  if (FormMode=ifmUpdate ) or (FormMode=ifmNewRecord ) then
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

      if PanelContainer.Controls[nIndex].ClassType = TthsEdit then
        if not ValidateSubControls( TthsEdit(PanelContainer.Controls[nIndex]) ) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TthsMemo then
        if not ValidateSubControls(TthsMemo(PanelContainer.Controls[nIndex])) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TthsCombobox then
        if not ValidateSubControls(TthsCombobox(PanelContainer.Controls[nIndex])) then
          Result := False;
    end;
  end;

  if (nProcessCount=1) then
  begin
    Repaint;
    if (not Result) then
    begin
      raise Exception.Create(
          TranslateText('Can''t be empty required input controls!', FrameworkLang.ErrorRequiredData, LngError, LngSystem) +
          AddLBs(2) +
          TranslateText('Red colored controls are required', FrameworkLang.ErrorRedInputsRequired, LngError, LngSystem)
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
