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
        Height = 13
        Margins.Left = 4
        Margins.Top = 6
        Margins.Right = 4
        Margins.Bottom = 6
        Align = alLeft
        Caption = 'lblFilter'
      end
      object edtFilter: TEdit
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
        ExplicitHeight = 21
      end
    end
  end
end
