object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cbbid: TAppLookupComboBox
    Left = 224
    Top = 72
    Width = 145
    Height = 21
    DataSource = DataSource2
    DataField = 'id'
    ListSource = DataSource1
    ListField = 'usuario'
    KeyField = 'id'
    TabOrder = 0
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Server=sistemashoras.mysql.uhserver.com'
      'Database=sistemashoras'
      'User_Name=yuriinasc'
      'Password=24641217Yuri.'
      'CharacterSet=utf8')
    Connected = True
    Left = 48
    Top = 32
  end
  object DataSource1: TDataSource
    DataSet = Consulta
    Left = 40
    Top = 112
  end
  object Consulta: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from usuarios')
    Left = 128
    Top = 32
    object Consultaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object Consultanome_completo: TWideStringField
      FieldName = 'nome_completo'
      Origin = 'nome_completo'
      Required = True
      Size = 150
    end
    object Consultausuario: TWideStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 50
    end
    object Consultasenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 255
    end
    object Consultaativo: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'ativo'
      Origin = 'ativo'
    end
    object Consultaadministrador: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'administrador'
      Origin = 'administrador'
    end
    object Consultacriado_em: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'criado_em'
      Origin = 'criado_em'
    end
    object Consultaatualizado_em: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'atualizado_em'
      Origin = 'atualizado_em'
    end
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from usuarios')
    Left = 128
    Top = 112
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 376
    Top = 232
  end
end
