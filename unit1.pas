unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, SQLDB, odbcconn, DB, Forms, Controls,
  Graphics, Dialogs, PReport, LR_Class, LR_DBSet, lr_e_pdf, LR_DSet, LR_Desgn;

type

  { TForm1 }

  TForm1 = class(TForm)
    DataSource1: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    frReport1: TfrReport;
    frTNPDFExport1: TfrTNPDFExport;
    IBConnection1: TIBConnection;
    ODBCConnection1: TODBCConnection;
    PReport1: TPReport;
    PReport2: TPReport;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure FormCreate(Sender: TObject);
    procedure frDBDataSet1CheckEOF(Sender: TObject; var Eof: Boolean);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses IniFiles, umain;
const
  IniFile = 'config.ini';

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
    Sett : TIniFile;
    cDatabase: String;
    cDriver: String;
    slDatabaseList: TStringList;
begin
    Sett := TIniFile.Create(IniFile);
    cDatabase:= Sett.ReadString('Default', 'database', '');
    cDriver:= Sett.ReadString(cDatabase,'driver','firebird');
    IBConnection1.Connected:= false;
    ODBCConnection1.Connected:= false;
    ODBCConnection1.Transaction:= nil;
    if (cDriver='firebird') then
    begin
        if frmMain <> nil then
           if frmMain.IsVisible then
              frmMain.StatusBar1.Panels[2].Text:= 'firebird:' + Sett.ReadString(cDatabase,'dbname','');
        IBConnection1.hostname:= Sett.ReadString(cDatabase,'dbhost','');
        IBConnection1.DatabaseName:= Sett.ReadString(cDatabase,'dbname','');
        IBConnection1.UserName:= Sett.ReadString(cDatabase,'dbuser','');
        IBConnection1.Password:= Sett.ReadString(cDatabase,'dbpass','');
        IBConnection1.Port:= Sett.ReadInteger(cDatabase,'dbport',3050);
        IBConnection1.Transaction:= SQLTransaction1;
        SQLQuery1.DataBase:= IBConnection1;
        IBConnection1.Connected:= true;
    end
    else if (cDriver='oracle') then
    begin
        if frmMain <> nil then
           if frmMain.IsVisible then
              frmMain.StatusBar1.Panels[2].Text:= 'oracle:' + Sett.ReadString(cDatabase,'dbname','');
        ODBCConnection1.hostname:= Sett.ReadString(cDatabase,'dbhost','');
        ODBCConnection1.DatabaseName:= Sett.ReadString(cDatabase,'dbname','');
        ODBCConnection1.UserName:= Sett.ReadString(cDatabase,'dbuser','');
        ODBCConnection1.Password:= Sett.ReadString(cDatabase,'dbpass','');
        ODBCConnection1.Transaction:= SQLTransaction1;
        ODBCConnection1.Connected:= true;
        SQLQuery1.DataBase:= ODBCConnection1;
    end;
    Application.processMessages;
    Sett.Free;
    //slDatabaseList: TStringList;

end;

procedure TForm1.frDBDataSet1CheckEOF(Sender: TObject; var Eof: Boolean);
begin

end;

end.

