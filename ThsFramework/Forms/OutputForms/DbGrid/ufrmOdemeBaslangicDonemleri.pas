unit ufrmOdemeBaslangicDonemleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmOdemeBaslangicDonemleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmOdemeBaslangicDonemi,
  Ths.Erp.Database.Table.AyarOdemeBaslangicDonem;

{$R *.dfm}

{ TfrmOdemeBaslangicDonemleri }

function TfrmOdemeBaslangicDonemleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmOdemeBaslangicDonemi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmOdemeBaslangicDonemi.Create(Application, Self, TAyarOdemeBaslangicDonem.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmOdemeBaslangicDonemi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
