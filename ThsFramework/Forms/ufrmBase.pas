unit ufrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.AppEvnts,

  uConstGenel,
  Ths.Erp.Database.Table,
  fyEdit, fyComboBox, fyMemo;

const
  WM_AFTER_SHOW = WM_USER + 300; // custom message
  WM_AFTER_CREATE = WM_USER + 301; // custom message

type
  TfrmBase = class(TForm)
    PanelMain: TPanel;
    PanelBottom: TPanel;
    AppEvntsBase: TApplicationEvents;
    btnSpin: TSpinButton;
    btnTamam: TBitBtn;
    btnSil: TBitBtn;
    btnKapat: TBitBtn;
    procedure btnKapatClick(Sender: TObject);virtual;
    procedure btnTamamClick(Sender: TObject);virtual;
    procedure btnSilClick(Sender: TObject);virtual;
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
    FTable                    : TTable;
    FFormTipi                 : Integer;
    FWithCommitTransaction    : Boolean;
    FWithRollbackTransaction  : Boolean;
    FDefaultSelectFilter      : string;
    FKaynakAdi                : string;
    FIsErisimKontrol          : Boolean;
    FParentForm               : TForm;

  protected
    function ValidateInput(panel_groupbox_pagecontrol_tabsheet: TWinControl = nil):boolean;virtual;
  public
    property Table                    : TTable  read FTable                     write FTable;
    property DefaultSelectFilter      : string  read FDefaultSelectFilter       write FDefaultSelectFilter;
    property FormTipi                 : Integer read FFormTipi                  write FFormTipi;
    property WithCommitTransaction    : Boolean read FWithCommitTransaction     write FWithCommitTransaction;
    property WithRollbackTransaction  : Boolean read FWithRollbackTransaction   write FWithRollbackTransaction;
    property KaynakAdi								: string  read FKaynakAdi                 write FKaynakAdi;
    property IsErisimKontrol          : Boolean read FIsErisimKontrol           write FIsErisimKontrol;
    property ParentForm               : TForm   read FParentForm                write FParentForm;

    constructor Create(AOwner: TComponent; pParentForm: TForm=nil;
        pTable: TTable=nil; pKaynakAdi: string=''; pIsErisimKontrol: Boolean=False;
        pFormTipi: Integer=-1);reintroduce;overload;

    function FocusedFirstControl(panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean; virtual;
  end;

implementation

uses
  ufrmMain;

{$R *.dfm}

constructor TfrmBase.Create(AOwner: TComponent; pParentForm: TForm=nil;
    pTable: TTable=nil; pKaynakAdi: string=''; pIsErisimKontrol: Boolean=False;
    pFormTipi: Integer=-1);
begin
  WithCommitTransaction := True;
  WithRollbackTransaction := True;

  ParentForm := pParentForm;
  FormTipi := pFormTipi;
  Table := pTable;
  IsErisimKontrol := pIsErisimKontrol;
  if Table <> nil then
    FKaynakAdi := Table.PermissionSourceCode
  else
    FKaynakAdi := '';

  inherited Create(AOwner);

  if Table <> nil then
  begin
    FDefaultSelectFilter := ' and ' + Table.TableName + '.id=' + IntToStr(Table.Id);

    if pFormTipi = FORM_YENI_KAYIT then
      Table.Database.Connection.GetConn.StartTransaction;
  end;
end;

procedure TfrmBase.AppEvntsBaseShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
//  if (Handled) and (Msg.CharCode = VK_ESCAPE) then
//    Self.Close;
//  if Msg.CharCode = VK_RETURN then
//    SelectNext(Screen.ActiveControl, not Bool(GetKeyState(VK_SHIFT) and $80), True);
end;

procedure TfrmBase.btnTamamClick(Sender: TObject);
begin
//
end;

procedure TfrmBase.btnKapatClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmBase.btnSilClick(Sender: TObject);
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
    PanelContainer := PanelMain
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
  btnSil.OnClick := btnSilClick;
  btnTamam.OnClick := btnTamamClick;
  btnKapat.OnClick := btnKapatClick;

  btnSpin.Visible := False;
  btnSil.Visible := False;
  btnTamam.Visible := False;

  btnKapat.Caption := 'KAPAT';

  PostMessage(self.Handle, WM_AFTER_CREATE, 0, 0);
end;

procedure TfrmBase.FormDestroy(Sender: TObject);
begin
  btnSpin.Free;
  btnSil.Free;
  btnTamam.Free;
  btnKapat.Free;

  PanelBottom.Free;
  PanelMain.Free;

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
    btnKapatClick(btnKapat);
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
    if btnSil.Visible and btnSil.Enabled then
      btnSil.Click;
  end
  else if Key = VK_F5 then
  begin
    if btnTamam.Visible and btnTamam.Enabled then
      btnTamam.Click
  end
  else if Key = VK_F6 then
  begin
    if btnKapat.Visible and btnKapat.Enabled then
      btnKapat.Click;
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
  FocusedFirstControl(PanelMain);

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
    PanelContainer := PanelMain
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

  if (FormTipi=FORM_GUNCELLEME ) or (FormTipi=FORM_YENI_KAYIT ) then
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
      raise Exception.Create('Zorunlu alanlarý boþ býrakamazsýnýz!');
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
