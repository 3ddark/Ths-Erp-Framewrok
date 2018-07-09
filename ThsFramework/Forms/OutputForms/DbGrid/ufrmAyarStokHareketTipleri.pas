unit ufrmAyarStokHareketTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarStokHareketTipleri = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarStokHareketTipi,
  Ths.Erp.Database.Table.AyarStokHareketTipi;

{$R *.dfm}

{ TfrmAyarStokHareketTipleri }

function TfrmAyarStokHareketTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarStokHareketTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarStokHareketTipi.Create(Application, Self, TAyarStokHareketTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarStokHareketTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarStokHareketTipleri.FormShow(Sender: TObject);
begin
  inherited;
  mniAddLanguageData.Visible := True;
end;

procedure TfrmAyarStokHareketTipleri.SetSelectedItem;
begin
  inherited;

  TAyarStokHareketTipi(Table).Deger.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TAyarStokHareketTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarStokHareketTipi(Table).Deger.FieldName).Value);
end;

end.
