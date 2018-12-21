unit Ths.Erp.Database.Table.AracTakip.Arac;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TArac = class(TTable)
  private
    FMarka: TFieldDB;
    FModel: TFieldDB;
    FPlaka: TFieldDB;
    FRenk: TFieldDB;
    FGelisTarihi: TFieldDB;
    FGelisKM: TFieldDB;
    FGelisYeri: TFieldDB;
    FAciklama: TFieldDB;
    FIsActive: TFieldDB;
    FAktifKM: TFieldDB;
    FAktifKonum: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property Marka: TFieldDB read FMarka write FMarka;
    Property Model: TFieldDB read FModel write FModel;
    Property Plaka: TFieldDB read FPlaka write FPlaka;
    Property Renk: TFieldDB read FRenk write FRenk;
    Property GelisTarihi: TFieldDB read FGelisTarihi write FGelisTarihi;
    Property GelisKM: TFieldDB read FGelisKM write FGelisKM;
    Property GelisYeri: TFieldDB read FGelisYeri write FGelisYeri;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
    Property IsActive: TFieldDB read FIsActive write FIsActive;
    Property AktifKM: TFieldDB read FAktifKM write FAktifKM;
    Property AktifKonum: TFieldDB read FAktifKonum write FAktifKonum;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TArac.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'arac';
  SourceCode := '1000';

  FMarka := TFieldDB.Create('marka', ftString, '');
  FModel := TFieldDB.Create('model', ftString, '');
  FPlaka := TFieldDB.Create('plaka', ftString, '');
  FRenk := TFieldDB.Create('renk', ftString, '');
  FGelisTarihi := TFieldDB.Create('gelis_tarihi', ftDate, 0);
  FGelisKM := TFieldDB.Create('gelis_km', ftInteger, 0);
  FGelisYeri := TFieldDB.Create('gelis_teri', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FIsActive := TFieldDB.Create('is_active', ftBoolean, 0);
  FAktifKM := TFieldDB.Create('aktif_km', ftInteger, 0);
  FAktifKonum := TFieldDB.Create('aktif_konum', ftString, '');
end;

procedure TArac.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FMarka.FieldName,
        TableName + '.' + FModel.FieldName,
        TableName + '.' + FPlaka.FieldName,
        TableName + '.' + FRenk.FieldName,
        TableName + '.' + FGelisTarihi.FieldName,
        TableName + '.' + FGelisKM.FieldName,
        TableName + '.' + FGelisYeri.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FIsActive.FieldName,
        TableName + '.' + FAktifKM.FieldName,
        TableName + '.' + FAktifKonum.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FMarka.FieldName).DisplayLabel := 'Marka';
      Self.DataSource.DataSet.FindField(FModel.FieldName).DisplayLabel := 'Model';
      Self.DataSource.DataSet.FindField(FPlaka.FieldName).DisplayLabel := 'Plaka';
      Self.DataSource.DataSet.FindField(FRenk.FieldName).DisplayLabel := 'Renk';
      Self.DataSource.DataSet.FindField(FGelisTarihi.FieldName).DisplayLabel := 'Geliþ Tarihi';
      Self.DataSource.DataSet.FindField(FGelisKM.FieldName).DisplayLabel := 'Geliþ KM';
      Self.DataSource.DataSet.FindField(FGelisYeri.FieldName).DisplayLabel := 'Geliþ Yeri';
      Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
      Self.DataSource.DataSet.FindField(FIsActive.FieldName).DisplayLabel := 'Aktif?';
      Self.DataSource.DataSet.FindField(FAktifKM.FieldName).DisplayLabel := 'Aktif KM';
      Self.DataSource.DataSet.FindField(FAktifKonum.FieldName).DisplayLabel := 'Aktif Konum';
    end;
  end;
end;

procedure TArac.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FMarka.FieldName,
        TableName + '.' + FModel.FieldName,
        TableName + '.' + FPlaka.FieldName,
        TableName + '.' + FRenk.FieldName,
        TableName + '.' + FGelisTarihi.FieldName,
        TableName + '.' + FGelisKM.FieldName,
        TableName + '.' + FGelisYeri.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FIsActive.FieldName,
        TableName + '.' + FAktifKM.FieldName,
        TableName + '.' + FAktifKonum.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FMarka.Value := FormatedVariantVal(FieldByName(FMarka.FieldName).DataType, FieldByName(FMarka.FieldName).Value);
        FModel.Value := FormatedVariantVal(FieldByName(FModel.FieldName).DataType, FieldByName(FModel.FieldName).Value);
        FPlaka.Value := FormatedVariantVal(FieldByName(FPlaka.FieldName).DataType, FieldByName(FPlaka.FieldName).Value);
        FRenk.Value := FormatedVariantVal(FieldByName(FRenk.FieldName).DataType, FieldByName(FRenk.FieldName).Value);
        FGelisTarihi.Value := FormatedVariantVal(FieldByName(FGelisTarihi.FieldName).DataType, FieldByName(FGelisTarihi.FieldName).Value);
        FGelisKM.Value := FormatedVariantVal(FieldByName(FGelisKM.FieldName).DataType, FieldByName(FGelisKM.FieldName).Value);
        FGelisYeri.Value := FormatedVariantVal(FieldByName(FGelisYeri.FieldName).DataType, FieldByName(FGelisYeri.FieldName).Value);
        FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FIsActive.Value := FormatedVariantVal(FieldByName(FIsActive.FieldName).DataType, FieldByName(FIsActive.FieldName).Value);
        FAktifKM.Value := FormatedVariantVal(FieldByName(FAktifKM.FieldName).DataType, FieldByName(FAktifKM.FieldName).Value);
        FAktifKonum.Value := FormatedVariantVal(FieldByName(FAktifKonum.FieldName).DataType, FieldByName(FAktifKonum.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TArac.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FMarka.FieldName,
        FModel.FieldName,
        FPlaka.FieldName,
        FRenk.FieldName,
        FGelisTarihi.FieldName,
        FGelisKM.FieldName,
        FGelisYeri.FieldName,
        FAciklama.FieldName,
        FIsActive.FieldName,
        FAktifKM.FieldName,
        FAktifKonum.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FMarka);
      NewParamForQuery(QueryOfInsert, FModel);
      NewParamForQuery(QueryOfInsert, FPlaka);
      NewParamForQuery(QueryOfInsert, FRenk);
      NewParamForQuery(QueryOfInsert, FGelisTarihi);
      NewParamForQuery(QueryOfInsert, FGelisKM);
      NewParamForQuery(QueryOfInsert, FGelisYeri);
      NewParamForQuery(QueryOfInsert, FAciklama);
      NewParamForQuery(QueryOfInsert, FIsActive);
      NewParamForQuery(QueryOfInsert, FAktifKM);
      NewParamForQuery(QueryOfInsert, FAktifKonum);

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

procedure TArac.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FMarka.FieldName,
        FModel.FieldName,
        FPlaka.FieldName,
        FRenk.FieldName,
        FGelisTarihi.FieldName,
        FGelisKM.FieldName,
        FGelisYeri.FieldName,
        FAciklama.FieldName,
        FIsActive.FieldName,
        FAktifKM.FieldName,
        FAktifKonum.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FMarka);
      NewParamForQuery(QueryOfUpdate, FModel);
      NewParamForQuery(QueryOfUpdate, FPlaka);
      NewParamForQuery(QueryOfUpdate, FRenk);
      NewParamForQuery(QueryOfUpdate, FGelisTarihi);
      NewParamForQuery(QueryOfUpdate, FGelisKM);
      NewParamForQuery(QueryOfUpdate, FGelisYeri);
      NewParamForQuery(QueryOfUpdate, FAciklama);
      NewParamForQuery(QueryOfUpdate, FIsActive);
      NewParamForQuery(QueryOfUpdate, FAktifKM);
      NewParamForQuery(QueryOfUpdate, FAktifKonum);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TArac.Clone():TTable;
begin
  Result := TArac.Create(Database);

  Self.Id.Clone(TArac(Result).Id);

  FMarka.Clone(TArac(Result).FMarka);
  FModel.Clone(TArac(Result).FModel);
  FPlaka.Clone(TArac(Result).FPlaka);
  FRenk.Clone(TArac(Result).FRenk);
  FGelisTarihi.Clone(TArac(Result).FGelisTarihi);
  FGelisKM.Clone(TArac(Result).FGelisKM);
  FGelisYeri.Clone(TArac(Result).FGelisYeri);
  FAciklama.Clone(TArac(Result).FAciklama);
  FIsActive.Clone(TArac(Result).FIsActive);
  FAktifKM.Clone(TArac(Result).FAktifKM);
  FAktifKonum.Clone(TArac(Result).FAktifKonum);
end;

end.
