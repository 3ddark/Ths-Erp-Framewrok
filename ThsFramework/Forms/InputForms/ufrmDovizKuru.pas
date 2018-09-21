unit ufrmDovizKuru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmDovizKuru = class(TfrmBaseInputDB)
    lblTarih: TLabel;
    edtTarih: TthsEdit;
    lblParaBirimi: TLabel;
    cbbParaBirimi: TthsComboBox;
    lblKur: TLabel;
    edtKur: TthsEdit;
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
  Ths.Erp.Database.Table.DovizKuru,
  Ths.Erp.Database.Table.ParaBirimi;

{$R *.dfm}

procedure TfrmDovizKuru.FormCreate(Sender: TObject);
var
  vPara: TParaBirimi;
  n1: Integer;
begin
  TDovizKuru(Table).Tarih.SetControlProperty(Table.TableName, edtTarih);
  TDovizKuru(Table).ParaBirimi.SetControlProperty(Table.TableName, cbbParaBirimi);
  TDovizKuru(Table).Kur.SetControlProperty(Table.TableName, edtKur);

  inherited;

//  cbbParaBirimi.Style := csDropDownList;

  vPara := TParaBirimi.Create(TSingletonDB.GetInstance.DataBase);
  try
    cbbParaBirimi.Clear;
    vPara.SelectToList(' and ' + vPara.TableName + '.' + vPara.IsVarsayilan.FieldName + '=false', False, False);
    for n1 := 0 to vPara.List.Count-1 do
      cbbParaBirimi.Items.Add(FormatedVariantVal(TParaBirimi(vPara.List[n1]).Kod.FieldType, TParaBirimi(vPara.List[n1]).Kod.Value));
    cbbParaBirimi.ItemIndex := 0;
  finally
    vPara.Free;
  end;
end;

procedure TfrmDovizKuru.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTarih.Text := FormatedVariantVal(TDovizKuru(Table).Tarih.FieldType, TDovizKuru(Table).Tarih.Value);
  cbbParaBirimi.Text := FormatedVariantVal(TDovizKuru(Table).ParaBirimi.FieldType, TDovizKuru(Table).ParaBirimi.Value);
  edtKur.Text := FormatedVariantVal(TDovizKuru(Table).Kur.FieldType, TDovizKuru(Table).Kur.Value);
end;

procedure TfrmDovizKuru.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TDovizKuru(Table).Tarih.Value := edtTarih.Text;
      TDovizKuru(Table).ParaBirimi.Value := cbbParaBirimi.Text;
      TDovizKuru(Table).Kur.Value := edtKur.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
