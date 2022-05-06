program wsreportserver;

{$mode objfpc}{$H+}


uses
    Classes, fphttpserver, fphttpapp, Process, math, sysutils, IniFiles;

Type
    TTestHTTPServer = Class(TFPHTTPServer)
    public
        procedure HandleRequest(
            Var ARequest: TFPHTTPConnectionRequest;
            Var AResponse : TFPHTTPConnectionResponse); override;
        procedure loadConfig();
    end;



Var
    Serv : TTestHTTPServer;
    ServCommand: String;
    ServReportsPath: String;
    ServPdfFilePath: String;
    ServPdfUrl: String;
    ServPdfDefaultPrefix: String;
    ServPort: integer;
    ServTimeOutSeconds: integer;
    ServPath: String;
    ConfigFile: String;


procedure TTestHTTPServer.loadConfig();
var
    Sett : TIniFile;
begin

    ServCommand:= 'c:\xampp\htdocs\app\reports\wsreport\wsreport.exe';
    ServReportsPath:= 'C:\xampp\htdocs\app\reports\wsreport\reports\';
    ServPdfFilePath:= 'c:\xampp\htdocs\app\reports\download\';
    ServPdfUrl:= 'http://localhost/app/reports/download/';
    ServPdfDefaultPrefix:= 'aRelV02022';
    ServTimeOutSeconds:=360;
    ServPort:=88;
    ServPath:= ExtractFilePath( Application.ExeName );
    if FileExists(ServPath + 'config.ini' ) then
    begin
        ConfigFile:= ServPath + 'config.ini';
    end
    else if ( pos( '\lib',ServPath)>0 ) then
    begin
        ConfigFile:= ServPath + '..\..\config.ini';
    end
    else if ( pos( '/lib',ServPath)>0 ) then
    begin
        ConfigFile:= ServPath + '../../config.ini';
    end;

    // Config from file
    Sett := TIniFile.Create(ConfigFile);
    ServCommand:= Sett.ReadString('Server', 'pdfGenerator', 'wsReport.exe');
    ServPdfFilePath:= Sett.ReadString('Server', 'pdfFilePath', '');
    ServPdfUrl:= Sett.ReadString('Server', 'pdfUrl', '' );
    ServPdfDefaultPrefix:= Sett.ReadString('Server','pdfDefaultPrefix', ServPdfDefaultPrefix);
    ServReportsPath:= Sett.ReadString('Server','reportsPath','');
    ServTimeOutSeconds:= Sett.ReadInteger('Server','timeOutSeconds',60);
    ServPort:= Sett.ReadInteger('Server','port',60);
end;

procedure TTestHTTPServer.HandleRequest(
   var ARequest: TFPHTTPConnectionRequest;
   var AResponse: TFPHTTPConnectionResponse);
   var
      F : TStringStream;
      cOutInfo: String;
      cCommand: String;
      cPdf: String;
      cParams: String;
      cReport: String;
      cPathReport: String;
      cReportPdfUrl: String;
      cHostReport: String;
      cPdfRandomName: String;
      nRand: Integer;
begin

    cPathReport:= ServReportsPath;
    writeln('Processando um requisito...');
    writeln('Information: ' + ARequest.QueryString);
    if pos('r=', '.' + ARequest.QueryString )>0 then
    begin
      cReport:= cPathReport + copy( ARequest.QueryString, pos('=', ARequest.QueryString )+1 );
      cReport:= copy( cReport, 0, pos( '/', cReport )-1 );
      cParams:= copy( ARequest.QueryString, pos('/', ARequest.QueryString)+1 );
    end
    else
    begin
      cReport:= 'rel_mapa_dieta_por_atendimento_validade';
      cParams:= 'atendimento=4784279';
    end;
    cCommand:= ServCommand;
    nRand:=  RandomRange(100000,199999);
    cPdfRandomName:= ServPdfDefaultPrefix + intToStr(nRand)  + '.pdf';
    cPdf:= ServPdfFilePath + cPdfRandomName;

    cReportPdfUrl:= ServPdfUrl + cPdfRandomName;

    // Run wsReport with parameters
    RunCommand(cCommand,['-r',cReport,cPdf,cParams], cOutInfo);
    writeln('Resposta realizada...');
    F:=TStringStream.Create('<a href="' + cReportPdfUrl + '">Relatorio gerado</a>' + '<p>' + cOutInfo + '</p>');
    try
        AResponse.ContentLength:=F.Size;
        AResponse.ContentStream:=F;
        AResponse.SendContent;
        AResponse.ContentStream:=Nil;
    finally
        F.Free;
    end;
end;

begin
;
    Serv:=TTestHTTPServer.Create(Nil);
    Serv.loadConfig();
    writeln('wsReportServer');
    writeln('Report generator listen on port ' + IntToStr( ServPort ) );
    writeln('Server path = ' + ServPath );
    writeln('Config file = ' + ConfigFile );
    writeln('Pdf generator = ' + ServCommand);

    try
        Serv.Threaded:=True;
        Serv.Port:=ServPort;
        Serv.AcceptIdleTimeout:=1000 * ServTimeOutSeconds;
        Serv.Active:=True;
    finally
        Serv.Free;
    end;
end.
