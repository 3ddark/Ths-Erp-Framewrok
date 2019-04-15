unit ufrmAyarVergiOranlari;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarVergiOranlari = class(TfrmBaseDBGrid)
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
  ufrmAyarVergiOrani,
  Ths.Erp.Database.Table.AyarVergiOrani;

{$R *.dfm}

{ TfrmAyarVergiOranlari }

function TfrmAyarVergiOranlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarVergiOrani.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarVergiOrani.Create(Application, Self, TAyarVergiOrani.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarVergiOrani.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarVergiOranlari.FormCreate(Sender: TObject);
begin
  inherited;
  TIntegerField(Table.DataSource.DataSet.FindField(TAyarVergiOrani(Table).VergiOrani.FieldName)).DisplayFormat := '0.00%';
end;

end.
