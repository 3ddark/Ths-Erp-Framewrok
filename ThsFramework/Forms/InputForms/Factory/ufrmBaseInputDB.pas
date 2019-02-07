unit ufrmBaseInputDB;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
  Vcl.ComCtrls, Dialogs, System.Variants, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Graphics, Vcl.AppEvnts, System.Math, Vcl.ImgList,
  Vcl.Menus, Data.DB, System.Rtti,

  FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseInput,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.View.SysViewColumns,
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
  private
    FSysTableInfo: TSysViewColumns;
  protected
    procedure ResetSession();virtual;
    function SetSession():Boolean;virtual;
    procedure HelperProcess(Sender: TObject);virtual;
  public
/// <summary>
///  Table sýnýfýndaki field özelliklerini almak için kullanýlýyor.
/// </summary>
    property SysTableInfo: TSysViewColumns read FSysTableInfo write FSysTableInfo;
  published
    function getContainTable(pTable: TTable): TTable;
/// <summary>
///  InputDB formlarýndaki Edit Memo ComboBox gibi kontrollerin zorunlu alan, maks leng, charcase gibi özelliklerini form ilk açýlýþta ayarlýyor.
/// </summary>
///  <remarks>
///  NOT: Bu kontroller direkt olarak pnlMain üzerinde veya pgcMain içindeki TabSheet ler içinde olmalý
///  </remarks>
    procedure SetControlDBProperty;

/// <summary>
///  Table sýnýfý içindeki IsFK bilgisi True ise bilgi Farklý Tablodan ForeignKey ile referans ediliyor demektir.
///  Böyle Field bilgileri için HelperProcess eventi editlere otomatik olarak tanýmlanýyor.
/// </summary>
///  <remarks>
///  NOT: Bu kontroller direkt olarak pnlMain üzerinde veya pgcMain içindeki TabSheet ler içinde olmalý
///  </remarks>
    procedure SetHelperProcess();

/// <summary>
///  Table sýnýfý içindeki deðerleri açýlan formda bulunan kontrollere otomatik olarak yüklüyor.
///  Yapýlan iþlemin gösterimsel örneði aþaðýdadýr.
///  <example>
///   <code lang="Delphi">edtcontrol_name_like_db_field_name.Text := Table.PersonelAd.Value</code>
///  </example>
/// </summary>
///  <remarks>
///  NOT: Bu kontroller direkt olarak pnlMain üzerinde veya pgcMain içindeki TabSheet ler içinde olmalý
///  </remarks>
    procedure RefreshDataAuto;

/// <summary>
///  Kontrollerde bulunan bilgileri Table sýnýfý içindeki database field value deðerlerine aktarýyor.
/// </summary>
///  <remarks>
///  NOT: Bu kontroller direkt olarak pnlMain üzerinde veya pgcMain içindeki TabSheet ler içinde olmalý
///  </remarks>
    procedure btnAcceptAuto;

    procedure stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect); override;
    procedure RefreshData; override;
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
      TranslateText('Are you sure you want to delete record?', FrameworkLang.MessageDeleteRecord, LngMsgData, LngSystem),
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
        btnAccept.Width := Max(100, btnAccept.Width);

        Repaint;
      end;
    end;
  end;
end;

procedure TfrmBaseInputDB.btnAcceptAuto;
var
  vTable: TTable;

  procedure SetSubTableValue(pParent: TControl; pField: TFieldDB);
  var
    vControl: TControl;
  begin
    vControl := TWinControl(pParent).FindChildControl(PREFIX_EDIT + pField.FieldName);
    if Assigned(vControl) then
      if pField.IsFK then
      begin
        pField.Value := pField.Value;
        pField.FK.FKCol.Value := TEdit(vControl).Text;
      end
      else
        pField.Value := TEdit(vControl).Text;

    vControl := TWinControl(pParent).FindChildControl(PREFIX_COMBOBOX + pField.FieldName);
    if Assigned(vControl) then
      if pField.IsFK then
      begin
        pField.Value := pField.Value;
        pField.FK.FKCol.Value := TCombobox(vControl).Text;
      end
      else
        pField.Value := TCombobox(vControl).Text;

    vControl := TWinControl(pParent).FindChildControl(PREFIX_MEMO + pField.FieldName);
    if Assigned(vControl) then
      if pField.IsFK then
      begin
        pField.Value := pField.Value;
        pField.FK.FKCol.Value := TMemo(vControl).Lines.Text;
      end
      else
        pField.Value := TMemo(vControl).Lines.Text;

    vControl := TWinControl(pParent).FindChildControl(PREFIX_CHECKBOX + pField.FieldName);
    if Assigned(vControl) then
      if pField.IsFK then
      begin
        pField.Value := pField.Value;
        pField.FK.FKCol.Value := TCheckBox(vControl).Checked;
      end
      else
        pField.Value := TCheckBox(vControl).Checked;

    vControl := TWinControl(pParent).FindChildControl(PREFIX_RADIOGROUP + pField.FieldName);
    if Assigned(vControl) then
      if pField.IsFK then
      begin
        pField.Value := pField.Value;
        pField.FK.FKCol.Value := TRadioGroup(vControl).Items.Strings[TRadioGroup(vControl).ItemIndex];
      end
      else
        pField.Value := TRadioGroup(vControl).Items.Strings[TRadioGroup(vControl).ItemIndex];
  end;

  procedure SetSubTableValues(pTable: TTable);
  var
    ctx: TRttiContext;
    typ: TRttiType;
    fld: TRttiField;
    AValue: TValue;
    AObject: TObject;
    vPageControl, vParent: TControl;
    n1: Integer;
  begin
    typ := ctx.GetType(pTable.ClassType);
    if Assigned(typ) then
      for fld in typ.GetFields do
        if Assigned(fld) then
          if fld.FieldType is TRttiInstanceType then
            if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TFieldDB) then
            begin
              AValue := fld.GetValue(pTable);
              AObject := nil;
              if not AValue.IsEmpty then
                AObject := AValue.AsObject;

              if Assigned(AObject) then
                if AObject.InheritsFrom(TFieldDB) then
                  if TFieldDB(AObject).FieldName <> pTable.Id.FieldName then
                  begin
                    vPageControl := pnlMain.FindChildControl('pgcMain');
                    if Assigned(vPageControl) then
                    begin
                      for n1 := 0 to TPageControl(vPageControl).PageCount-1 do
                      begin
                        vParent := TPageControl(vPageControl).Pages[n1];
                        SetSubTableValue(vParent, TFieldDB(AObject));
                      end;
                    end
                    else
                    begin
                      vParent := pnlMain;
                      SetSubTableValue(vParent, TFieldDB(AObject));
                    end;
                  end;
            end;
  end;
begin
  SetSubTableValues(Table);

  vTable := getContainTable(Table);
  if Assigned(vTable) then
    SetSubTableValues(vTable);
end;

procedure TfrmBaseInputDB.btnAcceptClick(Sender: TObject);
var
  id, nIndex : integer;
//  vTable: TTable;
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
          TfrmBaseDBGrid(Self.ParentForm).dbgrdBase.DataSource.DataSet.Refresh//.RefreshData;
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
      TranslateText('Are you sure you want to update record?', FrameworkLang.MessageUpdateRecord, LngMsgData, LngSystem),
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
        btnAccept.Width := Max(100, btnAccept.Width);
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
//    SetInputControlProperty(False);

    if (not Table.Database.TranscationIsStarted) then
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
//            vTable := TTable(Table.List[0]).Clone;
//            if Assigned(Table) then
//            begin
//              Table.Free;
//              Table := vTable;
//            end;
          end
          else
          if (Table.List.Count = 0) then
          begin
            raise Exception.Create(
              TranslateText('The record was deleted by another user while you were on the review screen.', FrameworkLang.ErrorRecordDeleted, LngMsgError, LngSystem) +
              AddLBs(2) +
              TranslateText('Check the current records again!', FrameworkLang.ErrorRecordDeletedMessage, LngMsgError, LngSystem)
            );
          end;

          btnSpin.Visible := false;
          FormMode := ifmUpdate;
          btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);
          btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;
          btnAccept.Width := Max(100, btnAccept.Width);
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
      CustomMsgDlg(TranslateText('There is an active transaction. Complete it first!', FrameworkLang.WarningActiveTransaction, LngMsgWarning, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK, '');
    end;

  end;
end;

procedure TfrmBaseInputDB.FormCreate(Sender: TObject);
begin
  inherited;

  if Assigned(Table) then
  begin
    SysTableInfo := TSysViewColumns.Create(Table.Database);
    SysTableInfo.SelectToList(' AND ' + FSysTableInfo.TableName + '.' + FSysTableInfo.OrjTableName.FieldName + '=' + QuotedStr(Table.TableName), False, False);
  end;

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
    btnAccept.Width := Max(100, btnAccept.Width);
  end
  else
  if FormMode = ifmRewiev then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;

    btnAccept.Caption := TranslateText('UPDATE', FrameworkLang.ButtonUpdate, LngButton, LngSystem);
    btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;
    btnAccept.Width := Max(100, btnAccept.Width);
    btnDelete.Caption := TranslateText('DELETE', FrameworkLang.ButtonDelete, LngButton, LngSystem);
    btnDelete.Width := Canvas.TextWidth(btnDelete.Caption) + 56;
    btnDelete.Width := Max(100, btnDelete.Width);
  end;
end;

procedure TfrmBaseInputDB.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Table) then
  begin
    SetControlDBProperty();
    SetHelperProcess;
  end;

  if (FormMode <> ifmNewRecord ) then
    RefreshData;

//  Repaint;
end;

function TfrmBaseInputDB.getContainTable(pTable: TTable): TTable;
var
  ctx: TRttiContext;
  typ: TRttiType;
  fld: TRttiField;
  AValue: TValue;
  AObject: TObject;
begin
  Result := nil;
  typ := ctx.GetType(pTable.ClassType);
  if Assigned(typ) then
    for fld in typ.GetFields do
      if Assigned(fld) then
        if fld.FieldType is TRttiInstanceType then
          if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TTable) then
          begin
            AValue := fld.GetValue(pTable);
            AObject := nil;
            if not AValue.IsEmpty then
              AObject := AValue.AsObject;

            if Assigned(AObject) then
              if AObject.InheritsFrom(TTable) then
                if Assigned(TTable(TFieldDB(AObject))) then
                  Result := TTable(TFieldDB(AObject));
          end;
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
  FSysTableInfo.Free;
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
  else if  (Key = Ord('T')) then
  begin
    if Shift = [ssCtrl, ssShift, ssAlt] then
    begin
      Key := 0;
      if FormViewMode = ivmSort then
        FormViewMode := ivmNormal
      else if FormViewMode = ivmNormal then
        FormViewMode := ivmSort;
      RefreshData;
    end;
  end
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
        TranslateText('Are you sure you want to exit?',FrameworkLang.MessageCloseWindow, LngMsgData, LngSystem),
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

procedure TfrmBaseInputDB.RefreshData;
begin
  RefreshDataAuto;
end;

procedure TfrmBaseInputDB.RefreshDataAuto;
var
  vTable: TTable;

  procedure SubSetControlValue(pParent: TControl; pFieldDB: TFieldDB);
  var
    vControl: TControl;
  begin
    vControl := TWinControl(pParent).FindChildControl(PREFIX_EDIT + pFieldDB.FieldName);
    if Assigned(vControl) then
    begin
      if pFieldDB.IsFK then
        TEdit(vControl).Text := FormatedVariantVal(pFieldDB.FK.FKCol.FieldType, pFieldDB.FK.FKCol.Value)
      else
        TEdit(vControl).Text := FormatedVariantVal(pFieldDB.FieldType, pFieldDB.Value);
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_MEMO + pFieldDB.FieldName);
    if Assigned(vControl) then
    begin
      if pFieldDB.IsFK then
        TMemo(vControl).Lines.Text := FormatedVariantVal(pFieldDB.FK.FKCol.FieldType, pFieldDB.FK.FKCol.Value)
      else
        TMemo(vControl).Lines.Text := FormatedVariantVal(pFieldDB.FieldType, pFieldDB.Value);
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_COMBOBOX + pFieldDB.FieldName);
    if Assigned(vControl) then
    begin
      if pFieldDB.IsFK then
        TCombobox(vControl).ItemIndex := TCombobox(vControl).Items.IndexOf( FormatedVariantVal(pFieldDB.FK.FKCol.FieldType, pFieldDB.FK.FKCol.Value) )
      else
        TCombobox(vControl).ItemIndex := TCombobox(vControl).Items.IndexOf( FormatedVariantVal(pFieldDB.FieldType, pFieldDB.Value) );
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_CHECKBOX + pFieldDB.FieldName);
    if Assigned(vControl) then
    begin
      if pFieldDB.IsFK then
        TCheckBox(vControl).Checked := FormatedVariantVal(pFieldDB.FK.FKCol.FieldType, pFieldDB.FK.FKCol.Value)
      else
        TCheckBox(vControl).Checked := FormatedVariantVal(pFieldDB.FieldType, pFieldDB.Value);
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_RADIOGROUP + pFieldDB.FieldName);
    if Assigned(vControl) then
    begin
      if pFieldDB.IsFK then
        TRadioGroup(vControl).ItemIndex := TRadioGroup(vControl).Items.IndexOf( FormatedVariantVal(pFieldDB.FK.FKCol.FieldType, pFieldDB.FK.FKCol.Value) )
      else
        TRadioGroup(vControl).ItemIndex := TRadioGroup(vControl).Items.IndexOf( FormatedVariantVal(pFieldDB.FieldType, pFieldDB.Value) );
    end;
  end;

  procedure SubSetControlValues(pTable: TTable);
  var
    vPageControl, vParent: TControl;
    n1: Integer;
    ctx: TRttiContext;
    typ: TRttiType;
    fld: TRttiField;
    AValue: TValue;
    AObject: TObject;
  begin
    typ := ctx.GetType(pTable.ClassType);
    if Assigned(typ) then
      for fld in typ.GetFields do
        if Assigned(fld) then
          if fld.FieldType is TRttiInstanceType then
            if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TFieldDB) then
            begin
              AValue := fld.GetValue(pTable);
              AObject := nil;
              if not AValue.IsEmpty then
                AObject := AValue.AsObject;

              if Assigned(AObject) then
                if AObject.InheritsFrom(TFieldDB) then
                begin
                  if TFieldDB(AObject).FieldName <> pTable.Id.FieldName then
                  begin
                    vPageControl := pnlMain.FindChildControl('pgcMain');
                    if Assigned(vPageControl) then
                    begin
                      for n1 := 0 to TPageControl(vPageControl).PageCount-1 do
                      begin
                        vParent := TPageControl(vPageControl).Pages[n1];
                        SubSetControlValue(vParent, TFieldDB(AObject));
                      end;
                    end
                    else
                    begin
                      vParent := pnlMain;
                      SubSetControlValue(vParent, TFieldDB(AObject));
                    end;
                  end;
                end;
            end;
  end;
begin
  SubSetControlValues(Table);
  vTable := getContainTable(Table);
  if Assigned(vTable) then
    SubSetControlValues(vTable);
end;

procedure TfrmBaseInputDB.ResetSession();
begin
  btnAccept.Enabled := false;
  btnDelete.Enabled := false;
  if not SetSession() then
  begin
    Self.Close;
    raise Exception.Create(TranslateText('Access right failure!', FrameworkLang.ErrorAccessRight, LngMsgError, LngSystem));
  end;
end;

procedure TfrmBaseInputDB.SetControlDBProperty;
var
  n1, n2: Integer;
  vControl, vPageControl, vParent: TControl;
  vColName: string;

  ctx: TRttiContext;
  typ: TRttiType;
  fld: TRttiField;
  AValue: TValue;
  AObject: TObject;
  vTable: TTable;
  vSysTableInfo: TSysViewColumns;

  procedure SubSetControlProperty(pParent: TControl; pColumns: TSysViewColumns);
  begin
    vColName := pColumns.OrjColumnName.Value;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_EDIT + vColName);
    if Assigned(vControl) then
    begin
      TEdit(vControl).CharCase := VCL.StdCtrls.ecUpperCase;
      TEdit(vControl).MaxLength := pColumns.CharacterMaximumLength.Value;
      TEdit(vControl).thsDBFieldName := pColumns.OrjColumnName.Value;
      TEdit(vControl).thsRequiredData := pColumns.IsNullable.Value = 'NO';
      TEdit(vControl).thsActiveYear := TSingletonDB.GetInstance.ApplicationSettings.Period.Value;
      TEdit(vControl).thsCaseUpLowSupportTr := True;

      if (pColumns.DataType.Value = 'text')
      or (pColumns.DataType.Value = 'character varying')
      then
        TEdit(vControl).thsInputDataType := itString
      else
      if (pColumns.DataType.Value = 'integer')
      or (pColumns.DataType.Value = 'bigint')
      then
        TEdit(vControl).thsInputDataType := itInteger
      else
      if (pColumns.DataType.Value = 'date')
      or (pColumns.DataType.Value = 'timestamp without time zone')
      then
        TEdit(vControl).thsInputDataType := itDate
      else if (pColumns.DataType.Value = 'double precision') then
        TEdit(vControl).thsInputDataType := itFloat
      else if (pColumns.DataType.Value = 'numeric') then
        TEdit(vControl).thsInputDataType := itMoney;
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_MEMO + vColName);
    if Assigned(vControl) then
    begin
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_COMBOBOX + vColName);
    if Assigned(vControl) then
    begin
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_CHECKBOX + vColName);
    if Assigned(vControl) then
    begin
    end;
    vControl := TWinControl(pParent).FindChildControl(PREFIX_RADIOGROUP + vColName);
    if Assigned(vControl) then
    begin
    end;
  end;

begin
  vPageControl := pnlMain.FindChildControl('pgcMain');
  if Assigned(vPageControl) then
  begin
    for n1 := 0 to TPageControl(vPageControl).PageCount-1 do
    begin
      vParent := TPageControl(vPageControl).Pages[n1];
      for n2 := 0 to SysTableInfo.List.Count-1 do
        SubSetControlProperty(vParent, TSysViewColumns(SysTableInfo.List[n2]));
    end;

    //is_contain_table(Table) evet ise control set yap hayýr ise çýk
    vTable := getContainTable(Table);
    if Assigned(vTable) then
    begin
      vSysTableInfo := TSysViewColumns.Create(Table.Database);
      try
        vSysTableInfo.SelectToList(' AND ' + vSysTableInfo.TableName + '.' + vSysTableInfo.OrjTableName.FieldName + '=' + QuotedStr(vTable.TableName), False, False);
        typ := ctx.GetType(vTable.ClassType);
        if Assigned(typ) then
          for fld in typ.GetFields do
            if Assigned(fld) then
              if fld.FieldType is TRttiInstanceType then
                if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TFieldDB) then
                begin
                  AValue := fld.GetValue(vTable);
                  AObject := nil;
                  if not AValue.IsEmpty then
                    AObject := AValue.AsObject;

                  if Assigned(AObject) then
                    if AObject.InheritsFrom(TFieldDB) then
                      for n1 := 0 to TPageControl(vPageControl).PageCount-1 do
                      begin
                        vParent := TPageControl(vPageControl).Pages[n1];
                        for n2 := 0 to vSysTableInfo.List.Count-1 do
                          SubSetControlProperty(vParent, TSysViewColumns(vSysTableInfo.List[n2]));
                      end;
                end
      finally
        vSysTableInfo.Free;
      end;
    end;
  end
  else
  begin
    vParent := pnlMain;
    for n1 := 0 to SysTableInfo.List.Count-1 do
      SubSetControlProperty(vParent, TSysViewColumns(SysTableInfo.List[n1]));
    //ilk önce sýnýfa ait tüm kontrolleri düzenle
    //daha sonra rtti ile table sýnýfý taranacak ve içinde ttable tipinden bir field varsa
    //table sýnýfý bulunup buradan sysviewcolums bilgileri çekilecek.
    //Bu çekilen column bilgilerine uyan kontrol varmý diye tüm hepsi taranacak ve bulunanlar için bilgiler set edilecek
    //is_contain_table(Table) evet ise control set yap hayýr ise çýk
    vTable := getContainTable(Table);
    if Assigned(vTable) then
    begin
      vSysTableInfo := TSysViewColumns.Create(Table.Database);
      try
        vSysTableInfo.SelectToList(' AND ' + vSysTableInfo.TableName + '.' + vSysTableInfo.OrjTableName.FieldName + '=' + QuotedStr(vTable.TableName), False, False);
        typ := ctx.GetType(vTable.ClassType);
        if Assigned(typ) then
          for fld in typ.GetFields do
            if Assigned(fld) then
              if fld.FieldType is TRttiInstanceType then
                if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TFieldDB) then
                begin
                  AValue := fld.GetValue(vTable);
                  AObject := nil;
                  if not AValue.IsEmpty then
                    AObject := AValue.AsObject;

                  if Assigned(AObject) then
                    if AObject.InheritsFrom(TFieldDB) then
                    begin
                      vParent := pnlMain;
                      for n1 := 0 to vSysTableInfo.List.Count-1 do
                        SubSetControlProperty(vParent, TSysViewColumns(vSysTableInfo.List[n1]));
                    end
                end
      finally
        vSysTableInfo.Free;
      end;
    end;
  end;
end;

procedure TfrmBaseInputDB.SetHelperProcess;
var
  vTable: TTable;

  procedure SubSetHelperProcess(pTable: TTable);
  var
    vControl, vPageControl, vParent: TControl;
    n1: Integer;
    ctx: TRttiContext;
    typ: TRttiType;
    fld: TRttiField;
    AValue: TValue;
    AObject: TObject;
  begin
    typ := ctx.GetType(pTable.ClassType);
    if Assigned(typ) then
      for fld in typ.GetFields do
        if Assigned(fld) then
          if fld.FieldType is TRttiInstanceType then
            if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TFieldDB) then
            begin
              AValue := fld.GetValue(pTable);
              AObject := nil;
              if not AValue.IsEmpty then
                AObject := AValue.AsObject;

              if Assigned(AObject) then
                if AObject.InheritsFrom(TFieldDB) and (TFieldDB(AObject).IsFK) then
                begin
                  vPageControl := pnlMain.FindChildControl('pgcMain');
                  if Assigned(vPageControl) then
                  begin
                    for n1 := 0 to TPageControl(vPageControl).PageCount-1 do
                    begin
                      vParent := TPageControl(vPageControl).Pages[n1];
                      vControl := TWinControl(vParent).FindChildControl(PREFIX_EDIT + TFieldDB(AObject).FieldName);
                      if Assigned(vControl) then
                        TEdit(vControl).OnHelperProcess := HelperProcess;
                    end;
                  end
                  else
                  begin
                    vParent := pnlMain;
                    vControl := TWinControl(vParent).FindChildControl(PREFIX_EDIT + TFieldDB(AObject).FieldName);
                    if Assigned(vControl) then
                      TEdit(vControl).OnHelperProcess := HelperProcess;
                  end;
                end;
            end;
  end;
begin
  SubSetHelperProcess(Table);

  vTable := getContainTable(Table);
  if Assigned(vTable) then
    SubSetHelperProcess(vTable);
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

