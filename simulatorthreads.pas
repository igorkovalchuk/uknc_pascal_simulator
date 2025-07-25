unit SimulatorThreads;

{$mode ObjFPC}{$H+}

interface

uses
  {$ifdef unix}cthreads,{$endif} Crt, Graphics, ExtCtrls,
  ProgramCode;

var
  Image1: TImage;
  OffscreenImage: TBitmap;
  finished: Boolean;

procedure startThreads;

implementation

function RepaintLoop(p : pointer) : ptrint;
begin
  Writeln('repaint thread started');

  while not finished do
    begin
      Delay(330);
      Image1.Invalidate;
    end;

  Writeln('repaint thread finished');
  RepaintLoop := 0;
end;

function Code(p : pointer) : ptrint;
begin
  Delay(1000);

  Writeln('program code thread started');
  ProgramCode.Run;
  Writeln('program code thread finished');

  Delay(1000);
  finished := True;
  Code := 0;
end;

procedure startThreads;
begin
  BeginThread(@RepaintLoop, pointer(1));
  BeginThread(@Code, pointer(2));
end;

end.

