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

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.frDBDataSet1CheckEOF(Sender: TObject; var Eof: Boolean);
begin

end;

end.

