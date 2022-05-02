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
    Button2: TButton;
    Button3: TButton;
    DBGrid1: TDBGrid;
    edFile: TEdit;
    edFileLrf: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    N1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;
  FormEditor: tForm1;

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

procedure TfrmMain.MenuItem5Click(Sender: TObject);
var
  cFile: String;
  cFileSQL: String;
  cFileLrf: String;
begin
  if SaveDialog1.Execute then
  begin
     cFile:= ExtractFilePath(SaveDialog1.FileName) + ExtractFileName(SaveDialog1.FileName);
     cFileSQL:= copy(cFile,0,length(cFile)-4) + '.sql';
     cFileLrf:= copy(cFile,0,length(cFile)-4) + '.lrf';
     memo1.Lines.saveToFile(cFileSQL);
     if ( FormEditor <> nil ) then
     begin
        with FormEditor do
        begin
           Self.DBGrid1.dataSource:= DataSource1;
           frReport1.SavetoFile(cFileLrf);
           frReport1.DesignReport;
        end;
     end
     else
     begin
        // execute
     end;

  end;

end;

procedure TfrmMain.MenuItem2Click(Sender: TObject);
var
  cFileSQL: String;
  cFileLrf: String;
  cFile: String;
begin
  if OpenDialog1.Execute then
  begin
     cFile:= ExtractFilePath(OpenDialog1.FileName) + ExtractFileName(OpenDialog1.FileName);
     cFileSQL:= copy(cFile,0,length(cFile)-4) + '.sql';
     cFileLrf:= copy(cFile,0,length(cFile)-4) + '.lrf';
     edFile.text:= cFileSQL;
     edFileLrf.text:= cFileLrf;
     memo1.lines.loadFromFile(cFileSQL);
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if ( FormEditor = nil ) then
     FormEditor:= tForm1.create( Application );
  with FormEditor do
  begin
     SQLQuery1.Close;
     SQLQuery1.SQL.clear;
     SQLQuery1.SQL.Assign( memo1.Lines );
     SQLQuery1.Open;
     Self.DBGrid1.dataSource:= DataSource1;
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  if ( FormEditor <> nil ) then
  begin
    with FormEditor do
    begin
       Self.DBGrid1.dataSource:= DataSource1;
       frReport1.loadFromFile(edFileLrf.text);
       frReport1.DesignReport;
    end;
  end
  else
  begin
     // execute
  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  with FormEditor do
  begin
     Self.DBGrid1.dataSource:= DataSource1;
     frReport1.loadFromFile(edFileLrf.text);
     frReport1.PrepareReport;
     frReport1.ShowPreparedReport;
  end;

end;

end.

