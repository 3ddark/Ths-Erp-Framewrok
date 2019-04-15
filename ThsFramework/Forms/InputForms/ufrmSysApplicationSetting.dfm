inherited frmSysApplicationSetting: TfrmSysApplicationSetting
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Sistem Uygulama Ayar'#305
  ClientHeight = 364
  ClientWidth = 702
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 708
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 698
    Height = 298
    Color = clWindow
    ExplicitWidth = 698
    ExplicitHeight = 298
    inherited pgcMain: TPageControl
      Width = 696
      Height = 296
      ActivePage = tsAdres
      ExplicitWidth = 696
      ExplicitHeight = 296
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 688
        ExplicitHeight = 268
        object lblcompany_name: TLabel
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
        object lblphone1: TLabel
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
        object lblphone2: TLabel
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
        object lblphone3: TLabel
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
        object lblphone4: TLabel
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
        object lblphone5: TLabel
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
        object lblfax1: TLabel
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
        object lblfax2: TLabel
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
        object imglogo: TImage
          Left = 360
          Top = 25
          Width = 320
          Height = 240
          Anchors = [akTop, akRight]
          OnDblClick = imglogoDblClick
        end
        object edtcompany_name: TEdit
          Left = 121
          Top = 2
          Width = 559
          Height = 21
          TabOrder = 0
        end
        object edtphone1: TEdit
          Left = 121
          Top = 25
          Width = 136
          Height = 21
          TabOrder = 1
        end
        object edtphone2: TEdit
          Left = 121
          Top = 48
          Width = 136
          Height = 21
          TabOrder = 2
        end
        object edtphone3: TEdit
          Left = 121
          Top = 71
          Width = 136
          Height = 21
          TabOrder = 3
        end
        object edtphone4: TEdit
          Left = 121
          Top = 94
          Width = 136
          Height = 21
          TabOrder = 4
        end
        object edtphone5: TEdit
          Left = 121
          Top = 117
          Width = 136
          Height = 21
          TabOrder = 5
        end
        object edtfax1: TEdit
          Left = 121
          Top = 140
          Width = 136
          Height = 21
          TabOrder = 6
        end
        object edtfax2: TEdit
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblgrid_color_1: TLabel
          Left = 61
          Top = 6
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
        object lblgrid_color_2: TLabel
          Left = 61
          Top = 28
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
        object lblgrid_color_active: TLabel
          Left = 40
          Top = 50
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
        object lblcrypt_key: TLabel
          Left = 76
          Top = 72
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
        object lblform_color: TLabel
          Left = 68
          Top = 95
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
        object lblperiod: TLabel
          Left = 93
          Top = 117
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
        object lblapp_main_lang: TLabel
          Left = 71
          Top = 139
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
        object lblmail_host_name: TLabel
          Left = 366
          Top = 6
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
        object lblmail_host_user: TLabel
          Left = 328
          Top = 28
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
        object lblmail_host_pass: TLabel
          Left = 372
          Top = 50
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
        object lblmail_host_smtp_port: TLabel
          Left = 355
          Top = 72
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
        object lblis_use_quality_form_number: TLabel
          Left = 303
          Top = 95
          Width = 168
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Kalite Form No Kullan'#305'ls'#305'n m'#305'?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtgrid_color_1: TEdit
          Left = 137
          Top = 3
          Width = 130
          Height = 21
          TabOrder = 0
          OnDblClick = edtgrid_color_1DblClick
          OnExit = edtgrid_color_1Exit
        end
        object edtgrid_color_2: TEdit
          Left = 137
          Top = 25
          Width = 130
          Height = 21
          TabOrder = 1
          OnDblClick = edtgrid_color_2DblClick
          OnExit = edtgrid_color_2Exit
        end
        object edtgrid_color_active: TEdit
          Left = 137
          Top = 47
          Width = 130
          Height = 21
          TabOrder = 2
          OnDblClick = edtgrid_color_activeDblClick
          OnExit = edtgrid_color_activeExit
        end
        object secrypt_key: TSpinEdit
          Left = 137
          Top = 69
          Width = 130
          Height = 22
          MaxLength = 5
          MaxValue = 65535
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object edtform_color: TEdit
          Left = 137
          Top = 92
          Width = 130
          Height = 21
          TabOrder = 4
          OnDblClick = edtform_colorDblClick
          OnExit = edtform_colorExit
        end
        object edtperiod: TEdit
          Left = 137
          Top = 114
          Width = 130
          Height = 21
          TabOrder = 5
        end
        object edtmail_host_name: TEdit
          Left = 477
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 7
        end
        object edtmail_host_user: TEdit
          Left = 477
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 8
        end
        object edtmail_host_pass: TEdit
          Left = 477
          Top = 47
          Width = 200
          Height = 21
          PasswordChar = '#'
          TabOrder = 9
        end
        object edtmail_host_smtp_port: TEdit
          Left = 477
          Top = 69
          Width = 200
          Height = 21
          TabOrder = 10
        end
        object chkis_use_quality_form_number: TCheckBox
          Left = 477
          Top = 94
          Width = 130
          Height = 17
          TabOrder = 11
        end
        object edtapp_main_lang: TEdit
          Left = 137
          Top = 136
          Width = 130
          Height = 21
          TabOrder = 6
        end
      end
      object tsAdres: TTabSheet
        Caption = 'tsAdres'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lbltaxpayer_type_id: TLabel
          Left = 43
          Top = 10
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
        object lbltax_administration: TLabel
          Left = 44
          Top = 32
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
        object lbltax_no: TLabel
          Left = 67
          Top = 54
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
        object lblmersis_no: TLabel
          Left = 60
          Top = 76
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
        object lblweb_site: TLabel
          Left = 55
          Top = 112
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
        object lblemail: TLabel
          Left = 429
          Top = 112
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
        object lblcountry_id: TLabel
          Left = 90
          Top = 135
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
        object lblcity_id: TLabel
          Left = 443
          Top = 135
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
        object lbltown: TLabel
          Left = 95
          Top = 158
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
        object lbldistrict: TLabel
          Left = 428
          Top = 158
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
        object lblroad: TLabel
          Left = 80
          Top = 181
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
        object lblstreet: TLabel
          Left = 436
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
        object lblbuilding_name: TLabel
          Left = 91
          Top = 204
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
        object lbldoor_no: TLabel
          Left = 427
          Top = 204
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
        object lblpost_code: TLabel
          Left = 51
          Top = 227
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
        object lbltrade_register_number: TLabel
          Left = 392
          Top = 76
          Width = 81
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Ticari Sicil No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edttaxpayer_type_id: TEdit
          Left = 121
          Top = 7
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edttax_administration: TEdit
          Left = 121
          Top = 29
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edttax_no: TEdit
          Left = 121
          Top = 51
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtmersis_no: TEdit
          Left = 121
          Top = 73
          Width = 200
          Height = 21
          TabOrder = 3
        end
        object edtweb_site: TEdit
          Left = 121
          Top = 109
          Width = 200
          Height = 21
          TabOrder = 5
        end
        object edtemail: TEdit
          Left = 477
          Top = 109
          Width = 200
          Height = 21
          TabOrder = 6
        end
        object edtcity_id: TEdit
          Left = 477
          Top = 132
          Width = 200
          Height = 21
          TabOrder = 8
        end
        object edttown: TEdit
          Left = 121
          Top = 155
          Width = 200
          Height = 21
          TabOrder = 9
        end
        object edtdistrict: TEdit
          Left = 477
          Top = 155
          Width = 200
          Height = 21
          TabOrder = 10
        end
        object edtroad: TEdit
          Left = 121
          Top = 178
          Width = 200
          Height = 21
          TabOrder = 11
        end
        object edtstreet: TEdit
          Left = 477
          Top = 178
          Width = 200
          Height = 21
          TabOrder = 12
        end
        object edtbuilding_name: TEdit
          Left = 121
          Top = 201
          Width = 200
          Height = 21
          TabOrder = 13
        end
        object edtdoor_no: TEdit
          Left = 477
          Top = 201
          Width = 200
          Height = 21
          TabOrder = 14
        end
        object edtpost_code: TEdit
          Left = 121
          Top = 224
          Width = 200
          Height = 21
          TabOrder = 15
        end
        object edtcountry_id: TEdit
          Left = 121
          Top = 132
          Width = 200
          Height = 21
          TabOrder = 7
        end
        object edttrade_register_number: TEdit
          Left = 477
          Top = 73
          Width = 200
          Height = 21
          TabOrder = 4
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 302
    Width = 698
    ExplicitTop = 302
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
    Top = 346
    Width = 702
    ExplicitTop = 346
    ExplicitWidth = 702
  end
  inherited AppEvntsBase: TApplicationEvents
    Left = 280
    Top = 24
  end
  inherited pmLabels: TPopupMenu
    Left = 352
    Top = 104
  end
end
