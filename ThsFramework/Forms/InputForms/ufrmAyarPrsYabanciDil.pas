unit ufrmAyarPrsYabanciDil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsYabanciDil = class(TfrmBaseInputDB)
    lblYabanciDil: TLabel;
    edtYabanciDil: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsYabanciDil;

{$R *.dfm}

procedure TfrmAyarPrsYabanciDil.FormCreate(Sender: TObject);
begin
  TAyarPrsYabanciDil(Table).YabanciDil.SetControlProperty(Table.TableName, edtYabanciDil);

  inherited;
end;

procedure TfrmAyarPrsYabanciDil.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtYabanciDil.Text := FormatedVariantVal(TAyarPrsYabanciDil(Table).YabanciDil.FieldType, TAyarPrsYabanciDil(Table).YabanciDil.Value);
end;

procedure TfrmAyarPrsYabanciDil.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsYabanciDil(Table).YabanciDil.Value := edtYabanciDil.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
