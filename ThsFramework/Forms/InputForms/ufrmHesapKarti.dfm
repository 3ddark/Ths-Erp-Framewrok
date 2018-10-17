inherited frmHesapKarti: TfrmHesapKarti
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Hesap Kart'#305
  ClientHeight = 483
  ClientWidth = 703
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 709
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 699
    Height = 417
    Color = clWindow
    ExplicitWidth = 734
    ExplicitHeight = 476
  end
  inherited pnlBottom: TPanel
    Top = 421
    Width = 699
    ExplicitTop = 480
    ExplicitWidth = 734
    inherited btnAccept: TButton
      Left = 490
      ExplicitLeft = 525
    end
    inherited btnDelete: TButton
      Left = 386
      ExplicitLeft = 421
    end
    inherited btnClose: TButton
      Left = 594
      ExplicitLeft = 629
    end
  end
  inherited stbBase: TStatusBar
    Top = 465
    Width = 703
    ExplicitTop = 524
    ExplicitWidth = 738
  end
  object pgcHesapKarti: TPageControl [3]
    Left = 0
    Top = 0
    Width = 703
    Height = 419
    ActivePage = tsGenel
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 738
    ExplicitHeight = 478
    object tsGenel: TTabSheet
      Caption = 'tsGenel'
      ExplicitWidth = 730
      ExplicitHeight = 450
      object lblHesapKodu: TLabel
        Left = 96
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
        Left = 103
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
        Left = 91
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
        Left = 92
        Top = 105
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
        Left = 95
        Top = 127
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
        Left = 60
        Top = 149
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
        Left = 75
        Top = 171
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
        Left = 435
        Top = 105
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
        Left = 458
        Top = 127
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
        Left = 444
        Top = 171
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
        Left = 447
        Top = 149
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
        Left = 475
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
      object lblKategori: TLabel
        Left = 118
        Top = 71
        Width = 48
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Kategori'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblTemsilciGrubu: TLabel
        Left = 423
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
        Left = 65
        Top = 223
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
        Left = 80
        Top = 201
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
        Left = 67
        Top = 248
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
        Left = 170
        Top = 2
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object edtHesapIsmi: TEdit
        Left = 170
        Top = 24
        Width = 522
        Height = 21
        TabOrder = 1
      end
      object edtHesapGrubu: TEdit
        Left = 170
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 2
      end
      object cbbMukellefTipi: TComboBox
        Left = 170
        Top = 102
        Width = 180
        Height = 21
        Style = csDropDownList
        TabOrder = 3
      end
      object edtMukellefAdi: TEdit
        Left = 170
        Top = 124
        Width = 180
        Height = 21
        TabOrder = 4
      end
      object edtMukellefIkinciAdi: TEdit
        Left = 170
        Top = 146
        Width = 180
        Height = 21
        TabOrder = 5
      end
      object edtMukellefSoyadi: TEdit
        Left = 170
        Top = 168
        Width = 180
        Height = 21
        TabOrder = 6
      end
      object edtVergiDairesi: TEdit
        Left = 512
        Top = 102
        Width = 180
        Height = 21
        TabOrder = 7
      end
      object edtVergiNo: TEdit
        Left = 512
        Top = 124
        Width = 180
        Height = 21
        TabOrder = 8
      end
      object edtNaceKodu: TEdit
        Left = 512
        Top = 168
        Width = 180
        Height = 21
        TabOrder = 9
      end
      object cbbParaBirimi: TComboBox
        Left = 512
        Top = 146
        Width = 180
        Height = 21
        Style = csDropDownList
        TabOrder = 10
      end
      object edtBolge: TEdit
        Left = 512
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 11
      end
      object cbbKategori: TComboBox
        Left = 170
        Top = 68
        Width = 180
        Height = 21
        Style = csDropDownList
        TabOrder = 12
      end
      object cbbTemsilciGrubu: TComboBox
        Left = 512
        Top = 68
        Width = 180
        Height = 21
        Style = csDropDownList
        TabOrder = 13
      end
      object edtMusteriTemsilcisi: TEdit
        Left = 170
        Top = 220
        Width = 180
        Height = 21
        TabOrder = 14
      end
      object edtIbanNo: TEdit
        Left = 170
        Top = 198
        Width = 336
        Height = 21
        TabOrder = 15
      end
      object cbbIbanParaBirimi: TComboBox
        Left = 512
        Top = 198
        Width = 180
        Height = 21
        Style = csDropDownList
        TabOrder = 16
      end
      object chkIsEFaturaHesabi: TCheckBox
        Left = 170
        Top = 247
        Width = 180
        Height = 17
        TabOrder = 17
      end
    end
    object tsAdres: TTabSheet
      Caption = 'tsAdres'
      ImageIndex = 1
      ExplicitWidth = 730
      ExplicitHeight = 450
      object lblOdemeVadeGunSayisi: TLabel
        Left = 29
        Top = 303
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
        Left = 93
        Top = 328
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
        Left = 103
        Top = 359
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
      object lblPostaKutusu: TLabel
        Left = 90
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
      object lblPostaKodu: TLabel
        Left = 100
        Top = 203
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
      object lblBina: TLabel
        Left = 140
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
        Left = 129
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
        Left = 129
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
        Left = 121
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
        Left = 144
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
        Left = 136
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
        Left = 139
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
      object edtOdemeVadeGunSayisi: TEdit
        Left = 170
        Top = 300
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object chkIsAcikHesap: TCheckBox
        Left = 170
        Top = 327
        Width = 180
        Height = 17
        TabOrder = 1
      end
      object edtKrediLimiti: TEdit
        Left = 170
        Top = 350
        Width = 180
        Height = 21
        TabOrder = 2
      end
      object edtPostaKutusu: TEdit
        Left = 170
        Top = 222
        Width = 180
        Height = 21
        TabOrder = 3
      end
      object edtPostaKodu: TEdit
        Left = 170
        Top = 200
        Width = 180
        Height = 21
        TabOrder = 4
      end
      object edtBina: TEdit
        Left = 170
        Top = 178
        Width = 180
        Height = 21
        TabOrder = 5
      end
      object edtSokak: TEdit
        Left = 170
        Top = 156
        Width = 180
        Height = 21
        TabOrder = 6
      end
      object edtCadde: TEdit
        Left = 170
        Top = 134
        Width = 180
        Height = 21
        TabOrder = 7
      end
      object edtMahalle: TEdit
        Left = 170
        Top = 112
        Width = 180
        Height = 21
        TabOrder = 8
      end
      object edtIlce: TEdit
        Left = 170
        Top = 90
        Width = 180
        Height = 21
        TabOrder = 9
      end
      object edtSehir: TEdit
        Left = 170
        Top = 68
        Width = 180
        Height = 21
        TabOrder = 10
      end
      object edtUlke: TEdit
        Left = 170
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 11
      end
    end
    object tsIletisim: TTabSheet
      Caption = 'tsIletisim'
      ImageIndex = 2
      ExplicitWidth = 730
      ExplicitHeight = 450
      object lblYetkiliKisi2: TLabel
        Left = 95
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
        Left = 95
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
        Left = 111
        Top = 98
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
        Left = 111
        Top = 120
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
        Left = 111
        Top = 142
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
        Left = 138
        Top = 164
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
        Left = 104
        Top = 186
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
        Left = 82
        Top = 208
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
        Left = 60
        Top = 236
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
        Left = 59
        Top = 258
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
      object Label1: TLabel
        Left = 414
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
      object Label2: TLabel
        Left = 414
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
      object edtYetkiliKisi2: TEdit
        Left = 170
        Top = 68
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object edtYetkiliKisi1: TEdit
        Left = 170
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 1
      end
      object edtTelefon1: TEdit
        Left = 170
        Top = 95
        Width = 180
        Height = 21
        TabOrder = 2
      end
      object edtTelefon2: TEdit
        Left = 170
        Top = 117
        Width = 180
        Height = 21
        TabOrder = 3
      end
      object edtTelefon3: TEdit
        Left = 170
        Top = 139
        Width = 180
        Height = 21
        TabOrder = 4
      end
      object edtFaks: TEdit
        Left = 170
        Top = 161
        Width = 180
        Height = 21
        TabOrder = 5
      end
      object edtWebSitesi: TEdit
        Left = 170
        Top = 183
        Width = 180
        Height = 21
        TabOrder = 6
      end
      object edtePostaAdresi: TEdit
        Left = 170
        Top = 205
        Width = 180
        Height = 21
        TabOrder = 7
      end
      object edtMuhasebeTelefon: TEdit
        Left = 170
        Top = 233
        Width = 180
        Height = 21
        TabOrder = 8
      end
      object edtMuhasebeEPosta: TEdit
        Left = 170
        Top = 255
        Width = 180
        Height = 21
        TabOrder = 9
      end
      object Edit1: TEdit
        Left = 512
        Top = 68
        Width = 180
        Height = 21
        TabOrder = 10
      end
      object Edit2: TEdit
        Left = 512
        Top = 46
        Width = 180
        Height = 21
        TabOrder = 11
      end
    end
    object tsDiger: TTabSheet
      Caption = 'tsDiger'
      ImageIndex = 3
      ExplicitWidth = 730
      ExplicitHeight = 450
      object lblOzelBilgi: TLabel
        Left = 110
        Top = 52
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
      object mmoOzelBilgi: TMemo
        Left = 170
        Top = 49
        Width = 522
        Height = 21
        TabOrder = 0
      end
    end
  end
end
