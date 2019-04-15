unit ufrmStokTipi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmStokTipi = class(TfrmBaseInputDB)
    lbltip: TLabel;
    edttip: TEdit;
    lblis_default: TLabel;
    chkis_default: TCheckBox;
    lblis_stok_hareketi_yap: TLabel;
    chkis_stok_hareketi_yap: TCheckBox;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    function VarsayilanKontrol(): Boolean;
  public
  protected
    function ValidateInput(panel_groupbox_pagecontrol_tabsheet: TWinControl = nil): Boolean;
      override;
  published
    procedure btnDeleteClick(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Functions,
  Ths.Erp.Constants,
  Ths.Erp.Database.Table.AyarStkStokTipi;

{$R *.dfm}

procedure TfrmStokTipi.btnDeleteClick(Sender: TObject);
begin
  //silme iþleminde, iþlem öncesinde varsayýlan olan kayýt silinemez önce baþka bir varsayýlan seçilmeli
  if (FormMode = ifmUpdate) then
  begin
    if (FormatedVariantVal(TAyarStkStokTipi(Table).IsDefault.FieldType, TAyarStkStokTipi(Table).IsDefault.Value) = True) then
    begin
      if VarsayilanKontrol then
        inherited;
    end
    else
      inherited;
  end
  else
    inherited;
end;

function TfrmStokTipi.ValidateInput(
  panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean;
begin
  Result := inherited ValidateInput();

  //güncelleme iþleminde, iþlem öncesinde varsayýlan olan kaydýn varsayýlan iþaretini kaldýramazsýnýz önce baþka bir varsayýlan seçilmeli
  if ((FormMode = ifmUpdate) and (not chkis_default.Checked)
  and (FormatedVariantVal(TAyarStkStokTipi(Table).IsDefault.FieldType, TAyarStkStokTipi(Table).IsDefault.Value) = True)) then
    Result := VarsayilanKontrol;
end;

function TfrmStokTipi.VarsayilanKontrol: Boolean;
begin
  Result := True;
  if ((FormMode = ifmUpdate)
  and (not chkis_default.Checked)
  and (FormatedVariantVal(TAyarStkStokTipi(Table).IsDefault.FieldType, TAyarStkStokTipi(Table).IsDefault.Value) = True))
  then
    Result := False;
    CustomMsgDlg(
      ReplaceMessages(
      TranslateText(
          'Bu iþlemi yapamazsýnýz! Bu iþlemde "Varsayýlan" iþareti kaldýrýlýyor.' + AddLBs +
          'Önce baþka bir kaydý "Varsayýlan" olarak seçmelisiniz.' + AddLBs +
          'Daha sonra bu kaydýn Varsayýlan iþaretini kadýrabilirsiniz.',
          'Stok Tipi Varsayilan Yok', LngMsgData, LngApplication), [''], ['']),
          mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
          TranslateText('Diðer', FrameworkLang.MessageTitleError, LngMsgTitle, LngSystem)
    );
end;

procedure TfrmStokTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
