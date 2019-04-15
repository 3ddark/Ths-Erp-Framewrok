inherited frmMain: TfrmMain
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Main'
  ClientHeight = 468
  ClientWidth = 809
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  DefaultMonitor = dmDesktop
  Font.Name = 'Lucida Sans'
  Menu = mmMain
  Position = poDesktopCenter
  Scaled = False
  ExplicitWidth = 815
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 805
    Height = 402
    BevelOuter = bvNone
    Color = clBtnFace
    ExplicitWidth = 805
    ExplicitHeight = 402
    object pb1: TProgressBar
      Left = 0
      Top = 376
      Width = 805
      Height = 26
      Align = alBottom
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Smooth = True
      TabOrder = 0
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 805
      Height = 376
      ActivePage = tsSettings
      Align = alClient
      MultiLine = True
      OwnerDraw = True
      TabOrder = 1
      object tsGeneral: TTabSheet
        Caption = 'General'
      end
      object tsBuying: TTabSheet
        Caption = 'tsBuying'
        ImageIndex = 1
      end
      object tsSales: TTabSheet
        Caption = 'tsSales'
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 2
        ParentFont = False
        object btnTeklifler: TButton
          Left = 10
          Top = 10
          Width = 180
          Height = 36
          Caption = 'Teklifler'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnTekliflerClick
        end
      end
      object tsStock: TTabSheet
        Caption = 'tsStock'
        ImageIndex = 3
        object btnStokHareketi: TButton
          Left = 188
          Top = 2
          Width = 180
          Height = 36
          Caption = 'STOK HAREKETLER'#304
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnStokHareketiClick
        end
        object btnStokKartlari: TButton
          Left = 2
          Top = 2
          Width = 180
          Height = 36
          Caption = 'Stok Kartlar'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = btnStokKartlariClick
        end
      end
      object tsAccounting: TTabSheet
        Caption = 'tsAccounting'
        ImageIndex = 4
        object btnDovizKurlari: TButton
          Left = 3
          Top = 3
          Width = 150
          Height = 36
          Caption = 'D'#246'viz Kurlar'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnDovizKurlariClick
        end
        object btnHesapKartlari: TButton
          Left = 159
          Top = 3
          Width = 150
          Height = 36
          Caption = 'Hesap Kartlar'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnHesapKartlariClick
        end
      end
      object tsProduction: TTabSheet
        Caption = 'tsProduction'
        ImageIndex = 5
      end
      object tsEquipment: TTabSheet
        Caption = 'tsEquipment'
        ImageIndex = 6
      end
      object tsEmployee: TTabSheet
        Caption = 'tsEmployee'
        ImageIndex = 7
        object btnPersonelKartlari: TButton
          Left = 158
          Top = 2
          Width = 150
          Height = 36
          Caption = 'Personel Kartlar'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnPersonelKartlariClick
        end
        object btnPersonelDilBilgileri: TButton
          Left = 314
          Top = 2
          Width = 150
          Height = 36
          Caption = 'Personel Dil Bilgileri'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = btnPersonelDilBilgileriClick
        end
        object btnPersonelTasimaServisi: TButton
          Left = 470
          Top = 2
          Width = 150
          Height = 36
          Caption = 'Personel Ta'#351#305'ma Servisi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          WordWrap = True
          OnClick = btnPersonelTasimaServisiClick
        end
      end
      object tsAracTakip: TTabSheet
        Caption = 'tsAracTakip'
        ImageIndex = 8
        object btnAracTakipArac: TButton
          Left = 3
          Top = 3
          Width = 150
          Height = 36
          Caption = 'Ara'#231
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnAracTakipAracClick
        end
      end
      object tsSettings: TTabSheet
        Caption = 'tsSettings'
        ImageIndex = 9
        object pgcSettings: TPageControl
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 793
          Height = 343
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ActivePage = tsSettingEInvoice
          Align = alClient
          TabOrder = 0
          object tsSettingGeneral: TTabSheet
            Caption = 'tsSettingGeneral'
            object btnParaBirimleri: TButton
              Left = 2
              Top = 86
              Width = 150
              Height = 36
              Caption = 'PARA B'#304'R'#304'MLER'#304
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              WordWrap = True
              OnClick = btnParaBirimleriClick
            end
            object btnAmbarlar: TButton
              Left = 158
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ambarlar'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              WordWrap = True
              OnClick = btnAmbarlarClick
            end
            object btnAyarFirmaTuru: TButton
              Left = 314
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar Firma T'#252'r'#252
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              WordWrap = True
              OnClick = btnAyarFirmaTuruClick
            end
            object btnAyarFirmaTipi: TButton
              Left = 314
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Ayar Firma Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              WordWrap = True
              OnClick = btnAyarFirmaTipiClick
            end
            object btnBankalar: TButton
              Left = 470
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Bankalar'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              WordWrap = True
              OnClick = btnBankalarClick
            end
            object btnBankaSubeleri: TButton
              Left = 470
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Banka '#350'ubeleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              WordWrap = True
              OnClick = btnBankaSubeleriClick
            end
            object btnUrunKabulRedNedenleri: TButton
              Left = 314
              Top = 275
              Width = 150
              Height = 36
              Caption = #220'r'#252'n Kabul Red Nedenleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              WordWrap = True
              OnClick = btnUrunKabulRedNedenleriClick
            end
            object btnQualityFormMailRecievers: TButton
              Left = 470
              Top = 275
              Width = 150
              Height = 36
              Caption = 'Kalite Formlar'#305' Mail Al'#305'c'#305'lar'#305
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
              WordWrap = True
              OnClick = btnQualityFormMailRecieversClick
            end
            object btnOdemeBaslangicDonemi: TButton
              Left = 626
              Top = 190
              Width = 150
              Height = 36
              Caption = #214'deme Ba'#351'lang'#305#231' D'#246'nemi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
              WordWrap = True
              OnClick = btnOdemeBaslangicDonemiClick
            end
            object btnTeklifTipleri: TButton
              Left = 626
              Top = 232
              Width = 150
              Height = 36
              Caption = 'Teklif Tipleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
              WordWrap = True
              OnClick = btnTeklifTipleriClick
            end
            object btnAyarTeklifDurumlar: TButton
              Left = 626
              Top = 274
              Width = 150
              Height = 36
              Caption = 'Teklif Durumlar'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 10
              WordWrap = True
              OnClick = btnAyarTeklifDurumlarClick
            end
            object btnMusteriTemsilciGruplari: TButton
              Left = 626
              Top = 86
              Width = 150
              Height = 36
              Caption = 'M'#252#351'teri Temsilci Gruplar'#305
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 11
              WordWrap = True
              OnClick = btnMusteriTemsilciGruplariClick
            end
          end
          object tsSettingStock: TTabSheet
            Caption = 'tsSettingStock'
            ImageIndex = 1
            object btnAyarStokHareketTipi: TButton
              Left = 314
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Stok Hareket Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              WordWrap = True
              OnClick = btnAyarStokHareketTipiClick
            end
            object btnStokTipi: TButton
              Left = 314
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Stok Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              WordWrap = True
              OnClick = btnStokTipiClick
            end
            object btnStokGrubuTurleri: TButton
              Left = 2
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Stok Grubu T'#252'rleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              WordWrap = True
              OnClick = btnStokGrubuTurleriClick
            end
            object btnStokGruplari: TButton
              Left = 2
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Stok Gruplar'#305
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              WordWrap = True
              OnClick = btnStokGruplariClick
            end
            object btnAyarBarkodUrunTuru: TButton
              Left = 626
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Barkod '#220'r'#252'n T'#252'r'#252
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              WordWrap = True
              OnClick = btnAyarBarkodUrunTuruClick
            end
            object btnAyarBarkodSeriNoTuru: TButton
              Left = 626
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Barkod Seri No T'#252'r'#252
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              WordWrap = True
              OnClick = btnAyarBarkodSeriNoTuruClick
            end
            object btnAyarBarkodHazirlikDosyaTurleri: TButton
              Left = 626
              Top = 86
              Width = 150
              Height = 36
              Caption = 'Barkod Haz'#305'rl'#305'k Dosya T'#252'rleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              WordWrap = True
              OnClick = btnAyarBarkodHazirlikDosyaTurleriClick
            end
            object btnAyarBarkodTezgahlar: TButton
              Left = 626
              Top = 128
              Width = 150
              Height = 36
              Caption = 'Barkod Tezgahlar'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
              WordWrap = True
              OnClick = btnAyarBarkodTezgahlarClick
            end
            object btnServis: TButton
              Left = 470
              Top = 275
              Width = 150
              Height = 36
              Caption = 'Elektromed Aktarma'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
              WordWrap = True
              OnClick = btnServisClick
            end
            object btnCinsAileleri: TButton
              Left = 158
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Cins Aileleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
              WordWrap = True
              OnClick = btnCinsAileleriClick
            end
            object btnCinsOzellikleri: TButton
              Left = 158
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Cins '#214'zellikleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 10
              WordWrap = True
              OnClick = btnCinsOzellikleriClick
            end
            object btnOlcuBirimleri: TButton
              Left = 2
              Top = 128
              Width = 150
              Height = 36
              Caption = #214'l'#231#252' Birimleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 11
              WordWrap = True
              OnClick = btnOlcuBirimleriClick
            end
            object btnAyarStkUrunTipi: TButton
              Left = 314
              Top = 86
              Width = 150
              Height = 36
              Caption = #220'r'#252'n Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 12
              WordWrap = True
              OnClick = btnAyarStkUrunTipiClick
            end
          end
          object tsSettingAccount: TTabSheet
            Caption = 'tsSettingAccount'
            ImageIndex = 2
            object btnHesapPlani: TButton
              Left = 10
              Top = 10
              Width = 150
              Height = 36
              Caption = 'Hesap Plan'#305
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              WordWrap = True
              OnClick = btnHesapPlaniClick
            end
            object btnAyarHesapTipleri: TButton
              Left = 10
              Top = 52
              Width = 150
              Height = 36
              Caption = 'Hesap Tipleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              WordWrap = True
              OnClick = btnAyarHesapTipleriClick
            end
            object btnHesapGrubu: TButton
              Left = 10
              Top = 94
              Width = 150
              Height = 36
              Caption = 'Hesap Grubu'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              WordWrap = True
              OnClick = btnHesapGrubuClick
            end
            object btnBolgeTuru: TButton
              Left = 322
              Top = 10
              Width = 150
              Height = 36
              Caption = 'B'#246'lge T'#252'r'#252
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              WordWrap = True
              OnClick = btnBolgeTuruClick
            end
            object btnBolge: TButton
              Left = 322
              Top = 52
              Width = 150
              Height = 36
              Caption = 'B'#246'lge'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              WordWrap = True
              OnClick = btnBolgeClick
            end
            object btnAyarVergiOrani: TButton
              Left = 478
              Top = 10
              Width = 150
              Height = 36
              Caption = 'Ayar Vergi Oran'#305
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              WordWrap = True
              OnClick = btnAyarVergiOraniClick
            end
          end
          object tsSettingEmployee: TTabSheet
            Caption = 'tsSettingEmployee'
            ImageIndex = 3
            object btnAyarPersonelBolum: TButton
              Left = 2
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar Personel B'#246'l'#252'm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              WordWrap = True
              OnClick = btnAyarPersonelBolumClick
            end
            object btnAyarPersonelBirim: TButton
              Left = 2
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Birim'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              WordWrap = True
              OnClick = btnAyarPersonelBirimClick
            end
            object btnAyarPersonelGorev: TButton
              Left = 2
              Top = 86
              Width = 150
              Height = 36
              Caption = 'Ayar Personel G'#246'rev'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              WordWrap = True
              OnClick = btnAyarPersonelGorevClick
            end
            object btnAyarPersonelTipi: TButton
              Left = 2
              Top = 128
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              WordWrap = True
              OnClick = btnAyarPersonelTipiClick
            end
            object btnAyarPersonelCinsiyet: TButton
              Left = 158
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Cinsiyet'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              WordWrap = True
              OnClick = btnAyarPersonelCinsiyetClick
            end
            object btnblaa: TButton
              Left = 158
              Top = 44
              Width = 150
              Height = 36
              Caption = 'blaa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              WordWrap = True
            end
            object btnAyarPersonelAskerlikDurumu: TButton
              Left = 158
              Top = 86
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Askerlik Durumu'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              WordWrap = True
              OnClick = btnAyarPersonelAskerlikDurumuClick
            end
            object btnAyarPersonelRaporTipi: TButton
              Left = 314
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Rapor Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
              WordWrap = True
              OnClick = btnAyarPersonelRaporTipiClick
            end
            object btnAyarPersonelIzinTipi: TButton
              Left = 314
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Ayar Personel '#304'zin Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
              WordWrap = True
              OnClick = btnAyarPersonelIzinTipiClick
            end
            object btnAyarPersonelMedeniDurum: TButton
              Left = 314
              Top = 86
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Medeni Durum'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
              WordWrap = True
              OnClick = btnAyarPersonelMedeniDurumClick
            end
            object btnAyarPersonelDil: TButton
              Left = 314
              Top = 128
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Dil'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 10
              WordWrap = True
              OnClick = btnAyarPersonelDilClick
            end
            object btnAyarPersonelDilSeviyesi: TButton
              Left = 314
              Top = 170
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Dil Seviyesi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 11
              WordWrap = True
              OnClick = btnAyarPersonelDilSeviyesiClick
            end
            object btnAyarPersonelEhliyetTipi: TButton
              Left = 314
              Top = 212
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Ehliyet Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 12
              WordWrap = True
              OnClick = btnAyarPersonelEhliyetTipiClick
            end
            object btnAyarPersonelMykTipi: TButton
              Left = 314
              Top = 254
              Width = 150
              Height = 36
              Caption = 'Ayar Personel MYK Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 13
              WordWrap = True
              OnClick = btnAyarPersonelMykTipiClick
            end
            object btnAyarPersonelSrcTipi: TButton
              Left = 470
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar Personel SRC Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 14
              WordWrap = True
              OnClick = btnAyarPersonelSrcTipiClick
            end
            object btnAyarPersonelAyarilmaNedeniTipi: TButton
              Left = 470
              Top = 44
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Ayr'#305'lma Nedeni Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 15
              WordWrap = True
              OnClick = btnAyarPersonelAyarilmaNedeniTipiClick
            end
            object btnAyarPersonelMektupTipi: TButton
              Left = 470
              Top = 86
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Mektup Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 16
              WordWrap = True
              OnClick = btnAyarPersonelMektupTipiClick
            end
            object btnAyarPersonelTatilTipi: TButton
              Left = 470
              Top = 128
              Width = 150
              Height = 36
              Caption = 'Ayar Personel Tatil Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 17
              WordWrap = True
              OnClick = btnAyarPersonelTatilTipiClick
            end
            object btnEgitimSeviyeleri: TButton
              Left = 470
              Top = 170
              Width = 150
              Height = 36
              Caption = 'Ayar Personel E'#287'itim Seviyeleri'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 18
              WordWrap = True
              OnClick = btnEgitimSeviyeleriClick
            end
          end
          object tsSettingEInvoice: TTabSheet
            Caption = 'tsSettingEInvoice'
            ImageIndex = 4
            object btnAyarEFaturaFaturaTipi: TButton
              Left = 2
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar E-Fatura Fatura Tipi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              WordWrap = True
              OnClick = btnAyarEFaturaFaturaTipiClick
            end
            object btnAyarEfaturaIletisimKanali: TButton
              Left = 158
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar E-Fatura '#304'leti'#351'im Kanal'#305
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              WordWrap = True
              OnClick = btnAyarEfaturaIletisimKanaliClick
            end
            object btnAyarEfaturaIstisnaKodu: TButton
              Left = 314
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar E-Fatura '#304'stisna Kodu'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              WordWrap = True
              OnClick = btnAyarEfaturaIstisnaKoduClick
            end
            object btnAyarEFaturaKimlikSemasi: TButton
              Left = 470
              Top = 2
              Width = 150
              Height = 36
              Caption = 'Ayar E-Fatura Kimlik '#350'emas'#305
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              WordWrap = True
              OnClick = btnAyarEFaturaKimlikSemasiClick
            end
          end
        end
      end
      object tsFrameworkSettings: TTabSheet
        Caption = 'tsFrameworkSettings'
        ImageIndex = 8
        object btnSysPermissionSourceGroup: TButton
          Left = 2
          Top = 2
          Width = 150
          Height = 36
          Caption = 'PERMISSION SOURCE GROUP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnSysPermissionSourceGroupClick
        end
        object btnSysPermissionSource: TButton
          Left = 2
          Top = 44
          Width = 150
          Height = 36
          Caption = 'PERMISSION SOURCE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = btnSysPermissionSourceClick
        end
        object btnSysUserAccessRight: TButton
          Left = 2
          Top = 86
          Width = 150
          Height = 36
          Caption = 'USER ACCESS RIGHT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          WordWrap = True
          OnClick = btnSysUserAccessRightClick
        end
        object btnSysUser: TButton
          Left = 2
          Top = 128
          Width = 150
          Height = 36
          Caption = 'Kullan'#305'c'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          WordWrap = True
          OnClick = btnSysUserClick
        end
        object btnSysGridColWidth: TButton
          Left = 188
          Top = 2
          Width = 150
          Height = 36
          Caption = 'GRID COLUMN WIDTH'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          WordWrap = True
          OnClick = btnSysGridColWidthClick
        end
        object btnSysGridColPercent: TButton
          Left = 188
          Top = 44
          Width = 150
          Height = 36
          Caption = 'GRID COL PERCENT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          WordWrap = True
          OnClick = btnSysGridColPercentClick
        end
        object btnSysGridColColor: TButton
          Left = 188
          Top = 86
          Width = 150
          Height = 36
          Caption = 'GRID COL COLOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          WordWrap = True
          OnClick = btnSysGridColColorClick
        end
        object btnSysDefaultOrderFilter: TButton
          Left = 188
          Top = 128
          Width = 150
          Height = 36
          Caption = 'SYS DEFAULT FILTER AND DEFAULT SORT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          WordWrap = True
          OnClick = btnSysDefaultOrderFilterClick
        end
        object btnSysLang: TButton
          Left = 560
          Top = 2
          Width = 150
          Height = 36
          Caption = 'LANGUAGE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          WordWrap = True
          OnClick = btnSysLangClick
        end
        object btnSysLangContent: TButton
          Left = 560
          Top = 44
          Width = 150
          Height = 36
          Caption = 'SYSTEM LANGUAGE CONTENTS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          WordWrap = True
          OnClick = btnSysLangContentClick
        end
        object btnSysQualityFormNumber: TButton
          Left = 560
          Top = 210
          Width = 150
          Height = 36
          Caption = 'SYS QUALITY FORM NUMBER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 10
          WordWrap = True
          OnClick = btnSysQualityFormNumberClick
        end
        object btnSysApplicationSettings: TButton
          Left = 560
          Top = 252
          Width = 150
          Height = 36
          Caption = 'System Application Settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 11
          WordWrap = True
          OnClick = btnSysApplicationSettingsClick
        end
        object btnSysUserMacAddressExceptions: TButton
          Left = 2
          Top = 170
          Width = 150
          Height = 36
          Caption = 'Kullan'#305'c'#305' Mac Adres '#304'stisnalar'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          WordWrap = True
          OnClick = btnSysUserMacAddressExceptionsClick
        end
        object btnSysTaxpayerTypes: TButton
          Left = 188
          Top = 170
          Width = 150
          Height = 36
          Caption = 'Ayar M'#252'kellef Tipi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 13
          WordWrap = True
          OnClick = btnSysTaxpayerTypesClick
        end
        object btnSysCountries: TButton
          Left = 378
          Top = 2
          Width = 150
          Height = 36
          Caption = #220'LKELER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 14
          WordWrap = True
          OnClick = btnSysCountriesClick
        end
        object btnSysCities: TButton
          Left = 378
          Top = 44
          Width = 150
          Height = 36
          Caption = #350'EH'#304'RLER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 15
          WordWrap = True
          OnClick = btnSysCitiesClick
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 406
    Width = 805
    Color = clBtnFace
    ParentBackground = False
    ExplicitTop = 406
    ExplicitWidth = 805
    inherited btnAccept: TButton
      Left = 596
      ExplicitLeft = 596
    end
    inherited btnClose: TButton
      Left = 700
      ExplicitLeft = 700
    end
    object Button1: TButton
      Left = 224
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 4
      OnClick = Button1Click
    end
  end
  inherited stbBase: TStatusBar
    Top = 450
    Width = 809
    ExplicitTop = 450
    ExplicitWidth = 809
  end
  inherited AppEvntsBase: TApplicationEvents
    OnIdle = AppEvntsBaseIdle
    Left = 48
    Top = 192
  end
  object mmMain: TMainMenu
    Left = 144
    Top = 192
    object mniApplication: TMenuItem
      Caption = 'Application'
      object mniClose: TMenuItem
        Caption = 'Close'
        OnClick = mniCloseClick
      end
    end
    object mniSettings: TMenuItem
      Caption = 'Settings'
      object mniChangePassword: TMenuItem
        Caption = 'Change Password'
      end
      object mniAdministration: TMenuItem
        Caption = 'Administration'
      end
    end
    object mniAbout: TMenuItem
      Caption = 'About'
      OnClick = mniAboutClick
    end
  end
  object pmButtons: TPopupMenu
    Left = 376
    Top = 248
    object mniAddLanguageContent: TMenuItem
      Caption = 'Add Language Data'
      OnClick = mniAddLanguageContentClick
    end
  end
end
