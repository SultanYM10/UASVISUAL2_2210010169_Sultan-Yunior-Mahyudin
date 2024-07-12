object DataModule2: TDataModule2
  OldCreateOrder = False
  Left = 550
  Top = 218
  Height = 268
  Width = 361
  object ZConnection1: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    Connected = True
    HostName = 'localhost'
    Port = 3306
    Database = 'penjualan'
    User = 'root'
    Protocol = 'mysql'
    LibraryLocation = 'C:\Program Files (x86)\Borland\libmysql.dll'
    Left = 48
    Top = 32
  end
  object kustomer: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'select*from kustomer;')
    Params = <>
    Left = 112
    Top = 32
  end
  object DataSource1: TDataSource
    DataSet = kustomer
    Left = 112
    Top = 88
  end
end
