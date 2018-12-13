unit ufrmSatisTeklifler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSatisTeklifler = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  ufrmSatisTeklifDetaylar,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SatisTeklif;

{$R *.dfm}

{ TfrmSatisTeklifler }

function TfrmSatisTeklifler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSatisTeklifDetaylar.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSatisTeklifDetaylar.Create(Application, Self, TSatisTeklif.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSatisTeklifDetaylar.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
