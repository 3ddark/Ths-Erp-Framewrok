unit ufrmBanka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmBanka = class(TfrmBaseInputDB)
    lblAdi: TLabel;
    edtAdi: TthsEdit;
    lblSwiftKodu: TLabel;
    edtSwiftKodu: TthsEdit;
    lblIsActive: TLabel;
    chkIsActive: TCheckBox;
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
  Ths.Erp.Database.Table.Banka;

{$R *.dfm}

procedure TfrmBanka.FormCreate(Sender: TObject);
begin
  TBanka(Table).Adi.SetControlProperty(Table.TableName, edtAdi);
  TBanka(Table).SwiftKodu.SetControlProperty(Table.TableName, edtSwiftKodu);

  inherited;
end;

procedure TfrmBanka.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtAdi.Text := FormatedVariantVal(TBanka(Table).Adi.FieldType, TBanka(Table).Adi.Value);
  edtSwiftKodu.Text := FormatedVariantVal(TBanka(Table).SwiftKodu.FieldType, TBanka(Table).SwiftKodu.Value);
  chkIsActive.Checked := FormatedVariantVal(TBanka(Table).IsActive.FieldType, TBanka(Table).IsActive.Value);
end;

procedure TfrmBanka.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TBanka(Table).Adi.Value := edtAdi.Text;
      TBanka(Table).SwiftKodu.Value := edtSwiftKodu.Text;
      TBanka(Table).IsActive.Value := chkIsActive.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
