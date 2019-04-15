unit ufrmSysGridColPercents;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysGridColPercents = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
    procedure FormCreate(Sender: TObject);override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysGridColPercent,
  Ths.Erp.Database.Table.SysGridColPercent;

{$R *.dfm}

{ TfrmSysGridColPercents }

function TfrmSysGridColPercents.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysGridColPercent.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysGridColPercent.Create(Self, Self, TSysGridColPercent.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysGridColPercent.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysGridColPercents.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := TSysGridColPercent(Table).TableName1.FieldName + ' ASC, ' +
                       TSysGridColPercent(Table).ColumnName.FieldName + ' ASC';
  inherited;
end;

end.
