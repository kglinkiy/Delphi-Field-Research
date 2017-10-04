object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'fMain'
  ClientHeight = 158
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnShow: TSpeedButton
    Left = 391
    Top = 8
    Width = 81
    Height = 22
    OnClick = btnShowClick
  end
  object mmoOutput: TDBMemo
    Left = 8
    Top = 8
    Width = 377
    Height = 145
    TabOrder = 0
  end
  object edtName: TEdit
    Left = 504
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edtName'
  end
  object cbIsFired: TCheckBox
    Left = 504
    Top = 62
    Width = 97
    Height = 17
    Caption = #1059#1074#1086#1083#1077#1085'!'
    TabOrder = 2
  end
  object edtAge: TSpinEdit
    Left = 504
    Top = 35
    Width = 121
    Height = 22
    MaxValue = 100
    MinValue = 20
    TabOrder = 3
    Value = 30
  end
end
