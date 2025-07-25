unit SimulatorCrt;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, Graphics, FPImage, Crt, LazUtf8,
  SimulatorColors;

const	GetMaxX = 639;
	GetMaxY = 263;

const   CharWidth = 8; // bits in one row
        CharHeight = 11;

var
  OffscreenImage: TBitmap;

var
  GetTextX    : Integer;
  GetTextY    : Integer;
  TextColor   : 0..7;
  TextBgColor : 0..7;

var
  KeyPressedState: Boolean = False;

var
  ukncfont: array[0..2815] of byte; // 256 characters, one char per 11 bytes
  bitmask: array[0..7] of byte = (1, 2, 4, 8, 16, 32, 64, 128);

procedure preInit;

PROCEDURE Color(fg, bg, unknown: Integer);
procedure ClrScr;
PROCEDURE GotoXY(x, y: Integer);

procedure Write(s : string);
procedure Writeln(s : string);

function KeyPressed: Boolean;

procedure IterateUTF8Codepoints(const AnUTF8String: string);

implementation

procedure preInit;
const
  C_FNAME = 'uknc_rom.bin';
var
  fs:TFileStream;
begin
  fs:=TFileStream.Create(C_FNAME,fmOpenRead);
  fs.Position := 7960;
  fs.Read (ukncfont[0], 2816);
  fs.Free;
end;

PROCEDURE Color(fg, bg, unknown: Integer);
BEGIN
 TextColor := fg;
 TextBgColor := bg;
 OffscreenImage.Canvas.Pen.Color := ColorToTColor(fg);
 OffscreenImage.Canvas.Brush.Color := ColorToTColor(bg);
END;

procedure ClrScr;
begin
  OffscreenImage.Canvas.FillRect(0, 0, OffscreenImage.Width, OffscreenImage.Height);
end;

PROCEDURE GotoXY(x, y: Integer);
BEGIN
 GetTextX := x;
 GetTextY := y
END;

procedure outputChar(x0, y0, index, fgColor, bgColor: Integer);
var
  start: Integer;
  x, y: Integer;
  chByte, row, bit: Integer;
  bg, fg: TFPColor;
begin
  bg := TColorToFPColor(ColorToTColor(bgColor));
  fg := TColorToFPColor(ColorToTColor(fgColor));
  y := (y0 - 1) * CharHeight; // y0 should be greater or equal to 1
  start := index * CharHeight;
  for row:= 0 to (CharHeight - 1) do
    begin
      chByte := ukncfont[start + row];
      for bit := 0 to (CharWidth - 1) do
        begin
          x := x0 * CharWidth + bit;
          if ((chByte and bitmask[bit]) = 0) then
            begin
              OffscreenImage.Canvas.DrawPixel(x, y, bg);
            end
          else
            begin
              OffscreenImage.Canvas.DrawPixel(x, y, fg);
            end;
        end;
      y := y + 1;
    end;
end;

procedure Write(s : string);
var
  byteArray : array of byte = ();
  chByte: byte;
  i: Integer;
begin
  setLength(byteArray, length(s));
  for i := 1 to length(s) do byteArray[i-1] := Ord(s[i]);
  for chByte in byteArray do
    begin
      outputChar(GetTextX, GetTextY, chByte, TextColor, TextBgColor);
      if (GetTextX < ((GetMaxX + 1) / CharWidth)) then
        begin
          GetTextX := GetTextX + 1;
        end
      else
        begin
          GetTextX := 0;
          GetTextY := GetTextY + 1; // todo: vertical scroll
        end;
    end;
end;

procedure Writeln(s : string);
begin
  Write(s);
  GetTextX := 0;
  GetTextY := GetTextY + 1; // todo: vertical scroll
end;

procedure IterateUTF8Codepoints(const AnUTF8String: string);
var
  p: PChar;
  unicode: Cardinal;
  CPLen: longint;
begin
  p:=PChar(AnUTF8String);
  repeat
    unicode:=UTF8CodepointToUnicode(p,CPLen);
    //writeln('Unicode=', unicode);
    inc(p,CPLen);
  until (CPLen=0) or (unicode=0);
end;

function KeyPressed: Boolean;
begin
  if KeyPressedState then
    begin
      KeyPressed := True;
      KeyPressedState := False;
    end
  else
    Delay(100);
end;

end.

