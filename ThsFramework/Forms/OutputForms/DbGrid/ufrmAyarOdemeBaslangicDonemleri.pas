unit ufrmAyarOdemeBaslangicDonemleri;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarOdemeBaslangicDonemleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarOdemeBaslangicDonemi,
  Ths.Erp.Database.Table.AyarOdemeBaslangicDonemi;

{$R *.dfm}

{ TfrmAyarOdemeBaslangicDonemleri }

function TfrmAyarOdemeBaslangicDonemleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarOdemeBaslangicDonemi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarOdemeBaslangicDonemi.Create(Application, Self, TAyarOdemeBaslangicDonemi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarOdemeBaslangicDonemi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
