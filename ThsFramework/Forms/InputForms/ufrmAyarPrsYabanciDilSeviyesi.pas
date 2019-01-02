unit ufrmAyarPrsYabanciDilSeviyesi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsYabanciDilSeviyesi = class(TfrmBaseInputDB)
    lblYabanciDilSeviyesi: TLabel;
    edtYabanciDilSeviyesi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsYabanciDilSeviyesi;

{$R *.dfm}

procedure TfrmAyarPrsYabanciDilSeviyesi.FormCreate(Sender: TObject);
begin
  TAyarPrsYabanciDilSeviyesi(Table).YabanciDilSeviyesi.SetControlProperty(Table.TableName, edtYabanciDilSeviyesi);

  inherited;
end;

procedure TfrmAyarPrsYabanciDilSeviyesi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtYabanciDilSeviyesi.Text := FormatedVariantVal(TAyarPrsYabanciDilSeviyesi(Table).YabanciDilSeviyesi.FieldType, TAyarPrsYabanciDilSeviyesi(Table).YabanciDilSeviyesi.Value);
end;

procedure TfrmAyarPrsYabanciDilSeviyesi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsYabanciDilSeviyesi(Table).YabanciDilSeviyesi.Value := edtYabanciDilSeviyesi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
