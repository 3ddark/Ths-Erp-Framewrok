unit ufrmBaseInputDB;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls,
  Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  fyEdit, fyMemo, fyComboBox,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  uGenel, Vcl.AppEvnts, ufrmBase;

type
  TfrmBaseInputDB = class(TfrmBase)
    procedure btnSpinDownClick(Sender: TObject);override;
    procedure btnSpinUpClick(Sender: TObject);override;
    procedure btnKapatClick(Sender: TObject);override;
    procedure btnSilClick(Sender: TObject);override;
    procedure btnTamamClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure FormDestroy(Sender: TObject);override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormResize(Sender: TObject);override;
    procedure FormPaint(Sender: TObject);override;
  protected
    procedure RefreshData;virtual;abstract;
    procedure ResetSession();virtual;
    function SetSession():Boolean;virtual;
    procedure SetControlsDisabledOrEnabled(pPanelGroupboxPagecontrolTabsheet: TWinControl = nil; pIsDisable: Boolean = True);
  public
    procedure FormKeyPress(Sender: TObject; var Key: Char);override;
    procedure fillSelectionBox();virtual;

  end;

implementation

uses
  uConstGenel,
  ufrmBaseDBGrid,
  uKaynakErisimHakki, uSingleton;

{$R *.dfm}

procedure TfrmBaseInputDB.btnSpinDownClick(Sender: TObject);
begin
  inherited;
  TfrmBaseDBGrid(ParentForm).MoveUp;

  Table.SelectToList(' and id=' + IntToStr(TfrmBaseDBGrid(ParentForm).Table.Id), False, False);
  DefaultSelectFilter := ' and id=' + IntToStr(Table.Id);
  RefreshData;
end;

procedure TfrmBaseInputDB.btnSpinUpClick(Sender: TObject);
begin
  inherited;
  TfrmBaseDBGrid(ParentForm).MoveDown;

  table.SelectToList(' and id=' + IntToStr(TfrmBaseDBGrid(ParentForm).Table.Id), false, false);
  DefaultSelectFilter := ' and =' + IntToStr(Table.Id);
  RefreshData;
end;

procedure TfrmBaseInputDB.btnKapatClick(Sender: TObject);
begin
  if (FormTipi = FORM_INCELEME) then
    inherited
  else
  begin
    if (Application.MessageBox(
        PWideChar('Çýkmak istediðinden emin misin?' + TGenel.AddLineBreak(2) +
                  'Yapýlan iþlemler kayýt edilmeden çýkýþ yapýlacak.'),
        PWideChar('Ýþlem Onayý'), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes)
    then
      inherited;
  end;
end;

procedure TfrmBaseInputDB.btnSilClick(Sender: TObject);
begin
  if (FormTipi = FORM_GUNCELLEME)then
  begin
      if Application.MessageBox(
          PWideChar('Kaydý silmek istediðinden emin misin?' + TGenel.AddLineBreak(2) +
                    'Bu iþlemin geri dönüþü yoktur. Kaydýnýz silinecektir.'),
          PWideChar('Ýþlem Onayý'), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes
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
          FormTipi := FORM_INCELEME;
          btnSil.Visible := False;

          Repaint;
        end;
      end;
  end;
end;

procedure TfrmBaseInputDB.btnTamamClick(Sender: TObject);
var
  id, nIndex : integer;
begin
  btnTamam.Enabled := False;
  try
    id := 0;
    if  (FormTipi = FORM_YENI_KAYIT) then
    begin
      if (Table.Database.HasTransactionBegun) then
      begin
        if (Table.LogicalInsert(id, (not Table.Database.HasTransactionBegun), WithCommitTransaction, False)) then
        begin
          if (Self.ParentForm <> nil) then
          begin
            TfrmBaseDBGrid(Self.ParentForm).Table.Id := id;
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
          if (Table.Database.HasTransactionBegun) then
            Close;
        end;
      end
      else
      begin
        raise Exception.Create('Þu anda aktif bir transaction var, önce onu tamamlayýn!');
      end;
    end
    else
    if (FormTipi = FORM_GUNCELLEME) then
    begin
      //Burada yeni kayýt veya güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
      SetControlsDisabledOrEnabled(PanelMain, True);

        if Application.MessageBox(
          PWideChar('Kaydý güncellemek istediðinden emin misin?'),
          PWideChar('Ýþlem Onayý'), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes
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
            FormTipi := FORM_INCELEME;
            btnTamam.Caption := '!';
            btnSil.Visible := false;
            Repaint;
          end;
        end;
    end
    else if (FormTipi = FORM_INCELEME) then
    begin
      //Burada yeni kayýt veya güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
      SetControlsDisabledOrEnabled(PanelMain, False);

      if (not table.Database.HasTransactionBegun) then
      begin
        //kayýt kilitle, eðer baþka kullanýcý tarfýndan bu esnada silinmemiþse
        if (Table.LogicalSelect(DefaultSelectFilter, True, ( not Table.Database.HasTransactionBegun), True)) then
        begin
          //eðer aranan kayýt baþka bir kullanýcý tarafýndan silinmiþse count 0 kalýr
          if (Table.List.Count = 1) then
          begin
            //detaylý tablelar listeye dolduruyo içeriðini
            Table := TTable(Table.List[0]).Clone;
          end
          else
            raise Exception.Create('Kayýt siz inceleme ekranýndayken baþka kullanýcý tarafýndan silinmiþ. Güncel kayýtlara tekrar bakýnýz!');
        end
        else
          raise Exception.Create('Kayýt baþka kullanýcý tarafýndan kilitlenmiþ.  Daha sonra tekrar deneyin.');

        //todo:zafer
        //açýlan tüm pencereleri kapatabilene kadar yaratma
        //
        //lock_timer := TLockTimerThread.Create(self, false);
        RefreshData;
        btnSpin.Visible := false;
        FormTipi := FORM_GUNCELLEME;
        btnTamam.Caption := 'TAMAM';
        btnSil.Visible := true;
        Repaint;

        //burada varsa ilk komponent setfocus yapýlmalý
        for nIndex := 0 to PanelMain.ControlCount-1 do
        begin
          if TControl(PanelMain.Controls[nIndex]) is TWinControl then
          begin
            TWinControl(PanelMain.Controls[nIndex]).SetFocus;
            break;
          end;
        end;

        btnSil.Left := btnTamam.Left-btnSil.Width;
      end
      else
      begin
        raise Exception.Create('Þu anda aktif bir transaction var, önce onu tamamlayýn!');
      end;

    end;

  finally
    btnTamam.Enabled := True;
  end;
end;

procedure TfrmBaseInputDB.FormCreate(Sender: TObject);
begin
  inherited;
  ResetSession();

  if FormTipi = FORM_YENI_KAYIT then
  begin
    btnTamam.Visible := True;
    btnKapat.Visible := True;
  end
  else
  if FormTipi = FORM_INCELEME then
  begin
    btnTamam.Visible := True;
    btnKapat.Visible := True;

    btnTamam.Caption := 'GÜNCELLE';
  end;

  fillSelectionBox();
end;

procedure TfrmBaseInputDB.FormShow(Sender: TObject);
begin
  inherited;

  if Self.FormTipi = FORM_INCELEME then
  begin
    //eðer baþka pencerede açýk transaction varsa güncelleme moduna hiç girilmemli
    if (Table.Database.HasTransactionBegun) then
    begin
      btnTamam.Visible   := False;
      btnSil.Visible     := False;
      btnTamam.OnClick   := nil;
      btnSil.OnClick     := nil;
    end;

    if ParentForm <> nil then
    begin
      btnSpin.Visible := True;
    end;

    //Burada inceleme modunda olduðu için bütün kontrolleri kapatmak gerekiyor.
    SetControlsDisabledOrEnabled(PanelMain, True);
  end
  else
  begin
    //Burada yeni kayýt veya güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
    SetControlsDisabledOrEnabled(PanelMain, False);
  end;


  if (FormTipi <> FORM_YENI_KAYIT ) then
    RefreshData;
  Repaint;
end;

procedure TfrmBaseInputDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if((self.FormTipi = FORM_YENI_KAYIT) or (self.FormTipi = FORM_GUNCELLEME)) and(self.ParentForm <> nil) then
    TfrmBaseDBGrid(Self.ParentForm).RefreshData;

  Table.Database.Connection.GetConn.Rollback;
end;

procedure TfrmBaseInputDB.FormDestroy(Sender: TObject);
begin
  Table.Database.Connection.GetConn.Rollback;
  inherited;
  //
end;

procedure TfrmBaseInputDB.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  //
end;

procedure TfrmBaseInputDB.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (btnSpin.Visible) and (Key = VK_NEXT) then  //page_down
    btnSpinDownClick(btnSpin);
  if (btnSpin.Visible) and (Key = VK_PRIOR) then  //page_up
    btnSpinUpClick(btnSpin);

  inherited;
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
  btnTamam.Enabled := false;
  btnSil.Enabled := false;
  if not SetSession() then
  begin
    self.Close;
    raise Exception.Create('Eriþim hakký hatasý!');
  end;
end;

function TfrmBaseInputDB.SetSession():Boolean;
var
  erisim_haklari: TKaynakErisimHakki;
begin
  Result := False;

//  erisim_haklari  := TKaynakErisimHakki.Create(Table.Database);
//  try
//    erisim_haklari.select_to_list(' and kullanici_id = ' + IntToStr(SingletonDB.Kullanici.Id) +
//                                  ' and (is_read=True or is_write=True or is_delete=True) ' +
//                                  ' and k.kaynak = ' + QuotedStr(KaynakAdi) +
//                                  ' and table_name = ' + QuotedStr(Table.TableName), False);
//    if (erisim_haklari.List.Count = 1) then
//    begin
//      if (TKaynakErisimHakki(erisim_haklari.List[0]).IsRead) then
//      begin
//        Result:=true;
//      end;
//      if (TKaynakErisimHakki(erisim_haklari.List[0]).IsWrite)  then
//      begin
//        //yazma veya silme hakký varsa true döndür
//        btnTamam.Enabled := true;
//        Result:=true;
//      end;
//      if (TKaynakErisimHakki(erisim_haklari.List[0]).IsDelete) then
//      begin
//        //yazma veya silme hakký varsa true döndür
//        btnSil.Enabled := true;
//        Result:=true;
//      end;
//    end;
//  finally
//    erisim_haklari.Free;
//  end;
  Result := True;
end;

procedure TfrmBaseInputDB.SetControlsDisabledOrEnabled(pPanelGroupboxPagecontrolTabsheet: TWinControl; pIsDisable: Boolean);
var
  nIndex: Integer;
  PanelContainer: TWinControl;
begin
  PanelContainer := nil;

  if pPanelGroupboxPagecontrolTabsheet = nil then
    PanelContainer := PanelMain
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
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyEdit)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TEdit)
    then
      TEdit(PanelContainer.Controls[nIndex]).ReadOnly := pIsDisable
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyComboBox)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TComboBox)
    then
      TComboBox(PanelContainer.Controls[nIndex]).Enabled := (pIsDisable = False)
    else
    if (TControl(PanelContainer.Controls[nIndex]).ClassType = TfyMemo)
    or (TControl(PanelContainer.Controls[nIndex]).ClassType = TMemo)
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

procedure TfrmBaseInputDB.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //esc tuþuyla kapanma
  if Key = #27 then
  begin
    Key := #0;
    if (FormTipi = FORM_YENI_KAYIT) or (FormTipi = FORM_GUNCELLEME) then
    begin
      if Application.MessageBox(
        PWideChar('Çýkmak istediðinize emin misiniz?'),
        PWideChar('Ýþlem Onayý'), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes
      then
        Close;
    end
    else
    if (FormTipi = FORM_INCELEME) then
      Close;
  end;
end;

procedure TfrmBaseInputDB.fillSelectionBox;
begin
  //
end;

end.
