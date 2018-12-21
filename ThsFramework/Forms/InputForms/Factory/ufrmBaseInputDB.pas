unit ufrmBaseInputDB;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
  Vcl.ComCtrls, Dialogs, System.Variants, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Rtti, Vcl.Graphics, Vcl.AppEvnts,
  Vcl.ImgList, Vcl.Menus,
  Data.DB,

  FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,
  ufrmBase, ufrmBaseInput,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Functions;

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
  TfrmBaseInputDB = class(TfrmBaseInput)
    procedure btnSpinDownClick(Sender: TObject);override;
    procedure btnSpinUpClick(Sender: TObject);override;
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
    procedure ResetSession();virtual;
    function SetSession():Boolean;virtual;
    procedure HelperProcess(Sender: TObject);virtual;
  public
  published
    procedure stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect); override;
  end;

implementation

uses
  ufrmBaseDBGrid,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Constants;

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
        btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;

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
        btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;
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

          btnSpin.Visible := false;
          FormMode := ifmUpdate;
          btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);
          btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;
          btnDelete.Visible := True;

          if Table.IsAuthorized(ptUpdate, True, False) then
            btnAccept.Enabled := True
          else
            btnAccept.Enabled := False;

          RefreshData;

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

  if Table <> nil then
  begin
    if (FormMode = ifmNewRecord)
    or (FormMode = ifmCopyNewRecord)
    then
      Table.Database.Connection.StartTransaction;
  end;

  ResetSession();

  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;
    btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);
    btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;

    //TRUE olarak gönder form ilk açýldýðýndan küçük-büyük harf ayarýný yap.
    SetInputControlProperty(True);
  end
  else
  if FormMode = ifmRewiev then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;

    btnAccept.Caption := TranslateText('UPDATE', FrameworkLang.ButtonUpdate, LngButton, LngSystem);
    btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;
    btnDelete.Caption := TranslateText('DELETE', FrameworkLang.ButtonDelete, LngButton, LngSystem);
    btnDelete.Width := Canvas.TextWidth(btnDelete.Caption) + 56;
  end;
end;

procedure TfrmBaseInputDB.FormShow(Sender: TObject);
begin
  inherited;

  if (FormMode <> ifmNewRecord ) then
    RefreshData;

//  Repaint;
end;

procedure TfrmBaseInputDB.HelperProcess(Sender: TObject);
begin
  //override eden dolduracak
end;

procedure TfrmBaseInputDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

//  ShowMessage(Self.ParentForm.Name + ' ' + Self.ParentForm.Parent.Name);

  if  ((self.FormMode = ifmNewRecord) or (self.FormMode = ifmUpdate))
  and (Self.ParentForm <> nil)
  then
    TfrmBaseDBGrid(Self.ParentForm).RefreshData;

  if Table <> nil then
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
        vIco := IMG_QUALITY
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

end.

