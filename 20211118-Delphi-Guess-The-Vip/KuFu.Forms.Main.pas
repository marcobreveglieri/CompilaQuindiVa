unit KuFu.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin,
  System.Rtti, FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Data.Bind.Controls, FMX.Layouts,
  Fmx.Bind.Navigator, FMX.StdCtrls, FMX.Objects, System.Actions, FMX.ActnList,
  FMX.StdActns, FMX.Effects, FMX.Filter.Effects, FMX.MultiResBitmap,
  KuFu.Forms.Live;

type
  TMainForm = class(TForm)
    VipTable: TFDMemTable;
    VipGrid: TStringGrid;
    VipBindSource: TBindSourceDB;
    MainBindingList: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    VipNavigator: TBindNavigator;
    MainToolBar: TToolBar;
    LeftLayout: TLayout;
    MainSplitter: TSplitter;
    RightLayout: TLayout;
    VipImage: TImage;
    ProjectImportButton: TButton;
    MainActionList: TActionList;
    FileExitAction: TFileExit;
    EditPictureAction: TAction;
    PictureOpenDialog: TOpenDialog;
    FileExitButton: TButton;
    LinkControlToField1: TLinkControlToField;
    ProjectImportAction: TAction;
    ProjectExportAction: TAction;
    ProjectOpenDialog: TOpenDialog;
    ProjectSaveDialog: TSaveDialog;
    EditPictureButton: TButton;
    ProjectExportButton: TButton;
    VipPixelateEffect: TPixelateEffect;
    PictureToolBar: TToolBar;
    PreviewSwitch: TSwitch;
    PreviewLabel: TLabel;
    LinkControlToPropertyEnabled: TLinkControlToProperty;
    LivePanel: TPanel;
    LiveShowAction: TAction;
    LiveHideAction: TAction;
    LiveShowButton: TButton;
    LiveHideButton: TButton;
    EffectTrackBar: TTrackBar;
    LiveRevealAction: TAction;
    LiveRevealButton: TButton;
    procedure MainActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure EditPictureActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ProjectImportActionExecute(Sender: TObject);
    procedure ProjectExportActionExecute(Sender: TObject);
    procedure LiveShowActionExecute(Sender: TObject);
    procedure LiveHideActionExecute(Sender: TObject);
    procedure EffectTrackBarChange(Sender: TObject);
    procedure LiveRevealActionExecute(Sender: TObject);
  private
    FLiveForm: TLiveForm;
    function IsLiveFormVisible: Boolean;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.EditPictureActionExecute(Sender: TObject);
begin
  if not PictureOpenDialog.Execute then
    Exit;
  var LFileName := PictureOpenDialog.FileName;
  TBlobField(VipTable.FieldByName('VipPicture')).LoadFromFile(LFileName);
end;

procedure TMainForm.EffectTrackBarChange(Sender: TObject);
begin
  if not Assigned(FLiveForm) then
    Exit;
  FLiveForm.SetEffectLevel(EffectTrackBar.Value);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  VipTable.Open;
end;

function TMainForm.IsLiveFormVisible: Boolean;
begin
  Result := Assigned(FLiveForm) and FLiveForm.Visible;
end;

procedure TMainForm.LiveHideActionExecute(Sender: TObject);
begin
  if not Assigned(FLiveForm) then
    Exit;
  FLiveForm.Hide;
end;

procedure TMainForm.LiveRevealActionExecute(Sender: TObject);
begin
  if not Assigned(FLiveForm) then
    Exit;
  FLiveForm.RevealVip;
end;

procedure TMainForm.LiveShowActionExecute(Sender: TObject);
var
  LVipName: string;
  LVipPicture: TFixedMultiResBitmap;
begin
  if not Assigned(FLiveForm) then
    FLiveForm := TLiveForm.Create(Self);
  with VipTable do
  begin
    if not (Bof and Eof) then
    begin
      LVipName := FieldByName('VipName').AsString;
      LVipPicture := VipImage.MultiResBitmap;
    end
    else begin
      LVipName := '';
      LVipPicture := nil;
    end;
  end;
  FLiveForm.SetVipInfo(LVipName, LVipPicture);
  FLiveForm.Show;
end;

procedure TMainForm.MainActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  EditPictureAction.Enabled := VipTable.State in dsEditModes;
  if IsLiveFormVisible then
  begin
    LiveHideAction.Enabled := True;
    LiveShowAction.Enabled := False;
    EffectTrackBar.Enabled := True;
    EffectTrackBar.Value := FLiveForm.GetEffectLevel;
  end
  else begin
    LiveHideAction.Enabled := False;
    LiveShowAction.Enabled := True;
    EffectTrackBar.Enabled := False;
    EffectTrackBar.Value := 25;
  end;
end;

procedure TMainForm.ProjectExportActionExecute(Sender: TObject);
begin
  if not ProjectSaveDialog.Execute then
    Exit;
  VipTable.SaveToFile(ProjectSaveDialog.FileName, TFDStorageFormat.sfBinary);
end;

procedure TMainForm.ProjectImportActionExecute(Sender: TObject);
begin
  if not ProjectOpenDialog.Execute then
    Exit;
  VipTable.LoadFromFile(ProjectOpenDialog.FileName, TFDStorageFormat.sfBinary);
end;

end.
