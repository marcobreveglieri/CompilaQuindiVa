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
  object btnClassic: TButton
    Left = 24
    Top = 16
    Width = 145
    Height = 25
    Caption = 'Classic Mode'
    TabOrder = 0
    OnClick = btnClassicClick
  end
  object btnCmrs: TButton
    Left = 24
    Top = 47
    Width = 145
    Height = 25
    Caption = 'CMRs Mode'
    TabOrder = 1
    OnClick = btnCmrsClick
  end
end
