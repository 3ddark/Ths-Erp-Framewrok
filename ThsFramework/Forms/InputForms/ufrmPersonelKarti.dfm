inherited frmPersonelKarti: TfrmPersonelKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Personel Bilgisi'
  ClientHeight = 686
  ClientWidth = 700
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 706
  ExplicitHeight = 715
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 696
    Height = 620
    Color = clWindow
    ExplicitWidth = 696
    ExplicitHeight = 620
    object pgcPersonel: TPageControl
      Left = 1
      Top = 1
      Width = 694
      Height = 618
      ActivePage = tsGenel
      Align = alClient
      TabOrder = 0
      object tsGenel: TTabSheet
        Caption = 'tsGenel'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelPersonelNo: TLabel
          Left = 76
          Top = 74
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'Personel No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKartNo: TLabel
          Left = 102
          Top = 96
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'Kart No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelIseGirisTarihi: TLabel
          Left = 32
          Top = 206
          Width = 114
          Height = 13
          Alignment = taRightJustify
          Caption = #304#351'e Giri'#351'-'#199#305'k'#305#351' Tarihi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelValueKidem: TLabel
          Left = 152
          Top = 227
          Width = 104
          Height = 21
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2098114
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelKidem: TLabel
          Left = 61
          Top = 228
          Width = 85
          Height = 13
          Alignment = taRightJustify
          Caption = #199'al'#305#351'ma K'#305'demi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelAyrilmaNedeni: TLabel
          Left = 60
          Top = 296
          Width = 85
          Height = 13
          Caption = 'Ayr'#305'lma Nedeni'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelGenelNot: TLabel
          Left = 43
          Top = 371
          Width = 58
          Height = 13
          Caption = 'Genel Not'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelAyrilmaNedeniAciklamasi: TLabel
          Left = 339
          Top = 371
          Width = 149
          Height = 13
          Caption = 'Ayr'#305'lma Nedeni A'#231#305'klamas'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ImagePersonelResim: TImage
          Left = 405
          Top = 3
          Width = 188
          Height = 223
          Stretch = True
        end
        object lblPersonelAd: TLabel
          Left = 77
          Top = 30
          Width = 69
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Personel Ad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPersonelSoyad: TLabel
          Left = 57
          Top = 52
          Width = 89
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Personel Soyad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPersonelTipi: TLabel
          Left = 71
          Top = 118
          Width = 75
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Personel Tipi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblBolum: TLabel
          Left = 111
          Top = 140
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'B'#246'l'#252'm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblBirim: TLabel
          Left = 118
          Top = 162
          Width = 28
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Birim'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGorev: TLabel
          Left = 111
          Top = 184
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'G'#246'rev'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsActive: TLabel
          Left = 112
          Top = 8
          Width = 34
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Aktif?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMailAdresi: TLabel
          Left = 309
          Top = 552
          Width = 83
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'e-Posta Adresi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object MemoGenelNot: TMemo
          Left = 43
          Top = 390
          Width = 278
          Height = 129
          MaxLength = 256
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object MemoAyrilmaNedeniAciklamasi: TMemo
          Left = 339
          Top = 390
          Width = 249
          Height = 129
          MaxLength = 256
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object edtPersonelAd: TEdit
          Left = 152
          Top = 29
          Width = 184
          Height = 21
          TabOrder = 2
        end
        object edtPersonelSoyad: TEdit
          Left = 152
          Top = 51
          Width = 184
          Height = 21
          TabOrder = 3
        end
        object cbbPersonelTipi: TComboBox
          Left = 152
          Top = 117
          Width = 184
          Height = 21
          TabOrder = 4
        end
        object cbbBolum: TComboBox
          Left = 152
          Top = 139
          Width = 184
          Height = 21
          TabOrder = 5
        end
        object cbbBirim: TComboBox
          Left = 152
          Top = 161
          Width = 184
          Height = 21
          TabOrder = 6
        end
        object cbbGorev: TComboBox
          Left = 152
          Top = 183
          Width = 184
          Height = 21
          TabOrder = 7
        end
        object cbbKartNo: TComboBox
          Left = 152
          Top = 95
          Width = 104
          Height = 21
          TabOrder = 8
        end
        object edtPersonelNo: TEdit
          Left = 152
          Top = 73
          Width = 104
          Height = 21
          TabOrder = 9
        end
        object chkIsActive: TCheckBox
          Left = 152
          Top = 7
          Width = 184
          Height = 21
          TabOrder = 10
        end
        object edtMailAdresi: TEdit
          Left = 396
          Top = 549
          Width = 200
          Height = 21
          TabOrder = 11
        end
        object edtIseGirisTarihi: TEdit
          Left = 152
          Top = 205
          Width = 90
          Height = 21
          TabOrder = 12
        end
        object edtIstenCikisTarihi: TEdit
          Left = 246
          Top = 205
          Width = 90
          Height = 21
          TabOrder = 13
        end
        object cbbAyrilmaNedeni: TComboBox
          Left = 152
          Top = 293
          Width = 184
          Height = 21
          TabOrder = 14
        end
      end
      object tsAyrinti: TTabSheet
        Caption = 'tsAyrinti'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelAyakkabiNo: TLabel
          Left = 374
          Top = 183
          Width = 81
          Height = 13
          Caption = 'Ayakkab'#305' No :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelElbiseBedeni: TLabel
          Left = 374
          Top = 206
          Width = 86
          Height = 13
          Caption = 'Elbise Bedeni :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelTCKimlikNo: TLabel
          Left = 374
          Top = 11
          Width = 82
          Height = 13
          Caption = 'TC Kimlik No :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelSemt: TLabel
          Left = 8
          Top = 211
          Width = 37
          Height = 13
          Caption = 'Semt :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelEgitimDurumu: TLabel
          Left = 8
          Top = 260
          Width = 90
          Height = 13
          Caption = 'E'#287'itim Durumu :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelBitirdigiOkul: TLabel
          Left = 8
          Top = 283
          Width = 81
          Height = 13
          Caption = 'Bitirdi'#287'i Okul :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelBitirdigiBolum: TLabel
          Left = 8
          Top = 306
          Width = 89
          Height = 13
          Caption = 'Bitirdi'#287'i B'#246'l'#252'm :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelEgitimDiger: TLabel
          Left = 8
          Top = 329
          Width = 77
          Height = 13
          Caption = 'E'#287'itim Di'#287'er :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelServisNo: TLabel
          Left = 78
          Top = 397
          Width = 66
          Height = 13
          Caption = 'Servis Ad'#305' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTelefon1: TLabel
          Left = 45
          Top = 6
          Width = 55
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Telefon 1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTelefon2: TLabel
          Left = 45
          Top = 29
          Width = 55
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Telefon 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblYakinTelefon: TLabel
          Left = 20
          Top = 74
          Width = 80
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yak'#305'n Telefon'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblYakinAdSoyad: TLabel
          Left = 9
          Top = 51
          Width = 91
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yak'#305'n Ad-Soyad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblEvAdresi: TLabel
          Left = 45
          Top = 152
          Width = 55
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ev Adresi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblDogumTarihi: TLabel
          Left = 398
          Top = 38
          Width = 76
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Do'#287'um Tarihi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblKanGrubu: TLabel
          Left = 413
          Top = 61
          Width = 61
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Kan Grubu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblCinsiyet: TLabel
          Left = 429
          Top = 83
          Width = 45
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Cinsiyet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMedeniDurumu: TLabel
          Left = 385
          Top = 105
          Width = 89
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Medeni Durumu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblAskerlikDurumu: TLabel
          Left = 381
          Top = 325
          Width = 93
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Askerlik Durumu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblCocukSayisi: TLabel
          Left = 400
          Top = 127
          Width = 74
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #199'ocuk Say'#305's'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object EditSemt: TEdit
          Left = 104
          Top = 207
          Width = 142
          Height = 21
          MaxLength = 16
          TabOrder = 0
        end
        object EditBitirdigiOkul: TEdit
          Left = 104
          Top = 280
          Width = 142
          Height = 21
          MaxLength = 128
          TabOrder = 1
        end
        object EditBitirdigiBolum: TEdit
          Left = 104
          Top = 303
          Width = 142
          Height = 21
          MaxLength = 128
          TabOrder = 2
        end
        object EditEgitimDiger: TEdit
          Left = 104
          Top = 326
          Width = 142
          Height = 21
          MaxLength = 32
          TabOrder = 3
        end
        object EditTcKimlikNo: TEdit
          Left = 478
          Top = 8
          Width = 112
          Height = 21
          MaxLength = 11
          TabOrder = 4
        end
        object EditAyakkabiNo: TEdit
          Left = 478
          Top = 179
          Width = 112
          Height = 21
          MaxLength = 2
          TabOrder = 5
        end
        object EditElbiseBedeni: TEdit
          Left = 478
          Top = 202
          Width = 112
          Height = 21
          MaxLength = 4
          TabOrder = 6
        end
        object ComboBoxServisNo: TComboBox
          Left = 182
          Top = 393
          Width = 180
          Height = 21
          Style = csDropDownList
          MaxLength = 32
          TabOrder = 7
        end
        object edtTelefon1: TEdit
          Left = 104
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 8
        end
        object edtTelefon2: TEdit
          Left = 104
          Top = 26
          Width = 200
          Height = 21
          TabOrder = 9
        end
        object edtYakinAdSoyad: TEdit
          Left = 104
          Top = 48
          Width = 200
          Height = 21
          TabOrder = 10
        end
        object edtYakinTelefon: TEdit
          Left = 104
          Top = 71
          Width = 200
          Height = 21
          TabOrder = 11
        end
        object edtEvAdresi: TEdit
          Left = 104
          Top = 149
          Width = 554
          Height = 21
          TabOrder = 12
        end
        object edtDogumTarihi: TEdit
          Left = 478
          Top = 35
          Width = 112
          Height = 21
          TabOrder = 13
        end
        object cbbKanGrubu: TComboBox
          Left = 478
          Top = 58
          Width = 112
          Height = 21
          TabOrder = 14
        end
        object cbbCinsiyet: TComboBox
          Left = 478
          Top = 80
          Width = 112
          Height = 21
          TabOrder = 15
        end
        object cbbMedeniDurumu: TComboBox
          Left = 478
          Top = 102
          Width = 112
          Height = 21
          TabOrder = 16
        end
        object cbbAskerlikDurumu: TComboBox
          Left = 478
          Top = 322
          Width = 200
          Height = 21
          TabOrder = 17
        end
        object edtCocukSayisi: TEdit
          Left = 478
          Top = 124
          Width = 200
          Height = 21
          TabOrder = 18
        end
        object cbbEgitimDurumu: TComboBox
          Left = 104
          Top = 257
          Width = 200
          Height = 21
          TabOrder = 19
        end
      end
      object tsOzel: TTabSheet
        Caption = 'tsOzel'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object LabelBrutMaas: TLabel
          Left = 8
          Top = 11
          Width = 66
          Height = 13
          Caption = 'Br'#252't Maa'#351' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelOzelNot: TLabel
          Left = 8
          Top = 80
          Width = 58
          Height = 13
          Caption = #214'zel Not :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelIkramiyeSayisi: TLabel
          Left = 8
          Top = 34
          Width = 93
          Height = 13
          Caption = #304'kramiye Say'#305's'#305' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelIkramiyeMiktar: TLabel
          Left = 8
          Top = 57
          Width = 95
          Height = 13
          Caption = #304'kramiye Miktar :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EditBrutMaas: TEdit
          Left = 109
          Top = 8
          Width = 200
          Height = 21
          MaxLength = 10
          TabOrder = 0
        end
        object EditIkramiyeSayisi: TEdit
          Left = 109
          Top = 31
          Width = 200
          Height = 21
          MaxLength = 16
          TabOrder = 1
        end
        object EditIkramiyeMiktar: TEdit
          Left = 109
          Top = 54
          Width = 200
          Height = 21
          MaxLength = 16
          TabOrder = 2
        end
        object MemoOzelNot: TMemo
          Left = 8
          Top = 99
          Width = 301
          Height = 150
          MaxLength = 256
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 624
    Width = 696
    ExplicitTop = 624
    ExplicitWidth = 696
    inherited btnAccept: TButton
      Left = 487
      ExplicitLeft = 487
    end
    inherited btnDelete: TButton
      Left = 383
      ExplicitLeft = 383
    end
    inherited btnClose: TButton
      Left = 591
      ExplicitLeft = 591
    end
  end
  inherited stbBase: TStatusBar
    Top = 668
    Width = 700
    ExplicitTop = 668
    ExplicitWidth = 700
  end
  inherited pmLabels: TPopupMenu
    Left = 280
    Top = 456
  end
end
