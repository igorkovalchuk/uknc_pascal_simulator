{ Reproducing the picture from The Hobbit (1982), illustrated by Kent Rees }
{ Data from https://richcarl.github.io/hobbitgfx/ }

PROGRAM HO82HO;

{$i cGraph}

const multiplier = 2;
const startX = 64; {(640 - 256*2) / 2}
const startY = 0;

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
  x: Integer;
begin
  SetColor(color);
  { 256 × 192 ZX Spectrum window size }
  x := 256 * 2 - 1;
  Line(startX + x, 0, startX + x, GetMaxY - (startY + 207)); { vertical line }
  Line(startX, 0, startX, GetMaxY - (startY + 207)); { vertical line }
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

  line1(158, 57, 158, 53); { the round door }
  line1(158, 52, 159, 48);
  line1(159, 47, 161, 43);
  line1(161, 42, 165, 38);
  line1(166, 37, 170, 35);
  line1(171, 35, 175, 34);
  line1(176, 34, 180, 34);
  line1(198, 57, 198, 53);
  line1(198, 52, 197, 48);
  line1(197, 47, 195, 43);
  line1(195, 42, 191, 38);
  line1(190, 37, 186, 35);
  line1(185, 35, 181, 35);
  line1(180, 34, 181, 35); { connected two lines }
  line1(158, 57, 159, 58); { connected two lines }
  line1(159, 58, 160, 62);
  line1(160, 63, 162, 67);
  line1(162, 68, 166, 72);
  line1(167, 73, 171, 75);
  line1(172, 75, 174, 75);
  line1(175, 76, 179, 76);
  line1(198, 57, 197, 58); { connected two lines }
  line1(197, 58, 196, 62);
  line1(196, 63, 194, 67);
  line1(194, 68, 190, 72);
  line1(189, 73, 185, 75);
  line1(184, 75, 180, 76);
  line1(180, 76, 179, 76); { connected two lines }

  line1(145, 49, 106, 49); { lines on the left side }
  line1(105, 49, 66, 45);
  line1(65, 44, 26, 40);
  line1(25, 39, 0, 36);
  line1(145, 72, 106, 72);
  line1(105, 72, 66, 76);
  line1(65, 77, 26, 81);
  line1(25, 82, 0, 85);
  line1(145, 38, 99, 38);
  line1(98, 37, 59, 30);
  line1(58, 29, 19, 22);
  line1(18, 21, 0, 18);

  line1(106, 103, 92, 103); { the chest }
  line1(91, 103, 85, 90);
  line1(84, 89, 97, 89);
  line1(98, 89, 112, 89);
  line1(113, 89, 106, 103);
  line1(85, 89, 86, 87);
  line1(86, 86, 88, 84);
  line1(89, 83, 91, 82);
  line1(92, 82, 94, 81);
  line1(95, 81, 97, 81);
  line1(98, 80, 100, 80);
  line1(101, 81, 103, 81);
  line1(104, 82, 106, 82);
  line1(107, 83, 109, 84);
  line1(110, 84, 112, 85);
  line1(113, 85, 114, 87);
  line1(114, 88, 116, 87);
  line1(117, 87, 121, 83);
  line1(106, 103, 108, 103); { connected two lines }
  line1(108, 103, 117, 94);
  line1(118, 93, 121, 83);
  line1(121, 82, 119, 80);
  line1(118, 79, 116, 78);
  line1(115, 78, 113, 77);
  line1(112, 77, 110, 77);
  line1(109, 76, 107, 76);
  line1(106, 77, 104, 77);
  line1(103, 78, 101, 78);
  line1(100, 79, 98, 79);
  line1(97, 80, 95, 80);
  line1(92, 103, 92, 82);
  line1(99, 103, 99, 80);
  line1(107, 102, 107, 82);
  line1(85, 90, 113, 90);
  line1(108, 83, 117, 79);
  line1(102, 80, 110, 76);

  extendedLine(147, 83, 122, 83, false); { line near the chest  }
  extendedLine(85, 87, 60, 92, true); { line near the chest }
  line1(59, 92, 34, 97);
  line1(33, 97, 8, 102);
  line1(7, 102, 0, 103);

  line1(147, 72, 147, 38); { the door }
  line1(148, 37, 150, 32);
  line1(151, 31, 156, 26);
  line1(157, 25, 162, 23);
  line1(163, 22, 168, 21);
  line1(169, 20, 174, 19);
  extendedLine(175, 19, 180, 19, false);
  line1(208, 38, 206, 33);
  line1(205, 32, 200, 27);
  line1(199, 26, 194, 24);
  line1(193, 23, 188, 22);
  line1(187, 21, 181, 19);
  extendedLine(208, 39, 208, 72, true);
  line1(208, 73, 202, 79);
  line1(201, 80, 159, 80);
  line1(158, 79, 152, 67);
  line1(152, 66, 153, 29);
  line1(152, 69, 147, 71);
  line1(157, 78, 147, 83);
  line1(96, 73, 98, 75);
  line1(99, 75, 147, 75);
  line1(148, 75, 147, 72);
  line1(148, 74, 154, 71);
  line1(148, 82, 148, 75);
  line1(205, 76, 205, 44);
  line1(205, 43, 203, 30);
  line1(155, 80, 162, 80);
  line1(157, 79, 157, 79);
  line1(156, 79, 156, 79);
  line1(98, 75, 36, 85);
  line1(35, 85, 0, 90);
  line1(147, 49, 152, 48);
  line1(147, 38, 151, 39);
  line1(167, 72, 167, 37);
  line1(176, 76, 176, 75); { connection for vertical line }
  line1(176, 75, 176, 35); { vertical line }
  line1(176, 35, 176, 34); { connection for vertical line }
  line1(186, 74, 186, 35);
  line1(195, 66, 195, 43);
  extendedLine(194, 44, 187, 46, false); { the door hinge }
  line1(186, 48, 198, 51);
  line1(195, 64, 186, 61);
  line1(186, 59, 198, 56);

  line1(162, 54, 162, 57); { the door handle }
  line1(163, 54, 163, 57);
  line1(161, 55, 161, 56);

  line1(203, 82, 212, 82);
  line1(213, 82, 255, 103);
  line1(215, 75, 255, 88);
  line1(219, 72, 255, 79);
  line1(217, 72, 215, 74);
  line1(215, 75, 215, 82);
  line1(216, 72, 209, 72);
  line1(214, 75, 205, 76);
  line1(206, 76, 206, 82);
  line1(202, 79, 205, 82);
  line1(98, 50, 98, 73);
  line1(98, 50, 100, 38);
  line1(210, 50, 216, 50);
  line1(217, 49, 255, 42);
  line1(209, 38, 214, 38);
  line1(215, 37, 255, 24);
  line1(216, 49, 216, 72);
  line1(216, 49, 214, 37);
  line1(214, 38, 213, 32);
  line1(213, 31, 210, 25);
  line1(210, 24, 204, 18);
  line1(203, 17, 197, 14);
  line1(196, 14, 190, 12);
  line1(189, 12, 183, 11);
  line1(182, 11, 176, 10);
  line1(175, 10, 169, 10);
  line1(168, 9, 162, 9);
  line1(161, 9, 155, 9);
  line1(154, 9, 148, 9);
  line1(147, 9, 145, 9);
  line1(144, 9, 140, 9);
  line1(99, 38, 101, 32);
  line1(101, 31, 104, 25);
  line1(104, 24, 110, 18);
  line1(111, 17, 117, 14);
  line1(118, 14, 124, 12);
  line1(125, 12, 131, 11);
  line1(132, 11, 139, 10);
  line1(207, 72, 205, 70);
  line1(209, 50, 206, 49);
  line1(208, 38, 206, 38);
  line1(96, 75, 96, 79);

  fill1(191, 46, Black, Black); { round door hinges }
  fill1(191, 60, Black, Black);
  fill1(196, 47, Black, Black);
  fill1(196, 58, Black, Black);

  fill1(156, 59, Black, Black); { the door frame }

  fill1(164, 52, Green, Black); { round door }
  fill1(172, 52, Green, Black);
  fill1(180, 52, Green, Black);
  fill1(190, 52, Green, Black);
  fill1(190, 42, Green, Black);
  fill1(190, 67, Green, Black);
  fill1(196, 52, Green, Black);

  frame(Black);
  fill1(127, 103, Purple, Black); { floor }
  frame(Purple);

  REPEAT UNTIL KeyPressed;
  Color(White, Dblue, Dblue);
  ClrScr;

  writeln('Tunnel like hall');
  writeln('Picture from The Hobbit (1982)');
  writeln('Illustrated by Kent Rees');
  writeln('Data from https://richcarl.github.io/hobbitgfx/');

end.

