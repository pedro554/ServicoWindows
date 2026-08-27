object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Button1: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 170
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Reiniciar'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 251
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ativo?'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 332
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Existe'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 413
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Status'
    TabOrder = 5
    OnClick = Button6Click
  end
end
