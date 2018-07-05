inherited frmFilterDBGrid: TfrmFilterDBGrid
  Caption = 'Filter'
  ClientHeight = 434
  ClientWidth = 414
  ExplicitWidth = 430
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 410
    Height = 368
    ExplicitWidth = 410
    ExplicitHeight = 368
    object lblFields: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 103
      Width = 402
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Select data fields to filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 8
      ExplicitTop = 127
      ExplicitWidth = 318
    end
    object chklstFields: TCheckListBox
      AlignWithMargins = True
      Left = 4
      Top = 122
      Width = 402
      Height = 208
      Align = alClient
      Columns = 2
      ItemHeight = 13
      TabOrder = 1
    end
    object rgFilterCriter: TRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 402
      Height = 93
      Align = alTop
      Caption = 'Filter Criteria'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '='
        'like'
        'not like'
        'with start...'
        '...with end'
        '<>'
        '>'
        '<'
        '>='
        '<=')
      TabOrder = 0
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 336
      Width = 402
      Height = 28
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        402
        28)
      object lblFilterKeyValue: TLabel
        Left = 54
        Top = 5
        Width = 87
        Height = 13
        Alignment = taRightJustify
        Caption = 'Filter Key Value'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtFilter: TthsEdit
        Left = 144
        Top = 2
        Width = 256
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        TabOrder = 0
        Text = 'EDTFILTER'
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 372
    Width = 410
    ExplicitTop = 372
    ExplicitWidth = 410
    inherited btnAccept: TButton
      Left = 201
      ExplicitLeft = 201
    end
    inherited btnDelete: TButton
      Left = 97
      ExplicitLeft = 97
    end
    inherited btnClose: TButton
      Left = 305
      ExplicitLeft = 305
    end
  end
  inherited stbBase: TStatusBar
    Top = 416
    Width = 414
    ExplicitTop = 416
    ExplicitWidth = 414
  end
  inherited il32x32: TImageList
    Top = 184
  end
  inherited il16x16: TImageList
    Left = 104
    Top = 184
  end
end
