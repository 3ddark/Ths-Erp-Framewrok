unit ufrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.AppEvnts,

  Ths.Erp.Database.Table,
  fyEdit, fyComboBox, fyMemo;

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
  end;

implementation

uses
  Ths.Erp.SpecialFunctions,
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
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyComboBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TCheckBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioGroup)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioButton)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyMemo)
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

  btnClose.Caption := 'CLOSE';

  PostMessage(self.Handle, WM_AFTER_CREATE, 0, 0);
end;

procedure TfrmBase.FormDestroy(Sender: TObject);
begin
  if Assigned(Table) then
    Table.Free;

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
//  frmMain.RefreshStatusBar;
end;

procedure TfrmBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_ESCAPE) then
  begin
    Key := #0;
    btnCloseClick(btnClose);
  end;

  if (Sender is TWinControl) then
  begin
    if (Sender.ClassType <> TfyEdit)
    and (Sender.ClassType <> TfyMemo)
    and (Sender.ClassType <> TfyComboBox)
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

  PostMessage(Self.Handle, WM_AFTER_SHOW, 0, 0);
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
    if (Sender.ClassType = TfyEdit)
    or (Sender.ClassType = TfyMemo)
    or (Sender.ClassType = TfyComboBox)
    then
    begin
      if Sender.ClassType = TfyEdit then
      begin
        if (TfyEdit(Sender).frhtRequiredData) then
          if (TfyEdit(Sender).Text = '') then
            Result := False;
          TfyEdit(Sender).Repaint;
      end
      else
      if Sender.ClassType = TfyMemo then
      begin
        if (TfyMemo(Sender).frhtRequiredData) then
          if (TfyMemo(Sender).Text = '') then
            Result := False;
        TfyMemo(Sender).Repaint;
      end
      else if Sender.ClassType = TfyComboBox then
      begin
        if (TfyComboBox(Sender).frhtRequiredData) then
          if (TfyComboBox(Sender).Text  = '') then
            Result := False;
        TfyComboBox(Sender).Repaint;
      end;
    end
    else
    begin
      for nIndex := 0 to Sender.ControlCount -1 do
      begin
        if Sender.Controls[nIndex].ClassType = TfyEdit then
        begin
          if (TfyEdit(Sender.Controls[nIndex]).frhtRequiredData) then
            if (TfyEdit(Sender.Controls[nIndex]).Text = '') then
              Result := False;
          TfyEdit(Sender.Controls[nIndex]).Repaint;
        end
        else
        if Sender.Controls[nIndex].ClassType = TfyMemo then
        begin
          if (TfyMemo(Sender.Controls[nIndex]).frhtRequiredData) then
            if (TfyMemo(Sender.Controls[nIndex]).Text = '') then
              Result := False;
          TfyMemo(Sender.Controls[nIndex]).Repaint;
        end
        else if Sender.Controls[nIndex].ClassType = TfyComboBox then
        begin
          if (TfyComboBox(Sender.Controls[nIndex]).frhtRequiredData) then
            if (TfyComboBox(Sender.Controls[nIndex]).Text  = '') then
              Result := False;
          TfyComboBox(Sender.Controls[nIndex]).Repaint;
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

      if PanelContainer.Controls[nIndex].ClassType = TfyEdit then
        if not ValidateSubControls( TfyEdit(PanelContainer.Controls[nIndex]) ) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TfyMemo then
        if not ValidateSubControls(TfyMemo(PanelContainer.Controls[nIndex])) then
          Result := False;

      if PanelContainer.Controls[nIndex].ClassType = TfyComboBox then
        if not ValidateSubControls(TfyComboBox(PanelContainer.Controls[nIndex])) then
          Result := False;
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
