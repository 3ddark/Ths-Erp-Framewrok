inherited frmAybeyTeklifHesapla: TfrmAybeyTeklifHesapla
  Caption = 'frmAybeyTeklifHesapla'
  ClientHeight = 695
  ClientWidth = 691
  ExplicitWidth = 707
  ExplicitHeight = 734
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 687
    Height = 629
    ExplicitWidth = 687
    ExplicitHeight = 629
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 685
      Height = 627
      ActivePage = TabSheetGenel
      Align = alClient
      TabOrder = 0
      object TabSheetGenel: TTabSheet
        Caption = 'GENEL'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelDurakSayisi: TLabel
          Left = 40
          Top = 10
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'Durak Say'#305's'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelSistemSayisi: TLabel
          Left = 35
          Top = 32
          Width = 75
          Height = 13
          Alignment = taRightJustify
          Caption = 'Sistem Say'#305's'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelGrupKumanda: TLabel
          Left = 27
          Top = 76
          Width = 83
          Height = 13
          Alignment = taRightJustify
          Caption = 'Grup Kumanda'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelSistemSayisiBirim: TLabel
          Left = 156
          Top = 34
          Width = 27
          Height = 13
          Caption = 'Adet'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelA3RegulatorKontrol: TLabel
          Left = 56
          Top = 220
          Width = 87
          Height = 13
          Alignment = taRightJustify
          Caption = 'A3 Reg. Kontrol'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKuyuHaberlesmesi: TLabel
          Left = 35
          Top = 244
          Width = 108
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kuyu Haberle'#351'mesi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinKapiSayisi: TLabel
          Left = 49
          Top = 268
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kabin Kap'#305' Say'#305's'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKatKapiSayisi: TLabel
          Left = 61
          Top = 290
          Width = 82
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kat Kapi Sayisi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelTrafikSistemi: TLabel
          Left = 65
          Top = 315
          Width = 78
          Height = 13
          Alignment = taRightJustify
          Caption = 'Trafik Sistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabloTuru: TLabel
          Left = 83
          Top = 337
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kablo T'#252'r'#252
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelCariKod: TLabel
          Left = 290
          Top = 8
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cari Kod'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueCariKod: TLabel
          Left = 338
          Top = 8
          Width = 88
          Height = 13
          Caption = 'LabelValueCariKod'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LabelReferans: TLabel
          Left = 285
          Top = 40
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Referans'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueReferans: TLabel
          Left = 338
          Top = 40
          Width = 95
          Height = 13
          Caption = 'LabelValueReferans'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LabelFirmaAdi: TLabel
          Left = 283
          Top = 24
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Firma Ad'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueFirmaAdi: TLabel
          Left = 338
          Top = 24
          Width = 92
          Height = 13
          Caption = 'LabelValueFirmaAdi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LabelEFaturaTipi: TLabel
          Left = 72
          Top = 403
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Caption = 'E-Fatura Tipi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelMakineDairesi: TLabel
          Left = 60
          Top = 361
          Width = 83
          Height = 13
          Alignment = taRightJustify
          Caption = 'Makine Dairesi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelAsansorStandardi: TLabel
          Left = 6
          Top = 54
          Width = 104
          Height = 13
          Alignment = taRightJustify
          Caption = 'Asans'#246'r Standard'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EditDurakSayisi: TEdit
          Left = 112
          Top = 7
          Width = 41
          Height = 21
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 0
        end
        object RadioGroupKonfigurasyon: TRadioGroup
          Left = 237
          Top = 101
          Width = 428
          Height = 108
          Caption = 'Konfig'#252'rasyon'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object RadioGroupTahrikSistemi: TRadioGroup
          Left = 8
          Top = 101
          Width = 225
          Height = 108
          Caption = 'Tahrik Sistemi'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object EditSistemSayisi: TEdit
          Left = 112
          Top = 29
          Width = 41
          Height = 21
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 1
        end
        object ComboBoxGrupKumanda: TComboBox
          Left = 112
          Top = 73
          Width = 129
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ComboBoxA3RegulatorKontrol: TComboBox
          Left = 144
          Top = 216
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object ComboBoxKuyuHaberlesmesi: TComboBox
          Left = 144
          Top = 240
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object ComboBoxKabinKapiSayisi: TComboBox
          Left = 144
          Top = 264
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object EditKatKapiSayisi: TEdit
          Left = 144
          Top = 288
          Width = 130
          Height = 21
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 9
        end
        object ComboBoxTrafikSistemi: TComboBox
          Left = 144
          Top = 312
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object ComboBoxKabloTuru: TComboBox
          Left = 144
          Top = 335
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object ComboBoxEFaturaTipi: TComboBox
          Left = 144
          Top = 399
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object ComboBoxMakineDairesi: TComboBox
          Left = 144
          Top = 358
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object CheckBoxPaketAsansor: TCheckBox
          Left = 448
          Top = 64
          Width = 161
          Height = 17
          Caption = 'Paket Asans'#246'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 14
        end
        object PanelHazirTesisat: TPanel
          Left = 278
          Top = 211
          Width = 387
          Height = 319
          ParentColor = True
          TabOrder = 15
          object LabelKatArasiYukseklik: TLabel
            Left = 154
            Top = 59
            Width = 126
            Height = 13
            Alignment = taRightJustify
            Caption = 'B - Kat Aras'#305' Y'#252'kseklik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuUzunlugu: TLabel
            Left = 178
            Top = 83
            Width = 102
            Height = 13
            Alignment = taRightJustify
            Caption = 'G - Kuyu Uzunlu'#287'u'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKabloUzunlugu: TLabel
            Left = 142
            Top = 198
            Width = 138
            Height = 13
            Alignment = taRightJustify
            Caption = '      Kabin Kablo Uzunlugu'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuAydinlatma: TLabel
            Left = 166
            Top = 286
            Width = 114
            Height = 13
            Alignment = taRightJustify
            Caption = '      Kuyu Ayd'#305'nlatma'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuTabloMesafe: TLabel
            Left = 153
            Top = 174
            Width = 127
            Height = 13
            Alignment = taRightJustify
            Caption = 'A - Kuyu-Tablo Mesafe'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatArasiYukseklikBirim: TLabel
            Left = 355
            Top = 62
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuUzunluguBirim: TLabel
            Left = 355
            Top = 86
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuTabloMesafeBirim: TLabel
            Left = 355
            Top = 177
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKabloUzunluguBirim: TLabel
            Left = 355
            Top = 201
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloMotorArasiMesafe: TLabel
            Left = 115
            Top = 222
            Width = 165
            Height = 13
            Alignment = taRightJustify
            Caption = 'H - Tablo-Motor Aras'#305' Mesafe'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloMotorArasiMesafeBirim: TLabel
            Left = 355
            Top = 225
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuDibiUzunlugu: TLabel
            Left = 155
            Top = 107
            Width = 125
            Height = 13
            Alignment = taRightJustify
            Caption = '      Kuyu Dibi Uzunlu'#287'u'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuDibiUzunluguBirim: TLabel
            Left = 355
            Top = 110
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelSonKatUzunlugu: TLabel
            Left = 164
            Top = 150
            Width = 116
            Height = 13
            Alignment = taRightJustify
            Caption = '      Son Kat Uzunlu'#287'u'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelSonKatUzunluguBirim: TLabel
            Left = 355
            Top = 153
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelRegulatorPanoUzakligi: TLabel
            Left = 126
            Top = 246
            Width = 154
            Height = 13
            Alignment = taRightJustify
            Caption = 'N - Reg'#252'lat'#246'r-Pano Uzakligi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelRegulatorPanoUzakligiBirim: TLabel
            Left = 355
            Top = 249
            Width = 22
            Height = 13
            Caption = 'mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditKatArasiYukseklik: TEdit
            Left = 286
            Top = 57
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 1
          end
          object EditKuyuUzunlugu: TEdit
            Left = 286
            Top = 81
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 6
            ParentFont = False
            TabOrder = 2
          end
          object EditKabinKabloUzunlugu: TEdit
            Left = 286
            Top = 196
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 6
          end
          object ComboBoxKuyuAydinlatma: TComboBox
            Left = 286
            Top = 284
            Width = 68
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object EditKuyuTabloMesafe: TEdit
            Left = 286
            Top = 172
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 5
          end
          object RadioGroupKuyuUzunluguHesaplama: TRadioGroup
            Left = 3
            Top = 2
            Width = 375
            Height = 49
            ItemIndex = 0
            Items.Strings = (
              'Kuyu Uzunlu'#287'unu Kat Y'#252'ksekli'#287'inden Hesapla'
              'Kuyu Uzunlu'#287'u Girilecek')
            TabOrder = 0
          end
          object EditTabloMotorArasiMesafe: TEdit
            Left = 286
            Top = 220
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 7
          end
          object EditKuyuDibiUzunlugu: TEdit
            Left = 286
            Top = 105
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 3
          end
          object EditSonKatUzunlugu: TEdit
            Left = 286
            Top = 148
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 4
          end
          object EditRegulatorPanoUzakligi: TEdit
            Left = 286
            Top = 244
            Width = 68
            Height = 21
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 8
          end
          object CheckBoxIsDusukKuyuDibi: TCheckBox
            Left = 232
            Top = 128
            Width = 67
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Low Pit'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 10
          end
        end
        object ComboBoxAsansorStandardi: TComboBox
          Left = 112
          Top = 51
          Width = 129
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object TabSheetTahrik: TTabSheet
        Caption = 'TAHR'#304'K'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelHizBirim: TLabel
          Left = 194
          Top = 30
          Width = 37
          Height = 13
          Caption = 'm / Sn'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelHiz: TLabel
          Left = 80
          Top = 30
          Width = 17
          Height = 13
          Alignment = taRightJustify
          Caption = 'H'#305'z'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelTahrikSistemiTahrik: TLabel
          Left = 16
          Top = 8
          Width = 81
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tahrik Sistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueTahrikSistemi: TLabel
          Left = 98
          Top = 8
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LabelYuk: TLabel
          Left = 76
          Top = 52
          Width = 21
          Height = 13
          Alignment = taRightJustify
          Caption = 'Y'#252'k'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelYukBirim: TLabel
          Left = 194
          Top = 54
          Width = 14
          Height = 13
          Caption = 'kg'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelMakineSasesi: TLabel
          Left = 17
          Top = 74
          Width = 80
          Height = 13
          Alignment = taRightJustify
          Caption = 'Makine '#350'asesi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelAski: TLabel
          Left = 73
          Top = 96
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ask'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelMakinaMarkaBulut: TLabel
          Left = 17
          Top = 118
          Width = 80
          Height = 13
          Alignment = taRightJustify
          Caption = 'Makine Marka'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKasnakCapi: TLabel
          Left = 34
          Top = 544
          Width = 68
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kasnak '#199'ap'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueKasnakCapi: TLabel
          Left = 106
          Top = 544
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LabelHalatSayisi: TLabel
          Left = 36
          Top = 560
          Width = 66
          Height = 13
          Alignment = taRightJustify
          Caption = 'Halat Say'#305's'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueHalatSayisi: TLabel
          Left = 106
          Top = 560
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LabelHalatCapi: TLabel
          Left = 45
          Top = 576
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'Halat '#199'ap'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueHalatCapi: TLabel
          Left = 106
          Top = 576
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object GroupBoxHidrolik: TGroupBox
          Left = 8
          Top = 190
          Width = 233
          Height = 215
          Caption = 'H'#304'DROL'#304'K'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          object LabelHidrolikMarka: TLabel
            Left = 52
            Top = 23
            Width = 36
            Height = 13
            Alignment = taRightJustify
            Caption = 'Marka'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelSoftStart: TLabel
            Left = 21
            Top = 119
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Soft Starter'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelValfGerilimi: TLabel
            Left = 21
            Top = 96
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Valf Gerilimi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelSeviyelemeMotoru: TLabel
            Left = 6
            Top = 167
            Width = 82
            Height = 13
            Alignment = taRightJustify
            Caption = 'Seviye.Motoru'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelValfTipi: TLabel
            Left = 44
            Top = 47
            Width = 44
            Height = 13
            Alignment = taRightJustify
            Caption = 'Valf Tipi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHidrolikGucBirim: TLabel
            Left = 211
            Top = 70
            Width = 18
            Height = 13
            Caption = 'kW'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHidrolikGuc: TLabel
            Left = 67
            Top = 70
            Width = 21
            Height = 13
            Alignment = taRightJustify
            Caption = 'G'#252#231
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHidrolikAkim: TLabel
            Left = 59
            Top = 190
            Width = 29
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ak'#305'm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHidrolikAkimBirim: TLabel
            Left = 213
            Top = 189
            Width = 8
            Height = 13
            Caption = 'A'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHidrolikTipi: TLabel
            Left = 22
            Top = 142
            Width = 66
            Height = 13
            Alignment = taRightJustify
            Caption = 'Hidrolik Tipi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ComboBoxSeviyelemeMotoru: TComboBox
            Left = 90
            Top = 162
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object ComboBoxSoftStarter: TComboBox
            Left = 90
            Top = 114
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object EditHidrolikGucu: TEdit
            Left = 90
            Top = 66
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 4
          end
          object EditHidrolikAkimi: TEdit
            Left = 90
            Top = 186
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 10
          end
          object EditHidrolikMarka: TEdit
            Left = 90
            Top = 18
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 0
          end
          object EditValfTipi: TEdit
            Left = 90
            Top = 42
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 2
          end
          object ComboBoxHidrolikMarka: TComboBox
            Left = 90
            Top = 18
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBoxValfTipi: TComboBox
            Left = 90
            Top = 42
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ComboBoxHidrolikTipi: TComboBox
            Left = 90
            Top = 138
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object ComboBoxHidrolikGuc: TComboBox
            Left = 90
            Top = 66
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object ComboBoxValfGerilimi: TComboBox
            Left = 90
            Top = 90
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
        end
        object GroupBoxMakine: TGroupBox
          Left = 8
          Top = 408
          Width = 233
          Height = 137
          Caption = 'ELEKTR'#304'KL'#304
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object LabelMakineMarka: TLabel
            Left = 52
            Top = 21
            Width = 36
            Height = 13
            Alignment = taRightJustify
            Caption = 'Marka'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineModel: TLabel
            Left = 54
            Top = 45
            Width = 34
            Height = 13
            Alignment = taRightJustify
            Caption = 'Model'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineGucuBirim: TLabel
            Left = 212
            Top = 68
            Width = 18
            Height = 13
            Caption = 'kW'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineGucu: TLabel
            Left = 67
            Top = 67
            Width = 21
            Height = 13
            Alignment = taRightJustify
            Caption = 'G'#252#231
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineAkimi: TLabel
            Left = 59
            Top = 92
            Width = 29
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ak'#305'm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineAkimiBirim: TLabel
            Left = 212
            Top = 91
            Width = 8
            Height = 13
            Caption = 'A'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelFrenGerilimi: TLabel
            Left = 17
            Top = 116
            Width = 71
            Height = 13
            Alignment = taRightJustify
            Caption = 'Fren Gerilimi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelFrenGerilimiBirim: TLabel
            Left = 212
            Top = 114
            Width = 7
            Height = 13
            Caption = 'V'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditMakineMarka: TEdit
            Left = 90
            Top = 16
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 0
          end
          object EditMakineModel: TEdit
            Left = 90
            Top = 40
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 2
          end
          object ComboBoxMakineMarka: TComboBox
            Left = 90
            Top = 16
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBoxMakineModel: TComboBox
            Left = 90
            Top = 40
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object EditMakineGucu: TEdit
            Left = 90
            Top = 63
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 4
          end
          object EditMakineAkimi: TEdit
            Left = 90
            Top = 87
            Width = 122
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 6
          end
          object ComboBoxMakineGuc: TComboBox
            Left = 90
            Top = 63
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object ComboBoxFrenGerilimi: TComboBox
            Left = 90
            Top = 111
            Width = 122
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
        end
        object RadioGroupMakineBilgiGirisSecim: TRadioGroup
          Left = 8
          Top = 148
          Width = 217
          Height = 36
          Caption = 'Bilgi Giri'#351' '#350'ekli'
          Columns = 2
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
        end
        object ComboBoxHiz: TComboBox
          Left = 98
          Top = 27
          Width = 95
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            '0,2'
            '0,4'
            '0,63'
            '1,0'
            '1,2'
            '1,5'
            '1,6'
            '1,75'
            '2,0'
            '2,5')
        end
        object EditYuk: TEdit
          Left = 98
          Top = 49
          Width = 95
          Height = 21
          TabOrder = 1
        end
        object ComboBoxMakineSasesi: TComboBox
          Left = 98
          Top = 71
          Width = 95
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Items.Strings = (
            '0,2'
            '0,4'
            '0,63'
            '1,0'
            '1,2'
            '1,5'
            '1,6'
            '1,75'
            '2,0'
            '2,5')
        end
        object ComboBoxAski: TComboBox
          Left = 98
          Top = 93
          Width = 95
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Items.Strings = (
            '1:1'
            '2:1')
        end
        object GroupBoxTahrikIlaveler: TGroupBox
          Left = 249
          Top = 280
          Width = 423
          Height = 97
          Caption = 'Tahrik '#304'laveler'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          object LabelTahrikIlave2: TLabel
            Left = 26
            Top = 49
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrikIlave3: TLabel
            Left = 26
            Top = 73
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrikIlave1: TLabel
            Left = 26
            Top = 25
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrikIlave1Ozellik: TLabel
            Left = 181
            Top = 25
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTahrikIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTahrikIlave3Ozellik: TLabel
            Left = 181
            Top = 73
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTahrikIlave3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTahrikIlave2Ozellik: TLabel
            Left = 181
            Top = 49
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTahrikIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTahrikIlaveKodBaslik: TLabel
            Left = 90
            Top = 8
            Width = 39
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrikIlaveAdetBaslik: TLabel
            Left = 149
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrikIlaveOzellikBaslik: TLabel
            Left = 181
            Top = 8
            Width = 200
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditTahrikIlave2Kod: TEdit
            Left = 67
            Top = 45
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditTahrikIlave1Kod: TEdit
            Left = 67
            Top = 21
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditTahrikIlave3Kod: TEdit
            Left = 67
            Top = 69
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditTahrikIlave1Adet: TEdit
            Left = 148
            Top = 21
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditTahrikIlave2Adet: TEdit
            Left = 148
            Top = 45
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditTahrikIlave3Adet: TEdit
            Left = 148
            Top = 69
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
        end
        object btnTahrikHesapla: TBitBtn
          Left = 532
          Top = 527
          Width = 140
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 10
        end
        object ComboBoxMakineMarkaBulut: TComboBox
          Left = 98
          Top = 115
          Width = 95
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object GroupBoxTahrikKodlari: TGroupBox
          Left = 248
          Top = 4
          Width = 423
          Height = 269
          Caption = 'Tahrik Kodlar'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          object LabelKasnakKod: TLabel
            Left = 65
            Top = 49
            Width = 41
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Kasnak'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineSasesiKod: TLabel
            Left = 26
            Top = 73
            Width = 80
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Makine '#350'asesi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineKod: TLabel
            Left = 65
            Top = 25
            Width = 41
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Makine'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMakineOzellik: TLabel
            Left = 221
            Top = 25
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelMakineOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelMakineSasesiOzellik: TLabel
            Left = 221
            Top = 73
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelMakineSasesiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKasnakOzellik: TLabel
            Left = 221
            Top = 49
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKasnakOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelHalatSisesiKabinKod: TLabel
            Left = 7
            Top = 121
            Width = 99
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Halat '#350'isesi Kabin'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHalatSisesiKabinOzellik: TLabel
            Left = 221
            Top = 121
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelHalatSisesiKabinOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTahrikKodBaslik: TLabel
            Left = 124
            Top = 8
            Width = 50
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrikAdetBaslik: TLabel
            Left = 189
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrikOzellikBaslik: TLabel
            Left = 221
            Top = 8
            Width = 200
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHalatSisesiAgirlikKod: TLabel
            Left = 2
            Top = 145
            Width = 104
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Halat '#350'isesi A'#287#305'rl'#305'k'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHalatSisesiAgirlikOzellik: TLabel
            Left = 221
            Top = 145
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelHalatSisesiAgirlikOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelRegulatorHalati: TLabel
            Left = 14
            Top = 217
            Width = 92
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Reg'#252'lat'#246'r Halat'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelRegulatorHalatiOzellik: TLabel
            Left = 221
            Top = 217
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelRegulatorHalatiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTasiyiciHalat: TLabel
            Left = 31
            Top = 97
            Width = 75
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Ta'#351#305'y'#305'c'#305' Halat'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTasiyiciHalatOzellik: TLabel
            Left = 221
            Top = 97
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTasiyiciHalatOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelHizRegulatoru: TLabel
            Left = 23
            Top = 193
            Width = 83
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'H'#305'z Reg'#252'lat'#246'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHizRegulatoruOzellik: TLabel
            Left = 221
            Top = 193
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelHizRegulatoruOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelRegulatorAgirligi: TLabel
            Left = 8
            Top = 241
            Width = 98
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Reg'#252'lat'#246'r A'#287#305'rl'#305#287#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelRegulatorAgirligiOzellik: TLabel
            Left = 221
            Top = 241
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelRegulatorHalatiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelHalatKlemensi: TLabel
            Left = 22
            Top = 169
            Width = 84
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = 'Halat Klemensi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHalatKlemensiOzellik: TLabel
            Left = 221
            Top = 169
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelHalatKlemensiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKasnakKod: TEdit
            Left = 107
            Top = 45
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditMakineKod: TEdit
            Left = 107
            Top = 21
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditMakineSasesiKod: TEdit
            Left = 107
            Top = 69
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditHalatSisesiKabinKod: TEdit
            Left = 107
            Top = 117
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditMakineAdet: TEdit
            Left = 188
            Top = 21
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditKasnakAdet: TEdit
            Left = 188
            Top = 45
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditMakineSasesiAdet: TEdit
            Left = 188
            Top = 69
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditHalatSisesiKabinAdet: TEdit
            Left = 188
            Top = 117
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object EditHalatSisesiAgirlikKod: TEdit
            Left = 107
            Top = 141
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object EditHalatSisesiAgirlikAdet: TEdit
            Left = 188
            Top = 141
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditRegulatorHalatiKod: TEdit
            Left = 107
            Top = 213
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditRegulatorHalatiAdet: TEdit
            Left = 188
            Top = 213
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object EditTasiyiciHalatKod: TEdit
            Left = 107
            Top = 93
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditTasiyiciHalatAdet: TEdit
            Left = 188
            Top = 93
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditHizRegulatoruKod: TEdit
            Left = 107
            Top = 189
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditHizRegulatoruAdet: TEdit
            Left = 188
            Top = 189
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
          object EditRegulatorAgirligiKod: TEdit
            Left = 107
            Top = 237
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
          end
          object EditRegulatorAgirligiAdet: TEdit
            Left = 188
            Top = 237
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 19
          end
          object EditHalatKlemensiKod: TEdit
            Left = 107
            Top = 165
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object EditHalatKlemensiAdet: TEdit
            Left = 188
            Top = 165
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
        end
      end
      object TabSheetKumanda: TTabSheet
        Caption = 'KUMANDA'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 685
        ExplicitHeight = 597
        object LabelKataGetirici: TLabel
          Left = 68
          Top = 170
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kata Getirici'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKapiTuru: TLabel
          Left = 84
          Top = 192
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kap'#305' T'#252'r'#252
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKatSecici: TLabel
          Left = 83
          Top = 317
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kat Se'#231'ici'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKontaktorMarkasi: TLabel
          Left = 32
          Top = 68
          Width = 105
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kontakt'#246'r Markas'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelSeviyeleme: TLabel
          Left = 71
          Top = 236
          Width = 66
          Height = 13
          Alignment = taRightJustify
          Caption = 'Seviyeleme'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object LabelKutuTipi: TLabel
          Left = 88
          Top = 118
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kutu Tipi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKontrolKarti: TLabel
          Left = 66
          Top = 13
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kontrol Kart'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelErkenKapiAcma: TLabel
          Left = 43
          Top = 258
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Erken Kap'#305' A'#231'ma'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object LabelInverterMarkasi: TLabel
          Left = 41
          Top = 346
          Width = 96
          Height = 13
          Alignment = taRightJustify
          Caption = 'Inverter Markas'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKontaktorBobinGerilim: TLabel
          Left = 0
          Top = 90
          Width = 137
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kontakt'#246'r Bobin Gerilimi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelGuvenlikDevresi: TLabel
          Left = 42
          Top = 46
          Width = 95
          Height = 13
          Alignment = taRightJustify
          Caption = 'G'#252'venlik Devresi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelMotorKablosu: TLabel
          Left = 56
          Top = 396
          Width = 81
          Height = 13
          Alignment = taRightJustify
          Caption = 'Motor Kablosu'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelInternetUsb: TLabel
          Left = 55
          Top = 417
          Width = 82
          Height = 13
          Alignment = taRightJustify
          Caption = 'Internet / USB'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPompaGerilimi: TLabel
          Left = 52
          Top = 214
          Width = 85
          Height = 13
          Alignment = taRightJustify
          Caption = 'Pompa Gerilimi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKutuTipiMRL: TLabel
          Left = 61
          Top = 140
          Width = 76
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kutu Tipi MRL'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ComboBoxKapiTuru: TComboBox
          Left = 140
          Top = 189
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object ComboBoxKatSecici: TComboBox
          Left = 140
          Top = 312
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object ComboBoxKataGetirici: TComboBox
          Left = 140
          Top = 167
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object ComboBoxKontaktorMarkasi: TComboBox
          Left = 140
          Top = 63
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ComboBoxSeviyeleme: TComboBox
          Left = 140
          Top = 233
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object ComboBoxKutuTipi: TComboBox
          Left = 140
          Top = 114
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object ComboBoxKontrolKarti: TComboBox
          Left = 140
          Top = 8
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ComboBoxErkenKapiAcma: TComboBox
          Left = 140
          Top = 255
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object ComboBoxInverterMarkasi: TComboBox
          Left = 140
          Top = 341
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object ComboBoxKontaktorBobinGerilimi: TComboBox
          Left = 140
          Top = 85
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ComboBoxGuvenlikDevresi: TComboBox
          Left = 140
          Top = 41
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ComboBoxMotorKablosu: TComboBox
          Left = 140
          Top = 391
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object GroupBoxTablo: TGroupBox
          Left = 273
          Top = 0
          Width = 392
          Height = 113
          Caption = 'Tablo'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 19
          object LabelTabloKumanda: TLabel
            Left = 20
            Top = 23
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'Kumanda'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloKoduBaslik: TLabel
            Left = 75
            Top = 8
            Width = 80
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloOzellikBaslik: TLabel
            Left = 189
            Top = 8
            Width = 200
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloKumandaOzellik: TLabel
            Left = 189
            Top = 26
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloKumandaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloGuc: TLabel
            Left = 18
            Top = 45
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'Tablo G'#252#231
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloGucOzellik: TLabel
            Left = 189
            Top = 48
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloGucOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelRevizyonKutusu: TLabel
            Left = 6
            Top = 68
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Rev. Kutusu'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelRevizyonKutusuOzellik: TLabel
            Left = 189
            Top = 69
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloGucOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloAdetBaslik: TLabel
            Left = 157
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelInverter: TLabel
            Left = 25
            Top = 90
            Width = 48
            Height = 13
            Alignment = taRightJustify
            Caption = 'Inverter'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelInverterOzellik: TLabel
            Left = 189
            Top = 90
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloGucOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditTabloKumandaKod: TEdit
            Left = 75
            Top = 21
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditTabloGucKod: TEdit
            Left = 75
            Top = 43
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object EditRevizyonKutusuKod: TEdit
            Left = 75
            Top = 65
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditInverterKod: TEdit
            Left = 75
            Top = 87
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
        end
        object GroupBoxTabloIlaveler: TGroupBox
          Left = 273
          Top = 120
          Width = 392
          Height = 437
          Caption = 'Tablo '#304'laveler'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 20
          object LabelTabloIlaveKoduBaslik: TLabel
            Left = 88
            Top = 8
            Width = 49
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlaveAdetBaslik: TLabel
            Left = 157
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlaveOzellikBaslik: TLabel
            Left = 189
            Top = 8
            Width = 200
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave1: TLabel
            Left = 34
            Top = 25
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave1Ozellik: TLabel
            Left = 189
            Top = 25
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave2: TLabel
            Left = 34
            Top = 48
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave2Ozellik: TLabel
            Left = 189
            Top = 48
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave3: TLabel
            Left = 34
            Top = 71
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave3Ozellik: TLabel
            Left = 189
            Top = 71
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave4: TLabel
            Left = 34
            Top = 94
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 4'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave4Ozellik: TLabel
            Left = 189
            Top = 94
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave4Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave5: TLabel
            Left = 34
            Top = 117
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 5'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave5Ozellik: TLabel
            Left = 189
            Top = 117
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave5Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave6: TLabel
            Left = 34
            Top = 140
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 6'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave6Ozellik: TLabel
            Left = 189
            Top = 140
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave6Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave7: TLabel
            Left = 34
            Top = 163
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 7'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave7Ozellik: TLabel
            Left = 189
            Top = 163
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave7Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave8: TLabel
            Left = 34
            Top = 186
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 8'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave8Ozellik: TLabel
            Left = 189
            Top = 186
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave8Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave9: TLabel
            Left = 34
            Top = 209
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 9'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave9Ozellik: TLabel
            Left = 189
            Top = 209
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave9Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave10: TLabel
            Left = 27
            Top = 232
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 10'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave10Ozellik: TLabel
            Left = 189
            Top = 232
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave11: TLabel
            Left = 27
            Top = 255
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 11'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave11Ozellik: TLabel
            Left = 189
            Top = 255
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave9Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave12: TLabel
            Left = 27
            Top = 278
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 12'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave12Ozellik: TLabel
            Left = 189
            Top = 278
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave13: TLabel
            Left = 27
            Top = 301
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 13'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave13Ozellik: TLabel
            Left = 189
            Top = 301
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave14: TLabel
            Left = 27
            Top = 324
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 14'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave14Ozellik: TLabel
            Left = 189
            Top = 324
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave15: TLabel
            Left = 27
            Top = 347
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 15'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave15Ozellik: TLabel
            Left = 189
            Top = 347
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave16: TLabel
            Left = 27
            Top = 370
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 16'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave16Ozellik: TLabel
            Left = 189
            Top = 370
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave17: TLabel
            Left = 27
            Top = 393
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 17'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave17Ozellik: TLabel
            Left = 189
            Top = 393
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabloIlave18: TLabel
            Left = 27
            Top = 416
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Alignment = taRightJustify
            Caption = #304'lave 18'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTabloIlave18Ozellik: TLabel
            Left = 189
            Top = 416
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTabloIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditTabloIlave1Kod: TEdit
            Left = 75
            Top = 21
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditTabloIlave1Adet: TEdit
            Left = 156
            Top = 21
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditTabloIlave2Kod: TEdit
            Left = 75
            Top = 44
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditTabloIlave2Adet: TEdit
            Left = 156
            Top = 44
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditTabloIlave3Kod: TEdit
            Left = 75
            Top = 67
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditTabloIlave3Adet: TEdit
            Left = 156
            Top = 67
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditTabloIlave4Kod: TEdit
            Left = 75
            Top = 90
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditTabloIlave4Adet: TEdit
            Left = 156
            Top = 90
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditTabloIlave5Kod: TEdit
            Left = 75
            Top = 113
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditTabloIlave5Adet: TEdit
            Left = 156
            Top = 113
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object EditTabloIlave6Kod: TEdit
            Left = 75
            Top = 136
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object EditTabloIlave6Adet: TEdit
            Left = 156
            Top = 136
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditTabloIlave7Kod: TEdit
            Left = 75
            Top = 159
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object EditTabloIlave7Adet: TEdit
            Left = 156
            Top = 159
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
          object EditTabloIlave8Kod: TEdit
            Left = 75
            Top = 182
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditTabloIlave8Adet: TEdit
            Left = 156
            Top = 182
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
          object EditTabloIlave9Kod: TEdit
            Left = 75
            Top = 205
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditTabloIlave9Adet: TEdit
            Left = 156
            Top = 205
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object EditTabloIlave10Kod: TEdit
            Left = 75
            Top = 228
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
          end
          object EditTabloIlave10Adet: TEdit
            Left = 156
            Top = 228
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 19
          end
          object EditTabloIlave11Kod: TEdit
            Left = 75
            Top = 251
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 20
          end
          object EditTabloIlave11Adet: TEdit
            Left = 156
            Top = 251
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 21
          end
          object EditTabloIlave12Kod: TEdit
            Left = 75
            Top = 274
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 22
          end
          object EditTabloIlave12Adet: TEdit
            Left = 156
            Top = 274
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 23
          end
          object EditTabloIlave13Kod: TEdit
            Left = 75
            Top = 297
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 24
          end
          object EditTabloIlave13Adet: TEdit
            Left = 156
            Top = 297
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 25
          end
          object EditTabloIlave14Kod: TEdit
            Left = 75
            Top = 320
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 26
          end
          object EditTabloIlave14Adet: TEdit
            Left = 156
            Top = 320
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 27
          end
          object EditTabloIlave15Kod: TEdit
            Left = 75
            Top = 343
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 28
          end
          object EditTabloIlave15Adet: TEdit
            Left = 156
            Top = 343
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 29
          end
          object EditTabloIlave16Kod: TEdit
            Left = 75
            Top = 366
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 30
          end
          object EditTabloIlave16Adet: TEdit
            Left = 156
            Top = 366
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 31
          end
          object EditTabloIlave17Kod: TEdit
            Left = 75
            Top = 389
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 32
          end
          object EditTabloIlave17Adet: TEdit
            Left = 156
            Top = 389
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 33
          end
          object EditTabloIlave18Kod: TEdit
            Left = 75
            Top = 412
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 34
          end
          object EditTabloIlave18Adet: TEdit
            Left = 156
            Top = 412
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 35
          end
        end
        object btnKumandaHesapla: TBitBtn
          Left = 535
          Top = 559
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 21
        end
        object ComboBoxInternetUsb: TComboBox
          Left = 140
          Top = 412
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object CheckBoxTarihSaat: TCheckBox
          Left = 8
          Top = 508
          Width = 150
          Height = 17
          Caption = 'Tarih - Saat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 16
        end
        object CheckBoxKutuIciIsiklandirma: TCheckBox
          Left = 8
          Top = 488
          Width = 150
          Height = 17
          Caption = 'Kutu '#304#231'i I'#351#305'kland'#305'rma'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 15
        end
        object CheckBoxMesajGonderme: TCheckBox
          Left = 8
          Top = 528
          Width = 150
          Height = 17
          Caption = 'Mesaj G'#246'nderme'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 17
        end
        object CheckBoxAnonsSistemi: TCheckBox
          Left = 8
          Top = 548
          Width = 150
          Height = 17
          Caption = 'Anons Sistemi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 18
        end
        object CheckBoxKuyuDibiKablosu: TCheckBox
          Left = 8
          Top = 568
          Width = 150
          Height = 17
          Caption = 'KuyuDibi Kablosu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 22
        end
        object cbbPompaGerilimi: TComboBox
          Left = 140
          Top = 211
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object ComboBoxKutuTipiMRL: TComboBox
          Left = 140
          Top = 136
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
      object TabSheetKaset: TTabSheet
        Caption = 'KASET'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelKabinKasetSayisi: TLabel
          Left = 6
          Top = 4
          Width = 102
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kabin Kaset Sayisi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelUstGostergeDurum: TLabel
          Left = 339
          Top = 5
          Width = 74
          Height = 13
          Alignment = taRightJustify
          Caption = #220'st G'#246'sterge'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKatKasetiDurum: TLabel
          Left = 190
          Top = 29
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kat Kaseti'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinKasetiDurum: TLabel
          Left = 178
          Top = 5
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kabin Kaseti'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelTabloMarkasi: TLabel
          Left = 334
          Top = 29
          Width = 79
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tablo Markas'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelBuzzerliButton: TLabel
          Left = 28
          Top = 28
          Width = 80
          Height = 13
          Alignment = taRightJustify
          Caption = 'Buzzerli Buton'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object GroupBoxKabinKaset: TGroupBox
          Left = 4
          Top = 52
          Width = 665
          Height = 276
          Caption = ' Kabin Kaseti '
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          object LabelKabinKasetGovde: TLabel
            Left = 347
            Top = 22
            Width = 36
            Height = 13
            Alignment = taRightJustify
            Caption = 'G'#246'vde'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave2: TLabel
            Left = 344
            Top = 154
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave3: TLabel
            Left = 344
            Top = 176
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetKat: TLabel
            Left = 364
            Top = 68
            Width = 19
            Height = 13
            Alignment = taRightJustify
            Caption = 'Kat'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave1: TLabel
            Left = 344
            Top = 132
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetFonksiyon: TLabel
            Left = 353
            Top = 44
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = 'Fonk.'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave3Ozellik: TLabel
            Left = 482
            Top = 175
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetIlave3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinKasetIlave2Ozellik: TLabel
            Left = 482
            Top = 153
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinKasetFonksiyonOzellik: TLabel
            Left = 482
            Top = 43
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetFonksiyonOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinKasetGovdeOzellik: TLabel
            Left = 482
            Top = 21
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetGovdeOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinKasetKatOzellik: TLabel
            Left = 482
            Top = 65
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetKatOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinKasetIlave1Ozellik: TLabel
            Left = 482
            Top = 131
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelBaslikMalAdiKabin: TLabel
            Left = 482
            Top = 6
            Width = 180
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikMalKoduKabin: TLabel
            Left = 384
            Top = 6
            Width = 70
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikAdetKabin: TLabel
            Left = 456
            Top = 6
            Width = 29
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinBukumSekli: TLabel
            Left = 34
            Top = 36
            Width = 69
            Height = 13
            Alignment = taRightJustify
            Caption = 'B'#252'k'#252'm '#350'ekli'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinButonTipi: TLabel
            Left = 47
            Top = 58
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'Buton Tipi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinPaslanmazTuru: TLabel
            Left = 13
            Top = 80
            Width = 90
            Height = 13
            Alignment = taRightJustify
            Caption = 'Paslanmaz T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinDisplayTuru: TLabel
            Left = 33
            Top = 124
            Width = 70
            Height = 13
            Alignment = taRightJustify
            Caption = 'Display T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinButonIsikRengi: TLabel
            Left = 11
            Top = 146
            Width = 92
            Height = 13
            Alignment = taRightJustify
            Caption = 'Buton I'#351#305'k Rengi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinLogoTuru: TLabel
            Left = 47
            Top = 168
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'Logo T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinBoy: TLabel
            Left = 82
            Top = 14
            Width = 21
            Height = 13
            Alignment = taRightJustify
            Caption = 'Boy'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinBoyBirim: TLabel
            Left = 207
            Top = 14
            Width = 17
            Height = 13
            Caption = 'cm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetDisplay: TLabel
            Left = 342
            Top = 88
            Width = 41
            Height = 13
            Alignment = taRightJustify
            Caption = 'Display'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetDisplayOzellik: TLabel
            Left = 481
            Top = 87
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetDisplayOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinKasetLogo: TLabel
            Left = 356
            Top = 110
            Width = 27
            Height = 13
            Alignment = taRightJustify
            Caption = 'Logo'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetLogoOzellik: TLabel
            Left = 481
            Top = 109
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetLogoOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinFonksiyonPaketi: TLabel
            Left = 14
            Top = 102
            Width = 89
            Height = 13
            Alignment = taRightJustify
            Caption = 'Fonsiyon Paketi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave4: TLabel
            Left = 344
            Top = 198
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 4'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave5: TLabel
            Left = 344
            Top = 220
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 5'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave5Ozellik: TLabel
            Left = 482
            Top = 219
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetIlave5Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinKasetIlave4Ozellik: TLabel
            Left = 482
            Top = 197
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetIlave4Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelDisplayBaglantisi: TLabel
            Left = 4
            Top = 190
            Width = 99
            Height = 13
            Alignment = taRightJustify
            Caption = 'Display Ba'#287'lant'#305's'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelDisplaySayisi: TLabel
            Left = 200
            Top = 60
            Width = 77
            Height = 13
            Alignment = taRightJustify
            Caption = 'Display Say'#305's'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave6: TLabel
            Left = 344
            Top = 242
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 6'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKasetIlave6Ozellik: TLabel
            Left = 482
            Top = 241
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKasetIlave6Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKabinKasetFonksiyonKod: TEdit
            Left = 384
            Top = 40
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
          end
          object EditKabinKasetIlave2Kod: TEdit
            Left = 384
            Top = 150
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 28
          end
          object EditKabinKasetIlave3Kod: TEdit
            Left = 384
            Top = 172
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 30
          end
          object EditKabinKasetKatKod: TEdit
            Left = 384
            Top = 62
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 20
          end
          object EditKabinKasetIlave1Kod: TEdit
            Left = 384
            Top = 128
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 26
          end
          object EditKabinKasetGovdeKod: TEdit
            Left = 384
            Top = 18
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditKabinKasetFonksiyonAdet: TEdit
            Left = 455
            Top = 40
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 19
          end
          object EditKabinKasetIlave2Adet: TEdit
            Left = 455
            Top = 150
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 29
          end
          object EditKabinKasetIlave3Adet: TEdit
            Left = 455
            Top = 172
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 31
          end
          object EditKabinKasetKatAdet: TEdit
            Left = 455
            Top = 62
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 21
          end
          object EditKabinKasetIlave1Adet: TEdit
            Left = 455
            Top = 128
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 27
          end
          object EditKabinKasetGovdeAdet: TEdit
            Left = 455
            Top = 18
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object ComboBoxKabinBukumSekli: TComboBox
            Left = 104
            Top = 34
            Width = 233
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBoxKabinButonTipi: TComboBox
            Left = 104
            Top = 56
            Width = 50
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object ComboBoxKabinPaslanmazTuru: TComboBox
            Left = 104
            Top = 78
            Width = 100
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object ComboBoxKabinDisplayTuru: TComboBox
            Left = 104
            Top = 121
            Width = 217
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object ComboBoxKabinButonIsikRengi: TComboBox
            Left = 104
            Top = 142
            Width = 100
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object ComboBoxKabinLogoTuru: TComboBox
            Left = 104
            Top = 164
            Width = 100
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object ComboBoxKabinBoy: TComboBox
            Left = 104
            Top = 12
            Width = 100
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object EditKabinKasetDisplayKod: TEdit
            Left = 384
            Top = 84
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 22
          end
          object EditKabinKasetDisplayAdet: TEdit
            Left = 455
            Top = 84
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 23
          end
          object EditKabinKasetLogoKod: TEdit
            Left = 384
            Top = 106
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 24
          end
          object EditKabinKasetLogoAdet: TEdit
            Left = 455
            Top = 106
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 25
          end
          object ComboBoxKabinFonksiyonPaketi: TComboBox
            Left = 104
            Top = 100
            Width = 235
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object EditKabinKasetIlave4Kod: TEdit
            Left = 384
            Top = 194
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 32
          end
          object EditKabinKasetIlave5Kod: TEdit
            Left = 384
            Top = 216
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 34
          end
          object EditKabinKasetIlave4Adet: TEdit
            Left = 455
            Top = 194
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 33
          end
          object EditKabinKasetIlave5Adet: TEdit
            Left = 455
            Top = 216
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 35
          end
          object ComboBoxDisplayBaglantisi: TComboBox
            Left = 104
            Top = 186
            Width = 100
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object ComboBoxDisplaySayisi: TComboBox
            Left = 280
            Top = 56
            Width = 41
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object CheckBoxVatmanAnahtari: TCheckBox
            Left = 10
            Top = 244
            Width = 125
            Height = 17
            Caption = 'Vatman Anahtar'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 12
          end
          object CheckBoxTelefonKapagi: TCheckBox
            Left = 10
            Top = 212
            Width = 105
            Height = 17
            Caption = 'Telefon Kapa'#287#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 10
          end
          object CheckBoxVideoEkrani: TCheckBox
            Left = 146
            Top = 244
            Width = 95
            Height = 17
            Caption = 'Video Ekran'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 15
          end
          object CheckBoxPanelKilidi: TCheckBox
            Left = 146
            Top = 228
            Width = 85
            Height = 17
            Caption = 'Panel Kilidi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 14
          end
          object CheckBoxHoparlor: TCheckBox
            Left = 146
            Top = 212
            Width = 85
            Height = 17
            Caption = 'Hoparl'#246'r'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 13
          end
          object CheckBoxKatIsimPenceresi: TCheckBox
            Left = 10
            Top = 228
            Width = 125
            Height = 17
            Caption = 'Kat '#304'sim Penceresi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 11
          end
          object EditKabinKasetIlave6Kod: TEdit
            Left = 384
            Top = 238
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 36
          end
          object EditKabinKasetIlave6Adet: TEdit
            Left = 455
            Top = 238
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 37
          end
        end
        object ComboBoxKabinKasetSayisi: TComboBox
          Left = 109
          Top = 1
          Width = 50
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            '1'
            '2')
        end
        object ComboBoxUstGostergeDurum: TComboBox
          Left = 414
          Top = 2
          Width = 50
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ComboBoxKatKasetiDurum: TComboBox
          Left = 248
          Top = 26
          Width = 50
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object ComboBoxKabinKasetiDurum: TComboBox
          Left = 248
          Top = 2
          Width = 50
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object GroupBoxKatKaset: TGroupBox
          Left = 4
          Top = 327
          Width = 665
          Height = 153
          Caption = ' Kat Kaseti'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object LabelKatIlave1: TLabel
            Left = 305
            Top = 109
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatIlave2: TLabel
            Left = 305
            Top = 131
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKaset1: TLabel
            Left = 302
            Top = 21
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Kaset 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKaset2: TLabel
            Left = 302
            Top = 43
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Kaset 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKaset3: TLabel
            Left = 302
            Top = 65
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Kaset 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatIlave1Ozellik: TLabel
            Left = 474
            Top = 110
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKatIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKatKaset3Ozellik: TLabel
            Left = 474
            Top = 66
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKatKaset3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKatKaset2Ozellik: TLabel
            Left = 474
            Top = 44
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKatKaset2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKatKaset1Ozellik: TLabel
            Left = 474
            Top = 22
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKatKaset1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKatIlave2Ozellik: TLabel
            Left = 474
            Top = 132
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKatIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelBaslikMalAdiKat: TLabel
            Left = 474
            Top = 6
            Width = 180
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikMalKoduKat: TLabel
            Left = 345
            Top = 6
            Width = 100
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikAdetKat: TLabel
            Left = 448
            Top = 6
            Width = 29
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatMontajSekli: TLabel
            Left = 33
            Top = 16
            Width = 70
            Height = 13
            Alignment = taRightJustify
            Caption = 'Montaj '#350'ekli'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatButonTipi: TLabel
            Left = 47
            Top = 38
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'Buton Tipi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatPaslanmazTuru: TLabel
            Left = 13
            Top = 60
            Width = 90
            Height = 13
            Alignment = taRightJustify
            Caption = 'Paslanmaz T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatDisplayTuru: TLabel
            Left = 33
            Top = 82
            Width = 70
            Height = 13
            Alignment = taRightJustify
            Caption = 'Display T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatButonIsikRengi: TLabel
            Left = 11
            Top = 104
            Width = 92
            Height = 13
            Alignment = taRightJustify
            Caption = 'Buton I'#351#305'k Rengi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatLogoTuru: TLabel
            Left = 47
            Top = 126
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'Logo T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKaset4: TLabel
            Left = 302
            Top = 87
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Kaset 4'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKaset4Ozellik: TLabel
            Left = 474
            Top = 88
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKatKaset4Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKatKaset1Adet: TEdit
            Left = 447
            Top = 19
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditKatKaset2Adet: TEdit
            Left = 447
            Top = 41
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object EditKatKaset3Adet: TEdit
            Left = 447
            Top = 63
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditKatIlave1Kod: TEdit
            Left = 345
            Top = 107
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditKatIlave2Kod: TEdit
            Left = 345
            Top = 129
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditKatKaset1Kod: TEdit
            Left = 345
            Top = 19
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditKatKaset2Kod: TEdit
            Left = 345
            Top = 41
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditKatKaset3Kod: TEdit
            Left = 345
            Top = 63
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object EditKatIlave1Adet: TEdit
            Left = 447
            Top = 107
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
          object EditKatIlave2Adet: TEdit
            Left = 447
            Top = 129
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object ComboBoxKatMontajSekli: TComboBox
            Left = 104
            Top = 12
            Width = 177
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ComboBoxKatButonTipi: TComboBox
            Left = 104
            Top = 34
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBoxKatPaslanmazTuru: TComboBox
            Left = 104
            Top = 56
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object ComboBoxKatDisplayTuru: TComboBox
            Left = 104
            Top = 78
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ComboBoxKatButonIsikRengi: TComboBox
            Left = 104
            Top = 100
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object ComboBoxKatLogoTuru: TComboBox
            Left = 104
            Top = 122
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object EditKatKaset4Adet: TEdit
            Left = 447
            Top = 85
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
          object EditKatKaset4Kod: TEdit
            Left = 345
            Top = 85
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
        end
        object GroupBoxUstGosterge: TGroupBox
          Left = 4
          Top = 479
          Width = 665
          Height = 118
          Caption = #220'st G'#246'sterge'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          Visible = False
          object LabelUstGostergeIlave1: TLabel
            Left = 314
            Top = 42
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelUstGostergeIlave2: TLabel
            Left = 314
            Top = 64
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelUstGosterge: TLabel
            Left = 302
            Top = 21
            Width = 51
            Height = 13
            Alignment = taRightJustify
            Caption = #220'st G'#246'st.'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelUstGostergeIlave2Ozellik: TLabel
            Left = 483
            Top = 66
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelUstGostergeIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelUstGostergeIlave1Ozellik: TLabel
            Left = 483
            Top = 43
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelUstGostergeIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelUstGostergeOzellik: TLabel
            Left = 483
            Top = 21
            Width = 180
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelUstGostergeOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelBaslikMalAdiUstGosterge: TLabel
            Left = 483
            Top = 6
            Width = 180
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikMalKoduUstGosterge: TLabel
            Left = 354
            Top = 6
            Width = 100
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikAdetUstGosterge: TLabel
            Left = 457
            Top = 6
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelUGMontajSekli: TLabel
            Left = 33
            Top = 16
            Width = 70
            Height = 13
            Alignment = taRightJustify
            Caption = 'Montaj '#350'ekli'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelUGHizmetYonOku: TLabel
            Left = 14
            Top = 82
            Width = 89
            Height = 13
            Alignment = taRightJustify
            Caption = 'Hizmet Y'#246'n Oku'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelUGPaslanmazTuru: TLabel
            Left = 13
            Top = 38
            Width = 90
            Height = 13
            Alignment = taRightJustify
            Caption = 'Paslanmaz T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelUGDisplayTuru: TLabel
            Left = 33
            Top = 60
            Width = 70
            Height = 13
            Alignment = taRightJustify
            Caption = 'Display T'#252'r'#252
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditUstGostergeIlave1Kod: TEdit
            Left = 354
            Top = 40
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditUstGostergeIlave2Kod: TEdit
            Left = 354
            Top = 62
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditUstGostergeAdet: TEdit
            Left = 456
            Top = 18
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditUstGostergeKod: TEdit
            Left = 354
            Top = 18
            Width = 100
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditUstGostergeIlave1Adet: TEdit
            Left = 456
            Top = 40
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditUstGostergeIlave2Adet: TEdit
            Left = 456
            Top = 62
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object ComboBoxUGMontajSekli: TComboBox
            Left = 104
            Top = 12
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ComboBoxUGHizmetYonOku: TComboBox
            Left = 104
            Top = 78
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ComboBoxUGPaslanmazTuru: TComboBox
            Left = 104
            Top = 34
            Width = 130
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBoxUGDisplayTuru: TComboBox
            Left = 104
            Top = 56
            Width = 169
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
        end
        object ComboBoxTabloMarkasi: TComboBox
          Left = 414
          Top = 26
          Width = 115
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object btnKasetHesapla: TBitBtn
          Left = 539
          Top = 559
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 9
        end
        object ComboBoxBuzzerliButon: TComboBox
          Left = 109
          Top = 25
          Width = 50
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Items.Strings = (
            '1'
            '2')
        end
      end
      object TabSheetHazirTesisat: TTabSheet
        Caption = 'HAZIR TES'#304'SAT'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 685
        ExplicitHeight = 597
        object GroupBoxHazirTesisat: TGroupBox
          Left = 8
          Top = 8
          Width = 441
          Height = 249
          Caption = ' Haz'#305'r Tesisat '
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object LabelAnaTesisat: TLabel
            Left = 36
            Top = 34
            Width = 66
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ana Tesisat'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelFlexibleKablo: TLabel
            Left = 25
            Top = 80
            Width = 77
            Height = 13
            Alignment = taRightJustify
            Caption = 'Flexible Kablo'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesisatIlave1: TLabel
            Left = 63
            Top = 129
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatbasiTesisat: TLabel
            Left = 26
            Top = 57
            Width = 76
            Height = 13
            Alignment = taRightJustify
            Caption = 'Katba'#351#305' Tesst'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatbasiTesisatOzellik: TLabel
            Left = 201
            Top = 58
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKatbasiTesisatOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAnaTesisatOzellik: TLabel
            Left = 201
            Top = 36
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAnaTesisatOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelFlexibleKabloOzellik: TLabel
            Left = 201
            Top = 82
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelFlexibleKabloOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTesisatIlave1Ozellik: TLabel
            Left = 201
            Top = 130
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelBaslikTesisatMalAdi: TLabel
            Left = 201
            Top = 20
            Width = 236
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikTesisatMalKodu: TLabel
            Left = 103
            Top = 20
            Width = 70
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikTesisatAdet: TLabel
            Left = 175
            Top = 20
            Width = 29
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesisatIlave2: TLabel
            Left = 63
            Top = 152
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesisatIlave2Ozellik: TLabel
            Left = 201
            Top = 153
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTesisatIlave3: TLabel
            Left = 63
            Top = 175
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesisatIlave3Ozellik: TLabel
            Left = 201
            Top = 176
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTesisatIlave4: TLabel
            Left = 63
            Top = 198
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 4'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesisatIlave4Ozellik: TLabel
            Left = 201
            Top = 199
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave4Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTesisatIlave5: TLabel
            Left = 63
            Top = 221
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 5'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesisatIlave5Ozellik: TLabel
            Left = 201
            Top = 222
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave5Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTesisatMotorKablosu: TLabel
            Left = 34
            Top = 104
            Width = 68
            Height = 13
            Alignment = taRightJustify
            Caption = 'Motor Kablo'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesisatMotorKablosuOzellik: TLabel
            Left = 201
            Top = 106
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatMotorKablosuOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKatbasiTesisatKod: TEdit
            Left = 103
            Top = 55
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditFlexibleKabloKod: TEdit
            Left = 103
            Top = 78
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditTesisatIlave1Kod: TEdit
            Left = 103
            Top = 125
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditAnaTesisatKod: TEdit
            Left = 103
            Top = 32
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditKatbasiTesisatAdet: TEdit
            Left = 174
            Top = 55
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditFlexibleKabloAdet: TEdit
            Left = 174
            Top = 78
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditTesisatIlave1Adet: TEdit
            Left = 174
            Top = 125
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object EditAnaTesisatAdet: TEdit
            Left = 174
            Top = 32
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditTesisatIlave2Kod: TEdit
            Left = 103
            Top = 148
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object EditTesisatIlave2Adet: TEdit
            Left = 174
            Top = 148
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditTesisatIlave3Kod: TEdit
            Left = 103
            Top = 171
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object EditTesisatIlave3Adet: TEdit
            Left = 174
            Top = 171
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
          object EditTesisatIlave4Kod: TEdit
            Left = 103
            Top = 194
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditTesisatIlave4Adet: TEdit
            Left = 174
            Top = 194
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
          object EditTesisatIlave5Kod: TEdit
            Left = 103
            Top = 217
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditTesisatIlave5Adet: TEdit
            Left = 174
            Top = 217
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object EditTesisatMotorKablosuKod: TEdit
            Left = 103
            Top = 102
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditTesisatMotorKablosuAdet: TEdit
            Left = 174
            Top = 102
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
        end
        object btnHazirTesisatHesapla: TBitBtn
          Left = 319
          Top = 407
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 1
        end
        object GroupBoxTesKuyuAydinlatma: TGroupBox
          Left = 8
          Top = 264
          Width = 441
          Height = 137
          Caption = ' Haz'#305'r Tesisat Kuyu Ayd'#305'nlatma '
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object LabelTesKuyuAydinlatma: TLabel
            Left = 6
            Top = 34
            Width = 96
            Height = 13
            Alignment = taRightJustify
            Caption = 'Kuyu Ayd'#305'nlatma'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesIlave1: TLabel
            Left = 63
            Top = 57
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesKuyuAydinlatmaOzellik: TLabel
            Left = 201
            Top = 36
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAnaTesisatOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTesIlave1Ozellik: TLabel
            Left = 201
            Top = 58
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelBaslikTesAydinlatmaMalAdi: TLabel
            Left = 201
            Top = 20
            Width = 236
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikTesAydinlatmaMalKodu: TLabel
            Left = 103
            Top = 20
            Width = 70
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikTesAydinlatmaAdet: TLabel
            Left = 175
            Top = 20
            Width = 29
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesIlave2: TLabel
            Left = 63
            Top = 80
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesIlave2Ozellik: TLabel
            Left = 201
            Top = 81
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTesIlave3: TLabel
            Left = 63
            Top = 103
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #304'lave 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTesIlave3Ozellik: TLabel
            Left = 201
            Top = 104
            Width = 236
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTesisatIlave3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditTesIlave1Kod: TEdit
            Left = 103
            Top = 53
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditTesKuyuAydinlatmaKod: TEdit
            Left = 103
            Top = 32
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditTesIlave1Adet: TEdit
            Left = 174
            Top = 53
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditTesKuyuAydinlatmaAdet: TEdit
            Left = 174
            Top = 32
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditTesIlave2Kod: TEdit
            Left = 103
            Top = 76
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditTesIlave2Adet: TEdit
            Left = 174
            Top = 76
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditTesIlave3Kod: TEdit
            Left = 103
            Top = 99
            Width = 70
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditTesIlave3Adet: TEdit
            Left = 174
            Top = 99
            Width = 25
            Height = 21
            Hint = 'ADET'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
        end
      end
      object TabSheetKapi: TTabSheet
        Caption = 'KAPI'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 685
        ExplicitHeight = 597
        object LabelKapiGenislik: TLabel
          Left = 8
          Top = 10
          Width = 50
          Height = 13
          Caption = 'Geni'#351'lik :'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKapiGenislikBirim: TLabel
          Left = 184
          Top = 10
          Width = 17
          Height = 13
          Caption = 'cm'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EditKapiGenislik: TEdit
          Left = 88
          Top = 7
          Width = 90
          Height = 21
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 0
        end
        object GroupBoxKabinKapisi: TGroupBox
          Left = 8
          Top = 46
          Width = 241
          Height = 147
          Caption = 'Kabin Kap'#305's'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object LabelKabinKapisiSeri: TLabel
            Left = 8
            Top = 23
            Width = 28
            Height = 13
            Caption = 'Seri :'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKapisiYon: TLabel
            Left = 8
            Top = 96
            Width = 21
            Height = 13
            Caption = 'Y'#246'n'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKapisiMalzeme: TLabel
            Left = 8
            Top = 47
            Width = 51
            Height = 13
            Caption = 'Malzeme'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKapisiPanelSayisi: TLabel
            Left = 8
            Top = 70
            Width = 67
            Height = 13
            Caption = 'Panel Say'#305's'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKapisiKalinlik: TLabel
            Left = 8
            Top = 120
            Width = 40
            Height = 13
            Caption = 'Kal'#305'nl'#305'k'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ComboBoxKabinKapisiSeri: TComboBox
            Left = 82
            Top = 18
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ComboBoxKabinKapisiMalzeme: TComboBox
            Left = 82
            Top = 42
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBoxKabinKapisiPanelSayisi: TComboBox
            Left = 82
            Top = 66
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object ComboBoxKabinKapisiYon: TComboBox
            Left = 82
            Top = 90
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ComboBoxKabinKapisiKalinlik: TComboBox
            Left = 82
            Top = 114
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
        end
        object CheckBoxKabinKapisiIleAyni: TCheckBox
          Left = 264
          Top = 114
          Width = 137
          Height = 17
          Caption = 'Kabin Kap'#305's'#305' ile Ayn'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object GroupBoxKatKapisi: TGroupBox
          Left = 416
          Top = 46
          Width = 241
          Height = 147
          Caption = 'Kat Kap'#305's'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object LabelKatKapisiSeri: TLabel
            Left = 8
            Top = 23
            Width = 28
            Height = 13
            Caption = 'Seri :'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKapisiYon: TLabel
            Left = 8
            Top = 96
            Width = 21
            Height = 13
            Caption = 'Y'#246'n'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKapisiMalzeme: TLabel
            Left = 8
            Top = 47
            Width = 51
            Height = 13
            Caption = 'Malzeme'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKapisiPanelSayisi: TLabel
            Left = 8
            Top = 70
            Width = 67
            Height = 13
            Caption = 'Panel Say'#305's'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKatKapisiKalinlik: TLabel
            Left = 8
            Top = 120
            Width = 40
            Height = 13
            Caption = 'Kal'#305'nl'#305'k'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ComboBoxKatKapisiSeri: TComboBox
            Left = 82
            Top = 18
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ComboBoxKatKapisiMalzeme: TComboBox
            Left = 82
            Top = 42
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBoxKatKapisiPanelSayisi: TComboBox
            Left = 82
            Top = 66
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object ComboBoxKatKapisiYon: TComboBox
            Left = 82
            Top = 90
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ComboBoxKatKapisiKalinlik: TComboBox
            Left = 82
            Top = 114
            Width = 146
            Height = 21
            Style = csDropDownList
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
        end
        object GroupBoxKapilar: TGroupBox
          Left = 9
          Top = 256
          Width = 416
          Height = 89
          Caption = 'Kap'#305'lar'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object LabelKatKapisi: TLabel
            Left = 8
            Top = 57
            Width = 55
            Height = 13
            Hint = 'BASLIK'
            Caption = 'Kat Kap'#305's'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKapisi: TLabel
            Left = 8
            Top = 33
            Width = 67
            Height = 13
            Hint = 'BASLIK'
            Caption = 'Kabin Kap'#305's'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKapisiOzellik: TLabel
            Left = 205
            Top = 33
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKatKapisiOzellik: TLabel
            Left = 205
            Top = 57
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKapiKodBaslik: TLabel
            Left = 83
            Top = 16
            Width = 86
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKapiAdetBaslik: TLabel
            Left = 173
            Top = 16
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKapiOzellikBaslik: TLabel
            Left = 205
            Top = 16
            Width = 200
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditKatKapisiKod: TEdit
            Left = 83
            Top = 53
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditKabinKapisiKod: TEdit
            Left = 83
            Top = 29
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditKabinKapisiAdet: TEdit
            Left = 172
            Top = 29
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditKatKapisiAdet: TEdit
            Left = 172
            Top = 53
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
        end
        object btnKapiHesapla: TBitBtn
          Left = 527
          Top = 327
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 5
        end
      end
      object TabSheetKabin: TTabSheet
        Caption = 'KAB'#304'N'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelKabinDuvarKaplama: TLabel
          Left = 4
          Top = 92
          Width = 92
          Height = 13
          Caption = 'Duvar Kaplama :'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinTavanTipleri: TLabel
          Left = 4
          Top = 161
          Width = 79
          Height = 13
          Caption = 'Tavan Tipleri :'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinTabanTipleri: TLabel
          Left = 4
          Top = 138
          Width = 79
          Height = 13
          Caption = 'Taban Tipleri :'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinKupesteTipleri: TLabel
          Left = 4
          Top = 184
          Width = 90
          Height = 13
          Caption = 'K'#252'pe'#351'te Tipleri :'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinDuvarKaplamaSekli: TLabel
          Left = 4
          Top = 115
          Width = 85
          Height = 13
          Caption = 'Kaplama '#350'ekli :'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinAsiriYukTipleri: TLabel
          Left = 4
          Top = 207
          Width = 93
          Height = 13
          Caption = 'A'#351#305'r'#305' Y'#252'k Tipleri :'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinSuspansiyonTipi: TLabel
          Left = 4
          Top = 229
          Width = 94
          Height = 13
          Caption = 'S'#252'spansiyon Tipi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinBoyFotoselMarkasi: TLabel
          Left = 4
          Top = 252
          Width = 113
          Height = 13
          Caption = 'Boy Fotosel Markas'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKabinFotoselBaglantiAparati: TLabel
          Left = 4
          Top = 275
          Width = 110
          Height = 13
          Caption = 'Fotosel Ba'#287'.Aparat'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RadioGroupKabinTipi: TRadioGroup
          Left = 8
          Top = 5
          Width = 241
          Height = 76
          Caption = 'Kabin Tipi'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ComboBoxKabinDuvarKaplama: TComboBox
          Left = 119
          Top = 88
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ComboBoxKabinTavanTipi: TComboBox
          Left = 119
          Top = 157
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object ComboBoxKabinTabanTipi: TComboBox
          Left = 119
          Top = 134
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ComboBoxKabinKupesteTipi: TComboBox
          Left = 119
          Top = 180
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object GroupBoxKabin: TGroupBox
          Left = 256
          Top = 0
          Width = 419
          Height = 209
          Caption = 'Kabin'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          object LabelKabinKodu: TLabel
            Left = 4
            Top = 25
            Width = 31
            Height = 13
            Caption = 'Kabin'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKoduBaslik: TLabel
            Left = 97
            Top = 8
            Width = 88
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinOzellikBaslik: TLabel
            Left = 217
            Top = 8
            Width = 200
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKabinOzellik: TLabel
            Left = 217
            Top = 25
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKabinOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTabanKodu: TLabel
            Left = 4
            Top = 47
            Width = 35
            Height = 13
            Caption = 'Taban'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinTabanOzellik: TLabel
            Left = 217
            Top = 47
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinTabanOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTavanKodu: TLabel
            Left = 4
            Top = 69
            Width = 35
            Height = 13
            Caption = 'Tavan'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinTavanOzellik: TLabel
            Left = 217
            Top = 69
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinTavanOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinAdetBaslik: TLabel
            Left = 187
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKupesteKodu: TLabel
            Left = 4
            Top = 91
            Width = 46
            Height = 13
            Caption = 'K'#252'pe'#351'te'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinKupesteOzellik: TLabel
            Left = 217
            Top = 91
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinKupesteOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinAsiriYuk: TLabel
            Left = 4
            Top = 113
            Width = 49
            Height = 13
            Caption = 'A'#351#305'r'#305' Y'#252'k'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinAsiriYukOzellik: TLabel
            Left = 217
            Top = 113
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinAsiriYukOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinHavalandirma: TLabel
            Left = 4
            Top = 135
            Width = 72
            Height = 13
            Caption = 'Havalnd'#305'rma'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinHavalandirmaOzellik: TLabel
            Left = 217
            Top = 135
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinHavalandirmaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinSuspansiyonKabin: TLabel
            Left = 4
            Top = 157
            Width = 54
            Height = 13
            Caption = 'S'#252's.Kabin'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinSuspansiyonKabinOzellik: TLabel
            Left = 217
            Top = 157
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinSuspansiyonKabinOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinBoyFotosel: TLabel
            Left = 4
            Top = 180
            Width = 65
            Height = 13
            Caption = 'Boy Fotosel'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinBoyFotoselOzellik: TLabel
            Left = 217
            Top = 180
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinBoyFotoselOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKabinKabinKod: TEdit
            Left = 97
            Top = 21
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditKabinKabinAdet: TEdit
            Left = 186
            Top = 21
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditKabinTabanKod: TEdit
            Left = 97
            Top = 43
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditKabinTabanAdet: TEdit
            Left = 186
            Top = 43
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditKabinTavanKod: TEdit
            Left = 97
            Top = 65
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditKabinTavanAdet: TEdit
            Left = 186
            Top = 65
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditKabinKupesteKod: TEdit
            Left = 97
            Top = 87
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditKabinKupesteAdet: TEdit
            Left = 186
            Top = 87
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditKabinAsiriYukKod: TEdit
            Left = 97
            Top = 109
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditKabinAsiriYukAdet: TEdit
            Left = 186
            Top = 109
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object EditKabinHavalandirmaKod: TEdit
            Left = 97
            Top = 131
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object EditKabinHavalandirmaAdet: TEdit
            Left = 186
            Top = 131
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditKabinSuspansiyonKabinKod: TEdit
            Left = 97
            Top = 153
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object EditKabinSuspansiyonKabinAdet: TEdit
            Left = 186
            Top = 153
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
          object EditKabinBoyFotoselKod: TEdit
            Left = 97
            Top = 176
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditKabinBoyFotoselAdet: TEdit
            Left = 186
            Top = 176
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
        end
        object GroupBoxKabinIlaveler: TGroupBox
          Left = 256
          Top = 320
          Width = 409
          Height = 273
          Caption = 'Kabin '#304'laveler'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          object LabelKabinIlaveKodBaslik: TLabel
            Left = 59
            Top = 16
            Width = 86
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlaveAdetBaslik: TLabel
            Left = 149
            Top = 16
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlaveOzellikBaslik: TLabel
            Left = 181
            Top = 16
            Width = 200
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave1: TLabel
            Left = 4
            Top = 33
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave1Ozellik: TLabel
            Left = 181
            Top = 33
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave2: TLabel
            Left = 4
            Top = 57
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave2Ozellik: TLabel
            Left = 181
            Top = 57
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave3: TLabel
            Left = 4
            Top = 81
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave3Ozellik: TLabel
            Left = 181
            Top = 81
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave4: TLabel
            Left = 4
            Top = 105
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 4'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave4Ozellik: TLabel
            Left = 181
            Top = 105
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave4Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave5: TLabel
            Left = 4
            Top = 129
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 5'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave5Ozellik: TLabel
            Left = 181
            Top = 129
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave5Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave6: TLabel
            Left = 4
            Top = 153
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 6'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave6Ozellik: TLabel
            Left = 181
            Top = 153
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave6Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave7: TLabel
            Left = 4
            Top = 177
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 7'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave7Ozellik: TLabel
            Left = 181
            Top = 177
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave7Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave8: TLabel
            Left = 4
            Top = 201
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 8'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave8Ozellik: TLabel
            Left = 181
            Top = 201
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave8Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave9: TLabel
            Left = 4
            Top = 225
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 9'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave9Ozellik: TLabel
            Left = 181
            Top = 225
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave9Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinIlave10: TLabel
            Left = 4
            Top = 249
            Width = 46
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 10'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinIlave10Ozellik: TLabel
            Left = 181
            Top = 249
            Width = 200
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinIlave10Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKabinIlave1Kod: TEdit
            Left = 59
            Top = 29
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditKabinIlave1Adet: TEdit
            Left = 148
            Top = 29
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditKabinIlave2Kod: TEdit
            Left = 59
            Top = 53
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditKabinIlave2Adet: TEdit
            Left = 148
            Top = 53
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditKabinIlave3Kod: TEdit
            Left = 59
            Top = 77
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditKabinIlave3Adet: TEdit
            Left = 148
            Top = 77
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditKabinIlave4Kod: TEdit
            Left = 59
            Top = 101
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditKabinIlave4Adet: TEdit
            Left = 148
            Top = 101
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditKabinIlave5Kod: TEdit
            Left = 59
            Top = 125
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditKabinIlave5Adet: TEdit
            Left = 148
            Top = 125
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object EditKabinIlave6Kod: TEdit
            Left = 59
            Top = 149
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object EditKabinIlave6Adet: TEdit
            Left = 148
            Top = 149
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditKabinIlave7Kod: TEdit
            Left = 59
            Top = 173
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object EditKabinIlave7Adet: TEdit
            Left = 148
            Top = 173
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
          object EditKabinIlave8Kod: TEdit
            Left = 59
            Top = 197
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditKabinIlave8Adet: TEdit
            Left = 148
            Top = 197
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
          object EditKabinIlave9Kod: TEdit
            Left = 59
            Top = 221
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditKabinIlave9Adet: TEdit
            Left = 148
            Top = 221
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object EditKabinIlave10Kod: TEdit
            Left = 59
            Top = 245
            Width = 88
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
          end
          object EditKabinIlave10Adet: TEdit
            Left = 148
            Top = 245
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 19
          end
        end
        object btnKabinHesapla: TBitBtn
          Left = 119
          Top = 556
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 12
        end
        object ComboBoxKabinDuvarKaplamaSekli: TComboBox
          Left = 119
          Top = 111
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ComboBoxKabinAsiriYukTipi: TComboBox
          Left = 119
          Top = 203
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object ComboBoxKabinSuspansiyonTipi: TComboBox
          Left = 119
          Top = 225
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Items.Strings = (
            'TEK SIRA'
            #199#304'FT SIRA')
        end
        object ComboBoxKabinBoyFotoselMarkasi: TComboBox
          Left = 119
          Top = 248
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          Items.Strings = (
            'TEK SIRA'
            #199#304'FT SIRA')
        end
        object ComboBoxKabinFotoselBaglantiAparati: TComboBox
          Left = 119
          Top = 271
          Width = 130
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          Items.Strings = (
            'TEK SIRA'
            #199#304'FT SIRA')
        end
      end
      object TabSheetRay: TTabSheet
        Caption = 'RAY'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 685
        ExplicitHeight = 597
        object LabelRayRayMarkasi: TLabel
          Left = 20
          Top = 20
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ray Markas'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelRayAgirlikKonumu: TLabel
          Left = 5
          Top = 43
          Width = 85
          Height = 13
          Alignment = taRightJustify
          Caption = 'A'#287#305'rl'#305'k Konumu'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelRayRayArasi: TLabel
          Left = 36
          Top = 66
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ray Aras'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object GroupBoxRay: TGroupBox
          Left = 192
          Top = 0
          Width = 481
          Height = 593
          Caption = 'Ray'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object LabelRayKodBaslik: TLabel
            Left = 119
            Top = 8
            Width = 80
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelRayOzellikBaslik: TLabel
            Left = 231
            Top = 8
            Width = 248
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelRayAdetBaslik: TLabel
            Left = 201
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object shpAyrac: TShape
            Left = 0
            Top = 263
            Width = 480
            Height = 4
            Align = alCustom
            Anchors = [akTop, akRight]
            Pen.Color = 2924009
            Pen.Width = 3
          end
          object LabelKabinRayi: TLabel
            Left = 8
            Top = 26
            Width = 59
            Height = 13
            Caption = 'Kabin Ray'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayiOzellik: TLabel
            Left = 231
            Top = 25
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayFlans: TLabel
            Left = 8
            Top = 48
            Width = 94
            Height = 13
            Caption = 'Kabin Ray'#305' Flan'#351#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayFlansOzellik: TLabel
            Left = 231
            Top = 47
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayFlansOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayFlansCivataSomun: TLabel
            Left = 8
            Top = 70
            Width = 90
            Height = 13
            Caption = 'Civata + Somun'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayFlansCivataSomunOzellik: TLabel
            Left = 231
            Top = 69
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayFlansCivataSomunOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayFlansPul: TLabel
            Left = 8
            Top = 92
            Width = 17
            Height = 13
            Caption = 'Pul'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayFlansPulOzellik: TLabel
            Left = 231
            Top = 91
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayFlansPulOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayFlansRondela: TLabel
            Left = 8
            Top = 114
            Width = 46
            Height = 13
            Caption = 'Rondela'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayFlansRondelaOzellik: TLabel
            Left = 231
            Top = 113
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayFlansRondelaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayKonsol: TLabel
            Left = 8
            Top = 136
            Width = 103
            Height = 13
            Caption = 'Kabin Ray Konsolu'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayKonsolOzellik: TLabel
            Left = 231
            Top = 135
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayKonsolOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayKonsolCivataSomun: TLabel
            Left = 8
            Top = 158
            Width = 90
            Height = 13
            Caption = 'Civata + Somun'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayKonsolCivataSomunOzellik: TLabel
            Left = 231
            Top = 157
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayKonsolCivataSomunOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayKonsolPul: TLabel
            Left = 8
            Top = 180
            Width = 17
            Height = 13
            Caption = 'Pul'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayKonsolPulOzellik: TLabel
            Left = 231
            Top = 179
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayKonsolPulOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayKonsolRondela: TLabel
            Left = 8
            Top = 202
            Width = 46
            Height = 13
            Caption = 'Rondela'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayKonsolRondelaOzellik: TLabel
            Left = 231
            Top = 201
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayKonsolRondelaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinDuvarKonsol: TLabel
            Left = 8
            Top = 224
            Width = 115
            Height = 13
            Caption = 'Kabin Duvar Konsolu'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinDuvarKonsolOzellik: TLabel
            Left = 231
            Top = 223
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinDuvarKonsolOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinRayDubel: TLabel
            Left = 8
            Top = 246
            Width = 32
            Height = 13
            Caption = 'D'#252'bel'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinRayDubelOzellik: TLabel
            Left = 231
            Top = 245
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinRayDubelOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayi: TLabel
            Left = 8
            Top = 273
            Width = 64
            Height = 13
            Caption = 'A'#287#305'rl'#305'k Ray'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayiOzellik: TLabel
            Left = 231
            Top = 274
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayFlans: TLabel
            Left = 8
            Top = 298
            Width = 96
            Height = 13
            Caption = 'A'#287#305'rl'#305'k Ray Flan'#351#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayFlansOzellik: TLabel
            Left = 231
            Top = 297
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayFlansOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayFlansCivataSomun: TLabel
            Left = 8
            Top = 320
            Width = 90
            Height = 13
            Caption = 'Civata + Somun'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayFlansCivataSomunOzellik: TLabel
            Left = 231
            Top = 319
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayFlansCivataSomunOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayFlansPul: TLabel
            Left = 8
            Top = 342
            Width = 17
            Height = 13
            Caption = 'Pul'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayFlansPulOzellik: TLabel
            Left = 231
            Top = 341
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayFlansPulOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayFlansRondela: TLabel
            Left = 8
            Top = 364
            Width = 46
            Height = 13
            Caption = 'Rondela'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayFlansRondelaOzellik: TLabel
            Left = 231
            Top = 363
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayFlansRondelaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayKonsol: TLabel
            Left = 8
            Top = 386
            Width = 108
            Height = 13
            Caption = 'A'#287#305'rl'#305'k Ray Konsolu'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayKonsolOzellik: TLabel
            Left = 231
            Top = 385
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayKonsolOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayKonsolCivataSomun: TLabel
            Left = 8
            Top = 408
            Width = 90
            Height = 13
            Caption = 'Civata + Somun'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayKonsolCivataSomunOzellik: TLabel
            Left = 231
            Top = 407
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayKonsolCivataSomunOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayKonsolPul: TLabel
            Left = 8
            Top = 430
            Width = 17
            Height = 13
            Caption = 'Pul'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayKonsolPulOzellik: TLabel
            Left = 231
            Top = 429
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayKonsolPulOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayKonsolRondela: TLabel
            Left = 8
            Top = 452
            Width = 46
            Height = 13
            Caption = 'Rondela'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayKonsolRondelaOzellik: TLabel
            Left = 231
            Top = 451
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayKonsolRondelaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikDuvarKonsol: TLabel
            Left = 8
            Top = 474
            Width = 120
            Height = 13
            Caption = 'A'#287#305'rl'#305'k Duvar Konsolu'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikDuvarKonsolOzellik: TLabel
            Left = 231
            Top = 473
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikDuvarKonsolOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikRayDubel: TLabel
            Left = 8
            Top = 496
            Width = 32
            Height = 13
            Caption = 'D'#252'bel'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRayDubelOzellik: TLabel
            Left = 231
            Top = 495
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikRayDubelOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelYagdanlik: TLabel
            Left = 8
            Top = 549
            Width = 55
            Height = 13
            Caption = 'Ya'#287'danl'#305'k'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelYagdanlikOzellik: TLabel
            Left = 231
            Top = 548
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelYagdanlikOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelYagToplamaKabi: TLabel
            Left = 8
            Top = 572
            Width = 100
            Height = 13
            Caption = 'Ya'#287' Toplama Kab'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelYagToplamaKabiOzellik: TLabel
            Left = 231
            Top = 571
            Width = 240
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelYagToplamaKabiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKabinRayiKod: TEdit
            Left = 119
            Top = 21
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditKabinRayiAdet: TEdit
            Left = 200
            Top = 21
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditKabinRayFlansKod: TEdit
            Left = 119
            Top = 43
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditKabinRayFlansAdet: TEdit
            Left = 200
            Top = 43
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditKabinRayFlansCivataSomunKod: TEdit
            Left = 119
            Top = 65
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditKabinRayFlansCivataSomunAdet: TEdit
            Left = 200
            Top = 65
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditKabinRayFlansPulKod: TEdit
            Left = 119
            Top = 87
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditKabinRayFlansPulAdet: TEdit
            Left = 200
            Top = 87
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditKabinRayFlansRondelaKod: TEdit
            Left = 119
            Top = 109
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditKabinRayFlansRondelaAdet: TEdit
            Left = 200
            Top = 109
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object EditKabinRayKonsolKod: TEdit
            Left = 119
            Top = 131
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object EditKabinRayKonsolAdet: TEdit
            Left = 200
            Top = 131
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditKabinRayKonsolCivataSomunKod: TEdit
            Left = 119
            Top = 153
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object EditKabinRayKonsolCivataSomunAdet: TEdit
            Left = 200
            Top = 153
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
          object EditKabinRayKonsolPulKod: TEdit
            Left = 119
            Top = 175
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditKabinRayKonsolPulAdet: TEdit
            Left = 200
            Top = 175
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
          object EditKabinRayKonsolRondelaKod: TEdit
            Left = 119
            Top = 197
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditKabinRayKonsolRondelaAdet: TEdit
            Left = 200
            Top = 197
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object EditKabinDuvarKonsolKod: TEdit
            Left = 119
            Top = 219
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
          end
          object EditKabinDuvarKonsolAdet: TEdit
            Left = 200
            Top = 219
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 19
          end
          object EditKabinRayDubelKod: TEdit
            Left = 119
            Top = 241
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 20
          end
          object EditKabinRayDubelAdet: TEdit
            Left = 200
            Top = 241
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 21
          end
          object EditAgirlikRayiKod: TEdit
            Left = 119
            Top = 270
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 22
          end
          object EditAgirlikRayiAdet: TEdit
            Left = 200
            Top = 270
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 23
          end
          object EditAgirlikRayFlansKod: TEdit
            Left = 119
            Top = 293
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 24
          end
          object EditAgirlikRayFlansAdet: TEdit
            Left = 200
            Top = 293
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 25
          end
          object EditAgirlikRayFlansCivataSomunKod: TEdit
            Left = 119
            Top = 315
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 26
          end
          object EditAgirlikRayFlansCivataSomunAdet: TEdit
            Left = 200
            Top = 315
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 27
          end
          object EditAgirlikRayFlansPulKod: TEdit
            Left = 119
            Top = 337
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 28
          end
          object EditAgirlikRayFlansPulAdet: TEdit
            Left = 200
            Top = 337
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 29
          end
          object EditAgirlikRayFlansRondelaKod: TEdit
            Left = 119
            Top = 359
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 30
          end
          object EditAgirlikRayFlansRondelaAdet: TEdit
            Left = 200
            Top = 359
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 31
          end
          object EditAgirlikRayKonsolKod: TEdit
            Left = 119
            Top = 381
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 32
          end
          object EditAgirlikRayKonsolAdet: TEdit
            Left = 200
            Top = 381
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 33
          end
          object EditAgirlikRayKonsolCivataSomunKod: TEdit
            Left = 119
            Top = 403
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 34
          end
          object EditAgirlikRayKonsolCivataSomunAdet: TEdit
            Left = 200
            Top = 403
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 35
          end
          object EditAgirlikRayKonsolPulKod: TEdit
            Left = 119
            Top = 425
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 36
          end
          object EditAgirlikRayKonsolPulAdet: TEdit
            Left = 200
            Top = 425
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 37
          end
          object EditAgirlikRayKonsolRondelaKod: TEdit
            Left = 119
            Top = 447
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 38
          end
          object EditAgirlikRayKonsolRondelaAdet: TEdit
            Left = 200
            Top = 447
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 39
          end
          object EditAgirlikDuvarKonsolKod: TEdit
            Left = 119
            Top = 469
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 40
          end
          object EditAgirlikDuvarKonsolAdet: TEdit
            Left = 200
            Top = 469
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 41
          end
          object EditAgirlikRayDubelKod: TEdit
            Left = 119
            Top = 491
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 42
          end
          object EditAgirlikRayDubelAdet: TEdit
            Left = 200
            Top = 491
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 43
          end
          object EditYagdanlikKod: TEdit
            Left = 119
            Top = 544
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 44
          end
          object EditYagdanlikAdet: TEdit
            Left = 200
            Top = 544
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 45
          end
          object EditYagToplamaKabiKod: TEdit
            Left = 119
            Top = 567
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 46
          end
          object EditYagToplamaKabiAdet: TEdit
            Left = 200
            Top = 567
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 47
          end
        end
        object btnRayHesapla: TBitBtn
          Left = 58
          Top = 111
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 4
        end
        object ComboBoxRayRayMarkasi: TComboBox
          Left = 91
          Top = 16
          Width = 97
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object ComboBoxRayAgirlikKonumu: TComboBox
          Left = 91
          Top = 39
          Width = 97
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
        object EditRayRayArasi: TEdit
          Left = 91
          Top = 62
          Width = 97
          Height = 21
          TabOrder = 3
        end
      end
      object TabSheetPQ: TTabSheet
        Caption = 'P&&Q'
        ImageIndex = 10
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelFrenMarkasi: TLabel
          Left = 8
          Top = 19
          Width = 73
          Height = 13
          Caption = 'Fren Markas'#305
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelFrenTuru: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 13
          Caption = 'Fren T'#252'r'#252
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelAgirlikTuru: TLabel
          Left = 8
          Top = 65
          Width = 65
          Height = 13
          Caption = 'A'#287#305'rl'#305'k T'#252'r'#252
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelAgirlikSaseDuzeni: TLabel
          Left = 8
          Top = 88
          Width = 107
          Height = 13
          Caption = 'A'#287#305'rl'#305'k '#350'ase D'#252'zeni'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 8
          Top = 136
          Width = 115
          Height = 13
          Caption = 'Kabin Toplam A'#287#305'rl'#305'k'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueKabinToplamAgirlik: TLabel
          Left = 152
          Top = 136
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 8
          Top = 152
          Width = 113
          Height = 13
          Caption = 'Asans'#246'r Anma Y'#252'k'#252
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueAsansorAnmaYuku: TLabel
          Left = 152
          Top = 152
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 8
          Top = 168
          Width = 136
          Height = 13
          Caption = 'Hesaplanan Kar'#351#305' A'#287#305'rl'#305'k'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueHesaplananKarsiAgirlik: TLabel
          Left = 152
          Top = 168
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 8
          Top = 184
          Width = 106
          Height = 13
          Caption = 'Kullan'#305'lacak A'#287#305'rl'#305'k'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueKullanilacakAgirlik: TLabel
          Left = 152
          Top = 184
          Width = 113
          Height = 13
          Caption = 'LabelValueTahrikSistemi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ComboBoxFrenMarkasi: TComboBox
          Left = 122
          Top = 15
          Width = 114
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            'TEK SIRA'
            #199#304'FT SIRA')
        end
        object ComboBoxFrenTuru: TComboBox
          Left = 122
          Top = 38
          Width = 114
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Items.Strings = (
            'TEK SIRA'
            #199#304'FT SIRA')
        end
        object ComboBoxAgirlikTuru: TComboBox
          Left = 122
          Top = 61
          Width = 114
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Items.Strings = (
            'TEK SIRA'
            #199#304'FT SIRA')
        end
        object GroupBoxPQ: TGroupBox
          Left = 240
          Top = 296
          Width = 435
          Height = 145
          Caption = 'P+Q'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object LabelPQBaslikKod: TLabel
            Left = 113
            Top = 8
            Width = 72
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelPQBaslikOzellik: TLabel
            Left = 217
            Top = 8
            Width = 208
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelPQBaslikAdet: TLabel
            Left = 187
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelFren: TLabel
            Left = 4
            Top = 120
            Width = 25
            Height = 13
            Caption = 'Fren'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelFrenOzellik: TLabel
            Left = 219
            Top = 120
            Width = 208
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelFrenOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinAltiTampon: TLabel
            Left = 4
            Top = 74
            Width = 102
            Height = 13
            Caption = 'Kabin Alt'#305' Tampon'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinAltiTamponOzellik: TLabel
            Left = 219
            Top = 74
            Width = 208
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinAltiTamponOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikAltiTampon: TLabel
            Left = 4
            Top = 97
            Width = 107
            Height = 13
            Caption = 'A'#287#305'rl'#305'k Alt'#305' Tampon'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikAltiTamponOzellik: TLabel
            Left = 219
            Top = 97
            Width = 208
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikAltiTamponOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlikSasesi: TLabel
            Left = 4
            Top = 28
            Width = 54
            Height = 13
            Caption = 'A'#287'.'#350'asesi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikSasesiOzellik: TLabel
            Left = 219
            Top = 28
            Width = 208
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikSasesiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAgirlik: TLabel
            Left = 4
            Top = 51
            Width = 36
            Height = 13
            Caption = 'A'#287#305'rl'#305'k'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikOzellik: TLabel
            Left = 219
            Top = 51
            Width = 208
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAgirlikOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditFrenKod: TEdit
            Left = 113
            Top = 116
            Width = 72
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditFrenAdet: TEdit
            Left = 186
            Top = 116
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditKabinAltiTamponKod: TEdit
            Left = 113
            Top = 70
            Width = 72
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditKabinAltiTamponAdet: TEdit
            Left = 186
            Top = 70
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditAgirlikAltiTamponKod: TEdit
            Left = 113
            Top = 93
            Width = 72
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditAgirlikAltiTamponAdet: TEdit
            Left = 186
            Top = 93
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditAgirlikSasesiKod: TEdit
            Left = 113
            Top = 24
            Width = 72
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditAgirlikSasesiAdet: TEdit
            Left = 186
            Top = 24
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditAgirlikKod: TEdit
            Left = 113
            Top = 47
            Width = 72
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditAgirlikAdet: TEdit
            Left = 186
            Top = 47
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
        end
        object ComboBoxAgirlikSaseDuzeni: TComboBox
          Left = 122
          Top = 84
          Width = 114
          Height = 21
          Style = csDropDownList
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Items.Strings = (
            'TEK SIRA'
            #199#304'FT SIRA')
        end
        object btnPQHesapla: TBitBtn
          Left = 545
          Top = 540
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 5
        end
        object GroupBoxPQAgirlik: TGroupBox
          Left = 240
          Top = 8
          Width = 433
          Height = 249
          Caption = 'A'#287#305'rl'#305'k'
          TabOrder = 6
          object LabelAgirlikKabin: TLabel
            Left = 28
            Top = 51
            Width = 31
            Height = 13
            Caption = 'Kabin'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikAgirlikHesabi: TLabel
            Left = 156
            Top = 8
            Width = 130
            Height = 24
            Caption = 'A'#287#305'rl'#305'k Hesab'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikTaban: TLabel
            Left = 28
            Top = 74
            Width = 35
            Height = 13
            Caption = 'Taban'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikTavan: TLabel
            Left = 28
            Top = 97
            Width = 35
            Height = 13
            Caption = 'Tavan'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikSuspansiyon: TLabel
            Left = 28
            Top = 120
            Width = 71
            Height = 13
            Caption = 'S'#252'spansiyon'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikKabinKapisi: TLabel
            Left = 28
            Top = 143
            Width = 67
            Height = 13
            Caption = 'Kabin Kap'#305's'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikRevizyonKutusu: TLabel
            Left = 28
            Top = 166
            Width = 94
            Height = 13
            Caption = 'Revizyon Kutusu'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikKabinKaseti: TLabel
            Left = 28
            Top = 189
            Width = 69
            Height = 13
            Caption = 'Kabin Kaseti'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAgirlikFotosel: TLabel
            Left = 28
            Top = 213
            Width = 41
            Height = 13
            Caption = 'Fotosel'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikKayitli: TLabel
            Left = 141
            Top = 32
            Width = 35
            Height = 13
            Alignment = taCenter
            Caption = 'Kay'#305'tl'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikVerilen: TLabel
            Left = 237
            Top = 32
            Width = 39
            Height = 13
            Alignment = taCenter
            Caption = 'Verilen'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelBaslikAgirlikKg: TLabel
            Left = 315
            Top = 32
            Width = 63
            Height = 13
            Alignment = taCenter
            Caption = 'A'#287#305'rl'#305'k (kg)'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditAgirlikKabinKayitli: TEdit
            Left = 127
            Top = 47
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditAgirlikTabanKayitli: TEdit
            Left = 127
            Top = 70
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object EditAgirlikTavanKayitli: TEdit
            Left = 127
            Top = 93
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditAgirlikSuspansiyonKayitli: TEdit
            Left = 127
            Top = 116
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object EditAgirlikKabinKapisiKayitli: TEdit
            Left = 127
            Top = 139
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditAgirlikRevizyonKutusuKayitli: TEdit
            Left = 127
            Top = 162
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object EditAgirlikKabinKasetiKayitli: TEdit
            Left = 127
            Top = 185
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditAgirlikFotoselKayitli: TEdit
            Left = 127
            Top = 208
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
          end
          object EditAgirlikKabinVerilen: TEdit
            Left = 223
            Top = 47
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 8
          end
          object EditAgirlikTabanVerilen: TEdit
            Left = 223
            Top = 70
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 9
          end
          object EditAgirlikTavanVerilen: TEdit
            Left = 223
            Top = 93
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 10
          end
          object EditAgirlikSuspansiyonVerilen: TEdit
            Left = 223
            Top = 116
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 11
          end
          object EditAgirlikKabinKapisiVerilen: TEdit
            Left = 223
            Top = 139
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 12
          end
          object EditAgirlikRevizyonKutusuVerilen: TEdit
            Left = 223
            Top = 162
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 13
          end
          object EditAgirlikKabinKasetiVerilen: TEdit
            Left = 223
            Top = 185
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 14
          end
          object EditAgirlikFotoselVerilen: TEdit
            Left = 223
            Top = 208
            Width = 68
            Height = 21
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            TabOrder = 15
          end
          object EditAgirlikKabin: TEdit
            Left = 311
            Top = 47
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditAgirlikTaban: TEdit
            Left = 311
            Top = 70
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 17
          end
          object EditAgirlikTavan: TEdit
            Left = 311
            Top = 93
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
          end
          object EditAgirlikSuspansiyon: TEdit
            Left = 311
            Top = 116
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 19
          end
          object EditAgirlikKabinKapisi: TEdit
            Left = 311
            Top = 139
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 20
          end
          object EditAgirlikRevizyonKutusu: TEdit
            Left = 311
            Top = 162
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 21
          end
          object EditAgirlikKabinKaseti: TEdit
            Left = 311
            Top = 185
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 22
          end
          object EditAgirlikFotosel: TEdit
            Left = 311
            Top = 208
            Width = 68
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 23
          end
        end
      end
      object TabSheetMekanik: TTabSheet
        Caption = 'MEKAN'#304'K'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 685
        ExplicitHeight = 597
        object GroupBoxMekanikIlaveler: TGroupBox
          Left = 8
          Top = 320
          Width = 489
          Height = 129
          Caption = 'Mekanik '#304'laveler'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object LabelMekanikIlave2: TLabel
            Left = 8
            Top = 57
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 2'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikIlave3: TLabel
            Left = 8
            Top = 81
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 3'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikIlave1: TLabel
            Left = 8
            Top = 33
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 1'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikIlave1Ozellik: TLabel
            Left = 173
            Top = 33
            Width = 304
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelMekanikIlave1Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelMekanikIlave3Ozellik: TLabel
            Left = 173
            Top = 81
            Width = 304
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelMekanikIlave3Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelMekanikIlave2Ozellik: TLabel
            Left = 173
            Top = 57
            Width = 304
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelMekanikIlave2Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelMekanikIlave4: TLabel
            Left = 8
            Top = 105
            Width = 39
            Height = 13
            Hint = 'BASLIK'
            Caption = #304'lave 4'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikIlave4Ozellik: TLabel
            Left = 173
            Top = 105
            Width = 304
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelMekanikIlave4Ozellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelMekanikIlaveKodBaslik: TLabel
            Left = 59
            Top = 16
            Width = 78
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikIlaveAdetBaslik: TLabel
            Left = 141
            Top = 16
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikIlaveOzellikBaslik: TLabel
            Left = 173
            Top = 16
            Width = 304
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditMekanikIlave1Kod: TEdit
            Left = 59
            Top = 29
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditMekanikIlave1Adet: TEdit
            Left = 140
            Top = 29
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditMekanikIlave2Kod: TEdit
            Left = 59
            Top = 53
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditMekanikIlave2Adet: TEdit
            Left = 140
            Top = 53
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditMekanikIlave3Kod: TEdit
            Left = 59
            Top = 77
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditMekanikIlave3Adet: TEdit
            Left = 140
            Top = 77
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditMekanikIlave4Kod: TEdit
            Left = 59
            Top = 101
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            AutoSize = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditMekanikIlave4Adet: TEdit
            Left = 140
            Top = 101
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
        end
        object GroupBoxMekanik: TGroupBox
          Left = 8
          Top = 8
          Width = 489
          Height = 281
          Caption = 'Mekanik'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object LabelMekanikKodBaslik: TLabel
            Left = 119
            Top = 8
            Width = 80
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'KOD'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikAdetBaslik: TLabel
            Left = 201
            Top = 8
            Width = 30
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelMekanikOzellikBaslik: TLabel
            Left = 231
            Top = 8
            Width = 248
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = #214'ZELL'#304'K'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKesiciBayrak: TLabel
            Left = 8
            Top = 30
            Width = 75
            Height = 13
            Caption = 'Kesici Bayrak'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKesiciBayrakOzellik: TLabel
            Left = 235
            Top = 31
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKesiciBayrakOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKuyuDibiMerdiven: TLabel
            Left = 8
            Top = 53
            Width = 108
            Height = 13
            Caption = 'Kuyu Dibi Merdiven'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKuyuDibiMerdivenOzellik: TLabel
            Left = 235
            Top = 54
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKuyuDibiMerdivenOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabinSandigi: TLabel
            Left = 8
            Top = 76
            Width = 75
            Height = 13
            Caption = 'Kabin Sand'#305#287#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabinSandigiOzellik: TLabel
            Left = 235
            Top = 77
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabinSandigiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelPaletAmbalajlama: TLabel
            Left = 8
            Top = 99
            Width = 107
            Height = 13
            Caption = 'Palet Ambalajlama'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelPaletAmbalajlamaOzellik: TLabel
            Left = 235
            Top = 100
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelPaletAmbalajlamaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelKabloKanali: TLabel
            Left = 8
            Top = 122
            Width = 68
            Height = 13
            Caption = 'Kablo Kanal'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelKabloKanaliOzellik: TLabel
            Left = 235
            Top = 123
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelKabloKanaliOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label19x30AgacVidasi: TLabel
            Left = 8
            Top = 145
            Width = 102
            Height = 13
            Caption = '19x30 A'#287'a'#231' Vidas'#305
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label19x30AgacVidasiOzellik: TLabel
            Left = 235
            Top = 146
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'Label19x30AgacVidasiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelPlastikDubel7mm: TLabel
            Left = 8
            Top = 168
            Width = 105
            Height = 13
            Caption = 'Plastik D'#252'bel 7mm'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelPlastikDubel7mmOzellik: TLabel
            Left = 235
            Top = 169
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelPlastikDubel7mmOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelXKisilikEtiket: TLabel
            Left = 8
            Top = 191
            Width = 78
            Height = 13
            Caption = 'x Ki'#351'ilik Etiket'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelXKisilikEtiketOzellik: TLabel
            Left = 235
            Top = 192
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelXKisilikEtiketOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelHalatEtiketi: TLabel
            Left = 8
            Top = 214
            Width = 69
            Height = 13
            Caption = 'Halat Etiketi'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelHalatEtiketiOzellik: TLabel
            Left = 235
            Top = 215
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelHalatEtiketiOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelAsKuyusundaCalisma: TLabel
            Left = 8
            Top = 237
            Width = 126
            Height = 13
            Caption = 'As.Kuyusunda '#199'al'#305#351'ma'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelAsKuyusundaCalismaOzellik: TLabel
            Left = 235
            Top = 238
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelAsKuyusundaCalismaOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelTahrigeOzelEtiket: TLabel
            Left = 8
            Top = 260
            Width = 106
            Height = 13
            Caption = 'Tahri'#287'e '#214'zel Etiket'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelTahrigeOzelEtiketOzellik: TLabel
            Left = 235
            Top = 261
            Width = 248
            Height = 13
            Hint = 'MALADI'
            AutoSize = False
            Caption = 'LabelTahrigeOzelEtiketOzellik'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EditKesiciBayrakKod: TEdit
            Left = 119
            Top = 27
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EditKesiciBayrakAdet: TEdit
            Left = 200
            Top = 27
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
          end
          object EditKuyuDibiMerdivenKod: TEdit
            Left = 119
            Top = 50
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditKuyuDibiMerdivenAdet: TEdit
            Left = 200
            Top = 50
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
          object EditKabinSandigiKod: TEdit
            Left = 119
            Top = 73
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditKabinSandigiAdet: TEdit
            Left = 200
            Top = 73
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
          end
          object EditPaletAmbalajlamaKod: TEdit
            Left = 119
            Top = 96
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object EditPaletAmbalajlamaAdet: TEdit
            Left = 200
            Top = 96
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
          end
          object EditKabloKanaliKod: TEdit
            Left = 119
            Top = 119
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object EditKabloKanaliAdet: TEdit
            Left = 200
            Top = 119
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 9
          end
          object Edit19x30AgacVidasiKod: TEdit
            Left = 119
            Top = 142
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object Edit19x30AgacVidasiAdet: TEdit
            Left = 200
            Top = 142
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 11
          end
          object EditPlastikDubel7mmKod: TEdit
            Left = 119
            Top = 165
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object EditPlastikDubel7mmAdet: TEdit
            Left = 200
            Top = 165
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 13
          end
          object EditXKisilikEtiketKod: TEdit
            Left = 119
            Top = 188
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object EditXKisilikEtiketAdet: TEdit
            Left = 200
            Top = 188
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 15
          end
          object EditHalatEtiketiKod: TEdit
            Left = 119
            Top = 211
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object EditHalatEtiketiAdet: TEdit
            Left = 200
            Top = 211
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 17
          end
          object EditAsKuyusundaCalismaKod: TEdit
            Left = 119
            Top = 234
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
          end
          object EditAsKuyusundaCalismaAdet: TEdit
            Left = 200
            Top = 234
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 19
          end
          object EditTahrigeOzelEtiketKod: TEdit
            Left = 119
            Top = 257
            Width = 80
            Height = 21
            Hint = 'MALKODU'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 16
            ParentFont = False
            ReadOnly = True
            TabOrder = 20
          end
          object EditTahrigeOzelEtiketAdet: TEdit
            Left = 200
            Top = 257
            Width = 30
            Height = 21
            Hint = 'ADET'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 21
          end
        end
        object btnMekanikHesapla: TBitBtn
          Left = 367
          Top = 511
          Width = 130
          Height = 36
          Caption = 'HESAPLA'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Glyph.Data = {
            A6070000424DA6070000000000003600000028000000160000001C0000000100
            18000000000070070000120B0000120B00000000000000000000ACACAC6B6B6B
            7070707070707070707070707070706E6E6E6F6F6F7070707070707070706F6F
            6F6E6E6E6E70706F71716F70716F71716E70706F6F6F6B6B6BB8B8B800006868
            68CDCDCDE2E2E2DADADADBDBDBDADADADCDCDCDEDEDEDDDDDDDBDBDBDBDBDBDA
            DADADBDBDBDDDDDDDCDCDBDCDADADCDAD9DCDAD9DCDBDBE5E5E5C2C2C26B6B6B
            0000777777E9E9E9C9C9C9AAAAAAB0B0B0AEAEAEB3B3B3DFDFDFBDBDBDADADAD
            B1B1B1ACACACBABABBE6E5E5D5B6A5CDA28DCDA591CBA089D2B19FEDE9E8DFE1
            E37070700000767676E1E1E1B0B0B08B8B8B949494919191959595D1D1D1A0A0
            A08F8F8F9494948E8E8E9B9D9EDBD9D8C6957CBC8062BD8467BB7C5DC18E73E5
            DEDADADDDE7171710000767676E2E2E2B1B1B18B8B8B949494929292959595D2
            D2D2A2A2A28F8F8F9494948F8F8F9E9F9FDDDBDAC89C84BF896DC08B72BE8669
            C4957CE6DFDBD9DCDE7171710000757575E2E2E2D4D4D4C0C0C0C3C3C3C2C2C2
            C6C6C6E1E1E1CDCDCDC1C1C1C3C3C3C1C1C1CCCDCEE2E0DFC69983BF886CC08B
            71BE8568C4957CE6DFDBD9DCDE7171710000757575E2E2E2D0D0D0B7B7B7BABA
            BABABABABFBFBFE0E0E0C6C6C6B7B7B7BABABAB7B7B7C4C5C6E2E0DFC69983BF
            886CC08B71BE8568C4957CE6DFDBD9DCDE7171710000767676E1E1E1B2B2B28F
            8F8F969696959595989898D2D2D2A4A4A49292929797979292929FA1A1DCDAD9
            C89A83BF876BC08A70BE8467C4947BE6DFDBD9DDDE7171710000767676E2E2E2
            B2B2B28C8C8C949494939393979797D2D2D2A3A3A39090909595959090909E9F
            A0DCDAD9C6987EBD8365BE876ABC8061C29077E6DFDBDADDDE71717100007575
            75E2E2E2C9C9C9AFAFAFB4B4B4B3B3B3B7B7B7DCDCDCC0C0C0B1B1B1B4B4B4B1
            B1B1BCBCBEE2E2E1E3C1AADFB296DFB499DEB094E0BCA5EAE7E4D8DADB717171
            0000747474E2E2E2DBDBDBCACACACCCCCCCCCCCCCFCFCFE3E3E3D5D5D5CACACA
            CCCCCCCACACAD4D3D3E7E6E5ADCEF390C0F694C2F68DBFF7A8CCF2E7E9EDDBD9
            D77171710000767676E2E2E2B7B7B79494949B9B9B9B9B9B9D9D9DD4D4D4AAAA
            AA9797979C9C9C979797A9A7A4D9DDDF2E8FFE0077FF037AFF0073FF2788FBD0
            DFEFE3DDD67071710000767676E1E1E1B1B1B18E8E8E959595949494969696D1
            D1D1A3A3A3919191969696919191A3A09DD4D9DD2189FF0073FF0077FF006FFF
            1D81FCCADCEFE5DED67071710000767676E2E2E2BBBBBB999999A0A0A09F9F9F
            A3A3A3D7D7D7AEAEAE9C9C9CA1A1A19B9B9BADACAADCDEE04097FC1080FF1883
            FF0B7CFF3791FAD6E1EEE2DDD67071710000747474E2E2E2DFDFDFD0D0D0D1D1
            D1D1D1D1D5D5D5E5E5E5D9D9D9D0D0D0D1D1D1CFCFCFD8D8D8E7E6E5CDD6E1BD
            CCDEBFCDDEBCCBDECBD5E0EBEBEAD9D8D87171710000767676E2E2E2BCBCBC9A
            9A9AA0A0A09F9F9FA3A3A3D7D7D7AFAFAF9C9C9CA1A1A19C9C9CACACACDEDFDF
            B2B0ADA39F9BA4A19DA09D98ADABA7E4E4E3DBDBDB7171710000767676E1E1E1
            B1B1B18D8D8D969696949494969696D0D0D0A2A2A29292929696969191919E9E
            9EDADADAA2A2A29293939495958F90909B9B9DDFDFDFDCDCDC71717100007676
            76E2E2E2B5B5B48F8F8E969796959695999999D3D4D3A6A6A592939297989792
            9292A3A3A2DDDDDBA6A6A6949494969896919291A0A0A0E2E2E1DCDCDC717171
            0000747474E3E3E2E6E3E8DBD7DEDCD9DFDBD8DFDEDBE1F0EEF5E2DFE6DBD8DF
            DCD9E0DAD7DEE2DFE6F3F1F7E3E0E7DBD8DFDCD9E0DAD7DEE2DEE6F1F0F3D9D9
            D87171710000767576E2E2E0BBC5AE97A6839CA98A9CA9899CA88998A5859BA8
            879CA8889BA8889BA88799A78696A38199A78499A78499A78397A58295A480CB
            D2C2DADADC72727200007A797CCCCFC657792C50811961912B5F902A60922C61
            922D6394306596346897396B993E6E9C43709C47739E4C759F4F76A0517BA556
            57822B79925AD3D4D375747600007B797CC5C8BF587E2A7CBC3A91D34F8ED04F
            92D55495D85798DC5B9BE061A0E468A5E872ACEB7CB2F087BAF594C0F99FC5FC
            A9D6FFC096C475769055CFCFCD75757600007B797CC6C9C1597D2B73AF2F85C4
            4384C24387C7478ACA4B8DCD4E90D15293D55596D85999DC5D9DE064A2E36DA8
            E777AEEB82C1FE9B8CC162779058D0CFCF75757600007B797CC6C9C052772264
            9C1B74AE2972AB2973AD2B74AE2C75B02D76B23077B33279B5337AB6347BB835
            7CB9367EBB3880BC3D8AC848639B24728C4FD1D1D175757600007A797CCDD1C9
            5273263A6900477407457207447206447105447105447105437105437004436F
            04426F03426F03426F02426E014270012E5D00789059D6D6D675747500007777
            77E8E8E8BCC6AF96A6839CA9899CAA899CAA899CAA899CAA899CAA899CAA899C
            AA899CAA899CAA899CAA899CAA899CAA899BA9889AA986CED6C6E1E0E2717071
            0000686868CFCECEEAE9EDE4E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7
            E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E7E5E3E6E5E3E8EBEAEDC2C2
            C26B6B6B0000ACACAC6A6A6B6F6F70706F70706F70706F70706F70706F70706F
            70706F70706F70706F70706F70706F70706F70706F70706F70706F70706F706F
            6F6F6B6B6BB7B7B70000}
          Margin = 5
          ParentFont = False
          Spacing = 8
          TabOrder = 2
        end
      end
      object TabSheetFiyat: TTabSheet
        Caption = 'F'#304'YAT'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 685
        ExplicitHeight = 597
        object LabelIskontoOrani: TLabel
          Left = 20
          Top = 6
          Width = 93
          Height = 13
          Alignment = taRightJustify
          Caption = #304'skonto Oran'#305' %'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelParaBirimi: TLabel
          Left = 228
          Top = 6
          Width = 61
          Height = 13
          Alignment = taRightJustify
          Caption = 'Para Birimi'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object StringGridFiyat: TStringGrid
          Left = 4
          Top = 32
          Width = 665
          Height = 489
          ColCount = 6
          DefaultRowHeight = 16
          FixedColor = 14206426
          FixedCols = 0
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
          ParentFont = False
          TabOrder = 2
          ColWidths = (
            64
            64
            64
            64
            64
            64)
          RowHeights = (
            16
            16
            16
            16
            16)
        end
        object EditIskontoOrani: TEdit
          Left = 114
          Top = 3
          Width = 70
          Height = 21
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 0
        end
        object ComboBoxParaBirimi: TComboBox
          Left = 292
          Top = 3
          Width = 73
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 633
    Width = 687
    ExplicitTop = 633
    ExplicitWidth = 687
    inherited btnAccept: TButton
      Left = 478
      ExplicitLeft = 478
    end
    inherited btnDelete: TButton
      Left = 374
      ExplicitLeft = 374
    end
    inherited btnClose: TButton
      Left = 582
      ExplicitLeft = 582
    end
  end
  inherited stbBase: TStatusBar
    Top = 677
    Width = 691
    ExplicitTop = 677
    ExplicitWidth = 691
  end
end
