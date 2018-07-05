unit ufrmSysLangContents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysLangContents = class(TfrmBaseDBGrid)
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
  ufrmSysLangContent,
  Ths.Erp.Database.Table.SysLangContents;

{$R *.dfm}

{ TfrmSysLangContents }

function TfrmSysLangContents.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysLangContent.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysLangContent.Create(Application, Self, TSysLangContents.Create(Table.Database), True, pFormMode);
end;

procedure TfrmSysLangContents.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysLangContents.SetSelectedItem;
begin
  inherited;

  TSysLangContents(Table).Lang.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).Lang.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).Lang.FieldName).Value);
  TSysLangContents(Table).Code.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).Code.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).Code.FieldName).Value);
  TSysLangContents(Table).Value.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).Value.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).Value.FieldName).Value);
  TSysLangContents(Table).IsFactorySetting.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).IsFactorySetting.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangContents(Table).IsFactorySetting.FieldName).Value);
end;

end.
