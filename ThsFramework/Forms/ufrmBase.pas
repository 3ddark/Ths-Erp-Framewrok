unit ufrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.AppEvnts,
  System.ImageList, Vcl.ImgList, Vcl.Graphics,

  Ths.Erp.Database.Table,
  thsEdit, //fyComboBox, fyMemo,
  Ths.Erp.Database.Table.SysVisibleColumn;

const
  WM_AFTER_SHOW = WM_USER + 300; // custom message
  WM_AFTER_CREATE = WM_USER + 301; // custom message

type
  TInputFormMod = (ifmNone, ifmNewRecord, ifmRewiev, ifmUpdate, ifmReadOnly);

type
  TfrmBase = class(TForm)
    pnlBottom: TPanel;
    pnlMain: TPanel;
    AppEvntsBase: TApplicationEvents;
    btnSpin: TSpinButton;
    btnAccept: TBitBtn;
    btnDelete: TBitBtn;
    btnClose: TBitBtn;
    il32x32: TImageList;
    il16x16: TImageList;
    stbBase: TStatusBar;
    procedure btnCloseClick(Sender: TObject);virtual;
    procedure btnAcceptClick(Sender: TObject);virtual;
    procedure btnDeleteClick(Sender: TObject);virtual;
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
      const Rect: TRect);
  private
    FTable: TTable;
    FFormMode: TInputFormMod;
    FWithCommitTransaction: Boolean;
    FWithRollbackTransaction: Boolean;
    FDefaultSelectFilter: string;
    FPermissionSourceForm: string;
    FIsPermissionControlForm: Boolean;
    FParentForm: TForm;

  protected
    function ValidateInput(panel_groupbox_pagecontrol_tabsheet: TWinControl = nil):boolean;virtual;
  public
    property Table                    : TTable  read FTable                     write FTable;
    property FormMode                 : TInputFormMod read FFormMode            write FFormMode;
    property WithCommitTransaction    : Boolean read FWithCommitTransaction     write FWithCommitTransaction;
    property WithRollbackTransaction  : Boolean read FWithRollbackTransaction   write FWithRollbackTransaction;
    property DefaultSelectFilter      : string  read FDefaultSelectFilter       write FDefaultSelectFilter;
    property PermissionSourceForm     : string  read FPermissionSourceForm      write FPermissionSourceForm;
    property IsPermissionControlForm  : Boolean read FIsPermissionControlForm   write FIsPermissionControlForm;
    property ParentForm               : TForm   read FParentForm                write FParentForm;

    constructor Create(AOwner: TComponent; pParentForm: TForm=nil;
        pTable: TTable=nil; pIsPermissionControl: Boolean=False;
        pFormMode: TInputFormMod=ifmNone);reintroduce;overload;

    function FocusedFirstControl(panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean; virtual;
    procedure SetControlProperty(pControl: TWinControl);
    procedure SetInputControlProperty();
  end;

implementation

uses
  Ths.Erp.SpecialFunctions,
  Ths.Erp.Constants,
  ufrmMain;

{$R *.dfm}

constructor TfrmBase.Create(AOwner: TComponent; pParentForm: TForm=nil;
  pTable: TTable=nil; pIsPermissionControl: Boolean=False;
  pFormMode: TInputFormMod=ifmNone);
begin
  WithCommitTransaction := True;
  WithRollbackTransaction := True;

  ParentForm := pParentForm;
  FormMode := pFormMode;
  Table := pTable;
  IsPermissionControlForm := pIsPermissionControl;

  inherited Create(AOwner);

  if Table <> nil then
  begin
    FDefaultSelectFilter := ' and ' + Table.TableName + '.id=' + IntToStr(Table.Id);

    if pFormMode = ifmNewRecord then
      Table.Database.Connection.StartTransaction;
  end;
end;

procedure TfrmBase.AppEvntsBaseShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
//  if (Handled) and (Msg.CharCode = VK_ESCAPE) then
//    Self.Close;
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
      Result := FocusedFirstControl(PanelContainer.Controls[nIndex] as TTabSheet)
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TCheckBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioGroup)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioButton)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TComboBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TEdit)
    //or (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyComboBox)
    //or (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyMemo)
    then
    begin

      if Self.Visible and TWinControl(TWinControl(PanelContainer.Controls[nIndex]).Parent).Visible and TWinControl(PanelContainer.Controls[nIndex]).Enabled and TWinControl(PanelContainer.Controls[nIndex]).Visible then
      begin
        TWinControl(PanelContainer.Controls[nIndex]).SetFocus;
        Result := True;
        break;
      end;
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
  inherited;

  btnSpin.OnDownClick := btnSpinDownClick;
  btnSpin.OnUpClick   := btnSpinUpClick;
  btnDelete.OnClick := btnDeleteClick;
  btnAccept.OnClick := btnAcceptClick;
  btnClose.OnClick := btnCloseClick;

  btnSpin.Visible := False;
  btnDelete.Visible := False;
  btnAccept.Visible := False;

  stbBase.Visible := False;

  btnClose.Caption := 'CLOSE';

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

  inherited;
end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
//  frmMain.RefreshStatusBar;
end;

procedure TfrmBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if Key = Char(VK_ESCAPE) then
  begin
    Key := #0;
    btnCloseClick(btnClose);
  end;

  if (Sender is TWinControl) then
  begin
    if (Sender.ClassType <> TthsEdit)
    //and (Sender.ClassType <> TfyMemo)
    //and (Sender.ClassType <> TfyComboBox)
    then
      if Key = Char(VK_RETURN) then
      begin
        Key := #0;
       if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
          PostMessage((Sender as TWinControl).Handle, WM_NEXTDLGCTL, 1, 0)
       else
          PostMessage((Sender as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0);
      end;
  end;

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
  end;
end;

procedure TfrmBase.FormPaint(Sender: TObject);
begin
//
end;

procedure TfrmBase.FormResize(Sender: TObject);
begin
//
end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  inherited;
  FocusedFirstControl(pnlMain);


    stbBase.Panels.Items[STATUS_SQL_SERVER].Text :=
        frmMain.SingletonDB.DataBase.Connection.Params.Values['Server'];

    stbBase.Panels.Items[STATUS_DATE].Text :=
        DateToStr(frmMain.SingletonDB.DataBase.GetToday(False));

    stbBase.Panels.Items[STATUS_EX_RATE_USD].Text := FloatToStr(4.1234);

    stbBase.Panels.Items[STATUS_EX_RATE_EUR].Text := FloatToStr(5.3214);

    stbBase.Panels.Items[STATUS_USERNAME].Text := frmMain.SingletonDB.User.UserName;

    stbBase.Panels.Items[STATUS_KEY_F4].Text := 'F4 DELETE';
    stbBase.Panels.Items[STATUS_KEY_F5].Text := 'F5 CONFIRM';
    stbBase.Panels.Items[STATUS_KEY_F6].Text := 'F6 CANCEL';
    stbBase.Panels.Items[STATUS_KEY_F7].Text := 'F7 ADD RECORD';

  PostMessage(Self.Handle, WM_AFTER_SHOW, 0, 0);
end;

procedure TfrmBase.SetControlProperty(pControl: TWinControl);
var
  vSysVisibleColumn: TSysVisibleColumns;
  vFieldName: string;
  n1: Integer;
begin
  if Table <> nil then
  begin
    vFieldName := '';
    if pControl.ClassType = TthsEdit then
      vFieldName := TthsEdit(pControl).thsDBFieldName;

    vSysVisibleColumn := TSysVisibleColumns.Create(Table.Database);
    try
      vSysVisibleColumn.SelectToList(
        ' and table_name=' + QuotedStr(Table.TableName) +
        ' and column_name=' + QuotedStr(vFieldName), False, False);

      for n1 := 0 to vSysVisibleColumn.List.Count-1 do
      begin
        TthsEdit(pControl).MaxLength := TSysVisibleColumns(vSysVisibleColumn.List[n1]).GUIMaxLength;
        TthsEdit(pControl).thsRequiredData := TSysVisibleColumns(vSysVisibleColumn.List[n1]).GUIIsRequired;
      end;
    finally
      vSysVisibleColumn.Free;
    end;
  end;
end;

procedure TfrmBase.SetInputControlProperty;
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
    //or (pnlMain.Controls[n1].ClassType = TfyMemo)
    //or (pnlMain.Controls[n1].ClassType = TfyComboBox)
    then
      SetControlProperty( TWinControl(pnlMain.Controls[n1]) );
  end;
end;

procedure TfrmBase.stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
var
  vIco: Integer;
begin
  Font.Color  := clBlack;
  Brush.Color := clOlive;

  Font.Style := [fsBold];
  stbBase.Canvas.TextRect(Rect,
    Rect.Left + il16x16.Width + 4,
    Rect.Top + (stbBase.Height-Canvas.TextHeight(Panel.Text)) div 2,
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
    il16x16.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, vIco);
    Panel.Width := stbBase.Canvas.TextWidth(Panel.Text)+ il16x16.Width + 8;
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
//    or (Sender.ClassType = TfyMemo)
//    or (Sender.ClassType = TfyComboBox)
    then
    begin
      if Sender.ClassType = TthsEdit then
      begin
        if (TthsEdit(Sender).thsRequiredData) then
          if (TthsEdit(Sender).Text = '') then
            Result := False;
          TthsEdit(Sender).Repaint;
      end
//      else
//      if Sender.ClassType = TfyMemo then
//      begin
//        if (TfyMemo(Sender).frhtRequiredData) then
//          if (TfyMemo(Sender).Text = '') then
//            Result := False;
//        TfyMemo(Sender).Repaint;
//      end
//      else if Sender.ClassType = TfyComboBox then
//      begin
//        if (TfyComboBox(Sender).frhtRequiredData) then
//          if (TfyComboBox(Sender).Text  = '') then
//            Result := False;
//        TfyComboBox(Sender).Repaint;
//      end;
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
//        else
//        if Sender.Controls[nIndex].ClassType = TfyMemo then
//        begin
//          if (TfyMemo(Sender.Controls[nIndex]).frhtRequiredData) then
//            if (TfyMemo(Sender.Controls[nIndex]).Text = '') then
//              Result := False;
//          TfyMemo(Sender.Controls[nIndex]).Repaint;
//        end
//        else if Sender.Controls[nIndex].ClassType = TfyComboBox then
//        begin
//          if (TfyComboBox(Sender.Controls[nIndex]).frhtRequiredData) then
//            if (TfyComboBox(Sender.Controls[nIndex]).Text  = '') then
//              Result := False;
//          TfyComboBox(Sender.Controls[nIndex]).Repaint;
//        end;
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

//      if PanelContainer.Controls[nIndex].ClassType = TfyMemo then
//        if not ValidateSubControls(TfyMemo(PanelContainer.Controls[nIndex])) then
//          Result := False;
//
//      if PanelContainer.Controls[nIndex].ClassType = TfyComboBox then
//        if not ValidateSubControls(TfyComboBox(PanelContainer.Controls[nIndex])) then
//          Result := False;
    end;
  end;

  if (nProcessCount=1) then
  begin
    Repaint;
    if (not Result) then
      raise Exception.Create('Can''t be empty required input controls!' +
                             TSpecialFunctions.AddLineBreak(2) +
                             'Red colored controls are required');
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
