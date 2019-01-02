unit ufrmAyarPrsGorev;

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
  TfrmAyarPrsGorev = class(TfrmBaseInputDB)
    lblGorev: TLabel;
    edtGorev: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsGorev;

{$R *.dfm}

procedure TfrmAyarPrsGorev.FormCreate(Sender: TObject);
begin
  TAyarPrsGorev(Table).Gorev.SetControlProperty(Table.TableName, edtGorev);

  inherited;
end;

procedure TfrmAyarPrsGorev.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtGorev.Text := FormatedVariantVal(TAyarPrsGorev(Table).Gorev.FieldType, TAyarPrsGorev(Table).Gorev.Value);
end;

procedure TfrmAyarPrsGorev.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsGorev(Table).Gorev.Value := edtGorev.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
