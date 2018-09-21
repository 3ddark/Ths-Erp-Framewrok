unit ufrmAyarEFaturaIstisnaKodu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmAyarEFaturaIstisnaKodu = class(TfrmBaseInputDB)
    lblKod: TLabel;
    lblAciklama: TLabel;
    lblFaturaTipi: TLabel;
    lblIsTamIstisna: TLabel;
    edtKod: TthsEdit;
    edtAciklama: TthsEdit;
    chkIsTamIstisna: TCheckBox;
    cbbFaturaTipi: TthsCombobox;
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
  Ths.Erp.Database.Table.AyarEFaturaIstisnaKodu,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi;

{$R *.dfm}

procedure TfrmAyarEFaturaIstisnaKodu.FormCreate(Sender: TObject);
var
  vFaturaTipi: TAyarEFaturaFaturaTipi;
  n1: Integer;
begin
  TAyarEFaturaIstisnaKodu(Table).Kod.SetControlProperty(Table.TableName, edtKod);
  TAyarEFaturaIstisnaKodu(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);
  TAyarEFaturaIstisnaKodu(Table).FaturaTipi.SetControlProperty(Table.TableName, cbbFaturaTipi);

  inherited;

  vFaturaTipi := TAyarEFaturaFaturaTipi.Create(TSingletonDB.GetInstance.DataBase);
  try
    cbbFaturaTipi.Clear;
    vFaturaTipi.SelectToList('', False, False);
    for n1 := 0 to vFaturaTipi.List.Count-1 do
      cbbFaturaTipi.Items.Add(TAyarEFaturaFaturaTipi(vFaturaTipi.List[n1]).Tip.Value);
  finally
    vFaturaTipi.Free;
  end;
end;

procedure TfrmAyarEFaturaIstisnaKodu.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtKod.Text := TAyarEFaturaIstisnaKodu(Table).Kod.Value;
  edtAciklama.Text := TAyarEFaturaIstisnaKodu(Table).Aciklama.Value;
  cbbFaturaTipi.Text := TAyarEFaturaIstisnaKodu(Table).FaturaTipi.Value;
  chkIsTamIstisna.Checked := TAyarEFaturaIstisnaKodu(Table).IsTamIstisna.Value;
end;

procedure TfrmAyarEFaturaIstisnaKodu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarEFaturaIstisnaKodu(Table).Kod.Value := edtKod.Text;
      TAyarEFaturaIstisnaKodu(Table).Aciklama.Value := edtAciklama.Text;
      TAyarEFaturaIstisnaKodu(Table).FaturaTipi.Value := cbbFaturaTipi.Text;
      TAyarEFaturaIstisnaKodu(Table).IsTamIstisna.Value := chkIsTamIstisna.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
