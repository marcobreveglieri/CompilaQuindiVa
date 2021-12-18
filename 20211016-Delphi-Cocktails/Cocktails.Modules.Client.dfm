object ClientModule: TClientModule
  Height = 406
  Width = 606
  PixelsPerInch = 96
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://www.thecocktaildb.com/api/json/v1/{ApiKey}'
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'ApiKey'
        Value = '1'
      end>
    SecureProtocols = [TLS12]
    ConnectTimeout = 10000
    ReadTimeout = 10000
    UserAgent = 'Cocktails App'
    Left = 72
    Top = 40
  end
  object RESTRequestSearch: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <
      item
        Kind = pkQUERY
        Name = 's'
        Value = 'margarita'
      end>
    Resource = 'search.php'
    Response = RESTResponseSearch
    ConnectTimeout = 10000
    ReadTimeout = 10000
    Left = 208
    Top = 40
  end
  object RESTResponseSearch: TRESTResponse
    ContentType = 'application/json'
    RootElement = 'drinks'
    Left = 376
    Top = 40
  end
end
