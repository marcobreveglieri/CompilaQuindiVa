unit Cqv.Overlays.UI.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.MultiView, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, SubjectStand, FrameStand,
  Cqv.Overlays.UI.Base.View;

type

  /// <summary>
  ///   Rappresenta la finestra principale dell'applicazione.
  /// </summary>
  TMainForm = class(TForm)
    MultiView: TMultiView;
    MainToolBar: TToolBar;
    MasterButton: TButton;
    TitleLabel: TLabel;
    LogoLabel: TLabel;
    LogoImage: TImage;
    ViewListBox: TListBox;
    ThirdsViewItem: TListBoxItem;
    Stand: TFrameStand;
    ViewLayout: TLayout;
    ExitViewItem: TListBoxItem;
    HomeViewItem: TListBoxItem;
    ChromaSwitch: TSwitch;
    ScoreViewItem: TListBoxItem;
    procedure ViewListBoxChange(Sender: TObject);
    procedure ChromaSwitchSwitch(Sender: TObject);
  private
    FViewItems: TDictionary<TListBoxItem, TViewClass>;
    procedure InitializeViewItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowView(AClass: TViewClass);
  end;

implementation

{$R *.fmx}

uses
  Cqv.Overlays.UI.Forms.Chroma, Cqv.Overlays.Modules.Resources,
  Cqv.Overlays.UI.Views.Home, Cqv.Overlays.UI.Views.Thirds,
  Cqv.Overlays.UI.Views.Score;

procedure TMainForm.ChromaSwitchSwitch(Sender: TObject);
begin
  ChromaForm.Visible := ChromaSwitch.IsChecked;
end;

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitializeViewItems;
  ShowView(THomeViewFrame);
end;

destructor TMainForm.Destroy;
begin
  if FViewItems <> nil then
    FreeAndNil(FViewItems);
  inherited Destroy;
end;

procedure TMainForm.InitializeViewItems;
begin
  FViewItems := TDictionary<TListBoxItem, TViewClass>.Create;
  FViewItems.Add(HomeViewItem, THomeViewFrame);
  FViewItems.Add(ThirdsViewItem, TThirdsViewFrame);
  FViewItems.Add(ScoreViewItem, TScoreViewFrame);
  HomeViewItem.IsSelected := True;
end;

procedure TMainForm.ShowView(AClass: TViewClass);
const
  StrStandName = 'stand';
var
  LFrameInfo: TFrameInfo<TFrame>;
  LLastView, LNextView: TFrame;
begin
  LLastView := Stand.LastShownFrame;

  if (LLastView <> nil) and (LLastView.ClassType = AClass) then
    Exit;

  for LLastView in Stand.VisibleFrames do
    Stand.FrameInfo(LLastView).Hide();

  if AClass = nil then
  begin
    TitleLabel.Text := EmptyStr;
    Exit;
  end;

  LNextView := nil;
  for var LFrame in Stand.FrameInfos.Keys do
    if LFrame.ClassType = AClass then
    begin
      LNextView := LFrame;
      Break;
    end;

  if LNextView = nil then
  begin
    LNextView := AClass.Create(Self);
    try
      LFrameInfo := Stand.Use(LNextView, ViewLayout, StrStandName);
    except
      FreeAndNil(LNextView);
      raise;
    end;
  end
  else
    LFrameInfo := Stand.FrameInfo(LNextView);

  LFrameInfo.Show();

  TitleLabel.Text := TViewBaseFrame(LNextView).GetTitle();
end;

procedure TMainForm.ViewListBoxChange(Sender: TObject);
var
  LViewItem: TListBoxItem;
  LViewClass: TViewClass;
begin
  LViewItem := ViewListBox.Selected;
  if LViewItem = nil then
    Exit;
  if LViewItem = ExitViewItem then
  begin
    Close;
    Exit;
  end;
  if not FViewItems.TryGetValue(LViewItem, LViewClass) then
    Exit;
  ShowView(LViewClass);
end;

end.
