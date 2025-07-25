unit SimulatorColors;

{$mode ObjFPC}{$H+}

interface

uses
  Graphics;

// uncomment the next line to use BGR colors
//{$define bgr}

const  Black  = 0;
       Dblue  = 1;
       Green  = 2;
       Blue   = 3;
       Red    = 4;
       Purple = 5;
       Yellow = 6;
       White  = 7;

function ColorToTColor(color: Integer) : TColor;
function ColorFromTColor(color: TColor) : Integer;

implementation

function ColorToTColor(color: Integer) : TColor;
begin
  case color of
   Black :  ColorToTColor := clBlack;
   Dblue :  ColorToTColor := clBlue;
   {$ifdef bgr}
   Green :  ColorToTColor := clRed;
   Blue :   ColorToTColor := clFuchsia;
   Red :    ColorToTColor := clLime;
   Purple : ColorToTColor := clAqua;
   {$else}
   Green :  ColorToTColor := clLime;
   Blue :   ColorToTColor := clAqua;
   Red :    ColorToTColor := clRed;
   Purple : ColorToTColor := clFuchsia;
   {$endif}
   Yellow : ColorToTColor := clYellow;
   White :  ColorToTColor := clWhite;
  else
    ColorToTColor := clBlack;
  end;
end;

function ColorFromTColor(color: TColor) : Integer;
begin
  case color of
   clBlack :   ColorFromTColor := Black;
   clBlue :    ColorFromTColor := Dblue;
   {$ifdef bgr}
   clRed:      ColorFromTColor := Green;
   clFuchsia : ColorFromTColor := Blue;
   clLime :    ColorFromTColor := Red;
   clAqua :    ColorFromTColor := Purple;
   {$else}
   clLime :    ColorFromTColor := Green;
   clAqua :    ColorFromTColor := Blue;
   clRed :     ColorFromTColor := Red;
   clFuchsia : ColorFromTColor := Purple;
   {$endif}
   clYellow :  ColorFromTColor := Yellow;
   clWhite :   ColorFromTColor := White;
  else
    ColorFromTColor := Black;
  end;
end;

end.

