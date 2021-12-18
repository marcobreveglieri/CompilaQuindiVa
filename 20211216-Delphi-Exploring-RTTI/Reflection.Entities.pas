unit Reflection.Entities;

interface

uses
  Reflection.Attributes;

type

{ TSmtpConfiguration }

  TSmtpConfiguration = class
  private
    FPort: Integer;
    FPassword: string;
    FHost: string;
    FUserName: string;
    FTimeout: Int64;
  public
    function ToString: string; override;
    property Host: string read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
    property Timeout: Int64 read FTimeout write FTimeout;
  end;

  TLoginConfiguration = class
  private
    FDomain: string;
    FUserName: string;
    FPassword: string;
    procedure SetDomain(const Value: string);
    procedure SetUserName(const Value: string);
  public
    function ToString: string; override;
    property Domain: string read FDomain write SetDomain;
    property UserName: string read FUserName write SetUserName;
    [Ident('Pwd')]
    property Password: string read FPassword write FPassword;
  end;

implementation

uses
  System.SysUtils;

{ TSmtpConfiguration }

function TSmtpConfiguration.ToString: string;
begin
  Result := Format('Host=%s, Port=%d, UserName=%s, Password=%s, Timeout=%d',
    [FHost, FPort, FUserName, FPassword, FTimeout]);
end;

{ TLoginConfiguration }

procedure TLoginConfiguration.SetDomain(const Value: string);
begin
  FDomain := Value;
end;

procedure TLoginConfiguration.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

function TLoginConfiguration.ToString: string;
begin
  Result := Format('[Login] Domain=%s, UserName=%s, Password=%s',
    [FDomain, FUserName, FPassword]);
end;

end.
