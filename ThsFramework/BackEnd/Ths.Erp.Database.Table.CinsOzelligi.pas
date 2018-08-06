unit Ths.Erp.Database.Table.CinsOzelligi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TCinsOzelligi = class(TTable)
  private
    FCinsAileID: TFieldDB;
    FCinsAilesi: TFieldDB;
    FCins: TFieldDB;
    FAciklama: TFieldDB;
    FString1: TFieldDB;
    FString2: TFieldDB;
    FString3: TFieldDB;
    FString4: TFieldDB;
    FString5: TFieldDB;
    FString6: TFieldDB;
    FString7: TFieldDB;
    FString8: TFieldDB;
    FString9: TFieldDB;
    FString10: TFieldDB;
    FString11: TFieldDB;
    FString12: TFieldDB;
    FIsSerinoIcerir: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property CinsAileID: TFieldDB read FCinsAileID write FCinsAileID;
    Property CinsAilesi: TFieldDB read FCinsAilesi write FCinsAilesi;
    Property Cins: TFieldDB read FCins write FCins;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
    Property String1: TFieldDB read FString1 write FString1;
    Property String2: TFieldDB read FString2 write FString2;
    Property String3: TFieldDB read FString3 write FString3;
    Property String4: TFieldDB read FString4 write FString4;
    Property String5: TFieldDB read FString5 write FString5;
    Property String6: TFieldDB read FString6 write FString6;
    Property String7: TFieldDB read FString7 write FString7;
    Property String8: TFieldDB read FString8 write FString8;
    Property String9: TFieldDB read FString9 write FString9;
    Property String10: TFieldDB read FString10 write FString10;
    Property String11: TFieldDB read FString11 write FString11;
    Property String12: TFieldDB read FString12 write FString12;
    Property IsSerinoIcerir: TFieldDB read FIsSerinoIcerir write FIsSerinoIcerir;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.CinsAilesi;

constructor TCinsOzelligi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'cins_ozelligi';
  SourceCode := '1000';

  FCinsAileID := TFieldDB.Create('cins_aile_id', ftInteger, 0);
  FCinsAilesi := TFieldDB.Create('cins_ailesi', ftString, '');
  FCins := TFieldDB.Create('cins', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FString1 := TFieldDB.Create('string1', ftString, '');
  FString2 := TFieldDB.Create('string2', ftString, '');
  FString3 := TFieldDB.Create('string3', ftString, '');
  FString4 := TFieldDB.Create('string4', ftString, '');
  FString5 := TFieldDB.Create('string5', ftString, '');
  FString6 := TFieldDB.Create('string6', ftString, '');
  FString7 := TFieldDB.Create('string7', ftString, '');
  FString8 := TFieldDB.Create('string8', ftString, '');
  FString9 := TFieldDB.Create('string9', ftString, '');
  FString10 := TFieldDB.Create('string10', ftString, '');
  FString11 := TFieldDB.Create('string11', ftString, '');
  FString12 := TFieldDB.Create('string12', ftString, '');
  FIsSerinoIcerir := TFieldDB.Create('is_serino_icerir', ftBoolean, False);
end;

procedure TCinsOzelligi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
var
  vCinsAilesi: TCinsAilesi;
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      vCinsAilesi := TCinsAilesi.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCinsAileID.FieldName,
          ColumnFromIDCol(vCinsAilesi.Aile.FieldName, vCinsAilesi.TableName, FCinsAileID.FieldName, FCinsAilesi.FieldName),
          GetRawDataSQLByLang(TableName, FCins.FieldName),
          GetRawDataSQLByLang(TableName, FAciklama.FieldName),
          GetRawDataSQLByLang(TableName, FString1.FieldName),
          GetRawDataSQLByLang(TableName, FString2.FieldName),
          GetRawDataSQLByLang(TableName, FString3.FieldName),
          GetRawDataSQLByLang(TableName, FString4.FieldName),
          GetRawDataSQLByLang(TableName, FString5.FieldName),
          GetRawDataSQLByLang(TableName, FString6.FieldName),
          GetRawDataSQLByLang(TableName, FString7.FieldName),
          GetRawDataSQLByLang(TableName, FString8.FieldName),
          GetRawDataSQLByLang(TableName, FString9.FieldName),
          GetRawDataSQLByLang(TableName, FString10.FieldName),
          GetRawDataSQLByLang(TableName, FString11.FieldName),
          GetRawDataSQLByLang(TableName, FString12.FieldName),
          TableName + '.' + FIsSerinoIcerir.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FCinsAileID.FieldName).DisplayLabel := 'Cins Aile ID';
        Self.DataSource.DataSet.FindField(FCinsAilesi.FieldName).DisplayLabel := 'Cins Ailesi';
        Self.DataSource.DataSet.FindField(FCins.FieldName).DisplayLabel := 'Cins';
        Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
        Self.DataSource.DataSet.FindField(FString1.FieldName).DisplayLabel := 'String 1';
        Self.DataSource.DataSet.FindField(FString2.FieldName).DisplayLabel := 'String 2';
        Self.DataSource.DataSet.FindField(FString3.FieldName).DisplayLabel := 'String 3';
        Self.DataSource.DataSet.FindField(FString4.FieldName).DisplayLabel := 'String 4';
        Self.DataSource.DataSet.FindField(FString5.FieldName).DisplayLabel := 'String 5';
        Self.DataSource.DataSet.FindField(FString6.FieldName).DisplayLabel := 'String 6';
        Self.DataSource.DataSet.FindField(FString7.FieldName).DisplayLabel := 'String 7';
        Self.DataSource.DataSet.FindField(FString8.FieldName).DisplayLabel := 'String 8';
        Self.DataSource.DataSet.FindField(FString9.FieldName).DisplayLabel := 'String 9';
        Self.DataSource.DataSet.FindField(FString10.FieldName).DisplayLabel := 'String 10';
        Self.DataSource.DataSet.FindField(FString11.FieldName).DisplayLabel := 'String 11';
        Self.DataSource.DataSet.FindField(FString12.FieldName).DisplayLabel := 'String 12';
        Self.DataSource.DataSet.FindField(FIsSerinoIcerir.FieldName).DisplayLabel := 'Seri No Ýçerir?';
      finally
        vCinsAilesi.Free;
      end;
    end;
  end;
end;

procedure TCinsOzelligi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
var
  vCinsAilesi: TCinsAilesi;
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfTable do
    begin
      vCinsAilesi := TCinsAilesi.Create(Database);
      try
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCinsAileID.FieldName,
          ColumnFromIDCol(vCinsAilesi.Aile.FieldName, vCinsAilesi.TableName, FCinsAileID.FieldName, FCinsAilesi.FieldName),
          GetRawDataSQLByLang(TableName, FCins.FieldName),
          GetRawDataSQLByLang(TableName, FAciklama.FieldName),
          GetRawDataSQLByLang(TableName, FString1.FieldName),
          GetRawDataSQLByLang(TableName, FString2.FieldName),
          GetRawDataSQLByLang(TableName, FString3.FieldName),
          GetRawDataSQLByLang(TableName, FString4.FieldName),
          GetRawDataSQLByLang(TableName, FString5.FieldName),
          GetRawDataSQLByLang(TableName, FString6.FieldName),
          GetRawDataSQLByLang(TableName, FString7.FieldName),
          GetRawDataSQLByLang(TableName, FString8.FieldName),
          GetRawDataSQLByLang(TableName, FString9.FieldName),
          GetRawDataSQLByLang(TableName, FString10.FieldName),
          GetRawDataSQLByLang(TableName, FString11.FieldName),
          GetRawDataSQLByLang(TableName, FString12.FieldName),
          TableName + '.' + FIsSerinoIcerir.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;

        FreeListContent();
        List.Clear;
        while NOT EOF do
        begin
          Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

          FCinsAileID.Value := FormatedVariantVal(FieldByName(FCinsAileID.FieldName).DataType, FieldByName(FCinsAileID.FieldName).Value);
          FCinsAilesi.Value := FormatedVariantVal(FieldByName(FCinsAilesi.FieldName).DataType, FieldByName(FCinsAilesi.FieldName).Value);
          FCins.Value := FormatedVariantVal(FieldByName(FCins.FieldName).DataType, FieldByName(FCins.FieldName).Value);
          FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
          FString1.Value := FormatedVariantVal(FieldByName(FString1.FieldName).DataType, FieldByName(FString1.FieldName).Value);
          FString2.Value := FormatedVariantVal(FieldByName(FString2.FieldName).DataType, FieldByName(FString2.FieldName).Value);
          FString3.Value := FormatedVariantVal(FieldByName(FString3.FieldName).DataType, FieldByName(FString3.FieldName).Value);
          FString4.Value := FormatedVariantVal(FieldByName(FString4.FieldName).DataType, FieldByName(FString4.FieldName).Value);
          FString5.Value := FormatedVariantVal(FieldByName(FString5.FieldName).DataType, FieldByName(FString5.FieldName).Value);
          FString6.Value := FormatedVariantVal(FieldByName(FString6.FieldName).DataType, FieldByName(FString6.FieldName).Value);
          FString7.Value := FormatedVariantVal(FieldByName(FString7.FieldName).DataType, FieldByName(FString7.FieldName).Value);
          FString8.Value := FormatedVariantVal(FieldByName(FString8.FieldName).DataType, FieldByName(FString8.FieldName).Value);
          FString9.Value := FormatedVariantVal(FieldByName(FString9.FieldName).DataType, FieldByName(FString9.FieldName).Value);
          FString10.Value := FormatedVariantVal(FieldByName(FString10.FieldName).DataType, FieldByName(FString10.FieldName).Value);
          FString11.Value := FormatedVariantVal(FieldByName(FString11.FieldName).DataType, FieldByName(FString11.FieldName).Value);
          FString12.Value := FormatedVariantVal(FieldByName(FString12.FieldName).DataType, FieldByName(FString12.FieldName).Value);
          FIsSerinoIcerir.Value := FormatedVariantVal(FieldByName(FIsSerinoIcerir.FieldName).DataType, FieldByName(FIsSerinoIcerir.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      finally
        vCinsAilesi.Free;
      end;
    end;
  end;
end;

procedure TCinsOzelligi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FCinsAileID.FieldName,
        FCins.FieldName,
        FAciklama.FieldName,
        FString1.FieldName,
        FString2.FieldName,
        FString3.FieldName,
        FString4.FieldName,
        FString5.FieldName,
        FString6.FieldName,
        FString7.FieldName,
        FString8.FieldName,
        FString9.FieldName,
        FString10.FieldName,
        FString11.FieldName,
        FString12.FieldName,
        FIsSerinoIcerir.FieldName
      ]);

      ParamByName(FCinsAileID.FieldName).Value := FormatedVariantVal(FCinsAileID.FieldType, FCinsAileID.Value);
      ParamByName(FCins.FieldName).Value := FormatedVariantVal(FCins.FieldType, FCins.Value);
      ParamByName(FAciklama.FieldName).Value := FormatedVariantVal(FAciklama.FieldType, FAciklama.Value);
      ParamByName(FString1.FieldName).Value := FormatedVariantVal(FString1.FieldType, FString1.Value);
      ParamByName(FString2.FieldName).Value := FormatedVariantVal(FString2.FieldType, FString2.Value);
      ParamByName(FString3.FieldName).Value := FormatedVariantVal(FString3.FieldType, FString3.Value);
      ParamByName(FString4.FieldName).Value := FormatedVariantVal(FString4.FieldType, FString4.Value);
      ParamByName(FString5.FieldName).Value := FormatedVariantVal(FString5.FieldType, FString5.Value);
      ParamByName(FString6.FieldName).Value := FormatedVariantVal(FString6.FieldType, FString6.Value);
      ParamByName(FString7.FieldName).Value := FormatedVariantVal(FString7.FieldType, FString7.Value);
      ParamByName(FString8.FieldName).Value := FormatedVariantVal(FString8.FieldType, FString8.Value);
      ParamByName(FString9.FieldName).Value := FormatedVariantVal(FString9.FieldType, FString9.Value);
      ParamByName(FString10.FieldName).Value := FormatedVariantVal(FString10.FieldType, FString10.Value);
      ParamByName(FString11.FieldName).Value := FormatedVariantVal(FString11.FieldType, FString11.Value);
      ParamByName(FString12.FieldName).Value := FormatedVariantVal(FString12.FieldType, FString12.Value);
      ParamByName(FIsSerinoIcerir.FieldName).Value := FormatedVariantVal(FIsSerinoIcerir.FieldType, FIsSerinoIcerir.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      Open;
      if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.FieldName).IsNull) then
        pID := Fields.FieldByName(Self.Id.FieldName).AsInteger
      else
        pID := 0;

      EmptyDataSet;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TCinsOzelligi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FCinsAileID.FieldName,
        FCins.FieldName,
        FAciklama.FieldName,
        FString1.FieldName,
        FString2.FieldName,
        FString3.FieldName,
        FString4.FieldName,
        FString5.FieldName,
        FString6.FieldName,
        FString7.FieldName,
        FString8.FieldName,
        FString9.FieldName,
        FString10.FieldName,
        FString11.FieldName,
        FString12.FieldName,
        FIsSerinoIcerir.FieldName
      ]);

      ParamByName(FCinsAileID.FieldName).Value := FormatedVariantVal(FCinsAileID.FieldType, FCinsAileID.Value);
      ParamByName(FCins.FieldName).Value := FormatedVariantVal(FCins.FieldType, FCins.Value);
      ParamByName(FAciklama.FieldName).Value := FormatedVariantVal(FAciklama.FieldType, FAciklama.Value);
      ParamByName(FString1.FieldName).Value := FormatedVariantVal(FString1.FieldType, FString1.Value);
      ParamByName(FString2.FieldName).Value := FormatedVariantVal(FString2.FieldType, FString2.Value);
      ParamByName(FString3.FieldName).Value := FormatedVariantVal(FString3.FieldType, FString3.Value);
      ParamByName(FString4.FieldName).Value := FormatedVariantVal(FString4.FieldType, FString4.Value);
      ParamByName(FString5.FieldName).Value := FormatedVariantVal(FString5.FieldType, FString5.Value);
      ParamByName(FString6.FieldName).Value := FormatedVariantVal(FString6.FieldType, FString6.Value);
      ParamByName(FString7.FieldName).Value := FormatedVariantVal(FString7.FieldType, FString7.Value);
      ParamByName(FString8.FieldName).Value := FormatedVariantVal(FString8.FieldType, FString8.Value);
      ParamByName(FString9.FieldName).Value := FormatedVariantVal(FString9.FieldType, FString9.Value);
      ParamByName(FString10.FieldName).Value := FormatedVariantVal(FString10.FieldType, FString10.Value);
      ParamByName(FString11.FieldName).Value := FormatedVariantVal(FString11.FieldType, FString11.Value);
      ParamByName(FString12.FieldName).Value := FormatedVariantVal(FString12.FieldType, FString12.Value);
      ParamByName(FIsSerinoIcerir.FieldName).Value := FormatedVariantVal(FIsSerinoIcerir.FieldType, FIsSerinoIcerir.Value);

      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TCinsOzelligi.Clear();
begin
  inherited;

  FCinsAileID.Value := 0;
  FCinsAilesi.Value := '';
  FCins.Value := '';
  FAciklama.Value := '';
  FString1.Value := '';
  FString2.Value := '';
  FString3.Value := '';
  FString4.Value := '';
  FString5.Value := '';
  FString6.Value := '';
  FString7.Value := '';
  FString8.Value := '';
  FString9.Value := '';
  FString10.Value := '';
  FString11.Value := '';
  FString12.Value := '';
  FIsSerinoIcerir.Value := False;
end;

function TCinsOzelligi.Clone():TTable;
begin
  Result := TCinsOzelligi.Create(Database);

  Self.Id.Clone(TCinsOzelligi(Result).Id);

  FCinsAileID.Clone(TCinsOzelligi(Result).FCinsAileID);
  FCinsAilesi.Clone(TCinsOzelligi(Result).FCinsAilesi);
  FCins.Clone(TCinsOzelligi(Result).FCins);
  FAciklama.Clone(TCinsOzelligi(Result).FAciklama);
  FString1.Clone(TCinsOzelligi(Result).FString1);
  FString2.Clone(TCinsOzelligi(Result).FString2);
  FString3.Clone(TCinsOzelligi(Result).FString3);
  FString4.Clone(TCinsOzelligi(Result).FString4);
  FString5.Clone(TCinsOzelligi(Result).FString5);
  FString6.Clone(TCinsOzelligi(Result).FString6);
  FString7.Clone(TCinsOzelligi(Result).FString7);
  FString8.Clone(TCinsOzelligi(Result).FString8);
  FString9.Clone(TCinsOzelligi(Result).FString9);
  FString10.Clone(TCinsOzelligi(Result).FString10);
  FString11.Clone(TCinsOzelligi(Result).FString11);
  FString12.Clone(TCinsOzelligi(Result).FString12);
  FIsSerinoIcerir.Clone(TCinsOzelligi(Result).FIsSerinoIcerir);
end;

end.
