unit ufrmCountry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  thsEdit, thsMemo, Data.DB,
  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts, System.ImageList, Vcl.ImgList,
  Vcl.Samples.Spin;

type
  TfrmCountry = class(TfrmBaseInputDB)
    lblcountry_code: TLabel;
    lblCountryName: TLabel;
    lblISOYear: TLabel;
    lblISOCCTLDCode: TLabel;
    edtCountryCode: TthsEdit;
    edtCountryName: TthsEdit;
    edtISOYear: TthsEdit;
    edtISOCCTLDCode: TthsEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.Country;

{$R *.dfm}

procedure TfrmCountry.FormCreate(Sender: TObject);
begin
  TCountry(Table).CountryCode.SetControlProperty(Table.TableName, edtCountryCode);
  TCountry(Table).CountryName.SetControlProperty(Table.TableName, edtCountryName);
  TCountry(Table).ISOYear.SetControlProperty(Table.TableName, edtISOYear);
  TCountry(Table).ISOCCTLDCode.SetControlProperty(Table.TableName, edtISOCCTLDCode);

  inherited;

  edtISOCCTLDCode.CharCase := ecLowerCase;
end;

procedure TfrmCountry.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmCountry.Repaint();
begin
  inherited;
  //
end;

procedure TfrmCountry.RefreshData();
begin
  edtCountryCode.Text := TCountry(Table).CountryCode.Value;
  edtCountryName.Text := TCountry(Table).CountryName.Value;
  edtISOYear.Text := VarToStr(TCountry(Table).ISOYear.Value);
  edtISOCCTLDCode.Text := TCountry(Table).ISOCCTLDCode.Value;
end;

procedure TfrmCountry.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TCountry(Table).CountryCode.Value := edtCountryCode.Text;
      TCountry(Table).CountryName.Value := edtCountryName.Text;
      TCountry(Table).ISOYear.Value := StrToIntDef(edtISOYear.Text, 0);
      TCountry(Table).ISOCCTLDCode.Value := edtISOCCTLDCode.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
