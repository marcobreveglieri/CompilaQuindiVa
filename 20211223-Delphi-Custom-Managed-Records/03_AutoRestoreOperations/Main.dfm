object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 369
    Height = 283
    ItemHeight = 13
    TabOrder = 0
  end
  object btnClassic: TButton
    Left = 383
    Top = 8
    Width = 244
    Height = 25
    Caption = 'Classic Mode'
    TabOrder = 1
    OnClick = btnClassicClick
  end
  object btnRecord: TButton
    Left = 383
    Top = 39
    Width = 244
    Height = 25
    Caption = 'CMRs Mode'
    TabOrder = 2
    OnClick = btnRecordClick
  end
  object btnClear: TButton
    Left = 383
    Top = 266
    Width = 244
    Height = 25
    Caption = 'Clear'
    TabOrder = 3
    OnClick = btnClearClick
  end
end
