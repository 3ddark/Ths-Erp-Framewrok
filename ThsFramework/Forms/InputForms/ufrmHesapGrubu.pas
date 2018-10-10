unit ufrmHesapGrubu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmHesapGrubu = class(TfrmBaseInputDB)
    lblGrup: TLabel;
    edtGrup: TEdit;
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
  Ths.Erp.Database.Table.HesapGrubu;

{$R *.dfm}

procedure TfrmHesapGrubu.FormCreate(Sender: TObject);
begin
  THesapGrubu(Table).Grup.SetControlProperty(Table.TableName, edtGrup);

  inherited;
end;

procedure TfrmHesapGrubu.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtGrup.Text := FormatedVariantVal(THesapGrubu(Table).Grup.FieldType, THesapGrubu(Table).Grup.Value);
end;

procedure TfrmHesapGrubu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      THesapGrubu(Table).Grup.Value := edtGrup.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
