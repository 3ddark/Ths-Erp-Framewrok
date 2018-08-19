inherited frmStokKarti: TfrmStokKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Stok Kart'#305
  ClientHeight = 652
  ClientWidth = 663
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 669
  ExplicitHeight = 681
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 659
    Height = 586
    Color = clWindow
    ExplicitWidth = 659
    ExplicitHeight = 586
    object pgcStokKarti: TPageControl
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 651
      Height = 578
      ActivePage = tsGenel
      Align = alClient
      TabOrder = 0
      OnChange = pgcStokKartiChange
      object tsGenel: TTabSheet
        Caption = 'Genel'
        object lblOrtalamaMaliyetBirim: TLabel
          Left = 302
          Top = 331
          Width = 16
          Height = 13
          Caption = 'TL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblStokKodu: TLabel
          Left = 86
          Top = 7
          Width = 60
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Stok Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStokAdi: TLabel
          Left = 97
          Top = 29
          Width = 49
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Stok Ad'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStokGrubu: TLabel
          Left = 81
          Top = 51
          Width = 65
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Stok Grubu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblOlcuBirimi: TLabel
          Left = 85
          Top = 73
          Width = 61
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #214'l'#231#252' Birimi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblEnAzStokSeviyesi: TLabel
          Left = 31
          Top = 95
          Width = 115
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'En Az Stok Seviyesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPaketMiktari: TLabel
          Left = 70
          Top = 117
          Width = 76
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Paket Miktar'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblLotPartiMiktari: TLabel
          Left = 55
          Top = 139
          Width = 91
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Lot Parti Miktar'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblAlisIskonto: TLabel
          Left = 79
          Top = 169
          Width = 67
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Al'#305#351' '#304'skonto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSatisIskonto: TLabel
          Left = 71
          Top = 191
          Width = 75
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Sat'#305#351' '#304'skonto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblYetkiliIskonto: TLabel
          Left = 64
          Top = 213
          Width = 82
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yetkili '#304'skonto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSatisFiyat: TLabel
          Left = 86
          Top = 243
          Width = 60
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Sat'#305#351' Fiyat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblAlisFiyat: TLabel
          Left = 94
          Top = 266
          Width = 52
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Al'#305#351' Fiyat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblHamAlisFiyat: TLabel
          Left = 65
          Top = 289
          Width = 81
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ham Al'#305#351' Fiyat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIhracFiyat: TLabel
          Left = 82
          Top = 312
          Width = 64
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #304'hra'#231' Fiyat'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblOrtalamaMaliyet: TLabel
          Left = 51
          Top = 331
          Width = 95
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ortalama Maliyet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsAnaUrun: TLabel
          Left = 362
          Top = 95
          Width = 61
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ana '#220'r'#252'n?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsSatilabilir: TLabel
          Left = 363
          Top = 7
          Width = 60
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Sat'#305'labilir?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsYariMamul: TLabel
          Left = 505
          Top = 95
          Width = 70
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yar'#305' Mam'#252'l?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsOzetUrun: TLabel
          Left = 510
          Top = 7
          Width = 65
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #214'zet '#220'r'#252'n?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblOzelKod: TLabel
          Left = 120
          Top = 359
          Width = 26
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #214'zel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblVarsayilanRecete: TLabel
          Left = 316
          Top = 51
          Width = 104
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Varsay'#305'lan Re'#231'ete'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblEn: TLabel
          Left = 427
          Top = 136
          Width = 16
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'En'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblBoy: TLabel
          Left = 497
          Top = 136
          Width = 22
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Boy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblYukseklik: TLabel
          Left = 567
          Top = 136
          Width = 56
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Y'#252'kseklik'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblEnXBoy: TLabel
          Left = 489
          Top = 156
          Width = 7
          Height = 13
          Caption = 'x'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblBoyxYukseklik: TLabel
          Left = 558
          Top = 156
          Width = 7
          Height = 13
          Caption = 'x'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblHacim: TLabel
          Left = 451
          Top = 176
          Width = 36
          Height = 13
          Alignment = taRightJustify
          Caption = 'Hacim'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblValueHacim: TLabel
          Left = 497
          Top = 176
          Width = 68
          Height = 13
          Caption = 'ValueHacim'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTasiyiciPaket: TLabel
          Left = 342
          Top = 73
          Width = 81
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ta'#351#305'y'#305'c'#305' Paket'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTanim: TLabel
          Left = 150
          Top = 461
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tan'#305'm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object LabelEnBoyYuseklikBirim: TLabel
          Left = 626
          Top = 156
          Width = 17
          Height = 13
          Caption = 'cm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtStokKodu: TthsEdit
          Left = 150
          Top = 4
          Width = 165
          Height = 21
          TabOrder = 0
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtStokAdi: TthsEdit
          Left = 150
          Top = 26
          Width = 477
          Height = 21
          TabOrder = 1
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtEnAzStokSeviyesi: TthsEdit
          Left = 150
          Top = 92
          Width = 104
          Height = 21
          TabOrder = 4
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtPaketMiktari: TthsEdit
          Left = 150
          Top = 114
          Width = 104
          Height = 21
          TabOrder = 5
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtLotPartiMiktari: TthsEdit
          Left = 150
          Top = 136
          Width = 104
          Height = 21
          TabOrder = 6
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtAlisIskonto: TthsEdit
          Left = 150
          Top = 166
          Width = 48
          Height = 21
          TabOrder = 7
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtSatisIskonto: TthsEdit
          Left = 150
          Top = 188
          Width = 48
          Height = 21
          TabOrder = 8
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtYetkiliIskonto: TthsEdit
          Left = 150
          Top = 210
          Width = 48
          Height = 21
          TabOrder = 9
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtSatisFiyat: TthsEdit
          Left = 150
          Top = 240
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 10
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object cbbSatisParaBirimi: TthsCombobox
          Left = 255
          Top = 240
          Width = 60
          Height = 21
          Style = csDropDownList
          TabOrder = 11
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtAlisFiyat: TthsEdit
          Left = 150
          Top = 262
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 12
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object cbbAlisParaBirimi: TthsCombobox
          Left = 255
          Top = 262
          Width = 60
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
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtHamAlisFiyat: TthsEdit
          Left = 150
          Top = 284
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 14
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object cbbHamAlisParaBirimi: TthsCombobox
          Left = 255
          Top = 284
          Width = 60
          Height = 21
          Style = csDropDownList
          TabOrder = 15
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtIhracFiyat: TthsEdit
          Left = 150
          Top = 306
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 16
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object cbbIhracParaBirimi: TthsCombobox
          Left = 255
          Top = 306
          Width = 60
          Height = 21
          Style = csDropDownList
          TabOrder = 17
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtOrtalamaMaliyet: TthsEdit
          Left = 150
          Top = 328
          Width = 149
          Height = 21
          TabOrder = 18
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtOzelKod: TthsEdit
          Left = 150
          Top = 356
          Width = 165
          Height = 21
          TabOrder = 19
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object chkIsAnaUrun: TCheckBox
          Left = 427
          Top = 94
          Width = 48
          Height = 17
          TabOrder = 20
        end
        object chkIsYariMamul: TCheckBox
          Left = 579
          Top = 94
          Width = 48
          Height = 17
          TabOrder = 21
        end
        object chkIsOzetUrun: TCheckBox
          Left = 579
          Top = 6
          Width = 48
          Height = 17
          TabOrder = 22
        end
        object chkIsSatilabilir: TCheckBox
          Left = 427
          Top = 6
          Width = 48
          Height = 17
          TabOrder = 23
        end
        object cbbVarsayilanRecete: TthsCombobox
          Left = 427
          Top = 48
          Width = 163
          Height = 21
          TabOrder = 24
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtEn: TthsEdit
          Left = 427
          Top = 153
          Width = 60
          Height = 21
          TabOrder = 25
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtBoy: TthsEdit
          Left = 497
          Top = 153
          Width = 60
          Height = 21
          TabOrder = 26
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtYukseklik: TthsEdit
          Left = 567
          Top = 153
          Width = 60
          Height = 21
          TabOrder = 27
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object cbbTasiyiciPaket: TthsCombobox
          Left = 427
          Top = 70
          Width = 163
          Height = 21
          TabOrder = 28
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object pnlCins: TPanel
          Left = 331
          Top = 189
          Width = 296
          Height = 285
          Color = 12711908
          ParentBackground = False
          TabOrder = 29
        end
        object mmoTanim: TthsMemo
          Left = 150
          Top = 476
          Width = 477
          Height = 68
          TabOrder = 30
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object btnGirisHareketleri: TButton
          Left = 0
          Top = 436
          Width = 66
          Height = 36
          Caption = 'Giri'#351'ler'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ImageAlignment = iaCenter
          ParentFont = False
          TabOrder = 31
          TabStop = False
          OnClick = btnGirisHareketleriClick
        end
        object btnCikisHareketleri: TButton
          Left = 0
          Top = 472
          Width = 66
          Height = 36
          Caption = #199#305'k'#305#351'lar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ImageAlignment = iaCenter
          ParentFont = False
          TabOrder = 32
          TabStop = False
          OnClick = btnCikisHareketleriClick
        end
        object btnTumHareketler: TButton
          Left = 0
          Top = 508
          Width = 66
          Height = 36
          Caption = 'T'#252'm'#252
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ImageAlignment = iaCenter
          ParentFont = False
          TabOrder = 33
          TabStop = False
          OnClick = btnTumHareketlerClick
        end
        object btnReceteyeGit: TButton
          Left = 592
          Top = 48
          Width = 35
          Height = 21
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 34
          TabStop = False
          OnClick = btnReceteyeGitClick
        end
        object edtStokGrubu: TthsEdit
          Left = 150
          Top = 48
          Width = 104
          Height = 21
          TabOrder = 2
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtOlcuBirimi: TthsEdit
          Left = 150
          Top = 70
          Width = 104
          Height = 21
          TabOrder = 3
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object btnTasiyiciPaketeGit: TButton
          Left = 592
          Top = 70
          Width = 35
          Height = 21
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 35
          TabStop = False
          OnClick = btnTasiyiciPaketeGitClick
        end
      end
      object tsCinsOzelligi: TTabSheet
        Caption = 'Cins '#214'zelli'#287'i'
        ImageIndex = 1
        object lblDoubleDegisken3: TLabel
          Left = 37
          Top = 381
          Width = 109
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Double De'#287'i'#351'ken 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblDoubleDegisken2: TLabel
          Left = 37
          Top = 359
          Width = 109
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Double De'#287'i'#351'ken 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblDoubleDegisken1: TLabel
          Left = 37
          Top = 337
          Width = 109
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Double De'#287'i'#351'ken 1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIntegerDegisken3: TLabel
          Left = 37
          Top = 315
          Width = 109
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Integer De'#287'i'#351'ken 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIntegerDegisken2: TLabel
          Left = 37
          Top = 293
          Width = 109
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Integer De'#287'i'#351'ken 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIntegerDegisken1: TLabel
          Left = 37
          Top = 271
          Width = 109
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Integer De'#287'i'#351'ken 1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStringDegisken6: TLabel
          Left = 44
          Top = 249
          Width = 102
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'String De'#287'i'#351'ken 6'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStringDegisken5: TLabel
          Left = 44
          Top = 227
          Width = 102
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'String De'#287'i'#351'ken 5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStringDegisken4: TLabel
          Left = 44
          Top = 205
          Width = 102
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'String De'#287'i'#351'ken 4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStringDegisken3: TLabel
          Left = 44
          Top = 183
          Width = 102
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'String De'#287'i'#351'ken 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStringDegisken2: TLabel
          Left = 44
          Top = 161
          Width = 102
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'String De'#287'i'#351'ken 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStringDegisken1: TLabel
          Left = 44
          Top = 139
          Width = 102
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'String De'#287'i'#351'ken 1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblCins: TLabel
          Left = 121
          Top = 51
          Width = 25
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Cins'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object imgStokResim: TImage
          Left = 380
          Top = 48
          Width = 250
          Height = 250
        end
        object lblMarka: TLabel
          Left = 110
          Top = 73
          Width = 36
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Marka'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblAgirlik: TLabel
          Left = 110
          Top = 95
          Width = 36
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'A'#287#305'rl'#305'k'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblKapasite: TLabel
          Left = 96
          Top = 117
          Width = 50
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Kapasite'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbCins: TthsCombobox
          Left = 150
          Top = 48
          Width = 160
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbbCinsChange
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtMarka: TthsEdit
          Left = 150
          Top = 70
          Width = 160
          Height = 21
          TabOrder = 1
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtAgirlik: TthsEdit
          Left = 150
          Top = 92
          Width = 160
          Height = 21
          TabOrder = 2
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtKapasite: TthsEdit
          Left = 150
          Top = 114
          Width = 160
          Height = 21
          TabOrder = 3
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtStringDegisken1: TthsEdit
          Left = 150
          Top = 136
          Width = 160
          Height = 21
          TabOrder = 4
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtStringDegisken2: TthsEdit
          Left = 150
          Top = 158
          Width = 160
          Height = 21
          TabOrder = 5
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtStringDegisken3: TthsEdit
          Left = 150
          Top = 180
          Width = 160
          Height = 21
          TabOrder = 6
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtStringDegisken4: TthsEdit
          Left = 150
          Top = 202
          Width = 160
          Height = 21
          TabOrder = 7
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtStringDegisken5: TthsEdit
          Left = 150
          Top = 224
          Width = 160
          Height = 21
          TabOrder = 8
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtStringDegisken6: TthsEdit
          Left = 150
          Top = 246
          Width = 160
          Height = 21
          TabOrder = 9
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtIntegerDegisken1: TthsEdit
          Left = 150
          Top = 268
          Width = 160
          Height = 21
          TabOrder = 10
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtIntegerDegisken2: TthsEdit
          Left = 150
          Top = 290
          Width = 160
          Height = 21
          TabOrder = 11
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtIntegerDegisken3: TthsEdit
          Left = 150
          Top = 312
          Width = 160
          Height = 21
          TabOrder = 12
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtDoubleDegisken1: TthsEdit
          Left = 150
          Top = 334
          Width = 160
          Height = 21
          TabOrder = 13
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtDoubleDegisken2: TthsEdit
          Left = 150
          Top = 356
          Width = 160
          Height = 21
          TabOrder = 14
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtDoubleDegisken3: TthsEdit
          Left = 150
          Top = 378
          Width = 160
          Height = 21
          TabOrder = 15
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object btnResimEkleDil: TButton
          Left = 380
          Top = 298
          Width = 250
          Height = 25
          Caption = 'btnResimEkleDil'
          TabOrder = 16
          TabStop = False
        end
      end
      object tsDiger: TTabSheet
        Caption = 'Di'#287'er'
        ImageIndex = 2
        object lblSeriNoTuru: TLabel
          Left = 73
          Top = 51
          Width = 73
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Seri No T'#252'r'#252
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsHariciSeriNoIcerir: TLabel
          Left = 33
          Top = 73
          Width = 113
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Harici Seri No '#304#231'erir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblHariciSerinoStokKodu: TLabel
          Left = 7
          Top = 95
          Width = 139
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Harici SeriNo Stok Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblOncekiDonemCikanMiktar: TLabel
          Left = 347
          Top = 51
          Width = 159
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #214'nceki D'#246'nem '#199#305'kan Miktar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTeminSuresi: TLabel
          Left = 432
          Top = 73
          Width = 74
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Temin S'#252'resi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblDiibUrunTanimi: TLabel
          Left = 48
          Top = 147
          Width = 98
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'D'#304#304'B '#220'r'#252'n Tan'#305'm'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMensei: TLabel
          Left = 105
          Top = 169
          Width = 41
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Men'#351'ei'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGtipNo: TLabel
          Left = 96
          Top = 191
          Width = 50
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'GTIP No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbSeriNoTuru: TthsCombobox
          Left = 150
          Top = 48
          Width = 112
          Height = 21
          TabOrder = 0
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object chkIsHariciSeriNoIcerir: TCheckBox
          Left = 150
          Top = 72
          Width = 112
          Height = 17
          TabOrder = 1
        end
        object edtOncekiDonemCikanMiktar: TthsEdit
          Left = 510
          Top = 48
          Width = 112
          Height = 21
          TabOrder = 3
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtTeminSuresi: TthsEdit
          Left = 510
          Top = 70
          Width = 112
          Height = 21
          TabOrder = 4
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itInteger
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtDiibUrunTanimi: TthsEdit
          Left = 150
          Top = 144
          Width = 202
          Height = 21
          TabOrder = 5
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object cbbMensei: TthsCombobox
          Left = 150
          Top = 166
          Width = 202
          Height = 21
          TabOrder = 6
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtGtipNo: TthsEdit
          Left = 150
          Top = 188
          Width = 202
          Height = 21
          TabOrder = 7
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
        object edtHariciSerinoStokKodu: TthsEdit
          Left = 150
          Top = 92
          Width = 202
          Height = 21
          TabOrder = 2
          thsAlignment = taLeftJustify
          thsColorActive = clSkyBlue
          thsColorRequiredData = 7367916
          thsTabEnterKeyJump = True
          thsInputDataType = itString
          thsCaseUpLowSupportTr = True
          thsDecimalDigit = 4
          thsRequiredData = True
          thsDoTrim = True
          thsActiveYear = 2018
        end
      end
      object tsOzetler: TTabSheet
        Caption = #214'zetler'
        ImageIndex = 3
        object pnlOzetHeader: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 4
          Width = 637
          Height = 52
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alTop
          Color = 14737632
          ParentBackground = False
          TabOrder = 0
        end
        object pnlOzetTop: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 64
          Width = 637
          Height = 152
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alTop
          Color = 14085611
          ParentBackground = False
          TabOrder = 1
          object lblSerbestStokBirim: TLabel
            Left = 257
            Top = 128
            Width = 28
            Height = 13
            Hint = 'Hide'
            Caption = 'Birim'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblSerbestStokToplam: TLabel
            Left = 17
            Top = 128
            Width = 127
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Serbest Stok Toplam :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblBlokajBirim: TLabel
            Left = 257
            Top = 104
            Width = 28
            Height = 13
            Hint = 'Hide'
            Caption = 'Birim'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblBlokajToplam: TLabel
            Left = 55
            Top = 104
            Width = 89
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Blokaj Toplam :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblDonemBasiBirim: TLabel
            Left = 257
            Top = 8
            Width = 28
            Height = 13
            Hint = 'Hide'
            Caption = 'Birim'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGirenToplamBirim: TLabel
            Left = 257
            Top = 32
            Width = 28
            Height = 13
            Hint = 'Hide'
            Caption = 'Birim'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCikanToplamBirim: TLabel
            Left = 257
            Top = 56
            Width = 28
            Height = 13
            Hint = 'Hide'
            Caption = 'Birim'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblStokMiktariBirim: TLabel
            Left = 257
            Top = 80
            Width = 28
            Height = 13
            Hint = 'Hide'
            Caption = 'Birim'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelStokMiktari: TLabel
            Left = 67
            Top = 80
            Width = 77
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Stok Miktar'#305' :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelCikanToplam: TLabel
            Left = 62
            Top = 56
            Width = 82
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = #199#305'kanToplam :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelGirenToplam: TLabel
            Left = 60
            Top = 32
            Width = 84
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Giren Toplam :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelDonemBasiMiktar: TLabel
            Left = 33
            Top = 8
            Width = 111
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'D'#246'nem Ba'#351#305' Miktar:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditDonemBasiMiktar: TEdit
            Left = 150
            Top = 5
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 0
          end
          object EditGirenToplam: TEdit
            Left = 150
            Top = 29
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 1
          end
          object EditCikanToplam: TEdit
            Left = 150
            Top = 53
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 2
          end
          object EditStokMiktari: TEdit
            Left = 150
            Top = 77
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 3
          end
          object edtBlokajToplam: TEdit
            Left = 150
            Top = 101
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 4
          end
          object edtSerbestStokToplam: TEdit
            Left = 150
            Top = 125
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 5
          end
        end
        object pnlOzetMiddle: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 224
          Width = 637
          Height = 213
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alClient
          Color = 15527135
          ParentBackground = False
          TabOrder = 2
          object lblStokDegeriOrtPara: TLabel
            Left = 257
            Top = 54
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblStokDegeriSonPara: TLabel
            Left = 257
            Top = 78
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblDonemBasiDegerPara: TLabel
            Left = 257
            Top = 30
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelStokDegeri2: TLabel
            Left = 11
            Top = 78
            Width = 133
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Stok De'#287'eri(Son Fiyat):'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelStokDegeri1: TLabel
            Left = 12
            Top = 54
            Width = 132
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Stok De'#287'eri(Ort. Fiyat):'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelDonemBasiDeger: TLabel
            Left = 30
            Top = 30
            Width = 114
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'D'#246'nem Ba'#351#305' De'#287'er :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblDonemBasiFiyatPara: TLabel
            Left = 257
            Top = 6
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblToplamAlisPara: TLabel
            Left = 257
            Top = 102
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblToplamSatisPara: TLabel
            Left = 257
            Top = 126
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelToplamSatis: TLabel
            Left = 62
            Top = 126
            Width = 82
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Toplam Sat'#305#351' :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelToplamAlis: TLabel
            Left = 70
            Top = 102
            Width = 74
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'Toplam Al'#305#351' :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelDonemBasiFiyat: TLabel
            Left = 37
            Top = 6
            Width = 107
            Height = 13
            Hint = 'Hide'
            Alignment = taRightJustify
            Caption = 'D'#246'nem Ba'#351#305' Fiyat :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditDonemBasiFiyat: TEdit
            Left = 150
            Top = 3
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 0
          end
          object EditDonembasiDeger: TEdit
            Left = 150
            Top = 27
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 1
          end
          object EditStokDegerOrt: TEdit
            Left = 150
            Top = 51
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 2
          end
          object EditStokDegerSon: TEdit
            Left = 150
            Top = 75
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 3
          end
          object EditToplamAlis: TEdit
            Left = 150
            Top = 99
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 4
          end
          object EditToplamSatis: TEdit
            Left = 150
            Top = 123
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 5
          end
        end
        object pnlOzetBottom: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 445
          Width = 637
          Height = 101
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alBottom
          Color = 14146536
          ParentBackground = False
          TabOrder = 3
          object lblSonAlisFiyatiPara: TLabel
            Left = 256
            Top = 79
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAlisPara: TLabel
            Left = 256
            Top = 31
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblOrtalamaMaliyetPara: TLabel
            Left = 256
            Top = 55
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblSatisPara: TLabel
            Left = 256
            Top = 7
            Width = 57
            Height = 13
            Hint = 'Hide'
            Caption = 'ParaBirimi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelSonAlisFiyati: TLabel
            Left = 63
            Top = 79
            Width = 81
            Height = 13
            Alignment = taRightJustify
            Caption = 'Son Al'#305#351' Fiyat'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelOzetOrtalamaMaliyet: TLabel
            Left = 49
            Top = 55
            Width = 95
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ortalama Maliyet'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelOzetAlis: TLabel
            Left = 123
            Top = 31
            Width = 21
            Height = 13
            Alignment = taRightJustify
            Caption = 'Al'#305#351
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelOzetSatis: TLabel
            Left = 115
            Top = 7
            Width = 29
            Height = 13
            Alignment = taRightJustify
            Caption = 'Sat'#305#351
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EditOzetSatis: TEdit
            Left = 150
            Top = 4
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 0
          end
          object EditOzetAlis: TEdit
            Left = 150
            Top = 28
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 1
          end
          object EditOzetOrtalamaMaliyet: TEdit
            Left = 150
            Top = 52
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 2
          end
          object EditSonAlisFiyati: TEdit
            Left = 150
            Top = 76
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 3
          end
        end
      end
      object tsGrupOzellikleri: TTabSheet
        Caption = 'Ambar ve Grup '#214'zellikleri'
        ImageIndex = 4
        object pnlAmbar: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 176
          Width = 637
          Height = 371
          Align = alBottom
          TabOrder = 0
          object lblAmbarlar: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 629
            Height = 13
            Hint = 'Hide'
            Align = alTop
            Alignment = taCenter
            Caption = 'Ambar Stok Durumlar'#305' '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
          object strngrdAmbar: TStringGrid
            AlignWithMargins = True
            Left = 4
            Top = 23
            Width = 629
            Height = 344
            Align = alClient
            ColCount = 7
            DefaultRowHeight = 20
            FixedColor = 8421440
            FixedCols = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
            TabOrder = 0
            ColWidths = (
              126
              71
              73
              71
              71
              75
              90)
            RowHeights = (
              20
              20
              20
              20
              20)
          end
        end
        object pnlGrupOzellikleri: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 63
          Width = 637
          Height = 107
          Align = alClient
          TabOrder = 1
          object lblGrupAlimHesabi: TLabel
            Left = 76
            Top = 23
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Al'#305'm Hesab'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGrupSatimHesabi: TLabel
            Left = 380
            Top = 24
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = 'Sat'#305'm Hesab'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGrupHammaddeHesabi: TLabel
            Left = 37
            Top = 43
            Width = 106
            Height = 13
            Alignment = taRightJustify
            Caption = 'Hammadde Hesab'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGrupMamaulHesabi: TLabel
            Left = 375
            Top = 43
            Width = 80
            Height = 13
            Alignment = taRightJustify
            Caption = 'Mam'#252'l Hesab'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblValGrupAlimHesabi: TLabel
            Left = 148
            Top = 23
            Width = 100
            Height = 13
            Caption = 'lblValGrupAlimHesabi'
          end
          object lblValGrupSatimHesabi: TLabel
            Left = 460
            Top = 24
            Width = 107
            Height = 13
            Caption = 'lblValGrupSatimHesabi'
          end
          object lblValGrupHammaddeHesabi: TLabel
            Left = 148
            Top = 43
            Width = 135
            Height = 13
            Caption = 'lblValGrupHammaddeHesabi'
          end
          object lblValGrupMamaulHesabi: TLabel
            Left = 460
            Top = 43
            Width = 118
            Height = 13
            Caption = 'lblValGrupMamaulHesabi'
          end
          object lblValGroupName: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 629
            Height = 13
            Align = alTop
            Alignment = taCenter
            Caption = 'Grup Ad'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 50
          end
          object lblGrupKDVOrani: TLabel
            Left = 83
            Top = 62
            Width = 60
            Height = 13
            Alignment = taRightJustify
            Caption = 'KDV Oran'#305
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblValGrupKDVOrani: TLabel
            Left = 148
            Top = 62
            Width = 95
            Height = 13
            Caption = 'lblValGrupKDVOrani'
          end
        end
        object pnlGrupHeader: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 4
          Width = 637
          Height = 52
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alTop
          Color = 14737632
          ParentBackground = False
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 590
    Width = 659
    ExplicitTop = 590
    ExplicitWidth = 659
    inherited btnAccept: TButton
      Left = 450
      ExplicitLeft = 450
    end
    inherited btnDelete: TButton
      Left = 346
      ExplicitLeft = 346
    end
    inherited btnClose: TButton
      Left = 554
      ExplicitLeft = 554
    end
  end
  inherited stbBase: TStatusBar
    Top = 634
    Width = 663
    ExplicitTop = 634
    ExplicitWidth = 663
  end
end
