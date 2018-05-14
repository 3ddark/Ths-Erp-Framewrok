unit ufrmCountries;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  uConstGenel, ufrmBaseDBGrid;

type
  TfrmCountries = class(TfrmBaseDBGrid)
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormTipi: Integer):TForm; override;
  public
    procedure SetSelectedItem();override;
    function GetLowHighEqual(pField: TField): Integer; override;
  end;

implementation

uses
  ufrmCountry,
  Ths.Erp.Database.Table.Country;

{$R *.dfm}

{ TfrmCountries }

function TfrmCountries.CreateInputForm(pFormTipi: Integer): TForm;
begin
  Result:=nil;
  if (pFormTipi = FORM_INCELEME) then
    Result := TfrmUlke.Create(Application, Self, Table.Clone(), KaynakAdi, True, pFormTipi)
  else
  if (pFormTipi = FORM_YENI_KAYIT) then
    Result := TfrmUlke.Create(Application, Self, TCountry.Create(Table.Database), KaynakAdi, True, pFormTipi);
end;

procedure TfrmCountries.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := 'ulke_adi DESC';
  inherited;
end;

function TfrmCountries.GetLowHighEqual(pField: TField): Integer;
begin
  Result := 2;
  if pField.FieldName = 'id' then
  begin
    if pField.AsInteger < 21 then
      Result := -1
    else if pField.AsInteger > 21 then
      Result := 1
    else if pField.AsInteger = 21 then
      Result := 0
  end;
end;

procedure TfrmCountries.SetSelectedItem;
begin
  inherited;

  TCountry(Table).CountryCode         := dbgrdBase.DataSource.DataSet.FindField('kod').AsString;
  TCountry(Table).CountryName         := dbgrdBase.DataSource.DataSet.FindField('ulke_adi').AsString;
  TCountry(Table).ISOYear             := dbgrdBase.DataSource.DataSet.FindField('yil').AsInteger;
  TCountry(Table).ISOCCTLDCode        := dbgrdBase.DataSource.DataSet.FindField('cctld_kodu').AsString;
end;

end.
