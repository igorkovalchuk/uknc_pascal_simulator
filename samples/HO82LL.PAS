{ Reproducing the picture from The Hobbit (1982), illustrated by Kent Rees }
{ Data from https://richcarl.github.io/hobbitgfx/ }

PROGRAM HO82LL;

{$i cGraph}

const multiplier = 2;
const startX = 64; {(640 - 256*2) / 2}
const startY = 5;

var
  px: Integer;
  py: Integer;

procedure line1(x0, y0, x1, y1: Real);
begin

  if (Abs(px - x0) <= 1) and (Abs(py - y0) <= 1) then
      begin
        lineto(Round(startX + x0 * multiplier), Round(GetMaxY - (startY + y0 * multiplier)));
      end;

  SetColor(0);
  line(Round(startX + x0 * multiplier), Round(GetMaxY - (startY + y0 * multiplier)),
       Round(startX + x1 * multiplier), Round(GetMaxY - (startY + y1 * multiplier)));

  px := Round(x1);
  py := Round(y1);
end;

procedure fill1(x0, y0, color, border: Integer);
begin
  FloodFill(startX + x0 * multiplier, GetMaxY - (startY + y0 * multiplier), color, border);
end;

procedure frame(color: Integer);
var
  x0, x1, y0, y1: Integer;
begin
  SetColor(color);
  { 256 * 192 ZX Spectrum window size }
  x0 := startX - 1;
  x1 := startX + 256 * 2 - 1;
  y0 := GetMaxY - (startY + 128 * 2) - 1; { bottom }
  y1 := GetMaxY - startY + 1; { top }

  Line(x0, y0, x0, y1); { vertical line }
  Line(x1, y0, x1, y1); { vertical line }
  Line(x0, y0, x1, y0); { horizontal line }
  Line(x0, y1, x1, y1); { horizontal line }
end;

procedure extendedLine(x0: Real;
                       y0: Real;
                       x1: Real;
                       y1: Real;
                       start: Boolean);
{ 'start' means we have to continue this line starting from x0, y0 point }
{ 'end' - from x1, y1 }
var
  direction: Integer;
  dx, dy: Real;
begin
  dx := x1 - x0;
  dy := y1 - y0;
  if Abs(dx) > Abs(dy) then
      begin
        dy := dy / dx;
        dx := 1;
      end
  else
      begin
        dx := dx / dy;
        dy := 1;
      end;

  if start then
    begin
      if x1 > x0 then direction := -1 else direction := 1;
      x0 := x0 + dx * direction;
      y0 := y0 + dy * direction;
    end
  else
    begin
      if x1 > x0 then direction := 1 else direction := -1;
      x1 := x1 + dx * direction;
      y1 := y1 + dy * direction;
    end;

  line1(x0, y0, x1, y1);
end;

begin

  Color(Black, White, Yellow);
  ClrScr;
  InitGraph;

  line1(0, 89, 62, 86);
  line1(63, 86, 113, 83);
  line1(114, 83, 107, 76);
  line1(106, 75, 163, 74);
  line1(164, 74, 221, 80);
  line1(222, 80, 255, 79);
  line1(101, 83, 105, 75);
  line1(101, 84, 105, 76);
  line1(0, 64, 62, 57);
  line1(63, 57, 125, 55);
  line1(126, 55, 188, 53);
  line1(189, 53, 251, 56);
  line1(252, 56, 255, 56);
  line1(255, 46, 229, 38);
  line1(228, 37, 202, 34);
  line1(201, 34, 175, 40);
  line1(174, 40, 148, 46);
  line1(168, 40, 142, 38);
  line1(141, 38, 115, 30);
  line1(114, 29, 88, 26);
  line1(87, 26, 61, 30);
  line1(60, 30, 34, 34);
  line1(33, 34, 7, 36);
  line1(6, 36, 0, 36);
  extendedLine(22, 34, 0, 27, true);
  extendedLine(184, 37, 158, 29, true);
  line1(157, 28, 131, 26);
  line1(130, 26, 104, 29);
  extendedLine(230, 37, 255, 34, true);

  line1(197, 70, 200, 44); { tree }
  line1(197, 59, 194, 45);
  line1(200, 53, 205, 43);
  line1(203, 49, 206, 48);
  line1(196, 49, 197, 46);
  line1(195, 55, 192, 54);

  frame(Black);

  fill1(183, 29, Dblue, Black);
  fill1(149, 94, Green, Black);

  frame(Yellow);

  REPEAT UNTIL KeyPressed;
  Color(White, Dblue, Dblue);
  ClrScr;

  writeln('Lonelands');
  writeln('Picture from The Hobbit (1982)');
  writeln('Illustrated by Kent Rees');
  writeln('Data from https://richcarl.github.io/hobbitgfx/');

end.

