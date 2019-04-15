unit ufrmBankaSubesi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.SysCity,
  Ths.Erp.Database.Table.Banka;

type
  TfrmBankaSubesi = class(TfrmBaseInputDB)
    cbbBanka: TComboBox;
    cbbSubeIl: TComboBox;
    edtSubeAdi: TEdit;
    edtSubeKodu: TEdit;
    lblBanka: TLabel;
    lblSubeAdi: TLabel;
    lblSubeIl: TLabel;
    lblSubeKodu: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.BankaSubesi;

{$R *.dfm}

procedure TfrmBankaSubesi.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmBankaSubesi.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TfrmBankaSubesi.RefreshData();
begin
  //control içeriðini table class ile doldur
  inherited;
end;

procedure TfrmBankaSubesi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
