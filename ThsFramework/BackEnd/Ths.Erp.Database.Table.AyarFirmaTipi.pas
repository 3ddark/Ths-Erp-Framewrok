unit Ths.Erp.Database.Table.AyarFirmaTipi;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,

  Ths.Erp.Database.Table.AyarFirmaTuru
  ;

type
  TAyarFirmaTipi = class(TTable)
  private
    FFirmaTipi: TFieldDB;
    FFirmaTuruID: TFieldDB;
    FFirmaTuru: TFieldDB;
  protected
    vFirmaTuru: TAyarFirmaTuru;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property FirmaTipi: TFieldDB read FFirmaTipi write FFirmaTipi;
    Property FirmaTuruID: TFieldDB read FFirmaTuruID write FFirmaTuruID;
    Property FirmaTuru: TFieldDB read FFirmaTuru write FFirmaTuru;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarFirmaTipi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_firma_tipi';
  SourceCode := '1000';

  FFirmaTipi := TFieldDB.Create('firma_tipi', ftString, '');
  FFirmaTuruID := TFieldDB.Create('firma_turu_id', ftInteger, 0);
  FFirmaTuru := TFieldDB.Create('firma_turu', ftString, '');
end;

procedure TAyarFirmaTipi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vFirmaTuru := TAyarFirmaTuru.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FFirmaTuruID.FieldName,
          ColumnFromIDCol(vFirmaTuru.Tur.FieldName, vFirmaTuru.TableName, FFirmaTuruID.FieldName, FFirmaTuru.FieldName, TableName),
          getRawDataByLang(TableName, FFirmaTipi.FieldName)
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FFirmaTuruID.FieldName).DisplayLabel := 'Firma Türü ID';
        Self.DataSource.DataSet.FindField(FFirmaTuru.FieldName).DisplayLabel := 'Firma Türü';
        Self.DataSource.DataSet.FindField(FFirmaTipi.FieldName).DisplayLabel := 'Firma Tipi';
      finally
        vFirmaTuru.Free;
      end;
    end;
  end;
end;

procedure TAyarFirmaTipi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

    with QueryOfList do
    begin
      vFirmaTuru := TAyarFirmaTuru.Create(Database);
      try
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FFirmaTuruID.FieldName,
          ColumnFromIDCol(vFirmaTuru.Tur.FieldName, vFirmaTuru.TableName, FFirmaTuruID.FieldName, FFirmaTuru.FieldName, TableName),
          getRawDataByLang(TableName, FFirmaTipi.FieldName)
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;

        FreeListContent();
        List.Clear;
        while NOT EOF do
        begin
          Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

          FFirmaTipi.Value := FormatedVariantVal(FieldByName(FFirmaTipi.FieldName).DataType, FieldByName(FFirmaTipi.FieldName).Value);
          FFirmaTuruID.Value := FormatedVariantVal(FieldByName(FFirmaTuruID.FieldName).DataType, FieldByName(FFirmaTuruID.FieldName).Value);
          FFirmaTuru.Value := FormatedVariantVal(FieldByName(FFirmaTuru.FieldName).DataType, FieldByName(FFirmaTuru.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      finally
        vFirmaTuru.Free;
      end;
    end;
  end;
end;

procedure TAyarFirmaTipi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FFirmaTipi.FieldName,
        FFirmaTuruID.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FFirmaTipi);
      NewParamForQuery(QueryOfInsert, FFirmaTuruID);

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

procedure TAyarFirmaTipi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FFirmaTipi.FieldName,
        FFirmaTuruID.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FFirmaTipi);
      NewParamForQuery(QueryOfUpdate, FFirmaTuruID);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TAyarFirmaTipi.Clone():TTable;
begin
  Result := TAyarFirmaTipi.Create(Database);

  Self.Id.Clone(TAyarFirmaTipi(Result).Id);

  FFirmaTipi.Clone(TAyarFirmaTipi(Result).FFirmaTipi);
  FFirmaTuruID.Clone(TAyarFirmaTipi(Result).FFirmaTuruID);
  FFirmaTuru.Clone(TAyarFirmaTipi(Result).FFirmaTuru);
end;

end.
