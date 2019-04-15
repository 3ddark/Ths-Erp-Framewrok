inherited frmBaseInput: TfrmBaseInput
  Caption = 'frmBaseInput'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    object pgcMain: TPageControl
      Left = 1
      Top = 1
      Width = 600
      Height = 334
      ActivePage = tsMain
      Align = alClient
      TabOrder = 0
      object tsMain: TTabSheet
        Caption = 'tsMain'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  inherited AppEvntsBase: TApplicationEvents
    Left = 104
    Top = 0
  end
  object pmLabels: TPopupMenu
    Left = 40
    object mniAddLanguageContent: TMenuItem
      Caption = 'Add Language Data'
      OnClick = mniAddLanguageContentClick
    end
    object mniEditFormTitleByLang: TMenuItem
      Caption = 'Edit Form Title By Language'
      OnClick = mniEditFormTitleByLangClick
    end
  end
end
