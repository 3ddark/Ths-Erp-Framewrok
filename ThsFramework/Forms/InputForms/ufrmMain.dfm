inherited frmMain: TfrmMain
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Main'
  ClientHeight = 469
  ClientWidth = 771
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  DefaultMonitor = dmDesktop
  Font.Name = 'Lucida Sans'
  Menu = mmMain
  Position = poDesktopCenter
  ExplicitWidth = 777
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 767
    Height = 403
    Color = clBtnFace
    ExplicitWidth = 767
    ExplicitHeight = 403
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 765
      Height = 401
      ActivePage = tsSettings
      Align = alClient
      TabOrder = 0
      object tsGeneral: TTabSheet
        Caption = 'General'
        object btnUlkeler: TButton
          Left = 2
          Top = 2
          Width = 180
          Height = 36
          Caption = #220'LKELER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnUlkelerClick
        end
        object btnSehirler: TButton
          Left = 2
          Top = 44
          Width = 180
          Height = 36
          Caption = #350'EH'#304'RLER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnSehirlerClick
        end
        object btnParaBirimleri: TButton
          Left = 2
          Top = 86
          Width = 180
          Height = 36
          Caption = 'PARA B'#304'R'#304'MLER'#304
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btnParaBirimleriClick
        end
      end
      object tsBuying: TTabSheet
        Caption = 'tsBuying'
        ImageIndex = 1
      end
      object tsSales: TTabSheet
        Caption = 'tsSales'
        ImageIndex = 2
      end
      object tsStock: TTabSheet
        Caption = 'tsStock'
        ImageIndex = 3
        object btnStokHareketi: TButton
          Left = 2
          Top = 2
          Width = 180
          Height = 36
          Caption = 'STOK HAREKETLER'#304
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnStokHareketiClick
        end
      end
      object tsAccounting: TTabSheet
        Caption = 'tsAccounting'
        ImageIndex = 4
      end
      object tsProduction: TTabSheet
        Caption = 'tsProduction'
        ImageIndex = 5
      end
      object tsEquipment: TTabSheet
        Caption = 'tsEquipment'
        ImageIndex = 6
      end
      object tsStaff: TTabSheet
        Caption = 'tsStaff'
        ImageIndex = 7
      end
      object tsSettings: TTabSheet
        Caption = 'tsSettings'
        ImageIndex = 9
        object btnAyarStokHareketTipi: TButton
          Left = 2
          Top = 2
          Width = 180
          Height = 36
          Caption = 'AYAR STOK HAREKET T'#304'P'#304
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnAyarStokHareketTipiClick
        end
      end
      object tsFrameworkSettings: TTabSheet
        Caption = 'tsFrameworkSettings'
        ImageIndex = 8
        object btnSysPermissionSource: TButton
          Left = 2
          Top = 2
          Width = 180
          Height = 36
          Caption = 'PERMISSION SOURCE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnSysPermissionSourceClick
        end
        object btnSysPermissionSourceGroup: TButton
          Left = 188
          Top = 2
          Width = 180
          Height = 36
          Caption = 'PERMISSION SOURCE GROUP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = btnSysPermissionSourceGroupClick
        end
        object btnSysUserAccessRight: TButton
          Left = 374
          Top = 2
          Width = 180
          Height = 36
          Caption = 'USER ACCESS RIGHT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          WordWrap = True
          OnClick = btnSysUserAccessRightClick
        end
        object btnSysLang: TButton
          Left = 560
          Top = 2
          Width = 180
          Height = 36
          Caption = 'LANGUAGE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          WordWrap = True
          OnClick = btnSysLangClick
        end
        object btnSysGridColWidth: TButton
          Left = 2
          Top = 44
          Width = 180
          Height = 36
          Caption = 'GRID COLUMN WIDTH'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          WordWrap = True
          OnClick = btnSysGridColWidthClick
        end
        object btnSysGridColColor: TButton
          Left = 188
          Top = 44
          Width = 180
          Height = 36
          Caption = 'GRID COL COLOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          WordWrap = True
          OnClick = btnSysGridColColorClick
        end
        object btnSysGridColPercent: TButton
          Left = 374
          Top = 44
          Width = 180
          Height = 36
          Caption = 'GRID COL PERCENT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          WordWrap = True
          OnClick = btnSysGridColPercentClick
        end
        object btnSysLangContent: TButton
          Left = 560
          Top = 44
          Width = 180
          Height = 36
          Caption = 'SYSTEM LANGUAGE CONTENTS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          WordWrap = True
          OnClick = btnSysLangContentClick
        end
        object btnSysQualityFormNumber: TButton
          Left = 2
          Top = 85
          Width = 180
          Height = 36
          Caption = 'SYS QUALITY FORM NUMBER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          WordWrap = True
          OnClick = btnSysQualityFormNumberClick
        end
        object btnSysDefaultOrderFilter: TButton
          Left = 188
          Top = 85
          Width = 180
          Height = 36
          Caption = 'SYS DEFAULT FILTER AND DEFAULT SORT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          WordWrap = True
          OnClick = btnSysDefaultOrderFilterClick
        end
        object btnSysTableLangContent: TButton
          Left = 374
          Top = 85
          Width = 180
          Height = 36
          Caption = 'SYSTEM TABLE LANGUAGE CONTENTS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 10
          WordWrap = True
          OnClick = btnSysTableLangContentClick
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 407
    Width = 767
    Color = clBtnFace
    ParentBackground = False
    ExplicitTop = 407
    ExplicitWidth = 767
    inherited btnAccept: TButton
      Left = 558
      ExplicitLeft = 558
    end
    inherited btnDelete: TButton
      Left = 454
      ExplicitLeft = 454
    end
    inherited btnClose: TButton
      Left = 662
      ExplicitLeft = 662
    end
  end
  inherited stbBase: TStatusBar
    Top = 451
    Width = 771
    ExplicitTop = 451
    ExplicitWidth = 771
  end
  inherited AppEvntsBase: TApplicationEvents
    OnIdle = AppEvntsBaseIdle
    Left = 48
    Top = 192
  end
  object mmMain: TMainMenu [4]
    Left = 144
    Top = 192
    object mniApplication: TMenuItem
      Caption = 'Application'
      object mniClose: TMenuItem
        Caption = 'Close'
      end
    end
    object mniSettings: TMenuItem
      Caption = 'Settings'
      object mniChangePassword: TMenuItem
        Caption = 'Change Password'
      end
      object mniAdministration: TMenuItem
        Caption = 'Administration'
      end
    end
    object mniAbout: TMenuItem
      Caption = 'About'
      OnClick = mniAboutClick
    end
  end
  inherited il32x32: TImageList
    Left = 256
    Top = 272
  end
  inherited il16x16: TImageList
    Left = 208
    Top = 272
  end
  object pmButtons: TPopupMenu
    Left = 376
    Top = 248
    object mniAddLanguageContent: TMenuItem
      Caption = 'Add Language Data'
      OnClick = mniAddLanguageContentClick
    end
  end
end
