unit ufrmSehir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmSehir = class(TfrmBaseInputDB)
    lblSehirAdi: TLabel;
    lblUlkeAdi: TLabel;
    edtSehirAdi: TthsEdit;
    cbbUlkeAdi: TthsCombobox;
    lblPlakaKodu: TLabel;
    edtPlakaKodu: TthsEdit;
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
  Ths.Erp.Database.Table.Ulke,
  Ths.Erp.Database.Table.Sehir;

{$R *.dfm}

procedure TfrmSehir.FormCreate(Sender: TObject);
var
  n1: Integer;
  vUlke: TUlke;
begin
  TSehir(Table).SehirAdi.SetControlProperty(Table.TableName, edtSehirAdi);
  TSehir(Table).UlkeAdi.SetControlProperty(Table.TableName, cbbUlkeAdi);
  TSehir(Table).PlakaKodu.SetControlProperty(Table.TableName, edtPlakaKodu);

  inherited;

  vUlke := TUlke.Create(Table.Database);
  try
    vUlke.SelectToList('', False, False);

    cbbUlkeAdi.Clear;
    for n1 := 0 to vUlke.List.Count-1 do
      cbbUlkeAdi.Items.Add( VarToStr(TUlke(vUlke.List[n1]).UlkeAdi.Value) );
    cbbUlkeAdi.ItemIndex := -1;
  finally
    vUlke.Free;
  end;
end;

procedure TfrmSehir.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtSehirAdi.Text := TSehir(Table).SehirAdi.Value;
  cbbUlkeAdi.ItemIndex := cbbUlkeAdi.Items.IndexOf( VarToStr(TSehir(Table).UlkeAdi.Value) );
  edtPlakaKodu.Text := TSehir(Table).PlakaKodu.Value;
end;

procedure TfrmSehir.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSehir(Table).SehirAdi.Value := edtSehirAdi.Text;
      TSehir(Table).UlkeAdi.Value := cbbUlkeAdi.Text;
      TSehir(Table).PlakaKodu.Value := edtPlakaKodu.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
