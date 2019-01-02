unit ufrmSehir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseInputDB,
  ufrmHelperUlke,

  Ths.Erp.Database.Table.Ulke;

type
  TfrmSehir = class(TfrmBaseInputDB)
    lblSehirAdi: TLabel;
    lblUlkeAdi: TLabel;
    edtSehirAdi: TEdit;
    lblPlakaKodu: TLabel;
    edtPlakaKodu: TEdit;
    edtUlkeAdi: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vHelperUlke: TfrmHelperUlke;
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
    procedure FormDestroy(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.Sehir;

{$R *.dfm}

procedure TfrmSehir.FormCreate(Sender: TObject);
begin
  TSehir(Table).SehirAdi.SetControlProperty(Table.TableName, edtSehirAdi);
  TSehir(Table).UlkeID.FK.FKCol.SetControlProperty(Table.TableName, edtUlkeAdi);
  TSehir(Table).PlakaKodu.SetControlProperty(Table.TableName, edtPlakaKodu);

  inherited;
end;

procedure TfrmSehir.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmSehir.FormShow(Sender: TObject);
begin
  inherited;
  edtUlkeAdi.OnHelperProcess := HelperProcess;
end;

procedure TfrmSehir.HelperProcess(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if Sender is TEdit then
    begin
      if TEdit(Sender).Name = edtUlkeAdi.Name then
      begin
        vHelperUlke := TfrmHelperUlke.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperUlke.ShowModal;
          if Assigned(TSehir(Table).UlkeID.FK.FKTable) then
            TSehir(Table).UlkeID.FK.FKTable.Free;
          TSehir(Table).UlkeID.FK.FKTable := vHelperUlke.Table.Clone;
        finally
          vHelperUlke.Free;
        end;
      end;
    end;
  end;
end;

procedure TfrmSehir.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtSehirAdi.Text := TSehir(Table).SehirAdi.Value;
  edtPlakaKodu.Text := TSehir(Table).PlakaKodu.Value;
  edtUlkeAdi.Text := TSehir(Table).UlkeID.FK.FKCol.Value;
end;

procedure TfrmSehir.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSehir(Table).SehirAdi.Value := edtSehirAdi.Text;
      TSehir(Table).PlakaKodu.Value := edtPlakaKodu.Text;
      TSehir(Table).UlkeID.Value := FormatedVariantVal(TSehir(Table).UlkeID.FK.FKTable.Id.FieldType, TSehir(Table).UlkeID.FK.FKTable.Id.Value);

      inherited;
    end;
  end
  else
    inherited;
end;

end.
