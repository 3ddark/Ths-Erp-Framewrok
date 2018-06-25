unit ufrmCity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.Country, System.ImageList, Vcl.ImgList,
  Vcl.Samples.Spin;

type
  TfrmCity = class(TfrmBaseInputDB)
    lblcity_name: TLabel;
    lblcountry_name: TLabel;
    edtCityName: TthsEdit;
    cbbCountryName: TthsCombobox;
    destructor Destroy; override;
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
  Ths.Erp.Database.Table.Country.City;

{$R *.dfm}

Destructor TfrmCity.Destroy;
begin
  //
  inherited;
end;

procedure TfrmCity.FormCreate(Sender: TObject);
var
  n1: Integer;
  vCountry: TCountry;
begin
  TCity(Table).CityName.SetControlProperty(Table.TableName, edtCityName);
  TCity(Table).CountryName.SetControlProperty(Table.TableName, cbbCountryName);

  inherited;

  vCountry := TCountry.Create(Table.Database);
  try
    vCountry.SelectToList('', False, False);

    cbbCountryName.Clear;
    for n1 := 0 to vCountry.List.Count-1 do
      cbbCountryName.Items.Add( VarToStr(TCountry(vCountry.List[n1]).CountryName.Value) );
    cbbCountryName.ItemIndex := -1;
  finally
    vCountry.Free;
  end;
end;

procedure TfrmCity.FormShow(Sender: TObject);
begin
  //
  inherited;
end;

procedure TfrmCity.Repaint();
begin
  inherited;
  //
end;

procedure TfrmCity.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtCityName.Text := TCity(Table).CityName.Value;
  cbbCountryName.ItemIndex := cbbCountryName.Items.IndexOf( VarToStr(TCity(Table).CountryName.Value) );
end;

procedure TfrmCity.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TCity(Table).CityName.Value := edtCityName.Text;
      TCity(Table).CountryName.Value := cbbCountryName.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
