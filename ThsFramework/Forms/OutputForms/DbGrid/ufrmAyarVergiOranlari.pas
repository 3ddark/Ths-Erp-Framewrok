unit ufrmAyarVergiOranlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarVergiOranlari = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  published
    procedure FormShow(Sender: TObject); override;
    procedure FormCreate(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarVergiOrani,
  Ths.Erp.Database.Table.AyarVergiOrani;

{$R *.dfm}

{ TfrmAyarVergiOranlari }

function TfrmAyarVergiOranlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarVergiOrani.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarVergiOrani.Create(Application, Self, TAyarVergiOrani.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarVergiOrani.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarVergiOranlari.FormCreate(Sender: TObject);
begin
  inherited;

  TIntegerField(Table.DataSource.DataSet.FindField(TAyarVergiOrani(Table).VergiOrani.FieldName)).DisplayFormat := '0.00%';
end;

procedure TfrmAyarVergiOranlari.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmAyarVergiOranlari.SetSelectedItem;
begin
  inherited;

  TAyarVergiOrani(Table).VergiOrani.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarVergiOrani(Table).VergiOrani.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarVergiOrani(Table).VergiOrani.FieldName).Value);
  TAyarVergiOrani(Table).VergiHesapKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarVergiOrani(Table).VergiHesapKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarVergiOrani(Table).VergiHesapKodu.FieldName).Value);
end;

end.
