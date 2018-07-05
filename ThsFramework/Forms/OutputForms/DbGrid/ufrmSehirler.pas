unit ufrmSehirler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSehirler = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  published
    procedure FormCreate(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSehir,
  Ths.Erp.Database.Table.Sehir;

{$R *.dfm}

{ TfrmSehirler }

function TfrmSehirler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSehir.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSehir.Create(Application, Self, TSehir.Create(Table.Database), True, pFormMode);
end;

procedure TfrmSehirler.FormCreate(Sender: TObject);
begin
  inherited;
  TIntegerField(dbgrdBase.DataSource.DataSet.FindField(TSehir(Table).PlakaKodu.FieldName)).DisplayFormat := '00';
end;

procedure TfrmSehirler.SetSelectedItem;
begin
  inherited;

  TSehir(Table).SehirAdi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSehir(Table).SehirAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSehir(Table).SehirAdi.FieldName).Value);
  TSehir(Table).UlkeAdi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSehir(Table).UlkeAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSehir(Table).UlkeAdi.FieldName).Value);
end;

end.
