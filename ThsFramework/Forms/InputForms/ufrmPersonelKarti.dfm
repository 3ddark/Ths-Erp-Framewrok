inherited frmPersonelKarti: TfrmPersonelKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Personel Bilgisi'
  ClientHeight = 403
  ClientWidth = 608
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 614
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 604
    Height = 337
    Color = clWindow
    ExplicitWidth = 604
    ExplicitHeight = 337
    object pgcPersonel: TPageControl
      Left = 1
      Top = 1
      Width = 602
      Height = 335
      ActivePage = tsAyrinti
      Align = alClient
      TabOrder = 0
      object tsGenel: TTabSheet
        Caption = 'tsGenel'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblGenelNot: TLabel
          Left = 88
          Top = 164
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Genel Not'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPersonelAd: TLabel
          Left = 77
          Top = 32
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
          Top = 54
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
          Top = 76
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
          Top = 98
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
          Top = 120
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
          Top = 142
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
          Top = 10
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
        object imgPersonelResim: TImage
          Left = 405
          Top = 3
          Width = 188
          Height = 220
          Stretch = True
        end
        object chkIsActive: TCheckBox
          Left = 152
          Top = 7
          Width = 184
          Height = 21
          TabOrder = 0
        end
        object edtPersonelAd: TEdit
          Left = 152
          Top = 29
          Width = 184
          Height = 21
          TabOrder = 1
        end
        object edtPersonelSoyad: TEdit
          Left = 152
          Top = 51
          Width = 184
          Height = 21
          TabOrder = 2
        end
        object cbbPersonelTipi: TComboBox
          Left = 152
          Top = 73
          Width = 184
          Height = 21
          TabOrder = 3
        end
        object cbbBolum: TComboBox
          Left = 152
          Top = 95
          Width = 184
          Height = 21
          TabOrder = 4
          OnChange = cbbBolumChange
        end
        object cbbBirim: TComboBox
          Left = 152
          Top = 117
          Width = 184
          Height = 21
          TabOrder = 5
        end
        object cbbGorev: TComboBox
          Left = 152
          Top = 139
          Width = 184
          Height = 21
          TabOrder = 6
        end
        object mmoGenelNot: TMemo
          Left = 152
          Top = 161
          Width = 247
          Height = 144
          MaxLength = 256
          ScrollBars = ssVertical
          TabOrder = 7
        end
      end
      object tsAyrinti: TTabSheet
        Caption = 'tsAyrinti'
        ImageIndex = 1
        object lblTelefon1: TLabel
          Left = 57
          Top = 10
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
          Left = 57
          Top = 32
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
          Left = 32
          Top = 98
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
          Left = 21
          Top = 76
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
          Left = 57
          Top = 143
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
        object lblMailAdresi: TLabel
          Left = 29
          Top = 54
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
        object lblAyakkabiNo: TLabel
          Left = 346
          Top = 165
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ayakkab'#305' No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblElbiseBedeni: TLabel
          Left = 341
          Top = 187
          Width = 78
          Height = 13
          Alignment = taRightJustify
          Caption = 'Elbise Bedeni'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTCKimlikNo: TLabel
          Left = 345
          Top = 10
          Width = 74
          Height = 13
          Alignment = taRightJustify
          Caption = 'TC Kimlik No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblServisAdi: TLabel
          Left = 361
          Top = 230
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Servis Ad'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblDogumTarihi: TLabel
          Left = 343
          Top = 32
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
          Left = 358
          Top = 54
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
          Left = 374
          Top = 76
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
          Left = 330
          Top = 98
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
          Left = 326
          Top = 208
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
          Left = 345
          Top = 120
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
        object edtTelefon1: TEdit
          Left = 113
          Top = 7
          Width = 170
          Height = 21
          TabOrder = 0
        end
        object edtTelefon2: TEdit
          Left = 113
          Top = 29
          Width = 170
          Height = 21
          TabOrder = 1
        end
        object edtMailAdresi: TEdit
          Left = 113
          Top = 51
          Width = 170
          Height = 21
          TabOrder = 2
        end
        object edtYakinAdSoyad: TEdit
          Left = 113
          Top = 73
          Width = 170
          Height = 21
          TabOrder = 3
        end
        object edtYakinTelefon: TEdit
          Left = 113
          Top = 95
          Width = 170
          Height = 21
          TabOrder = 4
        end
        object edtEvAdresi: TEdit
          Left = 113
          Top = 139
          Width = 478
          Height = 21
          TabOrder = 5
        end
        object edtTcKimlikNo: TEdit
          Left = 421
          Top = 7
          Width = 170
          Height = 21
          MaxLength = 11
          TabOrder = 6
        end
        object edtDogumTarihi: TEdit
          Left = 421
          Top = 29
          Width = 170
          Height = 21
          TabOrder = 7
        end
        object cbbKanGrubu: TComboBox
          Left = 421
          Top = 51
          Width = 170
          Height = 21
          TabOrder = 8
        end
        object cbbCinsiyet: TComboBox
          Left = 421
          Top = 73
          Width = 170
          Height = 21
          TabOrder = 9
        end
        object cbbMedeniDurumu: TComboBox
          Left = 421
          Top = 95
          Width = 170
          Height = 21
          TabOrder = 10
        end
        object edtCocukSayisi: TEdit
          Left = 421
          Top = 117
          Width = 170
          Height = 21
          TabOrder = 11
        end
        object edtAyakkabiNo: TEdit
          Left = 421
          Top = 161
          Width = 169
          Height = 21
          MaxLength = 2
          TabOrder = 12
        end
        object edtElbiseBedeni: TEdit
          Left = 421
          Top = 183
          Width = 169
          Height = 21
          MaxLength = 4
          TabOrder = 13
        end
        object cbbAskerlikDurumu: TComboBox
          Left = 421
          Top = 205
          Width = 170
          Height = 21
          TabOrder = 14
        end
        object cbbServisAdi: TComboBox
          Left = 421
          Top = 227
          Width = 170
          Height = 21
          Style = csDropDownList
          MaxLength = 32
          TabOrder = 15
        end
      end
      object tsOzel: TTabSheet
        Caption = 'tsOzel'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblBrutMaas: TLabel
          Left = 50
          Top = 11
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Br'#252't Maa'#351
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblOzelNot: TLabel
          Left = 58
          Top = 80
          Width = 50
          Height = 13
          Alignment = taRightJustify
          Caption = #214'zel Not'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIkramiyeSayisi: TLabel
          Left = 23
          Top = 34
          Width = 85
          Height = 13
          Alignment = taRightJustify
          Caption = #304'kramiye Say'#305's'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIkramiyeMiktar: TLabel
          Left = 21
          Top = 57
          Width = 87
          Height = 13
          Alignment = taRightJustify
          Caption = #304'kramiye Miktar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtBrutMaas: TEdit
          Left = 109
          Top = 8
          Width = 200
          Height = 21
          MaxLength = 10
          TabOrder = 0
        end
        object edtIkramiyeSayisi: TEdit
          Left = 109
          Top = 31
          Width = 200
          Height = 21
          MaxLength = 16
          TabOrder = 1
        end
        object edtIkramiyeMiktar: TEdit
          Left = 109
          Top = 54
          Width = 200
          Height = 21
          MaxLength = 16
          TabOrder = 2
        end
        object mmoOzelNot: TMemo
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
    Top = 341
    Width = 604
    ExplicitTop = 341
    ExplicitWidth = 604
    inherited btnAccept: TButton
      Left = 395
      ExplicitLeft = 395
    end
    inherited btnDelete: TButton
      Left = 25
      ExplicitLeft = 25
    end
    inherited btnClose: TButton
      Left = 499
      ExplicitLeft = 499
    end
  end
  inherited stbBase: TStatusBar
    Top = 385
    Width = 608
    ExplicitTop = 385
    ExplicitWidth = 608
  end
  inherited pmLabels: TPopupMenu
    Left = 280
    Top = 456
  end
end
