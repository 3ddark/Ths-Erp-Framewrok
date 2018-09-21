unit ufrmStokKartlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmStokKartlari = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmStokKarti,
  Ths.Erp.Database.Table.StokKarti;

{$R *.dfm}

{ TfrmStokKartlari }

function TfrmStokKartlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmStokKarti.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmStokKarti.Create(Application, Self, TStokKarti.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmStokKarti.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmStokKartlari.FormShow(Sender: TObject);
var
  vHaneSayisi: Integer;
begin
  inherited;
  vHaneSayisi := TSingletonDB.GetInstance.HaneMiktari.StokMiktar.Value;
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).HamAlisFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).AlisFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).SatisFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).IhracFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).IhracFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).OrtalamaMaliyet.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).EnAzStokSeviyesi.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
end;

procedure TfrmStokKartlari.SetSelectedItem;
begin
  inherited;

  TStokKarti(Table).StokKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokKodu.FieldName).Value);
  TStokKarti(Table).StokAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokAdi.FieldName).Value);
  TStokKarti(Table).StokGrubuID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokGrubuID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokGrubuID.FieldName).Value);
  TStokKarti(Table).StokGrubu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokGrubu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokGrubu.FieldName).Value);
  TStokKarti(Table).OlcuBirimiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OlcuBirimiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OlcuBirimiID.FieldName).Value);
  TStokKarti(Table).OlcuBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OlcuBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OlcuBirimi.FieldName).Value);
  TStokKarti(Table).AlisIskonto.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).AlisIskonto.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).AlisIskonto.FieldName).Value);
  TStokKarti(Table).SatisIskonto.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SatisIskonto.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SatisIskonto.FieldName).Value);
  TStokKarti(Table).YetkiliIskonto.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).YetkiliIskonto.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).YetkiliIskonto.FieldName).Value);
  TStokKarti(Table).StokTipiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokTipiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokTipiID.FieldName).Value);
  TStokKarti(Table).StokTipi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StokTipi.FieldName).Value);
  TStokKarti(Table).HamAlisFiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HamAlisFiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HamAlisFiyat.FieldName).Value);
  TStokKarti(Table).HamAlisParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HamAlisParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HamAlisParaBirimi.FieldName).Value);
  TStokKarti(Table).AlisFiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).AlisFiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).AlisFiyat.FieldName).Value);
  TStokKarti(Table).AlisParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).AlisParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).AlisParaBirimi.FieldName).Value);
  TStokKarti(Table).SatisFiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SatisFiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SatisFiyat.FieldName).Value);
  TStokKarti(Table).SatisParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SatisParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SatisParaBirimi.FieldName).Value);
  TStokKarti(Table).IhracFiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IhracFiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IhracFiyat.FieldName).Value);
  TStokKarti(Table).IhracParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IhracParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IhracParaBirimi.FieldName).Value);
  TStokKarti(Table).OrtalamaMaliyet.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OrtalamaMaliyet.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OrtalamaMaliyet.FieldName).Value);

  TStokKarti(Table).VarsayilaReceteID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).VarsayilaReceteID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).VarsayilaReceteID.FieldName).Value);
//  TStokKarti(Table).VarsayilanRecete.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).VarsayilanRecete.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).VarsayilanRecete.FieldName).Value);

  TStokKarti(Table).En.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).En.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).En.FieldName).Value);
  TStokKarti(Table).Boy.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Boy.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Boy.FieldName).Value);
  TStokKarti(Table).Yukseklik.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Yukseklik.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Yukseklik.FieldName).Value);
  TStokKarti(Table).MenseiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).MenseiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).MenseiID.FieldName).Value);
  TStokKarti(Table).Mensei.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Mensei.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Mensei.FieldName).Value);
  TStokKarti(Table).GtipNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).GtipNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).GtipNo.FieldName).Value);
  TStokKarti(Table).DiibUrunTanimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DiibUrunTanimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DiibUrunTanimi.FieldName).Value);

  TStokKarti(Table).EnAzStokSeviyesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).En.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).EnAzStokSeviyesi.FieldName).Value);
  TStokKarti(Table).Tanim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Tanim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Tanim.FieldName).Value);
  TStokKarti(Table).OzelKod.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OzelKod.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OzelKod.FieldName).Value);
  TStokKarti(Table).Marka.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Marka.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Marka.FieldName).Value);
  TStokKarti(Table).Agirlik.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Agirlik.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Agirlik.FieldName).Value);
  TStokKarti(Table).Kapasite.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Kapasite.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Kapasite.FieldName).Value);

  TStokKarti(Table).CinsID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).CinsID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).CinsID.FieldName).Value);
  TStokKarti(Table).Cins.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Cins.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).Cins.FieldName).Value);
  TStokKarti(Table).StringDegisken1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken1.FieldName).Value);
  TStokKarti(Table).StringDegisken2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken2.FieldName).Value);
  TStokKarti(Table).StringDegisken3.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken3.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken3.FieldName).Value);
  TStokKarti(Table).StringDegisken4.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken4.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken4.FieldName).Value);
  TStokKarti(Table).StringDegisken5.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken5.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken5.FieldName).Value);
  TStokKarti(Table).StringDegisken6.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken6.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).StringDegisken6.FieldName).Value);
  TStokKarti(Table).IntegerDegisken1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IntegerDegisken1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IntegerDegisken1.FieldName).Value);
  TStokKarti(Table).IntegerDegisken2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IntegerDegisken2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IntegerDegisken2.FieldName).Value);
  TStokKarti(Table).IntegerDegisken3.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IntegerDegisken3.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IntegerDegisken3.FieldName).Value);
  TStokKarti(Table).DoubleDegisken1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DoubleDegisken1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DoubleDegisken1.FieldName).Value);
  TStokKarti(Table).DoubleDegisken2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DoubleDegisken2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DoubleDegisken2.FieldName).Value);
  TStokKarti(Table).DoubleDegisken3.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DoubleDegisken3.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).DoubleDegisken3.FieldName).Value);

  TStokKarti(Table).IsSatilabilir.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsSatilabilir.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsSatilabilir.FieldName).Value);
  TStokKarti(Table).IsAnaUrun.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsAnaUrun.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsAnaUrun.FieldName).Value);
  TStokKarti(Table).IsYariMamul.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsYariMamul.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsYariMamul.FieldName).Value);
  TStokKarti(Table).IsOtomatikUretimUrunu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsOtomatikUretimUrunu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsOtomatikUretimUrunu.FieldName).Value);
  TStokKarti(Table).IsOzetUrun.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsOzetUrun.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsOzetUrun.FieldName).Value);
  TStokKarti(Table).LotPartiMiktari.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).LotPartiMiktari.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).LotPartiMiktari.FieldName).Value);
  TStokKarti(Table).PaketMiktari.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).PaketMiktari.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).PaketMiktari.FieldName).Value);

  TStokKarti(Table).SeriNoTuru.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SeriNoTuru.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).SeriNoTuru.FieldName).Value);
  TStokKarti(Table).IsHariciSeriNoIcerir.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsHariciSeriNoIcerir.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).IsHariciSeriNoIcerir.FieldName).Value);
  TStokKarti(Table).HariciSeriNoStokKoduID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HariciSeriNoStokKoduID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HariciSeriNoStokKoduID.FieldName).Value);
  TStokKarti(Table).HariciSerinoStokKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HariciSerinoStokKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).HariciSerinoStokKodu.FieldName).Value);

  TStokKarti(Table).TasiyiciPaketID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).TasiyiciPaketID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).TasiyiciPaketID.FieldName).Value);
//  TStokKarti(Table).TasiyiciPaket.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).TasiyiciPaket.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).TasiyiciPaket.FieldName).Value);

  TStokKarti(Table).OncekiDonemCikanMiktar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OncekiDonemCikanMiktar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).OncekiDonemCikanMiktar.FieldName).Value);
  TStokKarti(Table).TeminSuresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).TeminSuresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokKarti(Table).TeminSuresi.FieldName).Value);
end;

end.
