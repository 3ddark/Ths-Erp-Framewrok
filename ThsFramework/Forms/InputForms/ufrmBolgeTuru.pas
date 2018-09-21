unit ufrmBolgeTuru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmBolgeTuru = class(TfrmBaseInputDB)
    lblTur: TLabel;
    edtTur: TthsEdit;
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
  Ths.Erp.Database.Table.BolgeTuru;

{$R *.dfm}

procedure TfrmBolgeTuru.FormCreate(Sender: TObject);
begin
  TBolgeTuru(Table).Tur.SetControlProperty(Table.TableName, edtTur);

  inherited;
end;

procedure TfrmBolgeTuru.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTur.Text := FormatedVariantVal(TBolgeTuru(Table).Tur.FieldType, TBolgeTuru(Table).Tur.Value);
end;

procedure TfrmBolgeTuru.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TBolgeTuru(Table).Tur.Value := edtTur.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
