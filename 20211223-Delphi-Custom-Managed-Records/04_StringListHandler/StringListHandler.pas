unit StringListHandler;

interface

uses
  System.Classes, System.SysUtils;

type

  TStringListHandler = record
  private
    FList: TStringList;
  public
    class operator Initialize(out ADest: TStringListHandler);
    class operator Finalize(var ADest: TStringListHandler);
    class operator Assign(var ADest: TStringListHandler;
      const [ref] ASrc: TStringListHandler);
    property List: TStringList read FList;
  end;

implementation

class operator TStringListHandler.Initialize(out ADest: TStringListHandler);
begin
  ADest.FList := TStringList.Create;
  ADest.FList.Delimiter := '|';
  ADest.FList.StrictDelimiter := True;
end;

class operator TStringListHandler.Finalize(var ADest: TStringListHandler);
begin
  if ADest.FList <> nil then
    FreeAndNil(ADest.FList);
end;

class operator TStringListHandler.Assign(var ADest: TStringListHandler;
  const [ref] ASrc: TStringListHandler);
begin
  ADest.FList.Assign(ASrc.FList);
end;

end.
