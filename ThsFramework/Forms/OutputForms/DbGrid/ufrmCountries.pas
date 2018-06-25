unit ufrmCountries;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmCountries = class(TfrmBaseDBGrid)
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
  ufrmCountry,
  Ths.Erp.Database.Table.Country;

{$R *.dfm}

{ TfrmCountries }

function TfrmCountries.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmCountry.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmCountry.Create(Application, Self, TCountry.Create(Table.Database), True, pFormMode);
end;

procedure TfrmCountries.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := TCountry(Table).CountryCode.FieldName + ' DESC';
  inherited;
end;

procedure TfrmCountries.SetSelectedItem;
begin
  inherited;

  TCountry(Table).CountryCode.Value := dbgrdBase.DataSource.DataSet.FindField(TCountry(Table).CountryCode.FieldName).AsString;
  TCountry(Table).CountryName.Value := dbgrdBase.DataSource.DataSet.FindField(TCountry(Table).CountryName.FieldName).AsString;
  TCountry(Table).ISOYear.Value := dbgrdBase.DataSource.DataSet.FindField(TCountry(Table).ISOYear.FieldName).AsInteger;
  TCountry(Table).ISOCCTLDCode.Value := dbgrdBase.DataSource.DataSet.FindField(TCountry(Table).ISOCCTLDCode.FieldName).AsString;
end;

end.
