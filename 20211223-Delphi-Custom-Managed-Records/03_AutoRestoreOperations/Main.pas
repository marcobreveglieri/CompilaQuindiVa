unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    ListBox1: TListBox;
    btnClassic: TButton;
    btnRecord: TButton;
    btnClear: TButton;
    procedure btnClassicClick(Sender: TObject);
    procedure btnRecordClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


uses
  AutoUpdate;

procedure TMainForm.btnClassicClick(Sender: TObject);
var
  ItemNumber: Integer;
begin
  ListBox1.Items.BeginUpdate;
  try
    ListBox1.Items.Clear;
    for ItemNumber := 1 to 10000 do
      ListBox1.Items.Add(Format('Item %d', [ItemNumber]));
  finally
    ListBox1.Items.EndUpdate;
  end;
end;

procedure TMainForm.btnClearClick(Sender: TObject);
begin
  ListBox1.Items.Clear;
end;

procedure TMainForm.btnRecordClick(Sender: TObject);
var
  ItemNumber: Integer;
  //AUS: TAutoUpdateStrings; // <--- NO!
begin
  if True then
  begin
    var AUS := TAutoUpdateStrings.Create(ListBox1.Items);
    ListBox1.Items.Clear;
      for ItemNumber := 1 to 10000 do
        ListBox1.Items.Add(Format('Item %d', [ItemNumber]));
  end;
end;

end.
