{ Reproducing the picture from The Hobbit (1982), illustrated by Kent Rees }
{ Data from https://richcarl.github.io/hobbitgfx/ }

PROGRAM HO82NP;

{$i cGraph}

const multiplier = 2;
const startX = 64; {(640 - 256*2) / 2}
const startY = 4;

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
  y0 := GetMaxY - (startY + 128 * 2) + 1; { bottom }
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

  Color(Black, White, White);
  ClrScr;
  InitGraph;

  frame(Black);

  line1(161, 127, 172, 116); { the path }
  line1(173, 115, 178, 104);
  line1(179, 103, 182, 92);
  line1(183, 91, 175, 75);
  line1(175, 74, 159, 70);
  line1(158, 70, 142, 68);
  line1(141, 68, 125, 63);
  line1(124, 63, 108, 61);
  line1(107, 61, 91, 53);
  line1(90, 53, 88, 40);
  line1(88, 39, 87, 26);
  line1(87, 25, 90, 19);
  line1(90, 18, 95, 17);
  line1(96, 17, 94, 22);
  line1(93, 23, 95, 41);
  line1(95, 42, 97, 49);
  line1(97, 50, 107, 55);
  line1(108, 55, 123, 57);
  line1(124, 57, 139, 62);
  line1(140, 62, 175, 69);
  line1(176, 69, 211, 86);
  line1(212, 87, 247, 94);
  line1(248, 94, 255, 95);

  line1(97, 16, 105, 0);
  line1(62, 0, 60, 7);
  line1(60, 8, 56, 8);
  line1(55, 9, 50, 71);
  line1(50, 72, 45, 127);
  line1(56, 9, 97, 13); { the path }
  line1(56, 10, 97, 14); { the path }
  line1(86, 26, 78, 88);
  line1(77, 89, 74, 112);
  line1(90, 52, 85, 113);
  line1(106, 61, 103, 118);
  line1(137, 68, 130, 120);
  line1(155, 71, 143, 122);
  line1(173, 75, 148, 125);
  line1(181, 96, 150, 127);
  line1(68, 12, 60, 74);
  line1(59, 75, 57, 98);
  line1(87, 26, 79, 88);
  line1(78, 89, 75, 112);

  line1(51, 49, 38, 45); { mountain on the left }
  line1(37, 45, 24, 32);
  line1(23, 31, 17, 18);
  line1(16, 17, 0, 1);

  line1(27, 10, 29, 8); { the moon }
  line1(30, 7, 32, 6);
  line1(33, 6, 35, 6);
  line1(36, 7, 38, 8);
  line1(39, 8, 40, 10);
  line1(40, 11, 38, 11);
  line1(37, 12, 35, 13);
  line1(34, 13, 33, 15);
  line1(33, 16, 32, 18);
  line1(32, 19, 32, 21);
  line1(33, 22, 34, 24);
  line1(34, 25, 36, 27);
  line1(37, 28, 35, 28);
  line1(34, 28, 32, 28);
  line1(31, 27, 29, 26);
  line1(28, 26, 26, 24);
  line1(25, 23, 24, 21);
  line1(24, 20, 24, 18);
  line1(23, 17, 23, 15);
  line1(24, 14, 25, 12);
  line1(25, 11, 27, 9);

  fill1(24, 7, Dblue, Black);

  line1(0, 56, 51, 56); { not necessary }
  fill1(11, 58, Black, Black);
  line1(48, 55, 47, 48); { not necessary }
  fill1(50, 54, Black, Black); { not necessary }

  line1(96, 39, 115, 0);
  line1(127, 57, 141, 1);
  line1(161, 65, 172, 9);
  line1(172, 8, 173, 0);
  line1(202, 80, 220, 24);
  line1(221, 23, 232, 0);
  line1(70, 9, 72, 0);
  line1(83, 10, 85, 0);
  extendedLine(49, 95, 55, 98, true);
  line1(56, 98, 75, 102);
  extendedLine(76, 111, 84, 113, true);
  line1(85, 113, 101, 117);
  line1(102, 117, 129, 121);
  line1(130, 121, 142, 120);
  line1(143, 120, 149, 123);
  line1(150, 123, 152, 127);

  fill1(51, 114, Black, Black);
  fill1(181, 127, Red, Black);

  frame(White);

  REPEAT UNTIL KeyPressed;
  Color(White, Dblue, Dblue);
  ClrScr;

  writeln('Narrow place');
  writeln('Picture from The Hobbit (1982)');
  writeln('Illustrated by Kent Rees');
  writeln('Data from https://richcarl.github.io/hobbitgfx/');

end.

