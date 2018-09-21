unit ufrmQualityFormMailReciever;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmQualityFormMailReciever = class(TfrmBaseInputDB)
    lblMailAdresi: TLabel;
    edtMailAdresi: TthsEdit;
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
  TQualityFormMailReciever(Table).MailAdresi.SetControlProperty(Table.TableName, edtMailAdresi);

  inherited;

  edtMailAdresi.CharCase := ecNormal;
end;

procedure TfrmQualityFormMailReciever.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtMailAdresi.Text := FormatedVariantVal(TQualityFormMailReciever(Table).MailAdresi.FieldType, TQualityFormMailReciever(Table).MailAdresi.Value);
end;

procedure TfrmQualityFormMailReciever.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TQualityFormMailReciever(Table).MailAdresi.Value := edtMailAdresi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
