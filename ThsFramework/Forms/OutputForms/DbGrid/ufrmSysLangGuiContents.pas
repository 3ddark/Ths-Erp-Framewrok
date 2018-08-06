unit ufrmSysLangGuiContents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysLangGuiContents = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  published
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysLangGuiContent,
  Ths.Erp.Database.Table.SysLangGuiContent;

{$R *.dfm}

{ TfrmSysLangContents }

function TfrmSysLangGuiContents.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysLangGuiContent.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysLangGuiContent.Create(Self, Self, TSysLangGuiContent.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysLangGuiContent.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysLangGuiContents.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysLangGuiContents.FormShow(Sender: TObject);
begin
  inherited;

  mniCopyRecord.Visible := True;
end;

procedure TfrmSysLangGuiContents.SetSelectedItem;
begin
  inherited;

  TSysLangGuiContent(Table).Lang.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).Lang.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).Lang.FieldName).Value);
  TSysLangGuiContent(Table).Code.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).Code.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).Code.FieldName).Value);
  TSysLangGuiContent(Table).ContentType.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).ContentType.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).ContentType.FieldName).Value);
  TSysLangGuiContent(Table).TableName1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).TableName1.FieldName).Value);
  TSysLangGuiContent(Table).Value.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).Value.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).Value.FieldName).Value);
  TSysLangGuiContent(Table).IsFactorySetting.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).IsFactorySetting.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangGuiContent(Table).IsFactorySetting.FieldName).Value);
end;

end.
