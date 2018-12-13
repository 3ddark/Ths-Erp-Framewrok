unit ufrmAyarBarkodSeriNoTurleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarBarkodSeriNoTurleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarBarkodSeriNoTuru,
  Ths.Erp.Database.Table.AyarBarkodSeriNoTuru;

{$R *.dfm}

{ TfrmAyarBarkodSeriNoTurleri }

function TfrmAyarBarkodSeriNoTurleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarBarkodSeriNoTuru.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarBarkodSeriNoTuru.Create(Application, Self, TAyarBarkodSeriNoTuru.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarBarkodSeriNoTuru.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
