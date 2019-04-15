inherited frmHesapKarti: TfrmHesapKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Hesap Kart'#305
  ClientHeight = 417
  ClientWidth = 702
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 708
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 698
    Height = 351
    Color = clWindow
    ExplicitWidth = 698
    ExplicitHeight = 308
    inherited pgcMain: TPageControl
      Width = 696
      Height = 349
      ExplicitWidth = 696
      ExplicitHeight = 306
      inherited tsMain: TTabSheet
        ExplicitWidth = 688
        ExplicitHeight = 278
        object lblhesap_kodu: TLabel
          Left = 76
          Top = 45
          Width = 70
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Hesap Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblhesap_ismi: TLabel
          Left = 83
          Top = 67
          Width = 63
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Hesap '#304'smi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblhesap_grubu_id: TLabel
          Left = 71
          Top = 89
          Width = 75
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Hesap Grubu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmukellef_tipi_id: TLabel
          Left = 72
          Top = 141
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
        object lblmukellef_adi: TLabel
          Left = 417
          Top = 163
          Width = 71
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'M'#252'kellef Ad'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmukellef_ikinci_adi: TLabel
          Left = 382
          Top = 185
          Width = 106
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'M'#252'kellef '#304'kinci Ad'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmukellef_soyadi: TLabel
          Left = 397
          Top = 207
          Width = 91
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'M'#252'kellef Soyad'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblvergi_dairesi: TLabel
          Left = 73
          Top = 163
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
        object lblvergi_no: TLabel
          Left = 96
          Top = 185
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
        object lblnace_kodu: TLabel
          Left = 424
          Top = 251
          Width = 64
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Nace Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblpara_birimi: TLabel
          Left = 85
          Top = 207
          Width = 61
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Para Birimi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblbolge_id: TLabel
          Left = 455
          Top = 89
          Width = 33
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'B'#246'lge'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmusteri_temsilci_grubu_id: TLabel
          Left = 61
          Top = 111
          Width = 85
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Temsilci Grubu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmusteri_temsilcisi_id: TLabel
          Left = 45
          Top = 251
          Width = 101
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'M'#252#351'teri Temsilcisi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lbliban: TLabel
          Left = 60
          Top = 229
          Width = 86
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'IBAN Numaras'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_efatura_hesabi: TLabel
          Left = 47
          Top = 273
          Width = 99
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'E-Fatura Hesab'#305'?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmuhasebe_kodu: TLabel
          Left = 54
          Top = 23
          Width = 92
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Muhasebe Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblefatura_pk_name: TLabel
          Left = 360
          Top = 273
          Width = 128
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'E-Fatura Posta Kutusu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_ara_hesap: TLabel
          Left = 80
          Top = 5
          Width = 67
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ara Hesap?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object chkis_ara_hesap: TCheckBox
          Left = 150
          Top = 2
          Width = 80
          Height = 17
          TabOrder = 0
        end
        object edtmuhasebe_kodu: TEdit
          Left = 150
          Top = 20
          Width = 80
          Height = 21
          TabOrder = 1
        end
        object edthesap_kodu: TEdit
          Left = 150
          Top = 42
          Width = 80
          Height = 21
          TabOrder = 2
        end
        object edthesap_ismi: TEdit
          Left = 150
          Top = 64
          Width = 522
          Height = 21
          TabOrder = 3
        end
        object edthesap_grubu_id: TEdit
          Left = 150
          Top = 86
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtbolge_id: TEdit
          Left = 492
          Top = 86
          Width = 180
          Height = 21
          TabOrder = 5
        end
        object edtmusteri_temsilci_grubu_id: TEdit
          Left = 150
          Top = 108
          Width = 180
          Height = 21
          TabOrder = 6
        end
        object edtmukellef_tipi_id: TEdit
          Left = 150
          Top = 138
          Width = 107
          Height = 21
          TabOrder = 7
          OnChange = edtmukellef_tipi_idChange
        end
        object edtvergi_dairesi: TEdit
          Left = 150
          Top = 160
          Width = 180
          Height = 21
          TabOrder = 8
        end
        object edtmukellef_adi: TEdit
          Left = 492
          Top = 160
          Width = 180
          Height = 21
          TabOrder = 9
        end
        object edtvergi_no: TEdit
          Left = 150
          Top = 182
          Width = 180
          Height = 21
          TabOrder = 10
        end
        object edtmukellef_ikinci_adi: TEdit
          Left = 492
          Top = 182
          Width = 180
          Height = 21
          TabOrder = 11
        end
        object edtpara_birimi: TEdit
          Left = 150
          Top = 204
          Width = 180
          Height = 21
          TabOrder = 12
        end
        object edtmukellef_soyadi: TEdit
          Left = 492
          Top = 204
          Width = 180
          Height = 21
          TabOrder = 13
        end
        object edtiban: TEdit
          Left = 150
          Top = 226
          Width = 336
          Height = 21
          TabOrder = 14
        end
        object edtiban_para: TEdit
          Left = 492
          Top = 226
          Width = 180
          Height = 21
          TabOrder = 15
        end
        object edtmusteri_temsilcisi_id: TEdit
          Left = 150
          Top = 248
          Width = 180
          Height = 21
          TabOrder = 16
        end
        object edtnace_kodu: TEdit
          Left = 492
          Top = 248
          Width = 180
          Height = 21
          TabOrder = 17
        end
        object chkis_efatura_hesabi: TCheckBox
          Left = 150
          Top = 270
          Width = 180
          Height = 21
          TabOrder = 18
        end
        object edtefatura_pk_name: TEdit
          Left = 492
          Top = 270
          Width = 180
          Height = 21
          TabOrder = 19
        end
      end
      object tsAdres: TTabSheet
        Caption = 'tsAdres'
        ImageIndex = 1
        ExplicitHeight = 278
        object lblposta_kutusu: TLabel
          Left = 390
          Top = 203
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
        object lblbina: TLabel
          Left = 120
          Top = 203
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
        object lblsokak: TLabel
          Left = 109
          Top = 181
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
        object lblcadde: TLabel
          Left = 109
          Top = 159
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
        object lblmahalle: TLabel
          Left = 101
          Top = 137
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
        object lblilce: TLabel
          Left = 124
          Top = 115
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
        object lblsehir_id: TLabel
          Left = 116
          Top = 93
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
        object lblulke_id: TLabel
          Left = 119
          Top = 71
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
        object lblposta_kodu: TLabel
          Left = 400
          Top = 225
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
        object lblkapi_no: TLabel
          Left = 100
          Top = 225
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
        object edtulke_id: TEdit
          Left = 150
          Top = 68
          Width = 180
          Height = 21
          TabOrder = 0
        end
        object edtsehir_id: TEdit
          Left = 150
          Top = 90
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtilce: TEdit
          Left = 150
          Top = 112
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtmahalle: TEdit
          Left = 150
          Top = 134
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtcadde: TEdit
          Left = 150
          Top = 156
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtsokak: TEdit
          Left = 150
          Top = 178
          Width = 180
          Height = 21
          TabOrder = 5
        end
        object edtbina: TEdit
          Left = 150
          Top = 200
          Width = 180
          Height = 21
          TabOrder = 6
        end
        object edtkapi_no: TEdit
          Left = 150
          Top = 222
          Width = 180
          Height = 21
          TabOrder = 7
        end
        object edtposta_kutusu: TEdit
          Left = 470
          Top = 200
          Width = 180
          Height = 21
          TabOrder = 8
        end
        object edtposta_kodu: TEdit
          Left = 470
          Top = 222
          Width = 180
          Height = 21
          TabOrder = 9
        end
      end
      object tsIletisim: TTabSheet
        Caption = 'tsIletisim'
        ImageIndex = 2
        ExplicitHeight = 278
        object lblyetkili2: TLabel
          Left = 75
          Top = 93
          Width = 71
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yetkili Kisi 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblyetkili1: TLabel
          Left = 75
          Top = 71
          Width = 71
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yetkili Ki'#351'i 1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblfaks: TLabel
          Left = 118
          Top = 137
          Width = 28
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Faks'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblweb_sitesi: TLabel
          Left = 84
          Top = 159
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
        object lbleposta_adresi: TLabel
          Left = 62
          Top = 181
          Width = 84
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'E-Posta Adresi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmuhasebe_telefon: TLabel
          Left = 382
          Top = 159
          Width = 106
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Muhasebe Telefon'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmuhasebe_eposta: TLabel
          Left = 381
          Top = 181
          Width = 107
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Muhasebe E-Posta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblyetkili2_tel: TLabel
          Left = 391
          Top = 93
          Width = 94
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yetkili 2 Telefon'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblyetkili1_tel: TLabel
          Left = 391
          Top = 71
          Width = 94
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yetkili 1 Telefon'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblozel_bilgi: TLabel
          Left = 90
          Top = 247
          Width = 54
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #214'zel Bilgi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblmuhasebe_yetkili: TLabel
          Left = 387
          Top = 203
          Width = 98
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Muhasebe Yetkili'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblyetkili3: TLabel
          Left = 75
          Top = 115
          Width = 71
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yetkili Kisi 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblyetkili3_tel: TLabel
          Left = 391
          Top = 115
          Width = 94
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yetkili 2 Telefon'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtyetkili1: TEdit
          Left = 150
          Top = 68
          Width = 180
          Height = 21
          TabOrder = 0
        end
        object edtyetkili1_tel: TEdit
          Left = 492
          Top = 68
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtyetkili2: TEdit
          Left = 150
          Top = 90
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtyetkili2_tel: TEdit
          Left = 492
          Top = 90
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtyetkili3: TEdit
          Left = 150
          Top = 112
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtyetkili3_tel: TEdit
          Left = 492
          Top = 112
          Width = 180
          Height = 21
          TabOrder = 5
        end
        object edtfaks: TEdit
          Left = 150
          Top = 134
          Width = 180
          Height = 21
          TabOrder = 6
        end
        object edtweb_sitesi: TEdit
          Left = 150
          Top = 156
          Width = 180
          Height = 21
          TabOrder = 7
        end
        object edtMuhasebeTelefon: TEdit
          Left = 492
          Top = 156
          Width = 180
          Height = 21
          TabOrder = 8
        end
        object edteposta_adresi: TEdit
          Left = 150
          Top = 178
          Width = 180
          Height = 21
          TabOrder = 9
        end
        object edtmuhasebe_eposta: TEdit
          Left = 492
          Top = 178
          Width = 180
          Height = 21
          TabOrder = 10
        end
        object edtmuhasebe_yetkili: TEdit
          Left = 492
          Top = 200
          Width = 180
          Height = 21
          TabOrder = 11
        end
        object mmoozel_bilgi: TMemo
          Left = 150
          Top = 244
          Width = 522
          Height = 21
          TabOrder = 12
        end
      end
      object tsDiger: TTabSheet
        Caption = 'tsDiger'
        ImageIndex = 3
        ExplicitHeight = 278
        object lblodeme_vade_gun_sayisi: TLabel
          Left = 9
          Top = 71
          Width = 137
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #214'deme Vade G'#252'n Say'#305's'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_acik_hesap: TLabel
          Left = 73
          Top = 93
          Width = 73
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'A'#231#305'k Hesap?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblkredi_limiti: TLabel
          Left = 83
          Top = 115
          Width = 63
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Kredi Limiti'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblhesap_iskonto: TLabel
          Left = 63
          Top = 137
          Width = 83
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Hesap '#304'skonto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtodeme_vade_gun_sayisi: TEdit
          Left = 150
          Top = 68
          Width = 180
          Height = 21
          TabOrder = 0
        end
        object chkis_acik_hesap: TCheckBox
          Left = 150
          Top = 90
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtkredi_limiti: TEdit
          Left = 150
          Top = 112
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edthesap_iskonto: TEdit
          Left = 150
          Top = 134
          Width = 180
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 355
    Width = 698
    ExplicitTop = 312
    ExplicitWidth = 698
    inherited btnAccept: TButton
      Left = 489
      ExplicitLeft = 489
    end
    inherited btnClose: TButton
      Left = 593
      ExplicitLeft = 593
    end
  end
  inherited stbBase: TStatusBar
    Top = 399
    Width = 702
    ExplicitTop = 356
    ExplicitWidth = 702
  end
end
