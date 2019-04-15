unit ufrmSysGridColColors;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysGridColColors = class(TfrmBaseDBGrid)
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
  ufrmSysGridColColor,
  Ths.Erp.Database.Table.SysGridColColor;

{$R *.dfm}

{ TfrmSysGridColColors }

function TfrmSysGridColColors.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysGridColColor.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysGridColColor.Create(Self, Self, TSysGridColColor.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysGridColColor.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysGridColColors.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := TSysGridColColor(Table).TableName1.FieldName + ' ASC, ' +
                       TSysGridColColor(Table).ColumnName.FieldName + ' ASC';
  inherited;
end;

end.
