unit Cocktails.Model.Pages;

interface

uses
  System.Generics.Collections, System.SysUtils,
  Cocktails.Model.Types, Cocktails.Frames.BasePage;

function GetViewPage(AView: TPageView): TPageFrameClass;
procedure RegisterViewPage(AView: TPageView; AClass: TPageFrameClass);

implementation

var
  PageTypes: TDictionary<TPageView, TPageFrameClass>;

function GetViewPage(AView: TPageView): TPageFrameClass;
begin
  if not PageTypes.TryGetValue(AView, Result) then
    Result := nil;
end;

procedure RegisterViewPage(AView: TPageView; AClass: TPageFrameClass);
begin
  PageTypes.AddOrSetValue(AView, AClass);
end;

initialization

  PageTypes := TDictionary<TPageView, TPageFrameClass>.Create;

finalization

  if PageTypes <> nil then
    FreeAndNil(PageTypes);

end.
