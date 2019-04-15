inherited frmStokKarti: TfrmStokKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Stok Kart'#305
  ClientHeight = 549
  ClientWidth = 648
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 654
  ExplicitHeight = 578
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 644
    Height = 483
    Color = clWindow
    ExplicitWidth = 644
    ExplicitHeight = 567
    inherited pgcMain: TPageControl
      Width = 642
      Height = 481
      OnChange = pgcMainChange
      ExplicitWidth = 642
      ExplicitHeight = 565
      inherited tsMain: TTabSheet
        ExplicitWidth = 634
        ExplicitHeight = 537
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
        object lblstok_kodu: TLabel
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
        object lblstok_adi: TLabel
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
        object lblstok_grubu_id: TLabel
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
        object lblolcu_birimi_id: TLabel
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
        object lblen_az_stok_seviyesi: TLabel
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
        object lblpaket_miktari: TLabel
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
        object lbllot_parti_miktari: TLabel
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
        object lblalis_iskonto: TLabel
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
        object lblsatis_iskonto: TLabel
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
        object lblyetkili_iskonto: TLabel
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
        object lblsatis_fiyat: TLabel
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
        object lblalis_fiyat: TLabel
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
        object lblham_alis_fiyat: TLabel
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
        object lblihrac_fiyat: TLabel
          Left = 82
          Top = 309
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
        object lblortalama_maliyet: TLabel
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
        object lblis_satilabilir: TLabel
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
        object lblozel_kod: TLabel
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
        object lblvarsayilan_recete_id: TLabel
          Left = 319
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
        object lbltasiyici_paket_id: TLabel
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
        object lbltanim: TLabel
          Left = 111
          Top = 471
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
        object lblurun_tipi: TLabel
          Left = 370
          Top = 95
          Width = 53
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #220'r'#252'n Tipi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
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
          TabOrder = 0
          TabStop = False
          OnClick = btnReceteyeGitClick
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
          TabOrder = 1
          TabStop = False
          OnClick = btnTasiyiciPaketeGitClick
        end
        object edtstok_kodu: TEdit
          Left = 150
          Top = 4
          Width = 165
          Height = 21
          TabOrder = 2
        end
        object edtstok_adi: TEdit
          Left = 150
          Top = 26
          Width = 477
          Height = 21
          TabOrder = 3
        end
        object edtolcu_birimi_id: TEdit
          Left = 150
          Top = 70
          Width = 104
          Height = 21
          TabOrder = 4
        end
        object edten_az_stok_seviyesi: TEdit
          Left = 150
          Top = 92
          Width = 104
          Height = 21
          TabOrder = 5
        end
        object edtpaket_miktari: TEdit
          Left = 150
          Top = 114
          Width = 104
          Height = 21
          TabOrder = 6
        end
        object edtlot_parti_miktari: TEdit
          Left = 150
          Top = 136
          Width = 104
          Height = 21
          TabOrder = 7
        end
        object edtalis_iskonto: TEdit
          Left = 150
          Top = 166
          Width = 48
          Height = 21
          TabOrder = 8
        end
        object edtsatis_iskonto: TEdit
          Left = 150
          Top = 188
          Width = 48
          Height = 21
          TabOrder = 9
        end
        object edtyetkili_iskonto: TEdit
          Left = 150
          Top = 210
          Width = 48
          Height = 21
          TabOrder = 10
        end
        object edtsatis_fiyat: TEdit
          Left = 150
          Top = 240
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 11
        end
        object cbbsatis_para_birim: TComboBox
          Left = 255
          Top = 240
          Width = 60
          Height = 21
          Style = csDropDownList
          TabOrder = 12
        end
        object edtalis_fiyat: TEdit
          Left = 150
          Top = 262
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 13
        end
        object cbbalis_para_birim: TComboBox
          Left = 255
          Top = 262
          Width = 60
          Height = 21
          Style = csDropDownList
          TabOrder = 14
        end
        object edtham_alis_fiyat: TEdit
          Left = 150
          Top = 284
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 15
        end
        object cbbham_alis_para_birim: TComboBox
          Left = 255
          Top = 284
          Width = 60
          Height = 21
          Style = csDropDownList
          TabOrder = 16
        end
        object edtihrac_fiyat: TEdit
          Left = 150
          Top = 306
          Width = 104
          Height = 21
          Alignment = taRightJustify
          TabOrder = 17
        end
        object cbbihrac_para_birim: TComboBox
          Left = 255
          Top = 306
          Width = 60
          Height = 21
          Style = csDropDownList
          TabOrder = 18
        end
        object edtortalama_maliyet: TEdit
          Left = 150
          Top = 328
          Width = 149
          Height = 21
          TabOrder = 19
        end
        object edtozel_kod: TEdit
          Left = 150
          Top = 356
          Width = 165
          Height = 21
          TabOrder = 20
        end
        object chkis_satilabilir: TCheckBox
          Left = 427
          Top = 6
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
        object cbbtasiyici_paket_id: TComboBox
          Left = 427
          Top = 70
          Width = 163
          Height = 21
          TabOrder = 23
        end
        object mmotanim: TMemo
          Left = 150
          Top = 468
          Width = 477
          Height = 68
          TabOrder = 24
        end
        object pnlCins: TPanel
          Left = 331
          Top = 193
          Width = 296
          Height = 256
          Color = 12711908
          ParentBackground = False
          TabOrder = 25
        end
        object edtstok_grubu_id: TEdit
          Left = 150
          Top = 48
          Width = 104
          Height = 21
          TabOrder = 26
          OnChange = edtstok_grubu_idChange
        end
        object edtvarsayilan_recete_id: TEdit
          Left = 427
          Top = 48
          Width = 163
          Height = 21
          TabOrder = 27
          OnChange = edtstok_grubu_idChange
        end
        object edturun_tipi: TEdit
          Left = 427
          Top = 92
          Width = 163
          Height = 21
          TabOrder = 28
          OnChange = edtstok_grubu_idChange
        end
      end
      object tsCinsOzelligi: TTabSheet
        Caption = 'tsCinsOzelligi'
        ImageIndex = 1
        ExplicitHeight = 537
        object lbldouble_degisken3: TLabel
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
        object lbldouble_degisken2: TLabel
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
        object lbldouble_degisken1: TLabel
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
        object lblinteger_degisken3: TLabel
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
        object lblinteger_degisken2: TLabel
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
        object lblinteger_degisken1: TLabel
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
        object lblstring_degisken6: TLabel
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
        object lblstring_degisken5: TLabel
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
        object lblstring_degisken4: TLabel
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
        object lblstring_degisken3: TLabel
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
        object lblstring_degisken2: TLabel
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
        object lblstring_degisken1: TLabel
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
        object lblcins_id: TLabel
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
        object lblmarka: TLabel
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
        object lblagirlik: TLabel
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
        object lblkapasite: TLabel
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
        object imgStokResim: TImage
          Left = 380
          Top = 48
          Width = 250
          Height = 250
        end
        object edtcins_id: TEdit
          Left = 150
          Top = 48
          Width = 160
          Height = 21
          TabOrder = 0
          OnChange = edtcins_idChange
        end
        object edtmarka: TEdit
          Left = 150
          Top = 70
          Width = 160
          Height = 21
          TabOrder = 1
        end
        object edtagirlik: TEdit
          Left = 150
          Top = 92
          Width = 160
          Height = 21
          TabOrder = 2
        end
        object edtkapasite: TEdit
          Left = 150
          Top = 114
          Width = 160
          Height = 21
          TabOrder = 3
        end
        object edtstring_degisken1: TEdit
          Left = 150
          Top = 136
          Width = 160
          Height = 21
          TabOrder = 4
        end
        object edtstring_degisken2: TEdit
          Left = 150
          Top = 158
          Width = 160
          Height = 21
          TabOrder = 5
        end
        object edtstring_degisken3: TEdit
          Left = 150
          Top = 180
          Width = 160
          Height = 21
          TabOrder = 6
        end
        object edtstring_degisken4: TEdit
          Left = 150
          Top = 202
          Width = 160
          Height = 21
          TabOrder = 7
        end
        object edtstring_degisken5: TEdit
          Left = 150
          Top = 224
          Width = 160
          Height = 21
          TabOrder = 8
        end
        object edtstring_degisken6: TEdit
          Left = 150
          Top = 246
          Width = 160
          Height = 21
          TabOrder = 9
        end
        object edtinteger_degisken1: TEdit
          Left = 150
          Top = 268
          Width = 160
          Height = 21
          TabOrder = 10
        end
        object edtinteger_degisken2: TEdit
          Left = 150
          Top = 290
          Width = 160
          Height = 21
          TabOrder = 11
        end
        object edtinteger_degisken3: TEdit
          Left = 150
          Top = 312
          Width = 160
          Height = 21
          TabOrder = 12
        end
        object edtdouble_degisken1: TEdit
          Left = 150
          Top = 334
          Width = 160
          Height = 21
          TabOrder = 13
        end
        object edtdouble_degisken2: TEdit
          Left = 150
          Top = 356
          Width = 160
          Height = 21
          TabOrder = 14
        end
        object edtdouble_degisken3: TEdit
          Left = 150
          Top = 378
          Width = 160
          Height = 21
          TabOrder = 15
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
        Caption = 'tsDiger'
        ImageIndex = 2
        ExplicitHeight = 537
        object lblseri_no_turu: TLabel
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
        object lblis_harici_seri_no_icerir: TLabel
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
        object lblharici_serino_stok_kodu_id: TLabel
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
        object lblonceki_donem_cikan_miktar: TLabel
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
        object lbltemin_suresi: TLabel
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
        object lbldiib_urun_tanimi: TLabel
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
        object lblmensei_id: TLabel
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
        object lblgtip_no: TLabel
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
        object lblen: TLabel
          Left = 131
          Top = 218
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
        object lblboy: TLabel
          Left = 125
          Top = 240
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
        object lblyukseklik: TLabel
          Left = 91
          Top = 262
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
        object lblHacim: TLabel
          Left = 246
          Top = 242
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
          Left = 290
          Top = 242
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
        object LabelEnBoyYuseklikBirim: TLabel
          Left = 215
          Top = 218
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
        object chkis_harici_seri_no_icerir: TCheckBox
          Left = 151
          Top = 72
          Width = 154
          Height = 17
          TabOrder = 0
        end
        object edtharici_serino_stok_kodu_id: TEdit
          Left = 151
          Top = 92
          Width = 154
          Height = 21
          TabOrder = 1
        end
        object edtdiib_urun_tanimi: TEdit
          Left = 151
          Top = 144
          Width = 471
          Height = 21
          TabOrder = 2
        end
        object edtonceki_donem_cikan_miktar: TEdit
          Left = 510
          Top = 48
          Width = 112
          Height = 21
          TabOrder = 3
        end
        object edttemin_suresi: TEdit
          Left = 510
          Top = 70
          Width = 112
          Height = 21
          TabOrder = 4
        end
        object edtgtip_no: TEdit
          Left = 151
          Top = 188
          Width = 154
          Height = 21
          TabOrder = 5
        end
        object edtmensei_id: TEdit
          Left = 151
          Top = 166
          Width = 154
          Height = 21
          TabOrder = 6
        end
        object edten: TEdit
          Left = 151
          Top = 215
          Width = 60
          Height = 21
          TabOrder = 7
        end
        object edtboy: TEdit
          Left = 151
          Top = 237
          Width = 60
          Height = 21
          TabOrder = 8
        end
        object edtyukseklik: TEdit
          Left = 151
          Top = 259
          Width = 60
          Height = 21
          TabOrder = 9
        end
        object edtseri_no_turu: TEdit
          Left = 151
          Top = 48
          Width = 154
          Height = 21
          TabOrder = 10
        end
      end
      object tsOzetler: TTabSheet
        Caption = 'tsOzetler'
        ImageIndex = 3
        ExplicitHeight = 537
        object pnlOzetHeader: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 4
          Width = 628
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
          Width = 628
          Height = 137
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alTop
          Color = 14085611
          ParentBackground = False
          TabOrder = 1
          object lblSerbestStokBirim: TLabel
            Left = 257
            Top = 116
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
            Top = 116
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
            Top = 94
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
            Top = 94
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
            Top = 6
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
            Top = 28
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
            Top = 50
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
            Top = 72
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
            Top = 72
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
            Top = 50
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
            Top = 28
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
            Top = 6
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
            Top = 3
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 0
          end
          object EditGirenToplam: TEdit
            Left = 150
            Top = 25
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 1
          end
          object EditCikanToplam: TEdit
            Left = 150
            Top = 47
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 2
          end
          object EditStokMiktari: TEdit
            Left = 150
            Top = 69
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 3
          end
          object edtBlokajToplam: TEdit
            Left = 150
            Top = 91
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 4
          end
          object edtSerbestStokToplam: TEdit
            Left = 150
            Top = 113
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 5
          end
        end
        object pnlOzetMiddle: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 209
          Width = 628
          Height = 138
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alClient
          Color = 15527135
          ParentBackground = False
          TabOrder = 2
          ExplicitHeight = 150
          object lblStokDegeriOrtPara: TLabel
            Left = 257
            Top = 50
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
            Top = 72
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
            Top = 28
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
            Top = 72
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
            Top = 50
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
            Top = 28
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
            Top = 94
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
            Top = 116
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
            Top = 116
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
            Top = 94
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
            Top = 25
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 1
          end
          object EditStokDegerOrt: TEdit
            Left = 150
            Top = 47
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 2
          end
          object EditStokDegerSon: TEdit
            Left = 150
            Top = 69
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 3
          end
          object EditToplamAlis: TEdit
            Left = 150
            Top = 91
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 4
          end
          object EditToplamSatis: TEdit
            Left = 150
            Top = 113
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 5
          end
        end
        object pnlOzetBottom: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 355
          Width = 628
          Height = 94
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alBottom
          Color = 14146536
          ParentBackground = False
          TabOrder = 3
          ExplicitTop = 373
          object lblSonAlisFiyatiPara: TLabel
            Left = 256
            Top = 73
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
            Top = 29
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
            Top = 51
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
            Top = 73
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
            Top = 51
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
            Top = 29
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
            Top = 26
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 1
          end
          object EditOzetOrtalamaMaliyet: TEdit
            Left = 150
            Top = 48
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 2
          end
          object EditSonAlisFiyati: TEdit
            Left = 150
            Top = 70
            Width = 100
            Height = 21
            MaxLength = 16
            TabOrder = 3
          end
        end
      end
      object tsGrupOzellikleri: TTabSheet
        Caption = 'tsGrupOzellikleri'
        ImageIndex = 4
        ExplicitHeight = 537
        object pnlGrupHeader: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 4
          Width = 628
          Height = 52
          Margins.Top = 4
          Margins.Bottom = 4
          Align = alTop
          Color = 14737632
          ParentBackground = False
          TabOrder = 0
        end
        object pnlGrupOzellikleri: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 63
          Width = 628
          Height = 83
          Align = alClient
          Color = 15268861
          ParentBackground = False
          TabOrder = 1
          ExplicitHeight = 10
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
            Width = 620
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
        object pnlAmbar: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 152
          Width = 628
          Height = 298
          Align = alBottom
          TabOrder = 2
          ExplicitTop = 79
          object lblAmbarlar: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 620
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
            Width = 620
            Height = 271
            Align = alClient
            ColCount = 7
            DefaultRowHeight = 20
            FixedColor = 8421440
            FixedCols = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
            TabOrder = 0
            ExplicitHeight = 306
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
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 487
    Width = 644
    ExplicitTop = 571
    ExplicitWidth = 644
    inherited btnAccept: TButton
      Left = 435
      ExplicitLeft = 435
    end
    inherited btnClose: TButton
      Left = 539
      ExplicitLeft = 539
    end
  end
  inherited stbBase: TStatusBar
    Top = 531
    Width = 648
    ExplicitTop = 615
    ExplicitWidth = 648
  end
end
