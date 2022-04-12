unit AutoUpdate;

interface

uses
  System.Classes,
  Vcl.Controls;

type
  TAutoUpdateStrings = record
  private
    FStrings: TStrings;
  public
    constructor Create(const AStrings: TStrings);
  public
    class operator Initialize(out ADest: TAutoUpdateStrings);
    class operator Finalize(var ADest: TAutoUpdateStrings);
    class operator Assign(var ADest: TAutoUpdateStrings;
      const [ref] ASrc: TAutoUpdateStrings);
  end;

implementation

constructor TAutoUpdateStrings.Create(const AStrings: TStrings);
begin
  FStrings := AStrings;
  if FStrings <> nil then
    FStrings.BeginUpdate;
end;

class operator TAutoUpdateStrings.Initialize(out ADest: TAutoUpdateStrings);
begin
  ADest.FStrings := nil;
end;

class operator TAutoUpdateStrings.Finalize(var ADest: TAutoUpdateStrings);
begin
  if (ADest.FStrings <> nil) then
    ADest.FStrings.EndUpdate;
  ADest.FStrings := nil;
end;

class operator TAutoUpdateStrings.Assign(var ADest: TAutoUpdateStrings;
  const [ref] ASrc: TAutoUpdateStrings);
begin
  raise EInvalidOperation.Create('This record cannot be assigned');
end;

end.
