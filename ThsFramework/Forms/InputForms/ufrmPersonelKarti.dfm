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
    object pgcMain: TPageControl
      Left = 1
      Top = 1
      Width = 629
      Height = 421
      ActivePage = tsAyrinti
      Align = alClient
      DoubleBuffered = True
      MultiLine = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnChange = pgcMainChange
      object tsGenel: TTabSheet
        Caption = 'tsGenel'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblgenel_not: TLabel
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
        object lblpersonel_ad: TLabel
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
        object lblpersonel_soyad: TLabel
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
        object lblpersonel_tipi_id: TLabel
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
        object lblbolum_id: TLabel
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
        object lblbirim_id: TLabel
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
        object lblgorev_id: TLabel
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
        object lblis_active: TLabel
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
        object lblservis_id: TLabel
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
        object chkis_active: TCheckBox
          Left = 130
          Top = 7
          Width = 184
          Height = 21
          TabOrder = 0
        end
        object edtpersonel_ad: TEdit
          Left = 130
          Top = 29
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtpersonel_soyad: TEdit
          Left = 434
          Top = 29
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtpersonel_tipi_id: TEdit
          Left = 130
          Top = 51
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtbolum_id: TEdit
          Left = 130
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtbirim_id: TEdit
          Left = 130
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 5
        end
        object edtgorev_id: TEdit
          Left = 130
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 6
        end
        object mmogenel_not: TMemo
          Left = 130
          Top = 139
          Width = 298
          Height = 144
          MaxLength = 256
          ScrollBars = ssVertical
          TabOrder = 7
        end
        object edtservis_id: TEdit
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
        object lblposta_kutusu: TLabel
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
        object lblbina: TLabel
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
        object lblsokak: TLabel
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
        object lblcadde: TLabel
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
        object lblmahalle: TLabel
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
        object lblilce: TLabel
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
        object lblsehir_id: TLabel
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
        object lblulke_id: TLabel
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
        object lblposta_kodu: TLabel
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
        object lblkapi_no: TLabel
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
        object edtulke_id: TEdit
          Left = 130
          Top = 51
          Width = 180
          Height = 21
          TabOrder = 0
        end
        object edtsehir_id: TEdit
          Left = 130
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtilce: TEdit
          Left = 130
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtmahalle: TEdit
          Left = 130
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtcadde: TEdit
          Left = 130
          Top = 139
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtsokak: TEdit
          Left = 130
          Top = 161
          Width = 180
          Height = 21
          TabOrder = 5
        end
        object edtbina: TEdit
          Left = 130
          Top = 183
          Width = 180
          Height = 21
          TabOrder = 6
        end
        object edtkapi_no: TEdit
          Left = 130
          Top = 205
          Width = 180
          Height = 21
          TabOrder = 7
        end
        object edtposta_kutusu: TEdit
          Left = 130
          Top = 227
          Width = 180
          Height = 21
          TabOrder = 8
        end
        object edtposta_kodu: TEdit
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
        object lblbrut_maas: TLabel
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
        object lblozel_not: TLabel
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
        object lblikramiye_sayisi: TLabel
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
        object lblikramiye_miktar: TLabel
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
        object lbltelefon1: TLabel
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
        object lbltelefon2: TLabel
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
        object lblyakin_telefon: TLabel
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
        object lblyakin_ad_soyad: TLabel
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
        object lblmail_adresi: TLabel
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
        object lblayakkabi_no: TLabel
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
        object lblelbise_bedeni: TLabel
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
        object lbltc_kimlik_no: TLabel
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
        object lbldogum_tarihi: TLabel
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
        object lblkan_grubu: TLabel
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
        object lblcinsiyet_id: TLabel
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
        object lblmedeni_durum_id: TLabel
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
        object lblaskerlik_durum_id: TLabel
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
        object lblcocuk_sayisi: TLabel
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
        object edttelefon1: TEdit
          Left = 130
          Top = 51
          Width = 180
          Height = 21
          TabOrder = 0
        end
        object edttelefon2: TEdit
          Left = 130
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 1
        end
        object edtmail_adresi: TEdit
          Left = 130
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 2
        end
        object edtyakin_ad_soyad: TEdit
          Left = 130
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 3
        end
        object edtyakin_telefon: TEdit
          Left = 130
          Top = 139
          Width = 180
          Height = 21
          TabOrder = 4
        end
        object edtayakkabi_no: TEdit
          Left = 131
          Top = 161
          Width = 180
          Height = 21
          MaxLength = 2
          TabOrder = 5
        end
        object edtelbise_bedeni: TEdit
          Left = 131
          Top = 183
          Width = 180
          Height = 21
          MaxLength = 4
          TabOrder = 6
        end
        object edttc_kimlik_no: TEdit
          Left = 434
          Top = 51
          Width = 180
          Height = 21
          MaxLength = 11
          TabOrder = 7
        end
        object edtdogum_tarihi: TEdit
          Left = 434
          Top = 73
          Width = 180
          Height = 21
          TabOrder = 8
        end
        object cbbkan_grubu: TComboBox
          Left = 434
          Top = 95
          Width = 180
          Height = 21
          TabOrder = 9
        end
        object edtcinsiyet_id: TEdit
          Left = 434
          Top = 117
          Width = 180
          Height = 21
          TabOrder = 10
          OnChange = edtcinsiyet_idChange
        end
        object edtmedeni_durum_id: TEdit
          Left = 434
          Top = 139
          Width = 180
          Height = 21
          TabOrder = 11
          OnChange = edtmedeni_durum_idChange
        end
        object edtcocuk_sayisi: TEdit
          Left = 434
          Top = 161
          Width = 180
          Height = 21
          TabOrder = 12
        end
        object edtaskerlik_durum_id: TEdit
          Left = 434
          Top = 183
          Width = 180
          Height = 21
          TabOrder = 13
        end
        object edtbrut_maas: TEdit
          Left = 130
          Top = 221
          Width = 180
          Height = 21
          MaxLength = 10
          TabOrder = 14
        end
        object edtikramiye_sayisi: TEdit
          Left = 130
          Top = 243
          Width = 180
          Height = 21
          MaxLength = 16
          TabOrder = 15
        end
        object edtikramiye_miktar: TEdit
          Left = 434
          Top = 243
          Width = 180
          Height = 21
          MaxLength = 16
          TabOrder = 16
        end
        object mmoozel_not: TMemo
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
