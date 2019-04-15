unit ufrmStokHareketi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmStokHareketi = class(TfrmBaseInputDB)
    edtMiktar: TEdit;
    edtStokKodu: TEdit;
    edtTarih: TEdit;
    edtTutar: TEdit;
    lblMiktar: TLabel;
    lblStokKodu: TLabel;
    lblTarih: TLabel;
    lblTutar: TLabel;
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
  Ths.Erp.Database.Table.StokHareketi;

{$R *.dfm}

procedure TfrmStokHareketi.FormCreate(Sender: TObject);
begin
  TStokHareketi(Table).StokKodu.SetControlProperty(Table.TableName, edtStokKodu);
  TStokHareketi(Table).Miktar.SetControlProperty(Table.TableName, edtMiktar);
  TStokHareketi(Table).Tutar.SetControlProperty(Table.TableName, edtTutar);
  TStokHareketi(Table).Tarih.SetControlProperty(Table.TableName, edtTarih);

  inherited;
end;

procedure TfrmStokHareketi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtStokKodu.Text := TStokHareketi(Table).StokKodu.Value;
  edtMiktar.Text := TStokHareketi(Table).Miktar.Value;
  edtTutar.Text := TStokHareketi(Table).Tutar.Value;
  edtTarih.Text := TStokHareketi(Table).Tarih.Value;
end;

procedure TfrmStokHareketi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TStokHareketi(Table).StokKodu.Value := edtStokKodu.Text;
      TStokHareketi(Table).Miktar.Value := edtMiktar.Text;
      TStokHareketi(Table).Tutar.Value := edtTutar.Text;
      TStokHareketi(Table).Tarih.Value := edtTarih.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
