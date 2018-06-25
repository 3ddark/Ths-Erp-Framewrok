unit ufrmBaseInputDB;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Dialogs,
  Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.ExtCtrls, System.Rtti,
  thsEdit, thsMemo, thsComboBox,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.SpecialFunctions, Vcl.AppEvnts, ufrmBase, System.ImageList,
  Vcl.ImgList, System.WideStrUtils, System.StrUtils;

type
  TfrmBaseInputDB = class(TfrmBase)
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
  protected
    procedure RefreshData;virtual;abstract;
    procedure ResetSession();virtual;
    function SetSession():Boolean;virtual;
    procedure SetControlsDisabledOrEnabled(pPanelGroupboxPagecontrolTabsheet: TWinControl = nil; pIsDisable: Boolean = True);
  public
  end;

implementation

uses
  ufrmBaseDBGrid, Ths.Erp.Database.Singleton, Ths.Erp.Database.Table.Field;

{$R *.dfm}

procedure TfrmBaseInputDB.btnSpinDownClick(Sender: TObject);
begin
  if TfrmBaseDBGrid(ParentForm).dbgrdBase.DataSource.DataSet.RecNo < TfrmBaseDBGrid(ParentForm).dbgrdBase.DataSource.DataSet.RecordCount then
  begin
    TfrmBaseDBGrid(ParentForm).MoveUp;

    Table.SelectToList(' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(TfrmBaseDBGrid(ParentForm).Table.Id.Value), False, False);
    DefaultSelectFilter := ' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(Table.Id.Value);
    RefreshData;
  end;
end;

procedure TfrmBaseInputDB.btnSpinUpClick(Sender: TObject);
begin
  if TfrmBaseDBGrid(ParentForm).dbgrdBase.DataSource.DataSet.RecNo > 1 then
  begin
    TfrmBaseDBGrid(ParentForm).MoveDown;

    Table.SelectToList(' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(TfrmBaseDBGrid(ParentForm).Table.Id.Value), false, false);
    DefaultSelectFilter := ' and ' + Table.TableName + '.' + Table.Id.FieldName + '=' + IntToStr(Table.Id.Value);
    RefreshData;
  end;
end;

procedure TfrmBaseInputDB.btnCloseClick(Sender: TObject);
begin
  if (FormMode = ifmRewiev) then
    inherited
  else
  begin
    if (TSpecialFunctions.CustomMsgDlg(
      TSingletonDB.GetInstance.GetTextFromLang('Are you sure you want to exit?   All changes will be canceled!!!', TSingletonDB.GetInstance.LangFramework.MesajIslemIptal),
      mtConfirmation, mbYesNo, [TSingletonDB.GetInstance.GetTextFromLang('Yes', TSingletonDB.GetInstance.LangFramework.MantikEvetKucuk),
                                TSingletonDB.GetInstance.GetTextFromLang('No', TSingletonDB.GetInstance.LangFramework.MantikHayirKucuk)], mbNo,
                                TSingletonDB.GetInstance.GetTextFromLang('Confirmation', TSingletonDB.GetInstance.LangFramework.IslemOnayiKucuk)) = mrYes)
    then
      inherited;
  end;
end;

procedure TfrmBaseInputDB.btnDeleteClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate)then
  begin
    if TSpecialFunctions.CustomMsgDlg(
      TSingletonDB.GetInstance.GetTextFromLang('Are you sure you want to delete record?', TSingletonDB.GetInstance.LangFramework.MesajKayitSil),
      mtConfirmation, mbYesNo, [TSingletonDB.GetInstance.GetTextFromLang('Yes', TSingletonDB.GetInstance.LangFramework.MantikEvetKucuk),
                                TSingletonDB.GetInstance.GetTextFromLang('No', TSingletonDB.GetInstance.LangFramework.MantikHayirKucuk)], mbNo,
                                TSingletonDB.GetInstance.GetTextFromLang('Confirmation', TSingletonDB.GetInstance.LangFramework.IslemOnayiKucuk)) = mrYes
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
        btnSpin.Visible := True;
        FormMode := ifmRewiev;
        btnDelete.Visible := False;

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
    if  (FormMode = ifmNewRecord) then
    begin
      if (Table.Database.TranscationIsStarted) then
      begin
        if (Table.LogicalInsert(id, (not Table.Database.TranscationIsStarted), WithCommitTransaction, False)) then
        begin
          if (Self.ParentForm <> nil) then
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
      else
      begin
        raise Exception.Create(TSingletonDB.GetInstance.GetTextFromLang('There is an active transaction. Complete it first!', TSingletonDB.GetInstance.LangFramework.UyariAktifTransaction));
      end;
    end
    else
    if (FormMode = ifmUpdate) then
    begin
      //Burada yeni kayýt veya güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
      SetControlsDisabledOrEnabled(pnlMain, True);

      if TSpecialFunctions.CustomMsgDlg(
        TSingletonDB.GetInstance.GetTextFromLang('Are you sure you want to update record?', TSingletonDB.GetInstance.LangFramework.MesajKayitGuncelle),
        mtConfirmation, mbYesNo, [TSingletonDB.GetInstance.GetTextFromLang('Yes', TSingletonDB.GetInstance.LangFramework.MantikEvetKucuk),
                                  TSingletonDB.GetInstance.GetTextFromLang('No', TSingletonDB.GetInstance.LangFramework.MantikHayirKucuk)], mbNo,
                                  TSingletonDB.GetInstance.GetTextFromLang('Confirmation', TSingletonDB.GetInstance.LangFramework.IslemOnayiKucuk)) = mrYes
      then
      begin
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
          btnAccept.Caption := TSingletonDB.GetInstance.LangFramework.ButonGuncelle;
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
      SetInputControlProperty();

      if (not table.Database.TranscationIsStarted) then
      begin
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
              TSingletonDB.GetInstance.GetTextFromLang('The record was deleted by another user while you were on the review screen.', TSingletonDB.GetInstance.LangFramework.HataKayitSilinmis) +
              TSpecialFunctions.AddLineBreak(2) +
              TSingletonDB.GetInstance.GetTextFromLang('Check the current records again!', TSingletonDB.GetInstance.LangFramework.HataKayitSilinmisMesaj)
            );
          end;
        end
        else
        begin
          raise Exception.Create( TSingletonDB.GetInstance.GetTextFromLang('The record is locked by another user. Try again later.', TSingletonDB.GetInstance.LangFramework.UyariKilitliKayit) );
        end;

        RefreshData;
        btnSpin.Visible := false;
        FormMode := ifmUpdate;
        btnAccept.Caption := TSingletonDB.GetInstance.GetTextFromLang('CONFIRM', TSingletonDB.GetInstance.LangFramework.ButonOnay);
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
      end
      else
      begin
        raise Exception.Create( TSingletonDB.GetInstance.GetTextFromLang('There is an active transaction. Complete it first!', TSingletonDB.GetInstance.LangFramework.UyariAktifTransaction) );
      end;

    end;

end;

procedure TfrmBaseInputDB.FormCreate(Sender: TObject);
begin
  inherited;
  ResetSession();

  if FormMode = ifmNewRecord then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;
    btnAccept.Caption := TSingletonDB.GetInstance.GetTextFromLang('CONFIRM', TSingletonDB.GetInstance.LangFramework.ButonOnay);

    SetInputControlProperty();
  end
  else
  if FormMode = ifmRewiev then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;

    btnAccept.Caption := TSingletonDB.GetInstance.GetTextFromLang('UPDATE', TSingletonDB.GetInstance.LangFramework.ButonGuncelle);
    btnDelete.Caption := TSingletonDB.GetInstance.GetTextFromLang('DELETE', TSingletonDB.GetInstance.LangFramework.ButonSil);
  end;
end;

procedure TfrmBaseInputDB.FormShow(Sender: TObject);
var
  vCtx : TRttiContext;
  vRtf : TRttiField;
  vRtt : TRttiType;
  vLabel: TLabel;
begin
  inherited;

  vCtx := TRttiContext.Create;
  vRtt := vCtx.GetType(Self.ClassType);
  for vRtf in vRtt.GetFields do
    //label component isimleri lbl + db_field_name olacak þekilde verileceði varsayýlarak bu kod yazildi. örnek: lblcountry_code
    if vRtf.FieldType.Name = 'TLabel' then
    begin
      vLabel := TLabel(FindComponent(vRtf.Name));
      TLabel(vLabel).Caption :=
          TSingletonDB.GetInstance.GetTextFromLang(TLabel(vLabel).Caption,
          'LabelCaption.Input.' + Table.TableName + '.' + RightStr(TLabel(vLabel).Name, Length(TLabel(vLabel).Name)-3));
    end;

  Self.Caption := TSingletonDB.GetInstance.GetTextFromLang(Self.Caption, 'FormCaption.Input.' + Table.TableName);

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
  Repaint;
end;

procedure TfrmBaseInputDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if((self.FormMode = ifmNewRecord) or (self.FormMode = ifmUpdate)) and(self.ParentForm <> nil) then
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
    if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TSpecialFunctions.CustomMsgDlg(
        TSingletonDB.GetInstance.GetTextFromLang('Are you sure you want to exit?',TSingletonDB.GetInstance.LangFramework.MesajIslemIptal),
        mtConfirmation, mbYesNo, [TSingletonDB.GetInstance.GetTextFromLang('Yes',TSingletonDB.GetInstance.LangFramework.MantikEvetKucuk),
                                  TSingletonDB.GetInstance.GetTextFromLang('No',TSingletonDB.GetInstance.LangFramework.MantikHayirKucuk)], mbNo,
                                  TSingletonDB.GetInstance.GetTextFromLang('Confirmation',TSingletonDB.GetInstance.LangFramework.IslemOnayiKucuk)) = mrYes
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
    raise Exception.Create(TSingletonDB.GetInstance.GetTextFromLang('Access right failure!', TSingletonDB.GetInstance.LangFramework.HataErisimHakki));
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
