unit BarcodeClient.Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, Vcl.StdCtrls;

type

  TMainForm = class(TForm)
    BarcodeManager: TTetheringManager;
    BarcodeAppProfile: TTetheringAppProfile;
    ProductCodeLabel: TLabel;
    CodeEdit: TEdit;
    ConnectButton: TButton;
    procedure BarcodeAppProfileResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure BarcodeManagerEndAutoConnect(Sender: TObject);
    procedure ConnectButtonClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TMainForm.BarcodeAppProfileResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  // Displays the received resource containing the scanned barcode as a string.
  CodeEdit.Text := AResource.Value.AsString;
end;

procedure TMainForm.BarcodeManagerEndAutoConnect(Sender: TObject);
begin
  // Display paired manager information.
  ConnectButton.Caption := Format('Connected (%d)',
    [BarcodeManager.PairedManagers.Count]);
end;

procedure TMainForm.ConnectButtonClick(Sender: TObject);
begin
  // Connects to available tethering managers and profiles.
  ConnectButton.Caption := 'Connecting...';
  BarcodeManager.AutoConnect();
end;

end.
