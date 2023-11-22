object dm: Tdm
  OldCreateOrder = False
  Height = 348
  Width = 611
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=test'
      'User_Name=umang'
      'Password=um4n9'
      'DriverID=MySQL')
    Left = 64
    Top = 48
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'd:\Documents\RAD Studio\Projects\dbconn_form\libmySQL.dll'
    Left = 176
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = FDConn
    Left = 288
    Top = 48
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 384
    Top = 48
  end
  object frxReport1: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45251.631562662030000000
    ReportOptions.LastChange = 45251.631562662030000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 64
    Top = 120
    Datasets = <>
    Variables = <>
    Style = <>
  end
end
