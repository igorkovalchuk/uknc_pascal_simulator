// Most of this functionality and API has been copied from CGRAPH.PAS
unit SimulatorGraphics;

{$mode ObjFPC}{$H+}

interface

uses
  Graphics, Forms, FPImage, ExtCtrls, IntfGraphics, Crt, GraphType,
  SimulatorColors, SimulatorCrt;

const  EmptyPixel = 0;
       BorderPixel = 255;
       FilledPixel = 254;
       MarkedPixel = 1;

// define how many pixels should be set, before refreshing the screen,
// during the FloodFill.
// for a slow computer, like single core Celeron 1.7GHz,
// this value may be 50 pixels, for example.
// for the fast development mode use 10000 pixels or more.
const  UpdateScreenPeriod = 50;

type
  ScreenArray = array[0..GetMaxX,0..GetMaxY] of Byte;

var
  screen: ScreenArray;

var	GetColor : 0..7;
	GetX	 : 0..GetMaxX;
	GetY	 : 0..GetMaxY;

var     FgTFPColor: TFPColor;

var
  OffscreenImage: TBitmap;

PROCEDURE SetColor(c: Integer);
PROCEDURE MoveTo(x,y: Integer);
PROCEDURE MoveRel(dX,dY: Integer);
PROCEDURE LineTo(x,y: Integer);
PROCEDURE LineRel(dX,dY: Integer);
PROCEDURE Line(x0,y0,x1,y1: Integer);
PROCEDURE Rectangle(x0,y0,x1,y1: Integer);
PROCEDURE Bar(x0,y0,x1,y1,bg: Integer);
PROCEDURE PutPixel(x,y: Integer);
function GetPixel(x,y: Integer) : Integer;
PROCEDURE Ellips(x,y,dx,dy: Integer);
PROCEDURE InitGraph;
procedure FloodFill(x,y,fillColor,borderColor: Integer);

implementation

PROCEDURE SetColor(c: Integer);
BEGIN
 GetColor := c;
 FgTFPColor := TColorToFPColor(ColorToTColor(c));
 OffscreenImage.Canvas.Pen.Color := ColorToTColor(c);
END;

PROCEDURE MoveTo(x,y: Integer);
BEGIN
 GetX:=x;
 GetY:=y
END;

PROCEDURE MoveRel(dX,dY: Integer);
BEGIN
 MoveTo(dX+GetX,dY+GetY)
END;

PROCEDURE LineTo(x,y: Integer);
BEGIN
 // it is necessary to draw the pixels at the ends of the line,
 // otherwise the Ellips may have some spaces
 OffscreenImage.Canvas.DrawPixel(GetX, GetMaxY - GetY, FgTFPColor);
 OffscreenImage.Canvas.Line(GetX, GetMaxY - GetY, x, GetMaxY - y);
 OffscreenImage.Canvas.DrawPixel(x, GetMaxY - y, FgTFPColor);
 GetX:=x;
 GetY:=y
END;

PROCEDURE LineRel(dX,dY: Integer);
BEGIN
 LineTo(GetX+dX,GetY+dY)
END;

PROCEDURE Line(x0,y0,x1,y1: Integer);
BEGIN
 MoveTo(x0,y0);
 LineTo(x1,y1)
END;

PROCEDURE Rectangle(x0,y0,x1,y1: Integer);
BEGIN
 Line   (x0,y0,x1,y0);
 LineTo (      x1,y1);
 LineTo (x0,      y1);
 Lineto (x0,y0)
END;

PROCEDURE Bar(x0,y0,x1,y1,bg: Integer);
var y,prev: Integer;
BEGIN
 prev := GetColor;
 SetColor(bg);
 for y := y0 to y1 do
     Line(x0,y,x1,y);
 SetColor(prev);
END;

PROCEDURE PutPixel(x,y: Integer);
BEGIN
  OffscreenImage.Canvas.DrawPixel(x, GetMaxY - y, FgTFPColor);
  GetX:=x;
  GetY:=y
END;

function GetPixel(x,y: Integer) : Integer;
begin
  GetPixel := ColorFromTColor(OffscreenImage.Canvas.Pixels[x, GetMaxY - y]);
end;

PROCEDURE Ellips(x,y,dx,dy: Integer);
VAR xx,yy,mx,ky,tx,ty,st,nac: Integer;
BEGIN
 nac := dx DIV (dy*3)+1;
 xx  := x+x;
 yy  := y+y;
 tx  := x;
 ty  := y-dy;
 ky  := ty;
 st  := 0;
 REPEAT
  Inc(st);
  ky := ky+st DIV nac;
  IF ky>y THEN ky:=y;
  mx:=Round(Sqrt(1-Sqr((y-ky)/dy))*dx);
  Line(tx,    GetMaxY - ty,        x+mx, GetMaxY - ky);
  Line(xx-tx, GetMaxY - ty,        x-mx, GetMaxY - ky);
  Line(tx,    GetMaxY - (yy - ty), x+mx, GetMaxY - (yy-ky));
  Line(xx-tx, GetMaxY - (yy - ty), x-mx, GetMaxY - (yy-ky));
  tx := x+mx;
  ty := ky
 UNTIL ky=y;
 MoveTo(x,y)
END;

PROCEDURE InitGraph;
BEGIN
 SetColor(7);
 // todo: set background color
 MoveTo(0,0);
 Delay(1000);
END;

// UKNC uses a better algorithm than this one
procedure FloodFill(x, y, fillColor, borderColor: Integer);
var
  color: TFPColor;
  border: TFPColor;
  px, py: Integer;
  img: TLazIntfImage;
  marked: Boolean = True;
  minX: Integer = 0;
  maxX: Integer = 0;
  minY: Integer = 0;
  maxY: Integer = 0;
  counter: Integer = 0;
begin
  color := TColorToFPColor(ColorToTColor(fillColor));
  border := TColorToFPColor(ColorToTColor(borderColor));

  screen := Default(ScreenArray);

  img := OffscreenImage.CreateIntfImage;

  if img.Colors[x,y] = border then
    Exit;

  screen[x,y] := MarkedPixel;
  minX := x; maxX := x; minY := y; maxY := y;

  for py := 0 to GetMaxY do
    begin
      for px := 0 to GetMaxX do
        begin
          if img.Colors[px,py] = border then
            screen[px,py] := BorderPixel;
        end;
    end;

   while marked do
     begin
       marked := False;
       for py := minY to maxY do
         begin
           for px := minX to maxX do
             begin
               if screen[px,py] = MarkedPixel then
                 begin
                   marked := True;
                   screen[px, py] := FilledPixel;
                   OffscreenImage.Canvas.DrawPixel(px, py, color);

                   Inc(counter);
                   if counter = UpdateScreenPeriod then
                     begin
                       counter := 0;
                       Delay(1); // display/animate changes
                     end;

                   if (px < GetMaxX) and (screen[px + 1, py] = EmptyPixel) then
                     begin
                       screen[px + 1, py] := MarkedPixel;
                       if maxX < (px + 1) then
                         maxX := px + 1;
                     end;

                   if (px > 0) and (screen[px - 1, py] = EmptyPixel) then
                     begin
                       screen[px - 1, py] := MarkedPixel;
                       if minX > (px - 1) then
                         minX := px - 1;
                     end;

                   if (py < GetMaxY) and (screen[px, py + 1] = EmptyPixel) then
                     begin
                       screen[px, py + 1] := MarkedPixel;
                       if maxY < (py + 1) then
                         maxY := py + 1;
                     end;

                   if (py > 0) and (screen[px, py - 1] = EmptyPixel) then
                     begin
                       screen[px, py - 1] := MarkedPixel;
                       if minY > (py - 1) then
                         minY := py - 1;
                     end;

                 end;
             end;
         end;
     end;

   //for py := 0 to GetMaxY do
     //begin
       //for px := 0 to GetMaxX do
         //begin
           //if screen[px,py] = FilledPixel then
             //img.Colors[px,py] := color;
         //end;
     //end;

  //OffscreenImage.LoadFromIntfImage(img);
end;

end.

