unit ufrmSysCountries;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysCountries = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
    procedure FormCreate(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysCountry,
  Ths.Erp.Database.Table.SysCountry;

{$R *.dfm}

function TfrmSysCountries.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysCountry.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysCountry.Create(Self, Self, TSysCountry.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysCountry.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysCountries.FormCreate(Sender: TObject);
begin
  inherited;
  TIntegerField(dbgrdBase.DataSource.DataSet.FindField(TSysCountry(Table).ISOYear.FieldName)).DisplayFormat := '';
end;

end.
