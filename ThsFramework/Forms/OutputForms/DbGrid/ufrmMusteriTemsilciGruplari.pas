unit ufrmMusteriTemsilciGruplari;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmMusteriTemsilciGruplari = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmMusteriTemsilciGrubu,
  Ths.Erp.Database.Table.MusteriTemsilciGrubu;

{$R *.dfm}

{ TfrmMusteriTemsilciGruplari }

function TfrmMusteriTemsilciGruplari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmMusteriTemsilciGrubu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmMusteriTemsilciGrubu.Create(Application, Self, TMusteriTemsilciGrubu.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmMusteriTemsilciGrubu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
