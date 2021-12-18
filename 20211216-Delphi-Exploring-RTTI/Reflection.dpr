program Reflection;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.IOUtils,
  System.SysUtils,
  Reflection.Entities in 'Reflection.Entities.pas',
  Reflection.Services in 'Reflection.Services.pas',
  Reflection.Attributes in 'Reflection.Attributes.pas';

begin
  try
    var LPath := TPath.ChangeExtension(ParamStr(0), '.ini');
    var LConfig := TSmtpConfiguration.Create;
    try
      Writeln(LConfig.ToString);
      //TConfigurationProviderVintage.LoadSmtpConfiguration(LPath, LConfig);
      TConfigurationProviderModern<TSmtpConfiguration>.LoadInto(LPath, LConfig);
      Writeln(LConfig.ToString);
    finally
      LConfig.Free;
    end;
    var LLogin := TLoginConfiguration.Create;
    try
      Writeln(LLogin.ToString);
      TConfigurationProviderModern<TLoginConfiguration>.LoadInto(LPath, LLogin);
      Writeln(LLogin.ToString);
    finally
      LLogin.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
