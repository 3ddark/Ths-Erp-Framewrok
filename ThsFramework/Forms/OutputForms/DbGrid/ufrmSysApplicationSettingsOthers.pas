unit ufrmSysApplicationSettingsOthers;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysApplicationSettingsOthers = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysApplicationSettingsOthers,
  Ths.Erp.Database.Table.SysApplicationSettingsOther;

{$R *.dfm}

{ TfrmSysApplicationSettingsOthers }

function TfrmSysApplicationSettingsOthers.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysApplicationSettingsOthers.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysApplicationSettingsOthers.Create(Application, Self, TSysApplicationSettingsOther.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysApplicationSettingsOthers.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
