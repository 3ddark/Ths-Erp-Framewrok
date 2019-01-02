unit ufrmBaseInput;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
  Vcl.ComCtrls, Dialogs, System.Variants, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Rtti, Vcl.Graphics, Vcl.AppEvnts,
  System.StrUtils, Vcl.Menus,
  Data.DB,

  FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,
  ufrmBase,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Functions;


type
  TfrmBaseInput = class(TfrmBase)
    pmLabels: TPopupMenu;
    mniAddLanguageContent: TMenuItem;
    procedure btnCloseClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject); override;
    procedure mniAddLanguageContentClick(Sender: TObject);
    procedure RefreshData(); virtual;
  private
  protected
  public
    procedure SetControlsDisabledOrEnabled(pPanelGroupboxPagecontrolTabsheet: TWinControl = nil; pIsDisable: Boolean = True);
    procedure SetCaptionFromLangContent();
    procedure SetLabelPopup(Sender: TControl = nil);
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Constants,
  Ths.Erp.Database.Table.SysLangGuiContent,
  ufrmSysLangGuiContent;

{$R *.dfm}

procedure TfrmBaseInput.btnCloseClick(Sender: TObject);
begin
  if (FormMode = ifmRewiev) then
    inherited
  else
  begin
    if (CustomMsgDlg(
      TranslateText('Are you sure you want to exit?   All changes will be canceled!!!', FrameworkLang.MessageCloseWindow, LngMessage, LngSystem),
      mtConfirmation, mbYesNo, [TranslateText('Yes', FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                                TranslateText('No', FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                                TranslateText('Confirmation', FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes)
    then
      inherited;
  end;
end;

procedure TfrmBaseInput.FormCreate(Sender: TObject);
begin
  inherited;

  pmLabels.Images := TSingletonDB.GetInstance.ImageList16;
  mniAddLanguageContent.ImageIndex := IMG_ADD_DATA;

  TSingletonDB.GetInstance.HaneMiktari.SelectToList('', False, False);

  pnlBottom.Visible := False;
  stbBase.Visible := True;
  pnlBottom.Visible := True;
end;

procedure TfrmBaseInput.FormShow(Sender: TObject);
var
  vQualityFormNo: string;
  n1: Integer;
begin
  inherited;

  stbBase.Panels.Add;
  for n1 := 0 to stbBase.Panels.Count - 1 do
    stbBase.Panels.Items[n1].Style := psOwnerDraw;

  //Form Numarasý status bara yaz
  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
  begin
    vQualityFormNo := TSingletonDB.GetInstance.GetQualityFormNo(Table.TableName, True);
    if vQualityFormNo <> '' then
      stbBase.Panels.Items[STATUS_SQL_SERVER].Text := vQualityFormNo
    else
      stbBase.Panels.Items[STATUS_SQL_SERVER].Text := '';

    stbBase.Panels.Items[STATUS_SQL_SERVER].Width := stbBase.Width;
  end;

  SetCaptionFromLangContent();

  Self.Caption := TranslateText(Self.Caption, ReplaceRealColOrTableNameTo(Table.TableName), LngInputFormCaption);

  if Self.FormMode = ifmRewiev then
  begin
    //eðer baþka pencerede açýk transaction varsa güncelleme moduna hiç girilmemli
    if (Table.Database.TranscationIsStarted) then
    begin
      btnAccept.Visible   := False;
      btnDelete.Visible     := False;
      btnAccept.OnClick   := nil;
      btnDelete.OnClick     := nil;
    end;

    if ParentForm <> nil then
    begin
      btnSpin.Visible := True;
    end;

    //Burada inceleme modunda olduðu için bütün kontrolleri kapatmak gerekiyor.
    SetControlsDisabledOrEnabled(pnlMain, True);
  end
  else
  begin
    //Burada yeni kayýt veya güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
    SetControlsDisabledOrEnabled(pnlMain, False);
  end;

  mniAddLanguageContent.Visible := False;
  if (TSingletonDB.GetInstance.User.IsSuperUser.Value) and (FormMode = ifmRewiev) then
  begin
    //yeni kayýtta transactionlardan dolayý sorun oluyor. Düzeltmek için uðralýlmadý
    SetLabelPopup();
    mniAddLanguageContent.Visible := True;
  end;

//  if (FormMode <> ifmNewRecord ) then
//    RefreshData;
//ferhat buraya bak normal input db formlarda iki kere refreshdata yapýyor. Bunu engelle
//detaylý formlarda da refresh yapmalý fakat input db formlarýndan gelmediði için burada yapýldý.
//yapýyý gözden geçir

  Application.ProcessMessages;

end;

procedure TfrmBaseInput.mniAddLanguageContentClick(Sender: TObject);
var
  vSysLangGuiContent: TSysLangGuiContent;
  vCode, vValue, vContentType, vTableName: string;
begin
  if pmLabels.PopupComponent.ClassType = TLabel then
  begin
    vCode := StringReplace(pmLabels.PopupComponent.Name, PREFIX_LABEL, '', [rfReplaceAll]);
    vContentType := LngInputLabelCaption;
    vTableName := ReplaceRealColOrTableNameTo(Table.TableName);
    vValue := TLabel(pmLabels.PopupComponent).Caption;
  end
  else
  if pmLabels.PopupComponent.ClassType = TTabSheet then
  begin
    vCode := StringReplace(pmLabels.PopupComponent.Name, PREFIX_TABSHEET, '', [rfReplaceAll]);
    vContentType := LngTab;
    vTableName := ReplaceRealColOrTableNameTo(Table.TableName);
    vValue := TTabSheet(pmLabels.PopupComponent).Caption;
  end;


  vSysLangGuiContent := TSysLangGuiContent.Create(TSingletonDB.GetInstance.DataBase);

  vSysLangGuiContent.Lang.Value := TSingletonDB.GetInstance.DataBase.ConnSetting.Language;
  vSysLangGuiContent.Code.Value := vCode;
  vSysLangGuiContent.ContentType.Value := vContentType;
  vSysLangGuiContent.TableName1.Value := vTableName;
  vSysLangGuiContent.Value.Value := vValue;

  TfrmSysLangGuiContent.Create(Self, nil, vSysLangGuiContent, True, ifmCopyNewRecord).ShowModal;

  SetCaptionFromLangContent();
end;

procedure TfrmBaseInput.RefreshData;
begin
  //
end;

procedure TfrmBaseInput.SetLabelPopup(Sender: TControl);
var
  n1: Integer;
  n2: Integer;
begin
  if Sender = nil then
  begin
    Sender := pnlMain;
    SetLabelPopup(Sender);
  end;


  for n1 := 0 to TWinControl(Sender).ControlCount-1 do
  begin
    if TWinControl(Sender).Controls[n1].ClassType = TPageControl then
    begin
      for n2 := 0 to TPageControl(TWinControl(Sender).Controls[n1]).PageCount-1 do
      begin
        TPageControl(TWinControl(Sender).Controls[n1]).Pages[n2].PopupMenu := pmLabels;
      end;
      SetLabelPopup(TWinControl(Sender).Controls[n1]);
    end
    else if TWinControl(Sender).Controls[n1].ClassType = TTabSheet then
    begin
      TTabSheet(TWinControl(Sender).Controls[n1]).PopupMenu := pmLabels;
      SetLabelPopup(TWinControl(Sender).Controls[n1]);
    end
    else if TWinControl(Sender).Controls[n1].ClassType = TLabel then
    begin
      TLabel(TWinControl(Sender).Controls[n1]).PopupMenu := pmLabels;
    end;
  end;

end;

procedure TfrmBaseInput.SetCaptionFromLangContent;
var
  vCtx: TRttiContext;
  vRtf: TRttiField;
  vRtt: TRttiType;
  vLabel: TLabel;
  vTabSheet: TTabSheet;
  vSysLangGuiContent: TSysLangGuiContent;
  n1: Integer;
  vLabelNames, vLabelName: string;
begin
  vLabelNames := '';

  vCtx := TRttiContext.Create;
  vRtt := vCtx.GetType(Self.ClassType);
  for vRtf in vRtt.GetFields do
    if vRtf.FieldType.Name = TTabSheet.ClassName then
    begin
      vTabSheet := TTabSheet(FindComponent(vRtf.Name));
      TTabSheet(vTabSheet).Caption :=
          TranslateText(TTabSheet(vTabSheet).Caption,
          StringReplace(TTabSheet(vTabSheet).Name, PREFIX_TABSHEET, '', [rfReplaceAll]),
          LngTab,
          ReplaceRealColOrTableNameTo(Table.TableName));
    end;


  vCtx := TRttiContext.Create;
  vRtt := vCtx.GetType(Self.ClassType);
  for vRtf in vRtt.GetFields do
    //label component isimleri lbl + db_field_name olacak þekilde verileceði varsayýlarak bu kod yazildi. örnek: lblcountry_code
    if vRtf.FieldType.Name = TLabel.ClassName then
    begin
      vLabel := TLabel(FindComponent(vRtf.Name));
      vLabelNames := vLabelNames + QuotedStr(StringReplace(TLabel(vLabel).Name, PREFIX_LABEL, '', [rfReplaceAll])) + ', ';
    end;


  vLabelNames := Trim(vLabelNames);
  if Length(vLabelNames) > 0 then
    vLabelNames := LeftStr(vLabelNames, Length(vLabelNames)-1);

  vSysLangGuiContent := TSysLangGuiContent.Create(Table.Database);
  try
    vSysLangGuiContent.SelectToList(
        ' AND ' + vSysLangGuiContent.Lang.FieldName + '=' + QuotedStr(TSingletonDB.GetInstance.DataBase.ConnSetting.Language) +
        ' AND ' + vSysLangGuiContent.Code.FieldName + ' in (' +  vLabelNames + ')' +
        ' AND ' + vSysLangGuiContent.ContentType.FieldName + '=' + QuotedStr(LngInputLabelCaption) +
        ' AND ' + vSysLangGuiContent.TableName1.FieldName + '=' + QuotedStr(ReplaceRealColOrTableNameTo(Table.TableName)), False, False);
    for n1 := 0 to vSysLangGuiContent.List.Count-1 do
    begin
      if not VarIsNull(TSysLangGuiContent(vSysLangGuiContent.List[n1]).Code.Value) then
      begin
        vLabelName := VarToStr(TSysLangGuiContent(vSysLangGuiContent.List[n1]).Code.Value);
        vLabel := TLabel(FindComponent(PREFIX_LABEL + vLabelName));
        if not VarIsNull(TSysLangGuiContent(vSysLangGuiContent.List[n1]).Value.Value) then
          TLabel(vLabel).Caption := VarToStr(TSysLangGuiContent(vSysLangGuiContent.List[n1]).Value.Value);
      end;
    end;
  finally
    vSysLangGuiContent.Free;
  end;

end;

procedure TfrmBaseInput.SetControlsDisabledOrEnabled(pPanelGroupboxPagecontrolTabsheet: TWinControl; pIsDisable: Boolean);
var
  nIndex: Integer;
  PanelContainer: TWinControl;
begin
  PanelContainer := nil;

  if pPanelGroupboxPagecontrolTabsheet = nil then
    PanelContainer := pnlMain
  else
  begin
    if pPanelGroupboxPagecontrolTabsheet.ClassType = TPanel then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TPanel
    else if pPanelGroupboxPagecontrolTabsheet.ClassType = TGroupBox then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TGroupBox
    else if pPanelGroupboxPagecontrolTabsheet.ClassType = TPageControl then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TPageControl
    else if pPanelGroupboxPagecontrolTabsheet.ClassType = TTabSheet then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TTabSheet;
  end;

  for nIndex := 0 to PanelContainer.ControlCount-1 do
  begin
    if PanelContainer.Controls[nIndex].ClassType = TPanel then
      SetControlsDisabledOrEnabled(PanelContainer.Controls[nIndex] as TPanel, pIsDisable)
    else if PanelContainer.Controls[nIndex].ClassType = TGroupBox then
      SetControlsDisabledOrEnabled(PanelContainer.Controls[nIndex] as TGroupBox, pIsDisable)
    else if PanelContainer.Controls[nIndex].ClassType = TPageControl then
      SetControlsDisabledOrEnabled(PanelContainer.Controls[nIndex] as TPageControl, pIsDisable)
    else if PanelContainer.Controls[nIndex].ClassType = TTabSheet then
      SetControlsDisabledOrEnabled(PanelContainer.Controls[nIndex] as TTabSheet, pIsDisable)
    else if (TControl(PanelContainer.Controls[nIndex]).ClassType = TEdit) then
      TEdit(PanelContainer.Controls[nIndex]).ReadOnly := pIsDisable
    else if (TControl(PanelContainer.Controls[nIndex]).ClassType = TComboBox) then
      TComboBox(PanelContainer.Controls[nIndex]).Enabled := (pIsDisable = False)
    else if (TControl(PanelContainer.Controls[nIndex]).ClassType = TMemo) then
      TMemo(PanelContainer.Controls[nIndex]).ReadOnly := pIsDisable
    else if (TControl(PanelContainer.Controls[nIndex]).ClassType = TCheckBox) then
      TCheckBox(PanelContainer.Controls[nIndex]).Enabled := (pIsDisable = False)
    else if (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioGroup) then
      TRadioGroup(PanelContainer.Controls[nIndex]).Enabled := (pIsDisable = False)
    else if (TControl(PanelContainer.Controls[nIndex]).ClassType = TRadioButton) then
      TRadioButton(PanelContainer.Controls[nIndex]).Enabled := (pIsDisable = False);
  end;
end;

end.
