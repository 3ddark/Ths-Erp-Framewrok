inherited frmHesapKarti: TfrmHesapKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Hesap Kart'#305
  ClientHeight = 365
  ClientWidth = 688
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 694
  ExplicitHeight = 394
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 684
    Height = 299
    Color = clWindow
    ExplicitWidth = 684
    ExplicitHeight = 299
  end
  inherited pnlBottom: TPanel
    Top = 303
    Width = 684
    ExplicitTop = 303
    ExplicitWidth = 684
    inherited btnAccept: TButton
      Left = 475
      ExplicitLeft = 475
    end
    inherited btnDelete: TButton
      Left = 371
      ExplicitLeft = 371
    end
    inherited btnClose: TButton
      Left = 579
      ExplicitLeft = 579
    end
  end
  inherited stbBase: TStatusBar
    Top = 347
    Width = 688
    ExplicitTop = 347
    ExplicitWidth = 688
  end
  object pgcHesapKarti: TPageControl [3]
    Left = 0
    Top = 0
    Width = 688
    Height = 301
    ActivePage = tsGenel
    Align = alClient
    TabOrder = 3
    object tsGenel: TTabSheet
      Caption = 'tsGenel'
      object lblHesapKodu: TLabel
        Left = 76
        Top = 5
        Width = 70
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Hesap Kodu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblHesapIsmi: TLabel
        Left = 83
        Top = 27
        Width = 63
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Hesap '#304'smi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblHesapGrubu: TLabel
        Left = 71
        Top = 49
        Width = 75
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Hesap Grubu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblMukellefTipi: TLabel
        Left = 72
        Top = 101
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
      object lblMukellefAdi: TLabel
        Left = 417
        Top = 101
        Width = 71
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'M'#252'kellef Ad'#305
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblMukellefIkinciAdi: TLabel
        Left = 382
        Top = 123
        Width = 106
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'M'#252'kellef '#304'kinci Ad'#305
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblMukellefSoyadi: TLabel
        Left = 397
        Top = 145
        Width = 91
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'M'#252'kellef Soyad'#305
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblVergiDairesi: TLabel
        Left = 73
        Top = 123
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
      object lblVergiNo: TLabel
        Left = 96
        Top = 145
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
      object lblNaceKodu: TLabel
        Left = 424
        Top = 211
        Width = 64
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Nace Kodu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblParaBirimi: TLabel
        Left = 85
        Top = 167
        Width = 61
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Para Birimi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblBolge: TLabel
        Left = 455
        Top = 49
        Width = 33
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'B'#246'lge'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblTemsilciGrubu: TLabel
        Left = 403
        Top = 71
        Width = 85
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Temsilci Grubu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblMusteriTemsilcisi: TLabel
        Left = 45
        Top = 211
        Width = 101
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'M'#252#351'teri Temsilcisi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblIbanNo: TLabel
        Left = 60
        Top = 189
        Width = 86
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'IBAN Numaras'#305
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblIsEFaturaHesabi: TLabel
        Left = 47
        Top = 233
        Width = 99
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'E-Fatura Hesab'#305'?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtHesapKodu: TEdit
        Left = 150
        Top = 2
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object edtHesapIsmi: TEdit
        Left = 150
        Top = 24
        Width = 522
        Height = 21
        TabOrder = 1
      end
      object edtHesapGrubu: TEdit
        Left = 150
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 2
      end
      object cbbMukellefTipi: TComboBox
        Left = 150
        Top = 98
        Width = 69
        Height = 21
        Style = csDropDownList
        TabOrder = 5
        OnChange = cbbMukellefTipiChange
      end
      object edtMukellefAdi: TEdit
        Left = 492
        Top = 98
        Width = 180
        Height = 21
        TabOrder = 6
      end
      object edtMukellefIkinciAdi: TEdit
        Left = 492
        Top = 120
        Width = 180
        Height = 21
        TabOrder = 7
      end
      object edtMukellefSoyadi: TEdit
        Left = 492
        Top = 142
        Width = 180
        Height = 21
        TabOrder = 8
      end
      object edtVergiDairesi: TEdit
        Left = 150
        Top = 120
        Width = 180
        Height = 21
        TabOrder = 9
      end
      object edtVergiNo: TEdit
        Left = 150
        Top = 142
        Width = 180
        Height = 21
        TabOrder = 10
      end
      object edtNaceKodu: TEdit
        Left = 492
        Top = 208
        Width = 180
        Height = 21
        TabOrder = 15
      end
      object cbbParaBirimi: TComboBox
        Left = 150
        Top = 164
        Width = 69
        Height = 21
        Style = csDropDownList
        TabOrder = 11
      end
      object cbbTemsilciGrubu: TComboBox
        Left = 492
        Top = 68
        Width = 180
        Height = 21
        Style = csDropDownList
        TabOrder = 4
      end
      object edtMusteriTemsilcisi: TEdit
        Left = 150
        Top = 208
        Width = 180
        Height = 21
        TabOrder = 14
      end
      object edtIbanNo: TEdit
        Left = 150
        Top = 186
        Width = 336
        Height = 21
        TabOrder = 12
      end
      object cbbIbanParaBirimi: TComboBox
        Left = 492
        Top = 186
        Width = 69
        Height = 21
        Style = csDropDownList
        TabOrder = 13
      end
      object chkIsEFaturaHesabi: TCheckBox
        Left = 150
        Top = 230
        Width = 180
        Height = 21
        TabOrder = 16
      end
      object cbbBolge: TComboBox
        Left = 492
        Top = 46
        Width = 180
        Height = 21
        Style = csDropDownList
        TabOrder = 3
      end
    end
    object tsAdres: TTabSheet
      Caption = 'tsAdres'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPostaKutusu: TLabel
        Left = 70
        Top = 225
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
      object lblBina: TLabel
        Left = 120
        Top = 181
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
      object lblSokak: TLabel
        Left = 109
        Top = 159
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
      object lblCadde: TLabel
        Left = 109
        Top = 137
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
      object lblMahalle: TLabel
        Left = 101
        Top = 115
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
      object lblIlce: TLabel
        Left = 124
        Top = 93
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
      object lblSehir: TLabel
        Left = 116
        Top = 71
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
      object lblUlke: TLabel
        Left = 119
        Top = 49
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
      object lblPostaKodu: TLabel
        Left = 80
        Top = 247
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
      object lblKapiNo: TLabel
        Left = 100
        Top = 203
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
      object edtUlke: TEdit
        Left = 150
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object edtSehir: TEdit
        Left = 150
        Top = 68
        Width = 180
        Height = 21
        TabOrder = 1
      end
      object edtIlce: TEdit
        Left = 150
        Top = 90
        Width = 180
        Height = 21
        TabOrder = 2
      end
      object edtMahalle: TEdit
        Left = 150
        Top = 112
        Width = 180
        Height = 21
        TabOrder = 3
      end
      object edtCadde: TEdit
        Left = 150
        Top = 134
        Width = 180
        Height = 21
        TabOrder = 4
      end
      object edtSokak: TEdit
        Left = 150
        Top = 156
        Width = 180
        Height = 21
        TabOrder = 5
      end
      object edtBina: TEdit
        Left = 150
        Top = 178
        Width = 180
        Height = 21
        TabOrder = 6
      end
      object edtKapiNo: TEdit
        Left = 150
        Top = 200
        Width = 180
        Height = 21
        TabOrder = 7
      end
      object edtPostaKutusu: TEdit
        Left = 150
        Top = 222
        Width = 180
        Height = 21
        TabOrder = 8
      end
      object edtPostaKodu: TEdit
        Left = 150
        Top = 244
        Width = 180
        Height = 21
        TabOrder = 9
      end
    end
    object tsIletisim: TTabSheet
      Caption = 'tsIletisim'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblYetkiliKisi2: TLabel
        Left = 75
        Top = 71
        Width = 71
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Yetkili Kisi 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblYetkiliKisi1: TLabel
        Left = 75
        Top = 49
        Width = 71
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Yetkili Ki'#351'i 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblTelefon1: TLabel
        Left = 91
        Top = 101
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
      object lblTelefon2: TLabel
        Left = 91
        Top = 123
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
      object lblTelefon3: TLabel
        Left = 91
        Top = 145
        Width = 55
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Telefon 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblFaks: TLabel
        Left = 118
        Top = 167
        Width = 28
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Faks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblWebSitesi: TLabel
        Left = 84
        Top = 189
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
      object lblePostaAdresi: TLabel
        Left = 62
        Top = 211
        Width = 84
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'E-Posta Adresi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblMuhasebeTelefon: TLabel
        Left = 382
        Top = 101
        Width = 106
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Muhasebe Telefon'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblMuhasebeEPosta: TLabel
        Left = 381
        Top = 123
        Width = 107
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Muhasebe E-Posta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblYetkiliKisi2Telefon: TLabel
        Left = 391
        Top = 71
        Width = 94
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Yetkili 2 Telefon'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblYetkiliKisi1Telefon: TLabel
        Left = 391
        Top = 49
        Width = 94
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Yetkili 1 Telefon'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblOzelBilgi: TLabel
        Left = 90
        Top = 233
        Width = 54
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = #214'zel Bilgi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 387
        Top = 145
        Width = 98
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Muhasebe Yetkili'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtYetkiliKisi1: TEdit
        Left = 150
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object edtYetkiliKisi1Telefon: TEdit
        Left = 492
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 1
      end
      object edtYetkiliKisi2: TEdit
        Left = 150
        Top = 68
        Width = 180
        Height = 21
        TabOrder = 2
      end
      object edtYetkiliKisi2Telefon: TEdit
        Left = 492
        Top = 68
        Width = 180
        Height = 21
        TabOrder = 3
      end
      object edtTelefon1: TEdit
        Left = 150
        Top = 98
        Width = 180
        Height = 21
        TabOrder = 4
      end
      object edtTelefon2: TEdit
        Left = 150
        Top = 120
        Width = 180
        Height = 21
        TabOrder = 5
      end
      object edtTelefon3: TEdit
        Left = 150
        Top = 142
        Width = 180
        Height = 21
        TabOrder = 6
      end
      object edtFaks: TEdit
        Left = 150
        Top = 164
        Width = 180
        Height = 21
        TabOrder = 7
      end
      object edtWebSitesi: TEdit
        Left = 150
        Top = 186
        Width = 180
        Height = 21
        TabOrder = 8
      end
      object edtePostaAdresi: TEdit
        Left = 150
        Top = 208
        Width = 180
        Height = 21
        TabOrder = 9
      end
      object edtMuhasebeTelefon: TEdit
        Left = 492
        Top = 98
        Width = 180
        Height = 21
        TabOrder = 10
      end
      object edtMuhasebeEPosta: TEdit
        Left = 492
        Top = 120
        Width = 180
        Height = 21
        TabOrder = 11
      end
      object mmoOzelBilgi: TMemo
        Left = 150
        Top = 230
        Width = 522
        Height = 21
        TabOrder = 12
      end
      object Edit3: TEdit
        Left = 492
        Top = 142
        Width = 180
        Height = 21
        TabOrder = 13
      end
    end
    object tsDiger: TTabSheet
      Caption = 'tsDiger'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblOdemeVadeGunSayisi: TLabel
        Left = 33
        Top = 49
        Width = 137
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = #214'deme Vade G'#252'n Say'#305's'#305
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblIsAcikHesap: TLabel
        Left = 97
        Top = 71
        Width = 73
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'A'#231#305'k Hesap?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblKrediLimiti: TLabel
        Left = 107
        Top = 93
        Width = 63
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Kredi Limiti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblHesapIskonto: TLabel
        Left = 87
        Top = 115
        Width = 83
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Hesap '#304'skonto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtOdemeVadeGunSayisi: TEdit
        Left = 174
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object chkIsAcikHesap: TCheckBox
        Left = 174
        Top = 68
        Width = 180
        Height = 21
        TabOrder = 1
      end
      object edtKrediLimiti: TEdit
        Left = 174
        Top = 90
        Width = 180
        Height = 21
        TabOrder = 2
      end
      object edtHesapIskonto: TEdit
        Left = 174
        Top = 112
        Width = 180
        Height = 21
        TabOrder = 3
      end
    end
  end
end
