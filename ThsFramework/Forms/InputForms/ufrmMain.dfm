inherited frmMain: TfrmMain
  Caption = 'Main'
  ClientHeight = 459
  ClientWidth = 760
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  DefaultMonitor = dmPrimary
  Font.Name = 'Lucida Sans'
  Menu = mmMain
  Position = poDesktopCenter
  ExplicitWidth = 776
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 756
    Height = 393
    Color = clBtnFace
    ExplicitWidth = 623
    ExplicitHeight = 349
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 754
      Height = 391
      ActivePage = tsGeneral
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 621
      ExplicitHeight = 347
      object tsGeneral: TTabSheet
        Caption = 'General'
        ExplicitWidth = 613
        ExplicitHeight = 318
        object btnCountry: TButton
          Left = 633
          Top = 0
          Width = 110
          Height = 36
          Caption = 'COUNTRIES'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = btnCountryClick
        end
        object btnCity: TButton
          Left = 633
          Top = 42
          Width = 110
          Height = 36
          Caption = 'CITIES'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = btnCityClick
        end
        object btnCurrency: TButton
          Left = 633
          Top = 84
          Width = 110
          Height = 36
          Caption = 'CURRENCIES'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = btnCurrencyClick
        end
        object btnPermissionSource: TButton
          Left = 4
          Top = 42
          Width = 110
          Height = 36
          Caption = 'PERMISSION SOURCE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = btnPermissionSourceClick
        end
        object btnPermissionSourceGroup: TButton
          Left = 4
          Top = 0
          Width = 110
          Height = 36
          Caption = 'PERMISSION SOURCE GROUP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnPermissionSourceGroupClick
        end
        object btnUserAccessRight: TButton
          Left = 3
          Top = 84
          Width = 110
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
          OnClick = btnUserAccessRightClick
        end
      end
      object tsBuying: TTabSheet
        Caption = 'tsBuying'
        ImageIndex = 1
        ExplicitHeight = 318
      end
      object tsSales: TTabSheet
        Caption = 'tsSales'
        ImageIndex = 2
        ExplicitHeight = 318
      end
      object tsStock: TTabSheet
        Caption = 'tsStock'
        ImageIndex = 3
        ExplicitHeight = 318
      end
      object tsAccounting: TTabSheet
        Caption = 'tsAccounting'
        ImageIndex = 4
        ExplicitHeight = 318
      end
      object tsProduction: TTabSheet
        Caption = 'tsProduction'
        ImageIndex = 5
        ExplicitHeight = 318
      end
      object tsEquipment: TTabSheet
        Caption = 'tsEquipment'
        ImageIndex = 6
        ExplicitHeight = 318
      end
      object tsStaff: TTabSheet
        Caption = 'tsStaff'
        ImageIndex = 7
        ExplicitHeight = 318
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 397
    Width = 756
    Color = clBtnFace
    ParentBackground = False
    ExplicitTop = 353
    ExplicitWidth = 623
    inherited btnAccept: TButton
      Left = 547
      ExplicitLeft = 414
    end
    inherited btnDelete: TButton
      Left = 443
      ExplicitLeft = 310
    end
    inherited btnClose: TButton
      Left = 651
      ExplicitLeft = 518
    end
  end
  inherited stbBase: TStatusBar
    Top = 441
    Width = 760
    ExplicitTop = 397
    ExplicitWidth = 627
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
end
