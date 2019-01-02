inherited frmPersonelKarti: TfrmPersonelKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Personel Bilgisi'
  ClientHeight = 489
  ClientWidth = 635
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 641
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 631
    Height = 423
    Color = clWindow
    ExplicitWidth = 631
    ExplicitHeight = 423
    object pgcPersonel: TPageControl
      Left = 1
      Top = 1
      Width = 629
      Height = 421
      ActivePage = tsAyrinti
      Align = alClient
      TabOrder = 0
      OnChange = pgcPersonelChange
      object tsGenel: TTabSheet
        Caption = 'tsGenel'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblGenelNot: TLabel
          Left = 66
          Top = 142
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
          Left = 108
          Top = 32
          Width = 16
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPersonelSoyad: TLabel
          Left = 392
          Top = 32
          Width = 36
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Soyad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPersonelTipi: TLabel
          Left = 49
          Top = 54
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
          Left = 89
          Top = 76
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
          Left = 96
          Top = 98
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
          Left = 89
          Top = 120
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
          Left = 90
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
          Left = 434
          Top = 73
          Width = 180
          Height = 180
          Stretch = True
        end
        object lblServisAdi: TLabel
          Left = 374
          Top = 54
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
        object chkIsActive: TCheckBox
          Left = 130
          Top = 7
          Width = 184
          Height = 21
          TabOrder = 0
        end
        object edtPersonelAd: TEdit
          Left = 130
          Top = 29
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtPersonelSoyad: TEdit
          Left = 434
          Top = 29
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtPersonelTipi: TEdit
          Left = 130
          Top = 51
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtBolum: TEdit
          Left = 130
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtBirim: TEdit
          Left = 130
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 5
        end
        object edtGorev: TEdit
          Left = 130
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 6
        end
        object mmoGenelNot: TMemo
          Left = 130
          Top = 139
          Width = 298
          Height = 144
          MaxLength = 256
          ScrollBars = ssVertical
          TabOrder = 7
        end
        object edtServisAdi: TEdit
          Left = 434
          Top = 51
          Width = 180
          Height = 21
          TabOrder = 8
        end
      end
      object tsAyrinti: TTabSheet
        Caption = 'tsAyrinti'
        ImageIndex = 1
        object lblPostaKutusu: TLabel
          Left = 50
          Top = 230
          Width = 76
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Posta Kutusu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblBina: TLabel
          Left = 100
          Top = 186
          Width = 26
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Bina'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSokak: TLabel
          Left = 89
          Top = 164
          Width = 37
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Sokak'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblCadde: TLabel
          Left = 89
          Top = 142
          Width = 37
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Cadde'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMahalle: TLabel
          Left = 81
          Top = 120
          Width = 45
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Mahalle'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIlce: TLabel
          Left = 104
          Top = 98
          Width = 22
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #304'l'#231'e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSehir: TLabel
          Left = 96
          Top = 76
          Width = 30
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #350'ehir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblUlke: TLabel
          Left = 99
          Top = 54
          Width = 27
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #220'lke'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPostaKodu: TLabel
          Left = 60
          Top = 252
          Width = 66
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Posta Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblKapiNo: TLabel
          Left = 80
          Top = 208
          Width = 46
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Kap'#305' No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtUlke: TEdit
          Left = 130
          Top = 51
          Width = 180
          Height = 21
          TabOrder = 0
        end
        object edtSehir: TEdit
          Left = 130
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtIlce: TEdit
          Left = 130
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtMahalle: TEdit
          Left = 130
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtCadde: TEdit
          Left = 130
          Top = 139
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtSokak: TEdit
          Left = 130
          Top = 161
          Width = 180
          Height = 21
          TabOrder = 5
        end
        object edtBina: TEdit
          Left = 130
          Top = 183
          Width = 180
          Height = 21
          TabOrder = 6
        end
        object edtKapiNo: TEdit
          Left = 130
          Top = 205
          Width = 180
          Height = 21
          TabOrder = 7
        end
        object edtPostaKutusu: TEdit
          Left = 130
          Top = 227
          Width = 180
          Height = 21
          TabOrder = 8
        end
        object edtPostaKodu: TEdit
          Left = 130
          Top = 249
          Width = 180
          Height = 21
          TabOrder = 9
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
          Left = 71
          Top = 224
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
          Left = 79
          Top = 268
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
          Left = 44
          Top = 246
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
          Left = 346
          Top = 246
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
        object lblTelefon1: TLabel
          Left = 74
          Top = 54
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
          Left = 74
          Top = 76
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
          Left = 49
          Top = 142
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
          Left = 38
          Top = 120
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
        object lblMailAdresi: TLabel
          Left = 46
          Top = 98
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
          Left = 55
          Top = 164
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
          Left = 50
          Top = 186
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
          Left = 358
          Top = 54
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
        object lblDogumTarihi: TLabel
          Left = 356
          Top = 76
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
          Left = 371
          Top = 98
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
          Left = 387
          Top = 120
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
          Left = 343
          Top = 142
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
          Left = 339
          Top = 186
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
          Left = 358
          Top = 164
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
          Left = 130
          Top = 51
          Width = 180
          Height = 21
          TabOrder = 0
        end
        object edtTelefon2: TEdit
          Left = 130
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtMailAdresi: TEdit
          Left = 130
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtYakinAdSoyad: TEdit
          Left = 130
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtYakinTelefon: TEdit
          Left = 130
          Top = 139
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtAyakkabiNo: TEdit
          Left = 131
          Top = 161
          Width = 180
          Height = 21
          MaxLength = 2
          TabOrder = 5
        end
        object edtElbiseBedeni: TEdit
          Left = 131
          Top = 183
          Width = 180
          Height = 21
          MaxLength = 4
          TabOrder = 6
        end
        object edtTcKimlikNo: TEdit
          Left = 434
          Top = 51
          Width = 180
          Height = 21
          MaxLength = 11
          TabOrder = 7
        end
        object edtDogumTarihi: TEdit
          Left = 434
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 8
        end
        object cbbKanGrubu: TComboBox
          Left = 434
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 9
        end
        object edtCinsiyet: TEdit
          Left = 434
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 10
          OnChange = edtCinsiyetChange
        end
        object edtMedeniDurumu: TEdit
          Left = 434
          Top = 139
          Width = 180
          Height = 21
          TabOrder = 11
          OnChange = edtMedeniDurumuChange
        end
        object edtCocukSayisi: TEdit
          Left = 434
          Top = 161
          Width = 180
          Height = 21
          TabOrder = 12
        end
        object edtAskerlikDurumu: TEdit
          Left = 434
          Top = 183
          Width = 180
          Height = 21
          TabOrder = 13
        end
        object edtBrutMaas: TEdit
          Left = 130
          Top = 221
          Width = 180
          Height = 21
          MaxLength = 10
          TabOrder = 14
        end
        object edtIkramiyeSayisi: TEdit
          Left = 130
          Top = 243
          Width = 180
          Height = 21
          MaxLength = 16
          TabOrder = 15
        end
        object edtIkramiyeMiktar: TEdit
          Left = 434
          Top = 243
          Width = 180
          Height = 21
          MaxLength = 16
          TabOrder = 16
        end
        object mmoOzelNot: TMemo
          Left = 130
          Top = 265
          Width = 484
          Height = 112
          MaxLength = 256
          ScrollBars = ssVertical
          TabOrder = 17
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 427
    Width = 631
    ExplicitTop = 427
    ExplicitWidth = 631
    inherited btnAccept: TButton
      Left = 422
      ExplicitLeft = 422
    end
    inherited btnClose: TButton
      Left = 526
      ExplicitLeft = 526
    end
  end
  inherited stbBase: TStatusBar
    Top = 471
    Width = 635
    ExplicitTop = 471
    ExplicitWidth = 635
  end
  inherited pmLabels: TPopupMenu
    Left = 280
    Top = 456
  end
end
