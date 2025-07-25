unit ProgramCode;

{$mode TP}{$H+}

interface

uses
  SimulatorColors, SimulatorCrt, SimulatorGraphics;

procedure Run;

implementation

procedure Run;
var
  i, x, y, c: Integer;
begin
  Color(White, Black, Black);
  InitGraph;

  for c := 1 to 7 do
    begin
      SetColor(c);
      for i := 0 to 30 do
        PutPixel(Random(GetMaxX), Random(GetMaxY));
    end;

  for i := 1 to 10 do
    begin
      x := Random(GetMaxX - 50);
      y := Random(GetMaxY - 50);
      SetColor(Yellow);
      Rectangle(x, y, x + 50, y + 50);
      Bar(x + 1, y + 1, x + 49, y + 49, Green);
    end;

  for i := 1 to 5 do
    begin
      x := Random(GetMaxX - 50);
      y := Random(GetMaxY - 50);
      SetColor(Red);
      Ellips(x, y, 30, 20);
      FloodFill(x, y, Yellow, Red);
    end;

  Color(Black, White, Black);
  GotoXY(20, 3);
  Write('10 Rectangles, 5 Ellipses and many Pixels');

  REPEAT UNTIL KeyPressed;
  Color(White, Dblue, Dblue);
  ClrScr;

end;

end.

