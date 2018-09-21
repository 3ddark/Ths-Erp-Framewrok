inherited frmBaseHelper: TfrmBaseHelper
  Caption = 'frmBaseHelper'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited pnlHeader: TPanel
      object lblFilter: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 7
        Width = 34
        Height = 16
        Margins.Left = 4
        Margins.Top = 6
        Margins.Right = 4
        Margins.Bottom = 6
        Align = alLeft
        Caption = 'lblFilter'
        ExplicitHeight = 13
      end
      object edtFilter: TthsEdit
        AlignWithMargins = True
        Left = 47
        Top = 5
        Width = 530
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        TabOrder = 0
        Text = 'edtFilter'
        OnChange = edtFilterChange
        OnKeyDown = edtFilterKeyDown
        OnKeyUp = edtFilterKeyUp
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
        ExplicitHeight = 21
      end
    end
  end
end
