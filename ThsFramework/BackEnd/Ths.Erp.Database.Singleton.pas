unit Ths.Erp.Database.Singleton;

interface

uses
  IniFiles, SysUtils, WinTypes, Messages, Classes, Graphics, Controls, Forms,
  Dialogs,
  Data.DB, FireDAC.Stan.Param, FireDAC.Comp.Client, System.Variants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table.SysUser,
  Ths.Erp.Database.Table.AyarHaneSayisi;

type
  TLang = record
    BarEkle: string;
    BarIptal: string;
    BarOnay: string;
    BarSil: string;

    ButonEkle: string;
    ButonFilter: string;
    ButonGuncelle: string;
    ButonIptal: string;
    ButonKapat: string;
    ButonSil: string;
    ButonOnay: string;

    HataErisimHakki: string;
    HataKayitSilinmis: string;
    HataKayitSilinmisMesaj: string;
    HataKirmiziZorunluAlan: string;
    HataKullaniciAdi: string;
    HataVeritabaniBaglantisi: string;
    HataZorunluAlan: string;

    IslemOnayiKucuk: string;
    IslemOnayiBuyuk: string;

    MantikEvetBuyuk: string;
    MantikEvetKucuk: string;
    MantikHayirBuyuk: string;
    MantikHayirKucuk: string;

    MesajDesteklenmeyenIslem: string;
    MesajIslemIptal: string;
    MesajKayitGuncelle: string;
    MesajKayitSil: string;
    MesajUygulamaKapatma: string;

    PopupExcel: string;
    PopupFiltre: string;
    PopupFiltreKaldir: string;
    PopupIncele: string;
    PopupSiralamayiKaldir: string;
    PopupYazdir: string;

    UyariAktifTransaction: string;
    UyariKilitliKayit: string;
    UyariAcikPencere: string;
  end;

type
  TSingletonDB = class(TObject)
  strict private
    class var FInstance: TSingletonDB;
    constructor CreatePrivate;
  private
    FDataBase: TDatabase;
    FUser: TSysUser;
    FLangFramework: TLang;
    FHaneMiktari: TAyarHaneSayisi;
  public
    property DataBase: TDatabase read FDataBase write FDataBase;
    property User: TSysUser read FUser write FUser;
    property LangFramework : TLang read FLangFramework;
    property HaneMiktari: TAyarHaneSayisi read FHaneMiktari write FHaneMiktari;

    constructor Create;
    class function GetInstance(): TSingletonDB;

    destructor Destroy; override;

    function GetGridDefaultOrderFilter(pKey: string; pIsOrder: Boolean): string;
    function GetIsRequired(pTableName, pFieldName: string): Boolean;
    function GetTextFromLang(pDefault, pCode: string): string;
    function GetMaxLength(pTableName, pFieldName: string): Integer;
    function GetQualityFormNo(pTableName: string): string;
  end;

  function GetVarToFormatedValue(pType: TFieldType; pVal: Variant): Variant;

var
  SingletonDB: TSingletonDB;
  vLangContent, vLangContent2: string;

implementation

uses
  Ths.Erp.Database.Table.View.SysViewColumns, Ths.Erp.Database.Table.SysGridDefaultOrderFilter;

function GetVarToFormatedValue(pType: TFieldType; pVal: Variant): Variant;
begin
  if (pType = ftString)
  or (pType = ftMemo)
  or (pType = ftWideString)
  or (pType = ftWideMemo)
  or (pType = ftWideString)
  then
    Result := VarToStr(pVal)
  else
  if (pType = ftSmallint)
  or (pType = ftShortint)
  or (pType = ftInteger)
  or (pType = ftLargeint)
  or (pType = ftWord)
  or (pType = ftBCD)
  then
    Result := VarToStr(pVal).ToInteger
  else
  if (pType = ftFloat)
  or (pType = ftCurrency)
  or (pType = ftSingle)
  then
    Result := VarToStr(pVal).ToDouble
  else
  if (pType = ftBoolean) then
    Result := VarToStr(pVal).ToBoolean
  else
    Result := pVal;
end;

constructor TSingletonDB.Create();
begin
  raise Exception.Create('Object Singleton');
end;

constructor TSingletonDB.CreatePrivate;
begin
  inherited Create;

  FLangFramework.BarEkle := 'BAR EKLE';
  FLangFramework.BarIptal := 'BAR ÝPTAL';
  FLangFramework.BarOnay := 'BAR ONAY';
  FLangFramework.BarSil := 'BAR SÝL';

  FLangFramework.ButonEkle := 'BUTON EKLE';
  FLangFramework.ButonFilter := 'BUTON FÝLTER';
  FLangFramework.ButonGuncelle := 'BUTON GÜNCELLE';
  FLangFramework.ButonIptal := 'BUTON ÝPTAL';
  FLangFramework.ButonKapat := 'BUTON KAPAT';
  FLangFramework.ButonSil := 'BUTON SÝL';
  FLangFramework.ButonOnay := 'BUTON ONAY';

  FLangFramework.HataErisimHakki := 'HATA ERÝÞÝM HAKKI';
  FLangFramework.HataKayitSilinmis := 'HATA KAYIT SÝLÝNMÝÞ';
  FLangFramework.HataKayitSilinmisMesaj := 'HATA KAYIT SÝLÝNMÝÞ MESAJ';
  FLangFramework.HataKirmiziZorunluAlan := 'HATA KIRMIZI ZORUNLU';
  FLangFramework.HataKullaniciAdi := 'HATA KULLANICI ADI';
  FLangFramework.HataVeritabaniBaglantisi := 'HATA VERÝ TABANI BAÐLANTISI';
  FLangFramework.HataZorunluAlan := 'HATA ZORUNLU ALAN';

  FLangFramework.IslemOnayiKucuk := 'ÝÞLEM ONAYI KÜÇÜK';
  FLangFramework.IslemOnayiBuyuk := 'ÝÞLEM ONAYI BÜYÜK';

  FLangFramework.MantikEvetBuyuk := 'EVET BÜYÜK';
  FLangFramework.MantikEvetKucuk := 'EVET KÜÇÜK';
  FLangFramework.MantikHayirBuyuk := 'HAYIR BÜYÜK';
  FLangFramework.MantikHayirKucuk := 'HAYIR KÜÇÜK';

  FLangFramework.MesajDesteklenmeyenIslem := 'MESAJ DESTEKLENMEYEN ÝÞLEM';
  FLangFramework.MesajIslemIptal := 'MESAJ ÝÞLEM ÝPTAL';
  FLangFramework.MesajKayitGuncelle := 'MESAJ KAYIT GÜNCELLE';
  FLangFramework.MesajKayitSil := 'MESAJ KAYIT SÝL';
  FLangFramework.MesajUygulamaKapatma := 'MESAJ UYGULAMA KAPATMA';

  FLangFramework.PopupExcel := 'POPUP EXCEL';
  FLangFramework.PopupFiltre := 'POPUP FÝLTRE';
  FLangFramework.PopupFiltreKaldir := 'POPUP FÝLTRE KALDIR';
  FLangFramework.PopupIncele := 'POPUP ÝNCELE';
  FLangFramework.PopupSiralamayiKaldir := 'POPUP SIRALAMAYI KALDIR';
  FLangFramework.PopupYazdir := 'POPUP YAZDIR';

  FLangFramework.UyariAktifTransaction := 'UYARI AKTÝF TRANSACTION';
  FLangFramework.UyariKilitliKayit := 'UYARI KÝLÝTLÝ KAYIT';
  FLangFramework.UyariAcikPencere := 'UYARI AÇIK PENCERE';

  if Self.FDataBase = nil then
    FDataBase := TDatabase.Create;

  if Self.FUser = nil then
    FUser := TSysUser.Create(Self.FDataBase);

  if Self.FHaneMiktari = nil then
    FHaneMiktari := TAyarHaneSayisi.Create(Self.FDataBase);
end;

destructor TSingletonDB.Destroy();
begin
  if SingletonDB <> Self then
  begin
    SingletonDB := nil;
  end;

  FUser.Free;
  FHaneMiktari.Free;
  FDataBase.Free;

  inherited Destroy;
end;

class function TSingletonDB.GetInstance: TSingletonDB;
begin
  if not Assigned(FInstance) then
    FInstance := TSingletonDB.CreatePrivate;
  Result := FInstance;
end;

function TSingletonDB.GetGridDefaultOrderFilter(pKey: string; pIsOrder: Boolean): string;
var
  vSysGridDefaultOrderFilter: TSysGridDefaultOrderFilter;
  vOrderFilter: string;
begin
  Result := '';
  if pIsOrder then
    vOrderFilter := ' and is_order=True'
  else
    vOrderFilter := ' and is_order=False';

  vSysGridDefaultOrderFilter := TSysGridDefaultOrderFilter.Create(TSingletonDB.GetInstance.DataBase);
  try
    vSysGridDefaultOrderFilter.SelectToList(vOrderFilter + ' and key=' + QuotedStr(pKey), False, False);
    if vSysGridDefaultOrderFilter.List.Count=1 then
      Result := TSysGridDefaultOrderFilter(vSysGridDefaultOrderFilter.List[0]).Value.Value;
  finally
    vSysGridDefaultOrderFilter.Free;
  end;
end;

function TSingletonDB.GetIsRequired(pTableName, pFieldName: string): Boolean;
var
  vSysInputGui: TSysViewColumns;
begin
  Result := False;

  vSysInputGui := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  try
    vSysInputGui.SelectToList(' and table_name=' + QuotedStr(pTableName) +
                              ' and column_name=' + QuotedStr(pFieldName), False, False);
    if vSysInputGui.List.Count=1 then
      Result := TSysViewColumns(vSysInputGui.List[0]).IsNullable.Value = 'NO';
  finally
    vSysInputGui.Free;
  end;
end;

function TSingletonDB.GetMaxLength(pTableName, pFieldName: string): Integer;
var
  vSysInputGui: TSysViewColumns;
begin
  Result := 0;

  vSysInputGui := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  try
    vSysInputGui.SelectToList(' and table_name=' + QuotedStr(pTableName) +
                              ' and column_name=' + QuotedStr(pFieldName), False, False);
    if vSysInputGui.List.Count=1 then
      Result := TSysViewColumns(vSysInputGui.List[0]).CharacterMaximumLength.Value;
  finally
    vSysInputGui.Free;
  end;
end;

function TSingletonDB.GetQualityFormNo(pTableName: string): string;
var
  Query: TFDQuery;
begin
  Result := '';

  if Self.FInstance.DataBase.Connection.Connected then
  begin
    Query := Self.FInstance.DataBase.NewQuery;
    try
      with Query do
      begin
        Close;
        SQL.Text := 'SELECT form_no FROM sys_quality_form_number WHERE table_name=:table_name;';
        ParamByName('table_name').Value := pTableName;
        Open;

        if (not (Fields.Fields[0].IsNull)) and (Fields.Fields[0].AsString <> '') then
          Result := Fields.Fields[0].AsString;

        EmptyDataSet;
        Close;
      end;
    finally
      Query.Free;
    end;
  end;
end;

function TSingletonDB.GetTextFromLang(pDefault, pCode: string): string;
var
  Query: TFDQuery;
begin
  Result := pDefault;

  if Self.FInstance.DataBase.Connection.Connected then
  begin
    Query := Self.FInstance.DataBase.NewQuery;
    try
      with Query do
      begin
        Close;
        SQL.Text := 'SELECT value FROM sys_lang_contents WHERE lang=:lang and code=:code;';
        ParamByName('lang').Value := Self.FInstance.DataBase.ConnSetting.Language;
        ParamByName('code').Value := pCode;
        Open;

        if not (Fields.Fields[0].IsNull) then
          Result := Fields.Fields[0].AsString;

        if Result = '' then
          Result := pDefault;

        EmptyDataSet;
        Close;
      end;
    finally
      Query.Free;
    end;
  end;
end;

end.
