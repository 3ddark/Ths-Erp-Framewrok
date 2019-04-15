unit ufrmSysCities;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,
  ufrmBase, ufrmBaseDBGrid;

type
  TfrmSysCities = class(TfrmBaseDBGrid)
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
  ufrmSysCity,
  Ths.Erp.Database.Table.SysCity;

{$R *.dfm}

function TfrmSysCities.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysCity.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysCity.Create(Application, Self, TSysCity.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysCity.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysCities.FormCreate(Sender: TObject);
begin
  inherited;
  TIntegerField(dbgrdBase.DataSource.DataSet.FindField(TSysCity(Table).CarPlateCode.FieldName)).DisplayFormat := '00';
end;

end.
