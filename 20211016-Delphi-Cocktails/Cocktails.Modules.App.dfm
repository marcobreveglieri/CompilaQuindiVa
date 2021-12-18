object AppModule: TAppModule
  OnCreate = DataModuleCreate
  Height = 412
  Width = 686
  PixelsPerInch = 96
  object RESTAdapterSearch: TRESTResponseDataSetAdapter
    Dataset = DrinkTable
    FieldDefs = <>
    Response = ClientModule.RESTResponseSearch
    SampleObjects = 10
    StringFieldSize = 1024
    Left = 72
    Top = 112
  end
  object DrinkTable: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 192
    Top = 112
  end
  object DrinkBindSource: TBindSourceDB
    DataSet = DrinkTable
    ScopeMappings = <>
    Left = 296
    Top = 112
  end
end
