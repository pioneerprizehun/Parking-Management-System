object Form1: TForm1
  Left = 654
  Top = 353
  BorderStyle = bsSingle
  Caption = #51452#52264#44288#47532' '#49884#49828#53596' '#47196#44536#51064
  ClientHeight = 250
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 2
    Width = 286
    Height = 92
    Caption = #47196#44536#51064
    TabOrder = 0
    object editID: TEdit
      Left = 16
      Top = 24
      Width = 161
      Height = 23
      ImeMode = imDisable
      TabOrder = 0
      Text = 'ID'
    end
    object editPW: TEdit
      Left = 16
      Top = 53
      Width = 161
      Height = 23
      ImeMode = imDisable
      PasswordChar = '*'
      TabOrder = 1
      Text = 'PW'
    end
    object btnLogin: TButton
      Left = 183
      Top = 24
      Width = 75
      Height = 53
      Caption = #47196#44536#51064
      TabOrder = 2
      OnClick = btnLoginClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 120
    Width = 337
    Height = 120
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\js22\Desktop\libmariadb.dll'
    Left = 40
    Top = 280
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 264
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=parkinglot'
      'User_Name=root'
      'Password=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Left = 192
    Top = 264
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 264
    Top = 304
  end
end
