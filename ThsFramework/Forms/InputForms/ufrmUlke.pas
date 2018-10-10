unit ufrmUlke;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,
  ufrmBase, ufrmBaseInputDB;

type
  TfrmUlke = class(TfrmBaseInputDB)
    lblcountry_code: TLabel;
    lblCountryName: TLabel;
    lblISOYear: TLabel;
    lblISOCCTLDCode: TLabel;
    edtCountryCode: TEdit;
    edtCountryName: TEdit;
    edtISOYear: TEdit;
    edtISOCCTLDCode: TEdit;
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
  Ths.Erp.Database.Table.Ulke;

{$R *.dfm}

procedure TfrmUlke.FormCreate(Sender: TObject);
begin
  TUlke(Table).UlkeKodu.SetControlProperty(Table.TableName, edtCountryCode);
  TUlke(Table).UlkeAdi.SetControlProperty(Table.TableName, edtCountryName);
  TUlke(Table).ISOYear.SetControlProperty(Table.TableName, edtISOYear);
  TUlke(Table).ISOCCTLDCode.SetControlProperty(Table.TableName, edtISOCCTLDCode);

  inherited;

  edtISOCCTLDCode.CharCase := ecLowerCase;
end;

procedure TfrmUlke.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmUlke.Repaint();
begin
  inherited;
  //
end;

procedure TfrmUlke.RefreshData();
begin
  edtCountryCode.Text := TUlke(Table).UlkeKodu.Value;
  edtCountryName.Text := TUlke(Table).UlkeAdi.Value;
  edtISOYear.Text := VarToStr(TUlke(Table).ISOYear.Value);
  edtISOCCTLDCode.Text := TUlke(Table).ISOCCTLDCode.Value;
end;

procedure TfrmUlke.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TUlke(Table).UlkeKodu.Value := edtCountryCode.Text;
      TUlke(Table).UlkeAdi.Value := edtCountryName.Text;
      TUlke(Table).ISOYear.Value := StrToIntDef(edtISOYear.Text, 0);
      TUlke(Table).ISOCCTLDCode.Value := edtISOCCTLDCode.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
