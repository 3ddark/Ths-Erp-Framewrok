inherited frmSatisTeklifDetaylar: TfrmSatisTeklifDetaylar
  Caption = 'frmSatisTeklifDetaylar'
  ClientHeight = 732
  ClientWidth = 942
  ExplicitWidth = 948
  ExplicitHeight = 761
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 938
    Height = 666
    ExplicitWidth = 938
    ExplicitHeight = 666
    inherited splLeft: TSplitter
      Top = 349
      Height = 316
      ExplicitTop = 437
      ExplicitHeight = 502
    end
    inherited splHeader: TSplitter
      Top = 346
      Width = 936
      ExplicitLeft = 0
      ExplicitTop = 74
      ExplicitWidth = 973
    end
    inherited pnlHeader: TPanel
      Width = 932
      Height = 342
      ExplicitWidth = 932
      ExplicitHeight = 342
      inherited pgcHeader: TPageControl
        Width = 930
        Height = 340
        ExplicitWidth = 930
        ExplicitHeight = 340
        inherited tsHeader: TTabSheet
          ExplicitLeft = 24
          ExplicitTop = 4
          ExplicitWidth = 902
          ExplicitHeight = 332
          object lblIslemTipi: TLabel
            Left = 66
            Top = 6
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = #304#351'lem Tipi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblOdemeBaslangicDonemi: TLabel
            Left = 603
            Top = 270
            Width = 145
            Height = 13
            Alignment = taRightJustify
            Caption = #214'deme Ba'#351'lang'#305#231' D'#246'nemi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTeklifNo: TLabel
            Left = 383
            Top = 6
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'Teklif No'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTeklifTarihi: TLabel
            Left = 371
            Top = 28
            Width = 65
            Height = 13
            Alignment = taRightJustify
            Caption = 'TeklifTarihi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblMusteriKodu: TLabel
            Left = 46
            Top = 28
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = 'M'#252#351'teri Kodu'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblVadeGunSayisi: TLabel
            Left = 377
            Top = 226
            Width = 61
            Height = 13
            Alignment = taRightJustify
            Caption = 'Vade(G'#252'n)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblMusteriAdi: TLabel
            Left = 57
            Top = 50
            Width = 64
            Height = 13
            Alignment = taRightJustify
            Caption = 'M'#252#351'teri Ad'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblPostaKodu: TLabel
            Left = 55
            Top = 116
            Width = 66
            Height = 13
            Alignment = taRightJustify
            Caption = 'Posta Kodu'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblSehirMusteri: TLabel
            Left = 46
            Top = 94
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = #350'ehir M'#252#351'teri'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblVergiDairesi: TLabel
            Left = 365
            Top = 94
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = 'Vergi Dairesi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblVergiNo: TLabel
            Left = 388
            Top = 116
            Width = 50
            Height = 13
            Alignment = taRightJustify
            Caption = 'Vergi No'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAdresMusteri: TLabel
            Left = 43
            Top = 72
            Width = 78
            Height = 13
            Alignment = taRightJustify
            Caption = 'Adres M'#252#351'teri'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblParaBirimi: TLabel
            Left = 685
            Top = 204
            Width = 61
            Height = 13
            Alignment = taRightJustify
            Caption = 'Para Birimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblOrtakKdv: TLabel
            Left = 377
            Top = 248
            Width = 61
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ortak KDV'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblDolarKuru: TLabel
            Left = 687
            Top = 226
            Width = 61
            Height = 13
            Alignment = taRightJustify
            Caption = 'Dolar Kuru'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblEuroKuru: TLabel
            Left = 691
            Top = 248
            Width = 57
            Height = 13
            Alignment = taRightJustify
            Caption = 'Euro Kuru'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTeslimTarihi: TLabel
            Left = 675
            Top = 6
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = 'Teslim Tarihi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblOrtakIskonto: TLabel
            Left = 360
            Top = 270
            Width = 78
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ortak '#304'skonto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblOdemeVadesi: TLabel
            Left = 37
            Top = 182
            Width = 82
            Height = 13
            Alignment = taRightJustify
            Caption = #214'deme Vadesi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblMusteriTemsilci: TLabel
            Left = 647
            Top = 94
            Width = 101
            Height = 13
            Alignment = taRightJustify
            Caption = 'M'#252#351'teri Temsilcisi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGonderimSekli: TLabel
            Left = 35
            Top = 292
            Width = 86
            Height = 13
            Alignment = taRightJustify
            Caption = 'G'#246'nderim '#350'ekli'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTeslimSarti: TLabel
            Left = 54
            Top = 270
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Teslim '#350'art'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGonderimSekliDetaylari: TLabel
            Left = 344
            Top = 292
            Width = 92
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ula'#351#305'm Detaylar'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object lblOdemeSekli: TLabel
            Left = 49
            Top = 314
            Width = 72
            Height = 13
            Alignment = taRightJustify
            Caption = #214'deme '#350'ekli'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAciklama: TLabel
            Left = 384
            Top = 314
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'A'#231#305'klama'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblReferans: TLabel
            Left = 386
            Top = 182
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'Referans'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object lblTeklifTipi: TLabel
            Left = 612
            Top = 116
            Width = 136
            Height = 13
            Alignment = taRightJustify
            Caption = 'Teklif Tipi(Genel-Paket)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object lblDurum: TLabel
            Left = 365
            Top = 201
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = 'Teklif Durum'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object lblTeslimatSuresi: TLabel
            Left = 32
            Top = 204
            Width = 87
            Height = 13
            Alignment = taRightJustify
            Caption = 'Teslimat S'#252'resi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object lblMuhattapAd: TLabel
            Left = 363
            Top = 160
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = 'Muhattap Ad'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblSevkTarihi: TLabel
            Left = 53
            Top = 226
            Width = 66
            Height = 13
            Alignment = taRightJustify
            Caption = 'Sevk Tarihi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblFaturaSevkTarihi: TLabel
            Left = 13
            Top = 248
            Width = 106
            Height = 13
            Alignment = taRightJustify
            Caption = 'Fatura Sevk Tarihi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAdresSevkiyat: TLabel
            Left = 35
            Top = 137
            Width = 86
            Height = 13
            Alignment = taRightJustify
            Caption = 'Adres Sevkiyat'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblSehirSevkiyat: TLabel
            Left = 38
            Top = 160
            Width = 83
            Height = 13
            Alignment = taRightJustify
            Caption = #350'ehir Sevkiyat'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblMuhattapSoyad: TLabel
            Left = 653
            Top = 160
            Width = 93
            Height = 13
            Alignment = taRightJustify
            Caption = 'Muhattap Soyad'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGecerlilikTarihi: TLabel
            Left = 658
            Top = 28
            Width = 90
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ge'#231'erlilik Tarihi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbbIslemTipi: TthsCombobox
            Left = 123
            Top = 2
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtMusteriKodu: TthsEdit
            Left = 123
            Top = 24
            Width = 150
            Height = 21
            TabOrder = 1
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtMusteriAdi: TthsEdit
            Left = 123
            Top = 46
            Width = 777
            Height = 21
            TabOrder = 2
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtTeklifNo: TthsEdit
            Left = 440
            Top = 2
            Width = 150
            Height = 21
            TabOrder = 3
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtTeklifTarihi: TthsEdit
            Left = 440
            Top = 24
            Width = 150
            Height = 21
            TabOrder = 4
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbTeklifDurum: TthsCombobox
            Left = 440
            Top = 200
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 5
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtTeslimTarihi: TthsEdit
            Left = 750
            Top = 2
            Width = 150
            Height = 21
            TabOrder = 6
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtAdresMusteri: TthsEdit
            Left = 123
            Top = 68
            Width = 777
            Height = 21
            TabOrder = 7
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtSehirMusteri: TthsEdit
            Left = 123
            Top = 90
            Width = 150
            Height = 21
            TabOrder = 8
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtPostaKodu: TthsEdit
            Left = 123
            Top = 112
            Width = 150
            Height = 21
            TabOrder = 9
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtVergiDairesi: TthsEdit
            Left = 440
            Top = 90
            Width = 150
            Height = 21
            TabOrder = 10
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtVergiNo: TthsEdit
            Left = 440
            Top = 112
            Width = 150
            Height = 21
            TabOrder = 11
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbMusteriTemsilci: TthsCombobox
            Left = 750
            Top = 90
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 12
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbTeklifTipi: TthsCombobox
            Left = 750
            Top = 112
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 13
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtAdresSevkiyat: TthsEdit
            Left = 123
            Top = 134
            Width = 777
            Height = 21
            TabOrder = 14
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtSehirSevkiyat: TthsEdit
            Left = 123
            Top = 156
            Width = 150
            Height = 21
            TabOrder = 15
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtMuhattapAd: TthsEdit
            Left = 440
            Top = 156
            Width = 150
            Height = 21
            TabOrder = 16
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtReferans: TthsEdit
            Left = 440
            Top = 178
            Width = 460
            Height = 21
            TabOrder = 17
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtOrtakKdv: TthsEdit
            Left = 440
            Top = 244
            Width = 150
            Height = 21
            TabOrder = 18
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtOrtakIskonto: TthsEdit
            Left = 440
            Top = 266
            Width = 150
            Height = 21
            TabOrder = 19
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtVadeGunSayisi: TthsEdit
            Left = 440
            Top = 222
            Width = 150
            Height = 21
            TabOrder = 20
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbParaBirimi: TthsCombobox
            Left = 750
            Top = 200
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 21
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtDolarKuru: TthsEdit
            Left = 750
            Top = 222
            Width = 150
            Height = 21
            TabOrder = 22
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtEuroKuru: TthsEdit
            Left = 750
            Top = 244
            Width = 150
            Height = 21
            TabOrder = 23
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtOdemeVadesi: TthsEdit
            Left = 123
            Top = 178
            Width = 150
            Height = 21
            TabOrder = 24
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtTeslimatSuresi: TthsEdit
            Left = 123
            Top = 200
            Width = 150
            Height = 21
            TabOrder = 25
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtSevkTarihi: TthsEdit
            Left = 123
            Top = 222
            Width = 150
            Height = 21
            TabOrder = 26
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtFaturaSevkTarihi: TthsEdit
            Left = 123
            Top = 244
            Width = 150
            Height = 21
            TabOrder = 27
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbOdemeBaslangicDonemi: TthsCombobox
            Left = 750
            Top = 266
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 28
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbTeslimSarti: TthsCombobox
            Left = 123
            Top = 266
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 29
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbGonderimSekli: TthsCombobox
            Left = 123
            Top = 288
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 30
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtGonderimSekliDetaylari: TthsEdit
            Left = 440
            Top = 288
            Width = 460
            Height = 21
            TabOrder = 31
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object cbbOdemeSekli: TthsCombobox
            Left = 123
            Top = 310
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 32
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtAciklama: TthsEdit
            Left = 440
            Top = 310
            Width = 460
            Height = 21
            TabOrder = 33
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtMuhattapSoyad: TthsEdit
            Left = 750
            Top = 156
            Width = 150
            Height = 21
            TabOrder = 34
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
          object edtGecerlilikTarihi: TthsEdit
            Left = 750
            Top = 24
            Width = 150
            Height = 21
            TabOrder = 35
            thsAlignment = taLeftJustify
            thsColorActive = clSkyBlue
            thsColorRequiredData = 7367916
            thsTabEnterKeyJump = True
            thsInputDataType = itString
            thsCaseUpLowSupportTr = True
            thsDecimalDigit = 4
            thsRequiredData = False
            thsDoTrim = True
            thsActiveYear = 2018
          end
        end
        inherited tsHeaderDiger: TTabSheet
          ExplicitLeft = 24
          ExplicitTop = 4
          ExplicitWidth = 902
          ExplicitHeight = 332
          object LabelProformaNo: TLabel
            Left = 71
            Top = 6
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = 'Proforma No:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object LabelSonrakiAksiyonTarihi: TLabel
            Left = 37
            Top = 27
            Width = 109
            Height = 13
            Alignment = taRightJustify
            Caption = 'Sonraki Aksyn.Trh:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object LabelSonrakiAksiyon: TLabel
            Left = 66
            Top = 48
            Width = 80
            Height = 13
            Alignment = taRightJustify
            Caption = 'Aksiyon Notu:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object LabelArayanKisi: TLabel
            Left = 447
            Top = 28
            Width = 68
            Height = 13
            Alignment = taRightJustify
            Caption = 'Arayan Ki'#351'i:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object LabelAramaTarihi: TLabel
            Left = 439
            Top = 50
            Width = 76
            Height = 13
            Alignment = taRightJustify
            Caption = 'Arama Tarihi:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object LabelSonGecerlilikTarihi: TLabel
            Left = 421
            Top = 72
            Width = 94
            Height = 13
            Alignment = taRightJustify
            Caption = 'Son Ge'#231'rlik Trh:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object LabelGenelIskontoYuzdesiTutari: TLabel
            Left = 427
            Top = 5
            Width = 88
            Height = 13
            Alignment = taRightJustify
            Caption = 'Fatura Alt'#305' '#304'sk.:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object LabelGenelIskontoAyrac: TLabel
            Left = 568
            Top = 3
            Width = 6
            Height = 20
            Caption = '/'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelIhracKayitKodu: TLabel
            Left = 60
            Top = 118
            Width = 85
            Height = 13
            Alignment = taRightJustify
            Caption = #304'hra'#231' Kyt.Kodu'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTevkifatKodu: TLabel
            Left = 64
            Top = 138
            Width = 81
            Height = 13
            Alignment = taRightJustify
            Caption = 'Tevkifat Kodu'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTevkifatOrani: TLabel
            Left = 60
            Top = 160
            Width = 82
            Height = 13
            Alignment = taRightJustify
            Caption = 'Tevkifat Oran'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTevkifatBolme: TLabel
            Left = 199
            Top = 159
            Width = 6
            Height = 20
            Caption = '/'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditProformaNo: TEdit
            Left = 147
            Top = 3
            Width = 110
            Height = 21
            MaxLength = 10
            TabOrder = 0
          end
          object EditSonrakiAksiyonTarihi: TEdit
            Left = 147
            Top = 25
            Width = 110
            Height = 21
            MaxLength = 24
            TabOrder = 1
          end
          object MemoSonrakiAksiyon: TMemo
            Left = 147
            Top = 47
            Width = 110
            Height = 21
            MaxLength = 160
            TabOrder = 2
          end
          object EditGenelIskontoYuzdesi: TEdit
            Left = 516
            Top = 3
            Width = 50
            Height = 21
            MaxLength = 10
            TabOrder = 3
          end
          object EditGenelIskontoTutar: TEdit
            Left = 576
            Top = 3
            Width = 50
            Height = 21
            MaxLength = 10
            TabOrder = 4
          end
          object ComboBoxArayanKisi: TComboBox
            Left = 516
            Top = 25
            Width = 110
            Height = 21
            Style = csDropDownList
            TabOrder = 5
          end
          object EditAramaTarihi: TEdit
            Left = 516
            Top = 47
            Width = 110
            Height = 21
            MaxLength = 24
            TabOrder = 6
          end
          object EditSonGecerlilikTarihi: TEdit
            Left = 516
            Top = 69
            Width = 110
            Height = 21
            MaxLength = 24
            TabOrder = 7
          end
          object ComboBoxIhracKayitKodu: TComboBox
            Left = 147
            Top = 114
            Width = 479
            Height = 21
            Style = csDropDownList
            MaxLength = 16
            Sorted = True
            TabOrder = 8
          end
          object ComboBoxTevkifatKodu: TComboBox
            Left = 147
            Top = 136
            Width = 479
            Height = 21
            Style = csDropDownList
            MaxLength = 16
            Sorted = True
            TabOrder = 9
          end
          object ComboBoxTevkifatPay: TComboBox
            Left = 147
            Top = 158
            Width = 46
            Height = 21
            Style = csDropDownList
            MaxLength = 16
            Sorted = True
            TabOrder = 10
          end
          object ComboBoxTevkifatPayda: TComboBox
            Left = 211
            Top = 158
            Width = 46
            Height = 21
            Style = csDropDownList
            MaxLength = 16
            Sorted = True
            TabOrder = 11
          end
        end
      end
    end
    inherited pnlContent: TPanel
      Top = 350
      Width = 827
      Height = 313
      ExplicitTop = 350
      ExplicitWidth = 827
      ExplicitHeight = 313
      inherited pgcContent: TPageControl
        Width = 825
        Height = 311
        ExplicitWidth = 825
        ExplicitHeight = 311
        inherited ts1: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 24
          ExplicitWidth = 817
          ExplicitHeight = 283
          inherited pnl1: TPanel
            Top = 170
            Width = 817
            ExplicitTop = 170
            ExplicitWidth = 817
            inherited grpGenelToplamKalan: TGroupBox
              Left = 341
              ExplicitLeft = 341
            end
            inherited grpGenelToplam: TGroupBox
              Left = 580
              ExplicitLeft = 580
            end
            inherited flwpnl1: TFlowPanel
              Width = 337
              ExplicitWidth = 337
              inherited btnAddDetail: TButton
                Left = 1
                Top = 1
                Width = 110
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                ExplicitLeft = 1
                ExplicitTop = 1
                ExplicitWidth = 110
              end
              inherited btnConvert: TButton
                Left = 113
                Top = 1
                Width = 110
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                ExplicitLeft = 113
                ExplicitTop = 1
                ExplicitWidth = 110
              end
              inherited btnSelectContent: TButton
                Left = 225
                Top = 1
                Width = 110
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                ExplicitLeft = 225
                ExplicitTop = 1
                ExplicitWidth = 110
              end
            end
          end
          inherited strngrd1: TStringGrid
            Width = 817
            Height = 170
            ExplicitWidth = 817
            ExplicitHeight = 170
          end
        end
        inherited ts2: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 24
          ExplicitWidth = 817
          ExplicitHeight = 283
          inherited strngrd2: TStringGrid
            Width = 817
            Height = 149
            ExplicitWidth = 817
            ExplicitHeight = 149
          end
          inherited pnl2: TPanel
            Top = 149
            Width = 817
            ExplicitTop = 149
            ExplicitWidth = 817
            inherited flwpnl2: TFlowPanel
              Width = 817
              ExplicitWidth = 817
            end
          end
        end
        inherited ts3: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 24
          ExplicitWidth = 817
          ExplicitHeight = 283
          inherited strngrd3: TStringGrid
            Width = 817
            Height = 149
            ExplicitWidth = 817
            ExplicitHeight = 149
          end
          inherited pnl3: TPanel
            Top = 149
            Width = 817
            ExplicitTop = 149
            ExplicitWidth = 817
            inherited flwpnl3: TFlowPanel
              Width = 817
              ExplicitWidth = 817
            end
          end
        end
      end
      inherited btnHeaderShowHide: TButton
        Left = 725
        Width = 100
        ExplicitLeft = 725
        ExplicitWidth = 100
      end
    end
    inherited pnlLeft: TPanel
      Top = 350
      Height = 313
      ExplicitTop = 350
      ExplicitHeight = 313
    end
  end
  inherited pnlBottom: TPanel
    Top = 670
    Width = 938
    ExplicitTop = 670
    ExplicitWidth = 938
    inherited btnAccept: TButton
      Left = 729
      ExplicitLeft = 729
    end
    inherited btnDelete: TButton
      Left = 625
      ExplicitLeft = 625
    end
    inherited btnClose: TButton
      Left = 833
      ExplicitLeft = 833
    end
  end
  inherited stbBase: TStatusBar
    Top = 714
    Width = 942
    ExplicitTop = 714
    ExplicitWidth = 942
  end
end
