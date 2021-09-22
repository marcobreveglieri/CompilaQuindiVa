object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Barcode Client'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 21
  object ProductCodeLabel: TLabel
    Left = 32
    Top = 24
    Width = 94
    Height = 21
    Caption = '&Product Code'
    FocusControl = CodeEdit
  end
  object CodeEdit: TEdit
    Left = 176
    Top = 21
    Width = 441
    Height = 29
    TabOrder = 0
  end
  object ConnectButton: TButton
    Left = 176
    Top = 104
    Width = 185
    Height = 25
    Caption = 'Connect'
    TabOrder = 1
    OnClick = ConnectButtonClick
  end
  object BarcodeManager: TTetheringManager
    OnEndAutoConnect = BarcodeManagerEndAutoConnect
    Text = 'BarcodeManager'
    AllowedAdapters = 'Network'
    SynchronizeEvents = False
    Left = 72
    Top = 200
  end
  object BarcodeAppProfile: TTetheringAppProfile
    Manager = BarcodeManager
    Text = 'BarcodeAppProfile'
    Group = 'Barcode'
    Actions = <>
    Resources = <>
    OnResourceReceived = BarcodeAppProfileResourceReceived
    Left = 200
    Top = 200
  end
end
