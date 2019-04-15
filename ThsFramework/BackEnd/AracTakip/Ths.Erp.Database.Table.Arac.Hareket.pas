unit Ths.Erp.Database.Table.Arac.Hareket;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,

    Ths.Erp.Database
  , Ths.Erp.Database.Table
  ;

type
  THareket = class(TTable)
  private
    FYetkili: TFieldDB;
    FSurucu: TFieldDB;
    FPlaka: TFieldDB;
    FGorev: TFieldDB;
    FCikisYeri: TFieldDB;
    FCikisKM: TFieldDB;
    FCikisTarihi: TFieldDB;
    FVarisYeri: TFieldDB;
    FVarisKM: TFieldDB;
    FVarisTarihi: TFieldDB;
    FAciklama: TFieldDB;
    FSure: TFieldDB;
  protected
    procedure BusinessUpdate(pPermissionControl: Boolean); override;
  published
    constructor Create(pOwnerDatabase: TDatabase); override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean = True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean = True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean = True); override;
    procedure Update(pPermissionControl: Boolean = True); override;

    function Clone(): TTable; override;

    property Yetkili: TFieldDB read FYetkili write FYetkili;
    property Surucu: TFieldDB read FSurucu write FSurucu;
    property Plaka: TFieldDB read FPlaka write FPlaka;
    property Gorev: TFieldDB read FGorev write FGorev;
    property CikisYeri: TFieldDB read FCikisYeri write FCikisYeri;
    property CikisKM: TFieldDB read FCikisKM write FCikisKM;
    property CikisTarihi: TFieldDB read FCikisTarihi write FCikisTarihi;
    property VarisYeri: TFieldDB read FVarisYeri write FVarisYeri;
    property VarisKM: TFieldDB read FVarisKM write FVarisKM;
    property VarisTarihi: TFieldDB read FVarisTarihi write FVarisTarihi;
    property Aciklama: TFieldDB read FAciklama write FAciklama;
    property Sure: TFieldDB read FSure write FSure;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

{ TAracHareketi }

constructor THareket.Create(pOwnerDatabase:TDatabase);
begin
  inherited Create(pOwnerDatabase);
  TableName := 'arac_hareketi';
  SourceCode := '1000';

  FYetkili := TFieldDB.Create('yetkili', ftString, '');
  FSurucu := TFieldDB.Create('surucu', ftString, '');
  FPlaka := TFieldDB.Create('plaka', ftString, '');
  FGorev := TFieldDB.Create('gorev', ftString, '');
  FCikisYeri := TFieldDB.Create('cikis_yeri', ftString, 0);
  FCikisKM := TFieldDB.Create('cikis_km', ftInteger, 0);
  FCikisTarihi := TFieldDB.Create('cikis_tarihi', ftDateTime, '');
  FVarisYeri := TFieldDB.Create('varis_yeri', ftString, '');
  FVarisKM := TFieldDB.Create('varis_km', ftInteger, 0);
  FVarisTarihi := TFieldDB.Create('varis_tarihi', ftDateTime, 0);
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FSure := TFieldDB.Create('sure', ftString, '');
end;

procedure THareket.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FYetkili.FieldName,
        TableName + '.' + FSurucu.FieldName,
        TableName + '.' + FPlaka.FieldName,
        TableName + '.' + FGorev.FieldName,
        TableName + '.' + FCikisYeri.FieldName,
        TableName + '.' + FCikisKM.FieldName,
        TableName + '.' + FCikisTarihi.FieldName,
        TableName + '.' + FVarisYeri.FieldName,
        TableName + '.' + FVarisKM.FieldName,
        TableName + '.' + FVarisTarihi.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FSure.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'Id';
      Self.DataSource.DataSet.FindField(FYetkili.FieldName).DisplayLabel := 'Yetkili';
      Self.DataSource.DataSet.FindField(FSurucu.FieldName).DisplayLabel := 'Sürücü';
      Self.DataSource.DataSet.FindField(FPlaka.FieldName).DisplayLabel := 'Plaka';
      Self.DataSource.DataSet.FindField(FGorev.FieldName).DisplayLabel := 'Görev';
      Self.DataSource.DataSet.FindField(FCikisYeri.FieldName).DisplayLabel := 'Çýkýþ Yeri';
      Self.DataSource.DataSet.FindField(FCikisKM.FieldName).DisplayLabel := 'Çýkýþ KM';
      Self.DataSource.DataSet.FindField(FCikisTarihi.FieldName).DisplayLabel := 'Çýkýþ Tarihi';
      Self.DataSource.DataSet.FindField(FVarisYeri.FieldName).DisplayLabel := 'Varýþ Yeri';
      Self.DataSource.DataSet.FindField(FVarisKM.FieldName).DisplayLabel := 'Varýþ KM';
      Self.DataSource.DataSet.FindField(FVarisTarihi.FieldName).DisplayLabel := 'Varýþ Tarihi';
      Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
      Self.DataSource.DataSet.FindField(FSure.FieldName).DisplayLabel := 'Süre';
    end;
  end;
end;

procedure THareket.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FYetkili.FieldName,
        TableName + '.' + FSurucu.FieldName,
        TableName + '.' + FPlaka.FieldName,
        TableName + '.' + FGorev.FieldName,
        TableName + '.' + FCikisYeri.FieldName,
        TableName + '.' + FCikisKM.FieldName,
        TableName + '.' + FCikisTarihi.FieldName,
        TableName + '.' + FVarisYeri.FieldName,
        TableName + '.' + FVarisKM.FieldName,
        TableName + '.' + FVarisTarihi.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FSure.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FYetkili.Value := FormatedVariantVal(FieldByName(FYetkili.FieldName).DataType, FieldByName(FYetkili.FieldName).Value);
        FSurucu.Value := FormatedVariantVal(FieldByName(FSurucu.FieldName).DataType, FieldByName(FSurucu.FieldName).Value);
        FPlaka.Value := FormatedVariantVal(FieldByName(FPlaka.FieldName).DataType, FieldByName(FPlaka.FieldName).Value);
        FGorev.Value := FormatedVariantVal(FieldByName(FGorev.FieldName).DataType, FieldByName(FGorev.FieldName).Value);
        FCikisYeri.Value := FormatedVariantVal(FieldByName(FCikisYeri.FieldName).DataType, FieldByName(FCikisYeri.FieldName).Value);
        FCikisKM.Value := FormatedVariantVal(FieldByName(FCikisKM.FieldName).DataType, FieldByName(FCikisKM.FieldName).Value);
        FCikisTarihi.Value := FormatedVariantVal(FieldByName(FCikisTarihi.FieldName).DataType, FieldByName(FCikisTarihi.FieldName).Value);
        FVarisYeri.Value := FormatedVariantVal(FieldByName(FVarisYeri.FieldName).DataType, FieldByName(FVarisYeri.FieldName).Value);
        FVarisKM.Value := FormatedVariantVal(FieldByName(FVarisKM.FieldName).DataType, FieldByName(FVarisKM.FieldName).Value);
        FVarisTarihi.Value := FormatedVariantVal(FieldByName(FVarisTarihi.FieldName).DataType, FieldByName(FVarisTarihi.FieldName).Value);
        FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FSure.Value := FormatedVariantVal(FieldByName(FSure.FieldName).DataType, FieldByName(FSure.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure THareket.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FYetkili.FieldName,
        FSurucu.FieldName,
        FPlaka.FieldName,
        FGorev.FieldName,
        FCikisYeri.FieldName,
        FCikisKM.FieldName,
        FCikisTarihi.FieldName,
        FVarisYeri.FieldName,
        FVarisKM.FieldName,
        FVarisTarihi.FieldName,
        FAciklama.FieldName,
        FSure.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FYetkili);
      NewParamForQuery(QueryOfInsert, FSurucu);
      NewParamForQuery(QueryOfInsert, FPlaka);
      NewParamForQuery(QueryOfInsert, FGorev);
      NewParamForQuery(QueryOfInsert, FCikisYeri);
      NewParamForQuery(QueryOfInsert, FCikisKM);
      NewParamForQuery(QueryOfInsert, FCikisTarihi);
      NewParamForQuery(QueryOfInsert, FVarisYeri);
      NewParamForQuery(QueryOfInsert, FVarisKM);
      NewParamForQuery(QueryOfInsert, FVarisTarihi);
      NewParamForQuery(QueryOfInsert, FAciklama);
      NewParamForQuery(QueryOfInsert, FSure);

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

procedure THareket.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FYetkili.FieldName,
        FSurucu.FieldName,
        FPlaka.FieldName,
        FGorev.FieldName,
        FCikisYeri.FieldName,
        FCikisKM.FieldName,
        FCikisTarihi.FieldName,
        FVarisYeri.FieldName,
        FVarisKM.FieldName,
        FVarisTarihi.FieldName,
        FAciklama.FieldName,
        FSure.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FYetkili);
      NewParamForQuery(QueryOfUpdate, FSurucu);
      NewParamForQuery(QueryOfUpdate, FPlaka);
      NewParamForQuery(QueryOfUpdate, FGorev);
      NewParamForQuery(QueryOfUpdate, FCikisYeri);
      NewParamForQuery(QueryOfUpdate, FCikisKM);
      NewParamForQuery(QueryOfUpdate, FCikisTarihi);
      NewParamForQuery(QueryOfUpdate, FVarisYeri);
      NewParamForQuery(QueryOfUpdate, FVarisKM);
      NewParamForQuery(QueryOfUpdate, FVarisTarihi);
      NewParamForQuery(QueryOfUpdate, FAciklama);
      NewParamForQuery(QueryOfUpdate, FSure);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure THareket.BusinessUpdate(pPermissionControl: Boolean);
begin
  inherited;
  Self.Update(pPermissionControl);
end;

function THareket.Clone():TTable;
begin
  Result := THareket.Create(Database);

  Self.Id.Clone(THareket(Result).Id);

  FYetkili.Clone(THareket(Result).FYetkili);
  FSurucu.Clone(THareket(Result).FSurucu);
  FPlaka.Clone(THareket(Result).FPlaka);
  FGorev.Clone(THareket(Result).FGorev);
  FCikisYeri.Clone(THareket(Result).FCikisYeri);
  FCikisKM.Clone(THareket(Result).FCikisKM);
  FCikisTarihi.Clone(THareket(Result).FCikisTarihi);
  FVarisYeri.Clone(THareket(Result).FVarisYeri);
  FVarisKM.Clone(THareket(Result).FVarisKM);
  FVarisTarihi.Clone(THareket(Result).FVarisTarihi);
  FAciklama.Clone(THareket(Result).FAciklama);
  FSure.Clone(THareket(Result).FSure);
end;

end.

