unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, DBGrids, unit1;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    edFile: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    N1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.MenuItem3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.MenuItem4Click(Sender: TObject);
begin

end;

procedure TfrmMain.MenuItem2Click(Sender: TObject);
var
  cFileSQL: String;
begin
  if OpenDialog1.Execute then
  begin
     cFileSQL:= ExtractFileName(OpenDialog1.FileName) + '.sql';
     edFile.text:= cFileSQL;

  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  with tForm1.create( Application ) do
  begin
     SQLQuery1.Close;
     SQLQuery1.SQL.clear;
     SQLQuery1.loadFromFile( cFile );
     SQLQuery1.Open;

  end;
end;

end.

