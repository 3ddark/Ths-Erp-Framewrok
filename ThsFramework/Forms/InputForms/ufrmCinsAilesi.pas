unit ufrmCinsAilesi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmCinsAilesi = class(TfrmBaseInputDB)
    edtAile: TEdit;
    lblAile: TLabel;
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
  Ths.Erp.Database.Table.CinsAilesi;

{$R *.dfm}

procedure TfrmCinsAilesi.FormCreate(Sender: TObject);
begin
  TCinsAilesi(Table).Aile.SetControlProperty(Table.TableName, edtAile);

  inherited;
end;

procedure TfrmCinsAilesi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtAile.Text := FormatedVariantVal(TCinsAilesi(Table).Aile.FieldType, TCinsAilesi(Table).Aile.Value);
end;

procedure TfrmCinsAilesi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TCinsAilesi(Table).Aile.Value := edtAile.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
