inherited frmFilterDBGrid: TfrmFilterDBGrid
  Caption = 'Filter'
  ClientHeight = 485
  ClientWidth = 341
  ExplicitWidth = 357
  ExplicitHeight = 524
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 337
    Height = 419
    ExplicitWidth = 337
    ExplicitHeight = 419
    object lblFields: TLabel
      Left = 8
      Top = 127
      Width = 318
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Select Filter Data Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFilterKeyValue: TLabel
      Left = 27
      Top = 392
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
    object chklstFields: TCheckListBox
      Left = 8
      Top = 146
      Width = 318
      Height = 240
      ItemHeight = 13
      TabOrder = 1
    end
    object edtFilter: TthsEdit
      Left = 120
      Top = 389
      Width = 206
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
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
    object rgFilterCriter: TRadioGroup
      Left = 8
      Top = 8
      Width = 318
      Height = 113
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
  end
  inherited pnlBottom: TPanel
    Top = 423
    Width = 337
    ExplicitTop = 423
    ExplicitWidth = 337
    inherited btnAccept: TButton
      Left = 128
      ExplicitLeft = 128
    end
    inherited btnDelete: TButton
      Left = 24
      ExplicitLeft = 24
    end
    inherited btnClose: TButton
      Left = 232
      ExplicitLeft = 232
    end
  end
  inherited stbBase: TStatusBar
    Top = 467
    Width = 341
    ExplicitTop = 467
    ExplicitWidth = 341
  end
end
