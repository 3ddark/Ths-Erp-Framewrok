unit ufrmCountries;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  ufrmBase, ufrmBaseDBGrid;

type
  TfrmCountries = class(TfrmBaseDBGrid)
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
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

function TfrmCountries.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmCountry.Create(Application, Self, Table.Clone(), PermissionSourceForm, True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmCountry.Create(Application, Self, TCountry.Create(Table.Database), PermissionSourceForm, True, pFormMode);
end;

procedure TfrmCountries.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := 'country_name DESC';
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

  TCountry(Table).CountryCode         := dbgrdBase.DataSource.DataSet.FindField('country_code').AsString;
  TCountry(Table).CountryName         := dbgrdBase.DataSource.DataSet.FindField('country_name').AsString;
  TCountry(Table).ISOYear             := dbgrdBase.DataSource.DataSet.FindField('iso_yil').AsInteger;
  TCountry(Table).ISOCCTLDCode        := dbgrdBase.DataSource.DataSet.FindField('iso_cctld_code').AsString;
end;

end.
