unit Ths.Erp.Database.Singleton;

interface

uses
  IniFiles, SysUtils, WinTypes, Messages, Classes, Graphics, Controls, Forms,
  Dialogs,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  Ths.Erp.Database,
  Ths.Erp.Database.Table.SysUser;

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

    UyariAktifTransaction: string;
    UyariKilitliKayit: string;
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
  public
    property DataBase: TDatabase read FDataBase write FDataBase;
    property User: TSysUser read FUser write FUser;
    property LangFramework : TLang read FLangFramework;

    constructor Create;
    class function GetInstance(): TSingletonDB;

    destructor Destroy; override;

    function GetTextFromLang(pDefault, pCode: string): string;
    function GetMaxLength(pTableName, pFieldName: string): Integer;
    function GetIsRequired(pTableName, pFieldName: string): Boolean;
  end;

var
  SingletonDB: TSingletonDB;
  vLangContent, vLangContent2: string;

implementation

uses
  Ths.Erp.Database.Table.View.SysViewColumns;

constructor TSingletonDB.Create();
begin
  raise Exception.Create('Object Singleton');

//  if Self.FDataBase <> nil then
//    Abort
//  else
//  begin
//    FDataBase := TDatabase.Create;
//  end;
//
//  if Self.FUser = nil then
//  begin
//    FUser := TSysUser.Create(Self.FDataBase);
//  end;
//
//  if Self <> nil then
//    SingletonDB := Self;
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

  FLangFramework.UyariAktifTransaction := 'UYARI AKTÝF TRANSACTION';
  FLangFramework.UyariKilitliKayit := 'UYARI KÝLÝTLÝ KAYIT';

  if Self.FDataBase = nil then
    FDataBase := TDatabase.Create;

  if Self.FUser = nil then
    FUser := TSysUser.Create(Self.FDataBase);
end;

destructor TSingletonDB.Destroy();
begin
  if SingletonDB <> Self then
  begin
    SingletonDB := nil;
  end;

  FUser.Free;
  FDataBase.Free;

  inherited Destroy;
end;

class function TSingletonDB.GetInstance: TSingletonDB;
begin
  if not Assigned(FInstance) then
    FInstance := TSingletonDB.CreatePrivate;
  Result := FInstance;
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

        if not Fields.Fields[0].IsNull then
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

end.

