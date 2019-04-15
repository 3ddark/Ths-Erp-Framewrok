unit ufrmQualityFormMailReciever;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmQualityFormMailReciever = class(TfrmBaseInputDB)
    lblMailAdresi: TLabel;
    edtmail_adresi: TEdit;
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
  Ths.Erp.Database.Table.QualityFormMailReciever;

{$R *.dfm}

procedure TfrmQualityFormMailReciever.FormCreate(Sender: TObject);
begin
  TQualityFormMailReciever(Table).MailAdresi.SetControlProperty(Table.TableName, edtmail_adresi);

  inherited;

  edtmail_adresi.CharCase := ecNormal;
end;

procedure TfrmQualityFormMailReciever.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtmail_adresi.Text := FormatedVariantVal(TQualityFormMailReciever(Table).MailAdresi.FieldType, TQualityFormMailReciever(Table).MailAdresi.Value);
end;

procedure TfrmQualityFormMailReciever.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TQualityFormMailReciever(Table).MailAdresi.Value := edtmail_adresi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
