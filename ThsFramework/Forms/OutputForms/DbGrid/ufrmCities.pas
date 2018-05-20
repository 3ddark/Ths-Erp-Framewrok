unit ufrmCities;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList;

type
  TfrmCities = class(TfrmBaseDBGrid)
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  ufrmCity,
  Ths.Erp.Database.Table.Country.City;

{$R *.dfm}

{ TfrmCities }

function TfrmCities.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmCity.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmCity.Create(Application, Self, TCity.Create(Table.Database), True, pFormMode);
end;

procedure TfrmCities.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := 'country_name ASC, city_name ASC';
  inherited;
end;

procedure TfrmCities.SetSelectedItem;
begin
  inherited;

  TCity(Table).CityName         := dbgrdBase.DataSource.DataSet.FindField('city_name').AsString;
  TCity(Table).CountryName      := dbgrdBase.DataSource.DataSet.FindField('country_name').AsString;
end;

end.
