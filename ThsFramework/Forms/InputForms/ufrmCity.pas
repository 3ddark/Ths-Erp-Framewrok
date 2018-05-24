unit ufrmCity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Samples.Spin,
  Vcl.AppEvnts, Vcl.Buttons,
  thsEdit, //fyComboBox,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.Country, System.ImageList, Vcl.ImgList;

type
  TfrmCity = class(TfrmBaseInputDB)
    lblCityName: TLabel;
    lblCountryName: TLabel;
    edtCityName: TthsEdit;
    cbbCountryName: TComboBox;
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
  inherited;

  edtCityName.thsRequiredData := True;
  //cbbCountryName.thsrefrhtRequiredData := True;

  edtCityName.thsDBFieldName := TCity(Table).CityName.FieldName;
//  cbbCountryName.frhtDBFieldName := 'country_name';

  edtCityName.MaxLength := Table.Database.GetMaxChar(Table.TableName, TCity(Table).CityName.FieldName, 64);
  cbbCountryName.MaxLength := Table.Database.GetMaxChar(Table.TableName, TCountry(Table).CountryName.FieldName, 64);


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
  if  (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
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
