unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    btnClassic: TButton;
    btnCmrs: TButton;
    procedure btnClassicClick(Sender: TObject);
    procedure btnCmrsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses StringListHandler;

procedure TMainForm.btnClassicClick(Sender: TObject);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Delimiter := '|';
    SL.StrictDelimiter := True;
    SL.Add('123');
    SL.Add('abc');
    SL.Add('Xyz');
    ShowMessage(SL.DelimitedText);
  finally
    SL.Free;
  end;
end;

procedure TMainForm.btnCmrsClick(Sender: TObject);
var
  SLH: TStringListHandler;
begin
  SLH.List.Add('123');
  SLH.List.Add('abc');
  SLH.List.Add('Xyz');
  var SLH2 := SLH;
  SLH.List.Add('999');
  ShowMessage(SLH2.List.DelimitedText);
end;

end.
