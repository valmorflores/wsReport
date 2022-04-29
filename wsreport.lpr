program wsreport;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Windows, Interfaces, Classes, SysUtils, CustApp, Unit1, lazreportpdfexport,lr_e_pdf,
  pack_powerpdf, usql_editor, udesign
  { you can add units after this };

type

  { TMyApplication }

  TMyApplication = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    procedure WritePdf( cFile: String; cFileOut: String ); virtual;
    procedure runDesignForm; virtual;
  end;

{ TMyApplication }

procedure TMyApplication.DoRun;
var
  ErrorMsg: String;
  cStr: String;
  cOut: String;
begin
  // quick check parameters
  {ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;}

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('r', 'report') then
  begin
     cStr:= ParamStr(2);
     cOut:= ParamStr(3);
     Writeln('report: ' + cStr);
     WritePdf(cStr, cOut);
     Terminate;
     Exit;
  end;

  // parse parameters
  if HasOption('d', 'design') then
  begin
    Writeln('desigh');
    RunDesignForm;
    Terminate;
    Exit;
  end;

  { add your program here }

  // stop program loop
  Terminate;
end;

constructor TMyApplication.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TMyApplication.Destroy;
begin
  inherited Destroy;
end;

procedure TMyApplication.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
  writeln('', ExeName, ' -r');
  writeln('', ExeName, ' -d');
end;

procedure TMyApplication.WritePdf(cFile: String; cFileOut: String );
var
  cFileReport: String;
  cFileSQL: String;
begin
  cFileReport:= cFile + '.lrf';
  cFileSQL:= cFile + '.sql';
  with tForm1.Create( Self ) do
  begin
    writeln('Report: ' + cFileReport );
    writeln('SQL: ' + cFileSQL );
    // SQL
    SQLQuery1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.LoadFromFile( cFileSQL );
    SQLQuery1.Open;
    // Report
    frReport1.LoadFromFile(cFileReport);
    if frReport1.PrepareReport then
    begin
       frReport1.ExportTo(TfrTNPDFExportFilter,cFileOut);
       writeln('PDF: ' + cFileOut   );
    end;
  end;
end;

procedure TMyApplication.runDesignForm;
begin

end;

var
  Application: TMyApplication;
begin
  Application:=TMyApplication.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

