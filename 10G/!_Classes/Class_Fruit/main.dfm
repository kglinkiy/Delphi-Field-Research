object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'fMain'
  ClientHeight = 152
  ClientWidth = 585
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
    Left = 351
    Top = 8
    Width = 97
    Height = 22
    OnClick = btnShowClick
  end
  object edtName: TEdit
    Left = 454
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'edtName'
  end
  object isGreen: TCheckBox
    Left = 454
    Top = 86
    Width = 97
    Height = 17
    Caption = 'isGreen'
    TabOrder = 1
  end
  object mmoOutput: TMemo
    Left = 8
    Top = 8
    Width = 329
    Height = 137
    Lines.Strings = (
      'mmoOutput')
    TabOrder = 2
  end
  object edtDiameter: TSpinEdit
    Left = 454
    Top = 35
    Width = 121
    Height = 22
    MaxValue = 50
    MinValue = 10
    TabOrder = 3
    Value = 10
  end
  object isDiameterless: TCheckBox
    Left = 454
    Top = 63
    Width = 97
    Height = 17
    Caption = 'isDiameterless'
    TabOrder = 4
  end
end
