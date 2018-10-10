unit ufrmAyarPersonelKanGrubu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPersonelKanGrubu = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TEdit;
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
  Ths.Erp.Database.Table.AyarPersonelKanGrubu;

{$R *.dfm}

procedure TfrmAyarPersonelKanGrubu.FormCreate(Sender: TObject);
begin
  TAyarPersonelKanGrubu(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarPersonelKanGrubu.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarPersonelKanGrubu(Table).Deger.FieldType, TAyarPersonelKanGrubu(Table).Deger.Value);
end;

procedure TfrmAyarPersonelKanGrubu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelKanGrubu(Table).Deger.Value := edtDeger.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
