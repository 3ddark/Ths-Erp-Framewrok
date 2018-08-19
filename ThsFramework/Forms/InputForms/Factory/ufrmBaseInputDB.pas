unit ufrmBaseInputDB;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Dialogs, System.Variants,
  Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.ExtCtrls, System.Rtti, Vcl.Graphics,
  thsEdit, thsMemo, thsComboBox,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.SpecialFunctions, Vcl.AppEvnts, ufrmBase, System.ImageList,
  Vcl.ImgList, System.WideStrUtils, System.StrUtils, FireDAC.Phys.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, Vcl.Menus;

{
procedure TfrmBaseInputDB.FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
var
  vMesaj,
  vID,
  vPID: string;
  n1: Integer;
begin
  FDEventAlerter1.Unregister;

  if VarIsArray( AArgument ) then
  begin
    for n1 := VarArrayLowBound(AArgument, 1) to VarArrayHighBound(AArgument, 1) do
    begin
      if n1 = 0 then
      begin
        vMesaj := vMesaj + 'Process ID (pID):' + VarToStr(AArgument[n1]) + ', ';
        vPID := VarToStr(AArgument[n1]);
      end
      else if n1 = 1 then
      begin
        vMesaj := vMesaj + 'Notify Value:' + VarToStr(AArgument[n1]) + ', ';
        vID := VarToStr(AArgument[n1]);
      end;
    end;
  end
  else
  if VarIsNull(AArgument) then
    vMesaj := '<NULL>'
  else if VarIsEmpty(AArgument) then
    vMesaj := '<UNASSIGNED>'
  else
    vMesaj := VarToStr(AArgument);

  if (FormMode = ifmRewiev) and (VarToStr(Table.Id.Value).ToInteger = vID.ToInteger) then
    RefreshData;
end;
}
type
  TfrmBaseInputDB = class(TfrmBase)
    pmLabels: TPopupMenu;
    mniAddLanguageContent: TMenuItem;
    procedure btnSpinDownClick(Sender: TObject);override;
    procedure btnSpinUpClick(Sender: TObject);override;
    procedure btnCloseClick(Sender: TObject);override;
    procedure btnDeleteClick(Sender: TObject);override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure FormDestroy(Sender: TObject);override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormKeyPress(Sender: TObject; var Key: Char);override;
    procedure FormResize(Sender: TObject);override;
    procedure FormPaint(Sender: TObject);override;
    procedure mniAddLanguageContentClick(Sender: TObject);
  protected
    procedure RefreshData;virtual;abstract;
    procedure ResetSession();virtual;
    function SetSession():Boolean;virtual;
    procedure SetControlsDisabledOrEnabled(pPanelGroupboxPagecontrolTabsheet: TWinControl = nil; pIsDisable: Boolean = True);
    procedure SetLabelPopup(Sender: TControl = nil);
    procedure SetCaptionFromLangContent();
  public
  published
    procedure stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect); override;
  end;

implementation

uses
  ufrmBaseDBGrid,
  Ths.Erp.Database.Singleton, Ths.Erp.Database.Table.Field, Ths.Erp.Constants,
  Ths.Erp.Database.Table.SysLangGuiContent,
  ufrmSysLangGuiContent;

{$R *.dfm}

procedure TfrmBaseInputDB.btnSpinDownClick(Sender: TObject);
begin
  if (Self.ParentForm <> nil) then//and (Self.ParentForm.Name = 'frmBaseDBGrid') then
  begin
    if TfrmBaseDBGrid(ParentForm).dbgrdBase.DataSource.DataSet.RecNo < TfrmBaseDBGrid(ParentForm).dbgrdBase.DataSource.DataSet.RecordCount then
    begin
      TfrmBaseDBGrid(ParentForm).MoveUp;

      Table.SelectToList(' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(TfrmBaseDBGrid(ParentForm).Table.Id.Value), False, False);
      DefaultSelectFilter := ' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(Table.Id.Value);
      RefreshData;
    end;
  end;
end;

procedure TfrmBaseInputDB.btnSpinUpClick(Sender: TObject);
begin
  if (Self.ParentForm <> nil) then//and (Self.ParentForm.Name = 'frmBaseDBGrid') then
  begin
    if TfrmBaseDBGrid(ParentForm).dbgrdBase.DataSource.DataSet.RecNo > 1 then
    begin
      TfrmBaseDBGrid(ParentForm).MoveDown;

      Table.SelectToList(' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(TfrmBaseDBGrid(ParentForm).Table.Id.Value), false, false);
      DefaultSelectFilter := ' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(Table.Id.Value);
      RefreshData;
    end;
  end;
end;

procedure TfrmBaseInputDB.btnCloseClick(Sender: TObject);
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

procedure TfrmBaseInputDB.btnDeleteClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate)then
  begin
    if CustomMsgDlg(
      TranslateText('Are you sure you want to delete record?', FrameworkLang.MessageDeleteRecord, LngMessage, LngSystem),
      mtConfirmation, mbYesNo, [TranslateText('Yes', FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                                TranslateText('No', FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                                TranslateText('Confirmation', FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes
    then
    begin
      if (Table.LogicalDelete(True, False)) then
      begin
        ModalResult := mrOK;
        Close;

        TfrmBaseDBGrid(ParentForm).Table.DataSource.DataSet.Refresh;
        //Table.DataSource.DataSet.Refresh;
      end
      else
      begin
        ModalResult := mrNone;
        FormMode := ifmRewiev;
        btnSpin.Visible := True;
        btnDelete.Visible := False;
        btnAccept.Caption := TranslateText('UPDATE', FrameworkLang.ButtonUpdate, LngButton, LngSystem);

        Repaint;
      end;
    end;
  end;
end;

procedure TfrmBaseInputDB.btnAcceptClick(Sender: TObject);
var
  id, nIndex : integer;
begin
  id := 0;
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    if (Table.Database.TranscationIsStarted) then
    begin
      if (Table.LogicalInsert(id, (not Table.Database.TranscationIsStarted), WithCommitTransaction, False)) then
      begin
        if (Self.ParentForm <> nil) then//and (Self.ParentForm.Name = 'frmBaseDBGrid') then
        begin
          TfrmBaseDBGrid(Self.ParentForm).Table.Id.Value := id;
          TfrmBaseDBGrid(Self.ParentForm).RefreshData;
        end;
        ModalResult := mrOK;

        Close;
      end
      else
      begin
        ModalResult := mrNone;//hata durumunda pencere kapanmasýn

        //eðer begin transaction demiyosa insert pencere kapansýn çünkü rollback yapýld artýk insert etmemeli
        //önceki iþlemler geri alýndýðý için
        if (Table.Database.TranscationIsStarted) then
          Close;
        Table.Database.Connection.StartTransaction;
      end;
    end
//      else
//      begin
//        raise Exception.Create(GetTextFromLang('There is an active transaction. Complete it first!', FrameworkLang.WarningActiveTransaction, LngWarning, LngSystem));
//      end;
  end
  else
  if (FormMode = ifmUpdate) then
  begin
    if CustomMsgDlg(
      TranslateText('Are you sure you want to update record?', FrameworkLang.MessageUpdateRecord, LngMessage, LngSystem),
      mtConfirmation, mbYesNo, [TranslateText('Yes', FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                                TranslateText('No', FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                                TranslateText('Confirmation', FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes
    then
    begin
      //Burada yeni kayýt veya güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
      SetControlsDisabledOrEnabled(pnlMain, True);

      if (Table.LogicalUpdate(WithCommitTransaction, True)) then
      begin
        ModalResult := mrOK;
        Close;
      end
      else
      begin

        ModalResult := mrNone;
        btnSpin.Visible := true;
        FormMode := ifmRewiev;
        btnAccept.Caption := TranslateText(btnAccept.Caption, FrameworkLang.ButtonUpdate, LngButton, LngSystem);
        btnDelete.Visible := false;
        Repaint;
      end;

    end;
  end
  else if (FormMode = ifmRewiev) then
  begin
    //burada güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
    SetControlsDisabledOrEnabled(pnlMain, False);

    //inceleme modundan güncelleme moduna geçtiði için kontrollerin zorunlu alan ve max length bilgilerini set et
    //False olarak gönder form ilk açýldýðýndan küçük-büyük harf ayarýný yap. Sonrasýnda tekrar bozma
    SetInputControlProperty(False);

    if (not table.Database.TranscationIsStarted) then
    begin
      try
        //kayýt kilitle, eðer baþka kullanýcý tarfýndan bu esnada silinmemiþse
        if (Table.LogicalSelect(DefaultSelectFilter, True, ( not Table.Database.TranscationIsStarted), True)) then
        begin
          //eðer aranan kayýt baþka bir kullanýcý tarafýndan silinmiþse count 0 kalýr
          if (Table.List.Count = 1) then
          begin
            //detaylý tablelar listeye dolduruyo içeriðini
            //Table := TTable(Table.List[0]).Clone;
          end
          else
          if (Table.List.Count = 0) then
          begin
            raise Exception.Create(
              TranslateText('The record was deleted by another user while you were on the review screen.', FrameworkLang.ErrorRecordDeleted, LngError, LngSystem) +
              AddLBs(2) +
              TranslateText('Check the current records again!', FrameworkLang.ErrorRecordDeletedMessage, LngError, LngSystem)
            );
          end;

          RefreshData;
          btnSpin.Visible := false;
          FormMode := ifmUpdate;
          btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);
          btnDelete.Visible := True;

          if Table.IsAuthorized(ptUpdate, True, False) then
            btnAccept.Enabled := True
          else
            btnAccept.Enabled := False;

          Repaint;

          //burada varsa ilk komponent setfocus yapýlmalý
          for nIndex := 0 to pnlMain.ControlCount-1 do
          begin
            if TControl(pnlMain.Controls[nIndex]) is TWinControl then
            begin
              TWinControl(pnlMain.Controls[nIndex]).SetFocus;
              break;
            end;
          end;

          btnDelete.Left := btnAccept.Left-btnDelete.Width;
        end;
      except

      end;
    end
    else
    begin
      CustomMsgDlg(TranslateText('There is an active transaction. Complete it first!', FrameworkLang.WarningActiveTransaction, LngWarning, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK, '');
    end;

  end;
end;

procedure TfrmBaseInputDB.FormCreate(Sender: TObject);
begin
  inherited;

  pmLabels.Images := TSingletonDB.GetInstance.ImageList16;
  mniAddLanguageContent.ImageIndex := IMG_ADD_DATA;

  TSingletonDB.GetInstance.HaneMiktari.SelectToList('', False, False);

  stbBase.Panels.Delete(STATUS_KEY_F7);
  stbBase.Panels.Delete(STATUS_KEY_F6);
  stbBase.Panels.Delete(STATUS_KEY_F5);
  stbBase.Panels.Delete(STATUS_KEY_F4);
  stbBase.Panels.Delete(STATUS_USERNAME);
  stbBase.Panels.Delete(STATUS_EX_RATE_EUR);
  stbBase.Panels.Delete(STATUS_EX_RATE_USD);
  stbBase.Panels.Delete(STATUS_DATE);

  pnlBottom.Visible := False;
  stbBase.Visible := True;
  pnlBottom.Visible := True;

  ResetSession();

  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;
    btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);

    //TRUE olarak gönder form ilk açýldýðýndan küçük-büyük harf ayarýný yap.
    SetInputControlProperty(True);
  end
  else
  if FormMode = ifmRewiev then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;

    btnAccept.Caption := TranslateText('UPDATE', FrameworkLang.ButtonUpdate, LngButton, LngSystem);
    btnDelete.Caption := TranslateText('DELETE', FrameworkLang.ButtonDelete, LngButton, LngSystem);
  end;
end;

procedure TfrmBaseInputDB.FormShow(Sender: TObject);
var
  vQualityFormNo: string;
begin
  inherited;

  //Form Numarasý status bara yaz
  stbBase.Panels.Items[STATUS_DATE].Text := '';
  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
  begin
    vQualityFormNo := TSingletonDB.GetInstance.GetQualityFormNo(Table.TableName);
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

  if (FormMode <> ifmNewRecord ) then
    RefreshData;


  mniAddLanguageContent.Visible := False;
  if (TSingletonDB.GetInstance.User.IsSuperUser.Value) and (FormMode = ifmRewiev) then
  begin
    //yeni kayýtta transactionlardan dolayý sorun oluyor. Düzeltmek için uðralýlmadý
    SetLabelPopup();
    mniAddLanguageContent.Visible := True;
  end;

  Application.ProcessMessages;
//  Repaint;
end;

procedure TfrmBaseInputDB.mniAddLanguageContentClick(Sender: TObject);
var
  vSysLangGuiContent: TSysLangGuiContent;
  vCode, vValue, vContentType, vTableName: string;
begin
  if pmLabels.PopupComponent.ClassType = TButton then
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

procedure TfrmBaseInputDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if  ((self.FormMode = ifmNewRecord) or (self.FormMode = ifmUpdate))
  and (Self.ParentForm <> nil)
  then
    TfrmBaseDBGrid(Self.ParentForm).RefreshData;

  Table.Database.Connection.Rollback;
end;

procedure TfrmBaseInputDB.FormDestroy(Sender: TObject);
begin
  Table.Database.Connection.Rollback;
  inherited;
  //
end;

procedure TfrmBaseInputDB.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (btnSpin.Visible) and (Key = VK_NEXT) then  //page_down
    btnSpinDownClick(btnSpin)
  else if (btnSpin.Visible) and (Key = VK_PRIOR) then  //page_up
    btnSpinUpClick(btnSpin)
  else
    inherited;
end;

procedure TfrmBaseInputDB.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //ESC key Close action
  if Key = #27 then
  begin
    Key := #0;
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if CustomMsgDlg(
        TranslateText('Are you sure you want to exit?',FrameworkLang.MessageCloseWindow, LngMessage, LngSystem),
        mtConfirmation, mbYesNo, [TranslateText('Yes',FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                                  TranslateText('No',FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                                  TranslateText('Confirmation',FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes
      then
        Close;
    end
    else
    if (FormMode = ifmRewiev) then
      Close;
  end
  else
    inherited;
end;

procedure TfrmBaseInputDB.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  //
end;

procedure TfrmBaseInputDB.FormResize(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmBaseInputDB.FormPaint(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmBaseInputDB.ResetSession();
begin
  btnAccept.Enabled := false;
  btnDelete.Enabled := false;
  if not SetSession() then
  begin
    Self.Close;
    raise Exception.Create(TranslateText('Access right failure!', FrameworkLang.ErrorAccessRight, LngError, LngSystem));
  end;
end;

function TfrmBaseInputDB.SetSession():Boolean;
var
  vUpdate, vDelete: Boolean;
begin
  vUpdate := False;
  vDelete := False;

  Result := False;

  if Table.IsAuthorized(ptUpdate, True, False) then
  begin
    Result := True;
    vUpdate := True;
  end;

  if Table.IsAuthorized(ptDelete, True, False) then
  begin
    //if you have the right to delete, enable accept button
    btnDelete.Enabled := True;
    Result := True;
    vDelete := True;
  end;

  if Table.IsAuthorized(ptSpeacial, True, False) then
  begin
    //enable special property
    Result := True;
  end;

  //if you have the right to update or delete, enable accept button
  //for the delete or update confirmation
  if vUpdate or vDelete then
    btnAccept.Enabled := True;
end;

procedure TfrmBaseInputDB.stbBaseDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  vIco: Integer;
begin
  stbBase.Canvas.Font.Name := 'Tahoma';
  stbBase.Canvas.Font.Style := [fsBold];

  stbBase.Canvas.TextRect(Rect,
    Rect.Left + TSingletonDB.GetInstance.ImageList16.Width + 4,
    Rect.Top + (stbBase.Height-Canvas.TextHeight(Panel.Text)) div 2 - 2,
    Panel.Text);

  vIco := -1;
  case Panel.Index of
    STATUS_SQL_SERVER:
    begin
      if Panel.Text <> '' then
        vIco := IMG_NOTE
      else
        vIco := -1;
    end;
  end;

  if vIco > -1 then
  begin
    TSingletonDB.GetInstance.ImageList16.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, vIco);
    Panel.Width := stbBase.Width;
  end;
end;

procedure TfrmBaseInputDB.SetCaptionFromLangContent;
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
    if vRtf.FieldType.Name = 'TTabSheet' then
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
    if vRtf.FieldType.Name = 'TLabel' then
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
        vLabel := TLabel(FindComponent(vLabelName));
        if not VarIsNull(TSysLangGuiContent(vSysLangGuiContent.List[n1]).Value.Value) then
          TLabel(vLabel).Caption := VarToStr(TSysLangGuiContent(vSysLangGuiContent.List[n1]).Value.Value);
      end;
    end;
  finally
    vSysLangGuiContent.Free;
  end;

end;

procedure TfrmBaseInputDB.SetLabelPopup(Sender: TControl);
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

procedure TfrmBaseInputDB.SetControlsDisabledOrEnabled(pPanelGroupboxPagecontrolTabsheet: TWinControl; pIsDisable: Boolean);
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
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TEdit)
    then
      TEdit(PanelContainer.Controls[nIndex]).ReadOnly := pIsDisable
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TComboBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsCombobox)
    then
      TComboBox(PanelContainer.Controls[nIndex]).Enabled := (pIsDisable = False)
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TMemo)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TthsMemo)
    then
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
