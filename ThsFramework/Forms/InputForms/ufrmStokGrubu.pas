unit ufrmStokGrubu;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.AyarVergiOrani,
  Ths.Erp.Database.Table.AyarStkStokGrubuTuru,
  Ths.Erp.Database.Table.HesapKarti;

type
  TfrmStokGrubu = class(TfrmBaseInputDB)
    lblalis_hesabi: TLabel;
    lblalis_iade_hesabi: TLabel;
    lblgrup: TLabel;
    lblhammadde_hesabi: TLabel;
    lblIsIskontoAktif: TLabel;
    lblIskontoMudur: TLabel;
    lblIskontoSatis: TLabel;
    lblIsMaliyetAnalizFarkliDB: TLabel;
    lblIsSatisFiyatiniKullan: TLabel;
    lblkdv_orani: TLabel;
    lblmamul_hesabi: TLabel;
    lblsatis_hesabi: TLabel;
    lblsatis_iade_hesabi: TLabel;
    lblayar_stk_stok_grubu_turu_id: TLabel;
    lblihracat_hesabi: TLabel;
    edtayar_stk_stok_grubu_turu_id: TEdit;
    edtkdv_orani: TEdit;
    edtgrup: TEdit;
    edtalis_hesabi: TEdit;
    edtalis_iade_hesabi: TEdit;
    edtsatis_hesabi: TEdit;
    edtsatis_iade_hesabi: TEdit;
    edtihracat_hesabi: TEdit;
    edthammadde_hesabi: TEdit;
    edtmamul_hesabi: TEdit;
    chkIsIskontoAktif: TCheckBox;
    edtIskontoSatis: TEdit;
    edtIskontoMudur: TEdit;
    chkIsSatisFiyatiniKullan: TCheckBox;
    chkIsMaliyetAnalizFarkliDB: TCheckBox;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
  end;

implementation

uses
    ufrmBaseHelper
  , Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Table.AyarStkStokGrubu
  , ufrmHelperAyarVergiOranlari
  ;

{$R *.dfm}

procedure TfrmStokGrubu.btnAcceptClick(Sender: TObject);
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

procedure TfrmStokGrubu.HelperProcess(Sender: TObject);
var
  vHelperVergiOrani: TfrmHelperAyarVergiOranlari;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtkdv_orani.Name then
      begin
        vHelperVergiOrani := TfrmHelperAyarVergiOranlari.Create(TEdit(Sender), Self, TAyarVergiOrani.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperVergiOrani.ShowModal;

          if Assigned(TAyarStkStokGrubu(Table).KDVOrani.FK.FKTable) then
            TAyarStkStokGrubu(Table).KDVOrani.FK.FKTable.Free;
          TAyarStkStokGrubu(Table).KDVOrani.Value := TAyarVergiOrani(vHelperVergiOrani.Table).VergiOrani.Value;
          TAyarStkStokGrubu(Table).KDVOrani.FK.FKTable := vHelperVergiOrani.Table.Clone;
        finally
          vHelperVergiOrani.Free;
        end;
      end;
    end;
  end;
end;

end.
