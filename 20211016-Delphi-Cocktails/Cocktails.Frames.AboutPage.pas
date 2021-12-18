unit Cocktails.Frames.AboutPage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cocktails.Frames.BasePage, System.Actions, FMX.ActnList,
  FMX.Controls.Presentation;

type
  TAboutPageFrame = class(TBasePageFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  Cocktails.Model.Pages, Cocktails.Model.Types;

initialization

  RegisterViewPage(TPageView.About, TAboutPageFrame);

end.
