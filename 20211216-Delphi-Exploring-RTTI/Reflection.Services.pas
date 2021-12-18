unit Reflection.Services;

interface

uses Reflection.Entities, Reflection.Attributes;

type

  TConfigurationProviderVintage = class
  public
    class procedure LoadSmtpConfiguration(const APath: string;
      AConfig: TSmtpConfiguration);
  end;

  TConfigurationProviderModern<TConfig: class> = class
  public
    class procedure LoadInto(const APath: string; AConfig: TConfig);
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  System.Rtti,
  System.IniFiles;

const
  sSmtpConfigurationSection = 'SmtpConfiguration';

{ TConfigurationProviderVintage }

class procedure TConfigurationProviderVintage.LoadSmtpConfiguration(
  const APath: string; AConfig: TSmtpConfiguration);
begin
  var IniFile := TMemIniFile.Create(APath);
  try
    AConfig.Host := IniFile.ReadString(sSmtpConfigurationSection, 'Host', '');
    AConfig.Port := IniFile.ReadInteger(sSmtpConfigurationSection, 'Port', 0);
    AConfig.UserName := IniFile.ReadString(sSmtpConfigurationSection, 'UserName', '');
    AConfig.Password := IniFile.ReadString(sSmtpConfigurationSection, 'Password', '');
  finally
    IniFile.Free;
  end;
end;

{ TConfigurationProviderModern<TConfig> }

class procedure TConfigurationProviderModern<TConfig>.LoadInto(
  const APath: string; AConfig: TConfig);
begin
  var IniFile := TMemIniFile.Create(APath);

  try

    var LClassType := AConfig.ClassType;

    var LSection := LClassType.ClassName;

    if LSection.StartsWith('T') then
      LSection := LSection.Substring(1);

    var LContext := TRttiContext.Create;

    for var LProp in LContext.GetType(LClassType).GetProperties() do
    begin
      if not LProp.IsWritable then
        Continue;
      if not (LProp.Visibility in [mvPublic, mvPublished]) then
        Continue;

      var LIdent := LProp.Name;

      var LIdentAttr := LProp.GetAttribute<IdentAttribute>();
      if Assigned(LIdentAttr) then
        LIdent := LIdentAttr.Ident;

      var LValue: TValue;

      case LProp.PropertyType.TypeKind of
        tkInteger:
          LValue := IniFile.ReadInteger(LSection, LIdent, 0);
        tkFloat:
          LValue := IniFile.ReadFloat(LSection, LIdent, 0.0);
        tkString, tkLString, tkWString, tkUString:
          LValue := IniFile.ReadString(LSection, LIdent, '');
        tkInt64:
          LValue := IniFile.ReadInt64(LSection, LIdent, 0);
      else
        Continue;
      end;

      LProp.SetValue(Pointer(AConfig), LValue);
    end;
  finally
    IniFile.Free;
  end;
end;

end.
