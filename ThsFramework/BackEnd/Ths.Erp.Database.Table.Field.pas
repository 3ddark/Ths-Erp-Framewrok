unit Ths.Erp.Database.Table.Field;

interface

uses
  System.SysUtils, Windows, Messages, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  thsEdit, thsComboBox, thsMemo, thsBaseTypes,
  Data.DB;

//{$M+}
//type
//  TJoinType = (jtInner, jtLeft, jtRight);
//  TTableJoin = class
//  private
//    FJoinType: TJoinType;
//    FJoinTable: TTable;
//  published
//    constructor Create(pJoinType: TJoinType; pJoinTable: TTable);
//    destructor Destroy();override;
//  public
//    property JoinType: TJointype read FJoinType write FJoinType;
//    property JoinTable: TTable read FJoinTable write FJoinTable;
//  end;

type
  TFieldDB = class
  private
    FFieldName: string;
    FFieldType: TFieldType;
    FValue: Variant;
    FMaxLength: Integer;
    FIsAutoInc: Boolean;
    FIsNullable: Boolean;
//    FJoinTable: TArray<TTableJoin>;
  public
    property FieldName: string read FFieldName write FFieldName;
    property FieldType: TFieldType read FFieldType write FFieldType;
    property Value: Variant read FValue write FValue;
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    property IsAutoInc: Boolean read FIsAutoInc write FIsAutoInc default False;
    property IsNullable: Boolean read FIsNullable write FIsNullable default True;
//    property JoinTable: TArray<TTableJoin> read FJoinTable write FJoinTable;

    constructor Create(pFieldName: string; pFieldType: TFieldType;
      pValue: Variant; pMaxLength: Integer = 0; pIsAutoInc: Boolean=False;
      pIsNullable:Boolean=True);

    procedure Clone(var pField: TFieldDB);
    procedure SetControlProperty(pTableName: string; pControl: TWinControl);
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table;

{ TTableJoin }

//constructor TTableJoin.Create(pJoinType: TJoinType; pJoinTable: TTable);
//begin
//  Self.FJoinType := pJoinType;
//  Self.FJoinTable := pJoinTable;
//end;
//
//destructor TTableJoin.Destroy;
//begin
//  Self.FJoinTable.Free;
//
//  inherited;
//end;

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

procedure TFieldDB.SetControlProperty(pTableName: string; pControl: TWinControl);
var
  vAktifDonem: Integer;
begin
  //todo þimdilik sabit bilgi olarak kalsýn daha sonra bunu sys_application_setting tablosundan aktif dönem olarak alýnacak
  vAktifDonem := GetVarToFormatedValue(TSingletonDB.GetInstance.ApplicationSetting.Donem.FieldType, TSingletonDB.GetInstance.ApplicationSetting.Donem.Value);
  if pControl.ClassType = TthsEdit then
  begin
    with pControl as TthsEdit do
    begin
      Clear;
      thsDBFieldName := Self.FFieldName;
      thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(pTableName, Self.FFieldName);;
      thsActiveYear := vAktifDonem;
      MaxLength := TSingletonDB.GetInstance.GetMaxLength(pTableName, Self.FFieldName);
      thsCaseUpLowSupportTr := True;
      CharCase := ecUpperCase;

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
  end
  else
  if pControl.ClassType = TthsCombobox then
  begin
    with pControl as TthsCombobox do
    begin
      Clear;
      thsDBFieldName := Self.FFieldName;
      thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(pTableName, Self.FFieldName);;
      thsActiveYear := vAktifDonem;
      MaxLength := TSingletonDB.GetInstance.GetMaxLength(pTableName, Self.FFieldName);
      thsCaseUpLowSupportTr := True;
      CharCase := ecUpperCase;

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
  end
  else
  if pControl.ClassType = TthsMemo then
  begin
    with pControl as TthsMemo do
    begin
      Clear;
      thsDBFieldName := Self.FFieldName;
      thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(pTableName, Self.FFieldName);
      thsActiveYear := vAktifDonem;
      MaxLength := TSingletonDB.GetInstance.GetMaxLength(pTableName, Self.FFieldName);
      thsCaseUpLowSupportTr := True;
      CharCase := ecUpperCase;

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
