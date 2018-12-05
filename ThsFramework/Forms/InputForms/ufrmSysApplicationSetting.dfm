inherited frmSysApplicationSetting: TfrmSysApplicationSetting
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Sistem Uygulama Ayar'#305
  ClientHeight = 617
  ClientWidth = 694
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 700
  ExplicitHeight = 646
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 690
    Height = 551
    Color = clWindow
    ExplicitWidth = 693
    ExplicitHeight = 538
    object pgcSettings: TPageControl
      Left = 1
      Top = 1
      Width = 688
      Height = 549
      ActivePage = tsDiger
      Align = alClient
      TabOrder = 0
      object tsGenel: TTabSheet
        Caption = 'tsGenel'
        ExplicitWidth = 281
        ExplicitHeight = 165
        DesignSize = (
          680
          521)
        object lblUnvan: TLabel
          Left = 79
          Top = 5
          Width = 38
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #220'nvan'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTel1: TLabel
          Left = 89
          Top = 28
          Width = 26
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tel1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTel2: TLabel
          Left = 89
          Top = 51
          Width = 26
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tel2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTel3: TLabel
          Left = 91
          Top = 74
          Width = 26
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tel3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTel4: TLabel
          Left = 91
          Top = 97
          Width = 26
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tel4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTel5: TLabel
          Left = 91
          Top = 120
          Width = 26
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tel5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblFax1: TLabel
          Left = 82
          Top = 143
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Faks1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblFax2: TLabel
          Left = 82
          Top = 166
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Faks2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object imgLogo: TImage
          Left = 360
          Top = 25
          Width = 320
          Height = 240
          Anchors = [akTop, akRight]
          OnDblClick = imgLogoDblClick
          ExplicitLeft = 369
        end
        object edtUnvan: TEdit
          Left = 121
          Top = 2
          Width = 559
          Height = 21
          TabOrder = 0
        end
        object edtTel1: TEdit
          Left = 121
          Top = 25
          Width = 136
          Height = 21
          TabOrder = 1
        end
        object edtTel2: TEdit
          Left = 121
          Top = 48
          Width = 136
          Height = 21
          TabOrder = 2
        end
        object edtTel3: TEdit
          Left = 121
          Top = 71
          Width = 136
          Height = 21
          TabOrder = 3
        end
        object edtTel4: TEdit
          Left = 121
          Top = 94
          Width = 136
          Height = 21
          TabOrder = 4
        end
        object edtTel5: TEdit
          Left = 121
          Top = 117
          Width = 136
          Height = 21
          TabOrder = 5
        end
        object edtFax1: TEdit
          Left = 121
          Top = 140
          Width = 136
          Height = 21
          TabOrder = 6
        end
        object edtFax2: TEdit
          Left = 121
          Top = 163
          Width = 136
          Height = 21
          TabOrder = 7
        end
      end
      object tsDiger: TTabSheet
        Caption = 'tsDiger'
        ImageIndex = 1
        ExplicitWidth = 681
        ExplicitHeight = 520
        object lblMailSunucuAdres: TLabel
          Left = 367
          Top = 418
          Width = 107
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Mail Sunucu Adres'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMailSunucuKullanici: TLabel
          Left = 329
          Top = 440
          Width = 145
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Mail Sunucu Kullan'#305'c'#305' Ad'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMailSunucuSifre: TLabel
          Left = 373
          Top = 462
          Width = 101
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Mail Sunucu '#350'ifre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMailSunucuPort: TLabel
          Left = 356
          Top = 483
          Width = 118
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Mail Sunucu Port No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGridColor1: TLabel
          Left = 69
          Top = 418
          Width = 72
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Grid Rengi 1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGridColor2: TLabel
          Left = 69
          Top = 440
          Width = 72
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Grid Rengi 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGridColorActive: TLabel
          Left = 48
          Top = 461
          Width = 91
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Grid Rengi Aktif'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblFormRengi: TLabel
          Left = 52
          Top = 281
          Width = 65
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Form Rengi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblDonem: TLabel
          Left = 275
          Top = 281
          Width = 40
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'D'#246'nem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSystemLanguage: TLabel
          Left = 480
          Top = 281
          Width = 60
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Sistem Dili'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblCryptKey: TLabel
          Left = 62
          Top = 217
          Width = 55
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Crypt Key'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtMailSunucuAdres: TEdit
          Left = 478
          Top = 415
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtMailSunucuKullanici: TEdit
          Left = 478
          Top = 437
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtMailSunucuSifre: TEdit
          Left = 478
          Top = 459
          Width = 200
          Height = 21
          PasswordChar = '#'
          TabOrder = 2
        end
        object edtMailSunucuPort: TEdit
          Left = 478
          Top = 475
          Width = 200
          Height = 21
          TabOrder = 3
        end
        object edtGridColor1: TEdit
          Left = 145
          Top = 415
          Width = 88
          Height = 21
          TabOrder = 4
          OnDblClick = edtGridColor1DblClick
          OnExit = edtGridColor1Exit
        end
        object edtGridColor2: TEdit
          Left = 145
          Top = 437
          Width = 88
          Height = 21
          TabOrder = 5
          OnDblClick = edtGridColor2DblClick
          OnExit = edtGridColor2Exit
        end
        object edtGridColorActive: TEdit
          Left = 145
          Top = 453
          Width = 88
          Height = 21
          TabOrder = 6
          OnDblClick = edtGridColorActiveDblClick
          OnExit = edtGridColorActiveExit
        end
        object edtFormRengi: TEdit
          Left = 121
          Top = 278
          Width = 88
          Height = 21
          TabOrder = 7
          OnDblClick = edtFormRengiDblClick
          OnExit = edtFormRengiExit
        end
        object edtDonem: TEdit
          Left = 319
          Top = 278
          Width = 88
          Height = 21
          TabOrder = 8
        end
        object cbbSystemLanguage: TComboBox
          Left = 546
          Top = 278
          Width = 134
          Height = 21
          TabOrder = 9
        end
      end
      object tsAdres: TTabSheet
        Caption = 'tsAdres'
        ImageIndex = 2
        object lblMersisNo: TLabel
          Left = 480
          Top = 320
          Width = 57
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Mersis No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblWebSitesi: TLabel
          Left = 55
          Top = 352
          Width = 62
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Web Sitesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblVergiDairesi: TLabel
          Left = 44
          Top = 297
          Width = 73
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Vergi Dairesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblVergiNo: TLabel
          Left = 67
          Top = 320
          Width = 50
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Vergi No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMukellefTipi: TLabel
          Left = 43
          Top = 274
          Width = 74
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'M'#252'kellef Tipi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblBina: TLabel
          Left = 91
          Top = 444
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
        object lblPostaKodu: TLabel
          Left = 51
          Top = 467
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
        object lblCadde: TLabel
          Left = 80
          Top = 421
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
        object lblIlce: TLabel
          Left = 95
          Top = 398
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
        object lblUlke: TLabel
          Left = 90
          Top = 375
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
        object lblEPostaAdresi: TLabel
          Left = 429
          Top = 352
          Width = 44
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'e-Posta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblKapiNo: TLabel
          Left = 427
          Top = 444
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
        object lblSokak: TLabel
          Left = 436
          Top = 421
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
        object lblMahalle: TLabel
          Left = 428
          Top = 398
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
        object lblSehir: TLabel
          Left = 443
          Top = 375
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
        object edtMersisNo: TEdit
          Left = 541
          Top = 317
          Width = 136
          Height = 21
          TabOrder = 0
        end
        object edtVergiDairesi: TEdit
          Left = 121
          Top = 294
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtVergiNo: TEdit
          Left = 121
          Top = 317
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object cbbMukellefTipi: TComboBox
          Left = 121
          Top = 271
          Width = 200
          Height = 21
          TabOrder = 3
        end
        object edtWebSitesi: TEdit
          Left = 121
          Top = 349
          Width = 200
          Height = 21
          TabOrder = 4
        end
        object cbbUlke: TComboBox
          Left = 121
          Top = 372
          Width = 200
          Height = 21
          TabOrder = 5
          OnChange = cbbUlkeChange
        end
        object edtIlce: TEdit
          Left = 121
          Top = 395
          Width = 200
          Height = 21
          TabOrder = 6
        end
        object edtCadde: TEdit
          Left = 121
          Top = 418
          Width = 200
          Height = 21
          TabOrder = 7
        end
        object edtBina: TEdit
          Left = 121
          Top = 441
          Width = 200
          Height = 21
          TabOrder = 8
        end
        object edtPostaKodu: TEdit
          Left = 121
          Top = 464
          Width = 200
          Height = 21
          TabOrder = 9
        end
        object edtEPostaAdresi: TEdit
          Left = 477
          Top = 349
          Width = 200
          Height = 21
          TabOrder = 10
        end
        object cbbSehir: TComboBox
          Left = 477
          Top = 372
          Width = 200
          Height = 21
          TabOrder = 11
        end
        object edtMahalle: TEdit
          Left = 477
          Top = 395
          Width = 200
          Height = 21
          TabOrder = 12
        end
        object edtSokak: TEdit
          Left = 477
          Top = 418
          Width = 200
          Height = 21
          TabOrder = 13
        end
        object edtKapiNo: TEdit
          Left = 477
          Top = 441
          Width = 200
          Height = 21
          TabOrder = 14
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 555
    Width = 690
    ExplicitTop = 542
    ExplicitWidth = 693
    inherited btnAccept: TButton
      Left = 481
      ExplicitLeft = 484
    end
    inherited btnDelete: TButton
      Left = 25
      ExplicitLeft = 25
    end
    inherited btnClose: TButton
      Left = 585
      ExplicitLeft = 588
    end
  end
  inherited stbBase: TStatusBar
    Top = 599
    Width = 694
    ExplicitTop = 586
    ExplicitWidth = 697
  end
  object seCryptKey: TSpinEdit [3]
    Left = 128
    Top = 241
    Width = 121
    Height = 22
    MaxLength = 5
    MaxValue = 65535
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  inherited pmLabels: TPopupMenu
    Left = 288
    Top = 128
  end
end
