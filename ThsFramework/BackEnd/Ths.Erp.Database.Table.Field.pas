unit Ths.Erp.Database.Table.Field;

interface

uses
  System.SysUtils, Data.DB;

type
  TFieldDB = class
  private
    FFieldName: string;
    FFieldType: TFieldType;
    FValue: Variant;
    FMaxLength: Integer;
    FIsAutoInc: Boolean;
    FIsNullable: Boolean;
  public
    property FieldName: string read FFieldName write FFieldName;
    property FieldType: TFieldType read FFieldType write FFieldType;
    property Value: Variant read FValue write FValue;
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    property IsAutoInc: Boolean read FIsAutoInc write FIsAutoInc default False;
    property IsNullable: Boolean read FIsNullable write FIsNullable default True;

    constructor Create(pFieldName: string; pFieldType: TFieldType;
      pValue: Variant; pMaxLength: Integer = 0; pIsAutoInc: Boolean=False;
      pIsNullable:Boolean=True);

    procedure Clone(var vField: TFieldDB);
    function GetMaxLength(pTableName: string): Integer;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysVisibleColumn;

{ TFieldDB }

procedure TFieldDB.Clone(var vField: TFieldDB);
begin
  vField.FFieldName := Self.FFieldName;
  vField.FieldType := Self.FieldType;
  vField.FValue := Self.FValue;
  vField.FMaxLength := Self.FMaxLength;
  vField.FIsAutoInc := Self.FIsAutoInc;
  vField.FIsNullable := Self.FIsNullable;
end;

constructor TFieldDB.Create(pFieldName: string; pFieldType: TFieldType;
  pValue: Variant; pMaxLength: Integer = 0; pIsAutoInc: Boolean=False;
  pIsNullable:Boolean=True);
begin
  FFieldName := pFieldName;
  FFieldType := pFieldType;
  FValue := pValue;
  FIsAutoInc := pIsAutoInc;
  FIsNullable := pIsNullable;
  FMaxLength := pMaxLength;
end;

function TFieldDB.GetMaxLength(pTableName: string): Integer;
var
  vSysVisibleColumn: TSysVisibleColumns;
begin
  Result := 0;

  vSysVisibleColumn := TSysVisibleColumns.Create(TSingletonDB.GetInstance.DataBase);
  try
    vSysVisibleColumn.SelectToList(' and table_name=' + QuotedStr(pTableName) + ' and column_name=' + QuotedStr(FieldName), False, False);
    if vSysVisibleColumn.List.Count=1 then
      Result := TSysVisibleColumns(vSysVisibleColumn.List[0]).GUIMaxLength;
  finally
    vSysVisibleColumn.Free;
  end;
end;

end.
