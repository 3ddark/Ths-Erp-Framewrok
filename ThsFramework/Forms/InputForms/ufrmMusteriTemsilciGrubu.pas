unit ufrmMusteriTemsilciGrubu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmMusteriTemsilciGrubu = class(TfrmBaseInputDB)
    lblTemsilciGrupAdi: TLabel;
    edtTemsilciGrupAdi: TEdit;
    lblGecmisOcak: TLabel;
    edtGecmisOcak: TEdit;
    lblGecmisSubat: TLabel;
    edtGecmisSubat: TEdit;
    lblGecmisMart: TLabel;
    edtGecmisMart: TEdit;
    lblGecmisNisan: TLabel;
    edtGecmisNisan: TEdit;
    lblGecmisMayis: TLabel;
    edtGecmisMayis: TEdit;
    lblGecmisHaziran: TLabel;
    edtGecmisHaziran: TEdit;
    lblGecmisTemmuz: TLabel;
    edtGecmisTemmuz: TEdit;
    lblGecmisAgustos: TLabel;
    edtGecmisAgustos: TEdit;
    lblGecmisEkim: TLabel;
    edtGecmisEkim: TEdit;
    lblGecmisKasim: TLabel;
    edtGecmisKasim: TEdit;
    lblGecmisAralik: TLabel;
    edtGecmisAralik: TEdit;
    lblHedefOcak: TLabel;
    edtHedefOcak: TEdit;
    lblHedefSubat: TLabel;
    edtHedefSubat: TEdit;
    lblHedefMart: TLabel;
    edtHedefMart: TEdit;
    lblHedefNisan: TLabel;
    edtHedefNisan: TEdit;
    lblHedefMayis: TLabel;
    edtHedefMayis: TEdit;
    lblHedefHaziran: TLabel;
    edtHedefHaziran: TEdit;
    lblHedefTemmuz: TLabel;
    edtHedefTemmuz: TEdit;
    lblHedefAgustos: TLabel;
    edtHedefAgustos: TEdit;
    lblHedefEylul: TLabel;
    edtHedefEylul: TEdit;
    lblHedefEkim: TLabel;
    edtHedefEkim: TEdit;
    lblHedefKasim: TLabel;
    edtHedefKasim: TEdit;
    lblHedefAralik: TLabel;
    edtHedefAralik: TEdit;
    lblGecmisEylul: TLabel;
    edtGecmisEylul: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.MusteriTemsilciGrubu;

{$R *.dfm}

procedure TfrmMusteriTemsilciGrubu.FormCreate(Sender: TObject);
begin
  TMusteriTemsilciGrubu(Table).TemsilciGrupAdi.SetControlProperty(Table.TableName, edtTemsilciGrupAdi);
  TMusteriTemsilciGrubu(Table).GecmisOcak.SetControlProperty(Table.TableName, edtGecmisOcak);
  TMusteriTemsilciGrubu(Table).GecmisSubat.SetControlProperty(Table.TableName, edtGecmisSubat);
  TMusteriTemsilciGrubu(Table).GecmisMart.SetControlProperty(Table.TableName, edtGecmisMart);
  TMusteriTemsilciGrubu(Table).GecmisNisan.SetControlProperty(Table.TableName, edtGecmisNisan);
  TMusteriTemsilciGrubu(Table).GecmisMayis.SetControlProperty(Table.TableName, edtGecmisMayis);
  TMusteriTemsilciGrubu(Table).GecmisHaziran.SetControlProperty(Table.TableName, edtGecmisHaziran);
  TMusteriTemsilciGrubu(Table).GecmisTemmuz.SetControlProperty(Table.TableName, edtGecmisTemmuz);
  TMusteriTemsilciGrubu(Table).GecmisAgustos.SetControlProperty(Table.TableName, edtGecmisAgustos);
  TMusteriTemsilciGrubu(Table).GecmisEylul.SetControlProperty(Table.TableName, edtGecmisEylul);
  TMusteriTemsilciGrubu(Table).GecmisEkim.SetControlProperty(Table.TableName, edtGecmisEkim);
  TMusteriTemsilciGrubu(Table).GecmisKasim.SetControlProperty(Table.TableName, edtGecmisKasim);
  TMusteriTemsilciGrubu(Table).GecmisAralik.SetControlProperty(Table.TableName, edtGecmisAralik);
  TMusteriTemsilciGrubu(Table).HedefOcak.SetControlProperty(Table.TableName, edtHedefOcak);
  TMusteriTemsilciGrubu(Table).HedefSubat.SetControlProperty(Table.TableName, edtHedefSubat);
  TMusteriTemsilciGrubu(Table).HedefMart.SetControlProperty(Table.TableName, edtHedefMart);
  TMusteriTemsilciGrubu(Table).HedefNisan.SetControlProperty(Table.TableName, edtHedefNisan);
  TMusteriTemsilciGrubu(Table).HedefMayis.SetControlProperty(Table.TableName, edtHedefMayis);
  TMusteriTemsilciGrubu(Table).HedefHaziran.SetControlProperty(Table.TableName, edtHedefHaziran);
  TMusteriTemsilciGrubu(Table).HedefTemmuz.SetControlProperty(Table.TableName, edtHedefTemmuz);
  TMusteriTemsilciGrubu(Table).HedefAgustos.SetControlProperty(Table.TableName, edtHedefAgustos);
  TMusteriTemsilciGrubu(Table).HedefEylul.SetControlProperty(Table.TableName, edtHedefEylul);
  TMusteriTemsilciGrubu(Table).HedefEkim.SetControlProperty(Table.TableName, edtHedefEkim);
  TMusteriTemsilciGrubu(Table).HedefKasim.SetControlProperty(Table.TableName, edtHedefKasim);
  TMusteriTemsilciGrubu(Table).HedefAralik.SetControlProperty(Table.TableName, edtHedefAralik);

  inherited;
end;

procedure TfrmMusteriTemsilciGrubu.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTemsilciGrupAdi.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).TemsilciGrupAdi.FieldType, TMusteriTemsilciGrubu(Table).TemsilciGrupAdi.Value);
  edtGecmisOcak.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisOcak.FieldType, TMusteriTemsilciGrubu(Table).GecmisOcak.Value);
  edtGecmisSubat.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisSubat.FieldType, TMusteriTemsilciGrubu(Table).GecmisSubat.Value);
  edtGecmisMart.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisMart.FieldType, TMusteriTemsilciGrubu(Table).GecmisMart.Value);
  edtGecmisNisan.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisNisan.FieldType, TMusteriTemsilciGrubu(Table).GecmisNisan.Value);
  edtGecmisMayis.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisMayis.FieldType, TMusteriTemsilciGrubu(Table).GecmisMayis.Value);
  edtGecmisHaziran.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisHaziran.FieldType, TMusteriTemsilciGrubu(Table).GecmisHaziran.Value);
  edtGecmisTemmuz.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisTemmuz.FieldType, TMusteriTemsilciGrubu(Table).GecmisTemmuz.Value);
  edtGecmisAgustos.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisAgustos.FieldType, TMusteriTemsilciGrubu(Table).GecmisAgustos.Value);
  edtGecmisEylul.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisEylul.FieldType, TMusteriTemsilciGrubu(Table).GecmisEylul.Value);
  edtGecmisEkim.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisEkim.FieldType, TMusteriTemsilciGrubu(Table).GecmisEkim.Value);
  edtGecmisKasim.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisKasim.FieldType, TMusteriTemsilciGrubu(Table).GecmisKasim.Value);
  edtGecmisAralik.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).GecmisAralik.FieldType, TMusteriTemsilciGrubu(Table).GecmisAralik.Value);
  edtHedefOcak.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefOcak.FieldType, TMusteriTemsilciGrubu(Table).HedefOcak.Value);
  edtHedefSubat.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefSubat.FieldType, TMusteriTemsilciGrubu(Table).HedefSubat.Value);
  edtHedefMart.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefMart.FieldType, TMusteriTemsilciGrubu(Table).HedefMart.Value);
  edtHedefNisan.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefNisan.FieldType, TMusteriTemsilciGrubu(Table).HedefNisan.Value);
  edtHedefMayis.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefMayis.FieldType, TMusteriTemsilciGrubu(Table).HedefMayis.Value);
  edtHedefHaziran.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefHaziran.FieldType, TMusteriTemsilciGrubu(Table).HedefHaziran.Value);
  edtHedefTemmuz.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefTemmuz.FieldType, TMusteriTemsilciGrubu(Table).HedefTemmuz.Value);
  edtHedefAgustos.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefAgustos.FieldType, TMusteriTemsilciGrubu(Table).HedefAgustos.Value);
  edtHedefEylul.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefEylul.FieldType, TMusteriTemsilciGrubu(Table).HedefEylul.Value);
  edtHedefEkim.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefEkim.FieldType, TMusteriTemsilciGrubu(Table).HedefEkim.Value);
  edtHedefKasim.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefKasim.FieldType, TMusteriTemsilciGrubu(Table).HedefKasim.Value);
  edtHedefAralik.Text := FormatedVariantVal(TMusteriTemsilciGrubu(Table).HedefAralik.FieldType, TMusteriTemsilciGrubu(Table).HedefAralik.Value);
end;

procedure TfrmMusteriTemsilciGrubu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TMusteriTemsilciGrubu(Table).TemsilciGrupAdi.Value := edtTemsilciGrupAdi.Text;
      TMusteriTemsilciGrubu(Table).GecmisOcak.Value := edtGecmisOcak.Text;
      TMusteriTemsilciGrubu(Table).GecmisSubat.Value := edtGecmisSubat.Text;
      TMusteriTemsilciGrubu(Table).GecmisMart.Value := edtGecmisMart.Text;
      TMusteriTemsilciGrubu(Table).GecmisNisan.Value := edtGecmisNisan.Text;
      TMusteriTemsilciGrubu(Table).GecmisMayis.Value := edtGecmisMayis.Text;
      TMusteriTemsilciGrubu(Table).GecmisHaziran.Value := edtGecmisHaziran.Text;
      TMusteriTemsilciGrubu(Table).GecmisTemmuz.Value := edtGecmisTemmuz.Text;
      TMusteriTemsilciGrubu(Table).GecmisAgustos.Value := edtGecmisAgustos.Text;
      TMusteriTemsilciGrubu(Table).GecmisEylul.Value := edtGecmisEylul.Text;
      TMusteriTemsilciGrubu(Table).GecmisEkim.Value := edtGecmisEkim.Text;
      TMusteriTemsilciGrubu(Table).GecmisKasim.Value := edtGecmisKasim.Text;
      TMusteriTemsilciGrubu(Table).GecmisAralik.Value := edtGecmisAralik.Text;
      TMusteriTemsilciGrubu(Table).HedefOcak.Value := edtHedefOcak.Text;
      TMusteriTemsilciGrubu(Table).HedefSubat.Value := edtHedefSubat.Text;
      TMusteriTemsilciGrubu(Table).HedefMart.Value := edtHedefMart.Text;
      TMusteriTemsilciGrubu(Table).HedefNisan.Value := edtHedefNisan.Text;
      TMusteriTemsilciGrubu(Table).HedefMayis.Value := edtHedefMayis.Text;
      TMusteriTemsilciGrubu(Table).HedefHaziran.Value := edtHedefHaziran.Text;
      TMusteriTemsilciGrubu(Table).HedefTemmuz.Value := edtHedefTemmuz.Text;
      TMusteriTemsilciGrubu(Table).HedefAgustos.Value := edtHedefAgustos.Text;
      TMusteriTemsilciGrubu(Table).HedefEylul.Value := edtHedefEylul.Text;
      TMusteriTemsilciGrubu(Table).HedefEkim.Value := edtHedefEkim.Text;
      TMusteriTemsilciGrubu(Table).HedefKasim.Value := edtHedefKasim.Text;
      TMusteriTemsilciGrubu(Table).HedefAralik.Value := edtHedefAralik.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
