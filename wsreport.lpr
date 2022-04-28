program wsreport;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Windows, Interfaces, Classes, SysUtils, CustApp, Unit1, lazreportpdfexport,lr_e_pdf,
  pack_powerpdf, usql_editor
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
    procedure WritePdf; virtual;
  end;

{ TMyApplication }

procedure TMyApplication.DoRun;
var
  ErrorMsg: String;
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
    Writeln('report');
    WritePdf;
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

procedure TMyApplication.WritePdf;
var
  cFile: String;
begin
  cFile:= 'c:\dev\pascal\report_console_example\exemplo.lrf';
  with tForm1.Create( Self ) do
  begin
    writeln('Formulario criado'   );
    writeln('Carregando: ' + cFile   );
    frReport1.LoadFromFile(cFile);
    if frReport1.PrepareReport then
    begin
       frReport1.ExportTo(TfrTNPDFExportFilter,'C:\temp\report.pdf');
       writeln('Relatório gerado'   );
    end;
  end;
end;


var
  Application: TMyApplication;
begin
  Application:=TMyApplication.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

