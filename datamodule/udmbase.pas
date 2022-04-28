unit udmbase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, odbcconn;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    ODBCConnection1: TODBCConnection;
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

end.

