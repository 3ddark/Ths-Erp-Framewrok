unit Ths.Erp.Database.Table.PersonelDilBilgisi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.AyarPrsYabanciDil,
  Ths.Erp.Database.Table.AyarPrsYabanciDilSeviyesi,
  Ths.Erp.Database.Table.PersonelKarti;

type
  TPersonelDilBilgisi = class(TTable)
  private
    FDilID: TFieldDB;
    FDil: TFieldDB;
    FOkumaSeviyesiID: TFieldDB;
    FOkumaSeviyesi: TFieldDB;
    FYazmaSeviyesiID: TFieldDB;
    FYazmaSeviyesi: TFieldDB;
    FKonusmaSeviyesiID: TFieldDB;
    FKonusmaSeviyesi: TFieldDB;
    FPersonelID: TFieldDB;
    FPersonelAd: TFieldDB;
    FPersonelSoyad: TFieldDB;
  protected
    vPersonelDil: TAyarPrsYabanciDil;
    vPersonelDilSeviyesi: TAyarPrsYabanciDilSeviyesi;
    vPersonel: TPersonelKarti;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property DilID: TFieldDB read FDilID write FDilID;
    Property Dil: TFieldDB read FDil write FDil;
    Property OkumaSeviyesiID: TFieldDB read FOkumaSeviyesiID write FOkumaSeviyesiID;
    Property OkumaSeviyesi: TFieldDB read FOkumaSeviyesi write FOkumaSeviyesi;
    Property YazmaSeviyesiID: TFieldDB read FYazmaSeviyesiID write FYazmaSeviyesiID;
    Property YazmaSeviyesi: TFieldDB read FYazmaSeviyesi write FYazmaSeviyesi;
    Property KonusmaSeviyesiID: TFieldDB read FKonusmaSeviyesiID write FKonusmaSeviyesiID;
    Property KonusmaSeviyesi: TFieldDB read FKonusmaSeviyesi write FKonusmaSeviyesi;
    Property PersonelID: TFieldDB read FPersonelID write FPersonelID;
    Property PersonelAd: TFieldDB read FPersonelAd write FPersonelAd;
    Property PersonelSoyad: TFieldDB read FPersonelSoyad write FPersonelSoyad;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TPersonelDilBilgisi.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'personel_dil_bilgisi';
  SourceCode := '1000';

  inherited Create(OwnerDatabase);

  FDilID := TFieldDB.Create('dil_id', ftInteger, 0);
  FDil := TFieldDB.Create('dil', ftString, '');
  FOkumaSeviyesiID := TFieldDB.Create('okuma_seviyesi_id', ftInteger, 0);
  FOkumaSeviyesi := TFieldDB.Create('okuma_seviyesi', ftString, '');
  FYazmaSeviyesiID := TFieldDB.Create('yazma_seviyesi_id', ftInteger, 0);
  FYazmaSeviyesi := TFieldDB.Create('yazma_seviyesi', ftString, '');
  FKonusmaSeviyesiID := TFieldDB.Create('konusma_seviyesi_id', ftInteger, 0);
  FKonusmaSeviyesi := TFieldDB.Create('konusma_seviyesi', ftString, '');
  FPersonelID := TFieldDB.Create('personel_id', ftInteger, 0);
  FPersonelAd := TFieldDB.Create('personel_ad', ftString, '');
  FPersonelSoyad := TFieldDB.Create('personel_soyad', ftString, '');
end;

procedure TPersonelDilBilgisi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vPersonelDil := TAyarPrsYabanciDil.Create(Database);
      vPersonelDilSeviyesi := TAyarPrsYabanciDilSeviyesi.Create(Database);
      vPersonel := TPersonelKarti.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FDilID.FieldName,
          ColumnFromIDCol(vPersonelDil.YabanciDil.FieldName, vPersonelDil.TableName, FDilID.FieldName, FDil.FieldName, TableName),
          TableName + '.' + FOkumaSeviyesiID.FieldName,
          ColumnFromIDCol(vPersonelDilSeviyesi.YabanciDilSeviyesi.FieldName, vPersonelDilSeviyesi.TableName, FOkumaSeviyesiID.FieldName, FOkumaSeviyesi.FieldName, TableName),
          TableName + '.' + FYazmaSeviyesiID.FieldName,
          ColumnFromIDCol(vPersonelDilSeviyesi.YabanciDilSeviyesi.FieldName, vPersonelDilSeviyesi.TableName, FYazmaSeviyesiID.FieldName, FYazmaSeviyesi.FieldName, TableName),
          TableName + '.' + FKonusmaSeviyesiID.FieldName,
          ColumnFromIDCol(vPersonelDilSeviyesi.YabanciDilSeviyesi.FieldName, vPersonelDilSeviyesi.TableName, FKonusmaSeviyesiID.FieldName, FKonusmaSeviyesi.FieldName, TableName),
          TableName + '.' + FPersonelID.FieldName,
          ColumnFromIDCol(vPersonel.PersonelAd.FieldName, vPersonel.TableName, FPersonelID.FieldName, FPersonelAd.FieldName, TableName),
          ColumnFromIDCol(vPersonel.PersonelAd.FieldName, vPersonel.TableName, FPersonelID.FieldName, FPersonelSoyad.FieldName, TableName)
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FDilID.FieldName).DisplayLabel := 'Dil ID';
        Self.DataSource.DataSet.FindField(FDil.FieldName).DisplayLabel := 'Dil';
        Self.DataSource.DataSet.FindField(FOkumaSeviyesiID.FieldName).DisplayLabel := 'Okuma Seviyesi ID';
        Self.DataSource.DataSet.FindField(FOkumaSeviyesi.FieldName).DisplayLabel := 'Okuma Seviyesi';
        Self.DataSource.DataSet.FindField(FYazmaSeviyesiID.FieldName).DisplayLabel := 'Yazma Seviyesi ID';
        Self.DataSource.DataSet.FindField(FYazmaSeviyesi.FieldName).DisplayLabel := 'Yazma Seviyesi';
        Self.DataSource.DataSet.FindField(FKonusmaSeviyesiID.FieldName).DisplayLabel := 'Konuþma Seviyesi ID';
        Self.DataSource.DataSet.FindField(FKonusmaSeviyesi.FieldName).DisplayLabel := 'Konuþma Seviyesi';
        Self.DataSource.DataSet.FindField(FPersonelID.FieldName).DisplayLabel := 'Personel ID';
        Self.DataSource.DataSet.FindField(FPersonelAd.FieldName).DisplayLabel := 'Personel Ad';
        Self.DataSource.DataSet.FindField(FPersonelSoyad.FieldName).DisplayLabel := 'Personel Soyad';
      finally
        vPersonelDil.Free;
        vPersonelDilSeviyesi.Free;
        vPersonel.Free;
      end;
    end;
  end;
end;

procedure TPersonelDilBilgisi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FDilID.FieldName,
          ColumnFromIDCol(vPersonelDil.YabanciDil.FieldName, vPersonelDil.TableName, FDilID.FieldName, FDil.FieldName, TableName),
          TableName + '.' + FOkumaSeviyesiID.FieldName,
          ColumnFromIDCol(vPersonelDilSeviyesi.YabanciDilSeviyesi.FieldName, vPersonelDilSeviyesi.TableName, FOkumaSeviyesiID.FieldName, FOkumaSeviyesi.FieldName, TableName),
          TableName + '.' + FYazmaSeviyesiID.FieldName,
          ColumnFromIDCol(vPersonelDilSeviyesi.YabanciDilSeviyesi.FieldName, vPersonelDilSeviyesi.TableName, FYazmaSeviyesiID.FieldName, FYazmaSeviyesi.FieldName, TableName),
          TableName + '.' + FKonusmaSeviyesiID.FieldName,
          ColumnFromIDCol(vPersonelDilSeviyesi.YabanciDilSeviyesi.FieldName, vPersonelDilSeviyesi.TableName, FKonusmaSeviyesiID.FieldName, FKonusmaSeviyesi.FieldName, TableName),
          TableName + '.' + FPersonelID.FieldName,
          ColumnFromIDCol(vPersonel.PersonelAd.FieldName, vPersonel.TableName, FPersonelID.FieldName, FPersonelAd.FieldName, TableName),
          ColumnFromIDCol(vPersonel.PersonelAd.FieldName, vPersonel.TableName, FPersonelID.FieldName, FPersonelSoyad.FieldName, TableName)
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FDilID.Value := FormatedVariantVal(FieldByName(FDilID.FieldName).DataType, FieldByName(FDilID.FieldName).Value);
        FDil.Value := FormatedVariantVal(FieldByName(FDil.FieldName).DataType, FieldByName(FDil.FieldName).Value);
        FOkumaSeviyesiID.Value := FormatedVariantVal(FieldByName(FOkumaSeviyesiID.FieldName).DataType, FieldByName(FOkumaSeviyesiID.FieldName).Value);
        FOkumaSeviyesi.Value := FormatedVariantVal(FieldByName(FOkumaSeviyesi.FieldName).DataType, FieldByName(FOkumaSeviyesi.FieldName).Value);
        FYazmaSeviyesiID.Value := FormatedVariantVal(FieldByName(FYazmaSeviyesiID.FieldName).DataType, FieldByName(FYazmaSeviyesiID.FieldName).Value);
        FYazmaSeviyesi.Value := FormatedVariantVal(FieldByName(FYazmaSeviyesi.FieldName).DataType, FieldByName(FYazmaSeviyesi.FieldName).Value);
        FKonusmaSeviyesiID.Value := FormatedVariantVal(FieldByName(FKonusmaSeviyesiID.FieldName).DataType, FieldByName(FKonusmaSeviyesiID.FieldName).Value);
        FKonusmaSeviyesi.Value := FormatedVariantVal(FieldByName(FKonusmaSeviyesi.FieldName).DataType, FieldByName(FKonusmaSeviyesi.FieldName).Value);
        FPersonelID.Value := FormatedVariantVal(FieldByName(FPersonelID.FieldName).DataType, FieldByName(FPersonelID.FieldName).Value);
        FPersonelAd.Value := FormatedVariantVal(FieldByName(FPersonelAd.FieldName).DataType, FieldByName(FPersonelAd.FieldName).Value);
        FPersonelSoyad.Value := FormatedVariantVal(FieldByName(FPersonelSoyad.FieldName).DataType, FieldByName(FPersonelSoyad.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TPersonelDilBilgisi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FDilID.FieldName,
        FOkumaSeviyesiID.FieldName,
        FYazmaSeviyesiID.FieldName,
        FKonusmaSeviyesiID.FieldName,
        FPersonelID.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FDilID);
      NewParamForQuery(QueryOfInsert, FOkumaSeviyesiID);
      NewParamForQuery(QueryOfInsert, FYazmaSeviyesiID);
      NewParamForQuery(QueryOfInsert, FKonusmaSeviyesiID);
      NewParamForQuery(QueryOfInsert, FPersonelID);

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

procedure TPersonelDilBilgisi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FDilID.FieldName,
        FOkumaSeviyesiID.FieldName,
        FYazmaSeviyesiID.FieldName,
        FKonusmaSeviyesiID.FieldName,
        FPersonelID.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FDilID);
      NewParamForQuery(QueryOfUpdate, FOkumaSeviyesiID);
      NewParamForQuery(QueryOfUpdate, FYazmaSeviyesiID);
      NewParamForQuery(QueryOfUpdate, FKonusmaSeviyesiID);
      NewParamForQuery(QueryOfUpdate, FPersonelID);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TPersonelDilBilgisi.Clone():TTable;
begin
  Result := TPersonelDilBilgisi.Create(Database);

  Self.Id.Clone(TPersonelDilBilgisi(Result).Id);

  FDilID.Clone(TPersonelDilBilgisi(Result).FDilID);
  FDil.Clone(TPersonelDilBilgisi(Result).FDil);
  FOkumaSeviyesiID.Clone(TPersonelDilBilgisi(Result).FOkumaSeviyesiID);
  FOkumaSeviyesi.Clone(TPersonelDilBilgisi(Result).FOkumaSeviyesi);
  FYazmaSeviyesiID.Clone(TPersonelDilBilgisi(Result).FYazmaSeviyesiID);
  FYazmaSeviyesi.Clone(TPersonelDilBilgisi(Result).FYazmaSeviyesi);
  FKonusmaSeviyesiID.Clone(TPersonelDilBilgisi(Result).FKonusmaSeviyesiID);
  FKonusmaSeviyesi.Clone(TPersonelDilBilgisi(Result).FKonusmaSeviyesi);
  FPersonelID.Clone(TPersonelDilBilgisi(Result).FPersonelID);
  FPersonelAd.Clone(TPersonelDilBilgisi(Result).FPersonelAd);
  FPersonelSoyad.Clone(TPersonelDilBilgisi(Result).FPersonelSoyad);
end;

end.
