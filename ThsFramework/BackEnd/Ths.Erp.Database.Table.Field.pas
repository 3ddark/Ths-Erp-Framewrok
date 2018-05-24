unit Ths.Erp.Database.Table.Field;

interface

uses
  System.SysUtils, Windows, Messages, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, thsEdit,
  Data.DB;

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

    procedure Clone(var pField: TFieldDB);
    procedure SetControlProperty(pControl: TWinControl);
    function GetMaxLength(pTableName: string): Integer;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysVisibleColumn;

{ TFieldDB }

procedure TFieldDB.Clone(var pField: TFieldDB);
begin
  pField.FFieldName := Self.FFieldName;
  pField.FieldType := Self.FieldType;
  pField.FValue := Self.FValue;
  pField.FMaxLength := Self.FMaxLength;
  pField.FIsAutoInc := Self.FIsAutoInc;
  pField.FIsNullable := Self.FIsNullable;
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

procedure TFieldDB.SetControlProperty(pControl: TWinControl);
begin
  if pControl.ClassType = TthsEdit then
  begin
    with pControl as TthsEdit do
    begin
      thsDBFieldName := Self.FFieldName;
      thsRequiredData := not Self.FIsNullable;
      thsActiveYear := 2018;
      MaxLength := Self.GetMaxLength(Self.FFieldName);

      if FFieldType = ftString then
        thsInputDataType := itString
      else
      if (FFieldType = ftInteger)
      or (FFieldType = ftSmallint)
      or (FFieldType = ftShortint)
      or (FFieldType = ftLargeint)
      or (FFieldType = ftWord)
      then
        thsInputDataType := itInteger
      else
      if (FFieldType = ftFloat) then
        thsInputDataType := itFloat
      else
      if (FFieldType = ftCurrency) then
        thsInputDataType := itMoney
      else
      if (FFieldType = ftDate)
      or (FFieldType = ftDateTime)
      then
        thsInputDataType := itDate;
    end;
  end;
end;

end.
