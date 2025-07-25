
// DMC.PAS from Pascal/Fast distribution
PROGRAM DMC;

{$i cGraph}

VAR i,j: Integer; 

BEGIN
  Color(White,Black,Black);
  InitGraph;

  SetColor(6);
  FOR i:=0 TO 300 DO PutPixel(Random(240)+200,247-Random(33));

  FOR i:=0 TO 13  DO
  BEGIN
    SetColor(7-i DIV 2);
    Rectangle(i,i,GetMaxX-i,GetMaxY-i)
  END;

  SetColor(6);

  Ellips(319,132,250,80);
  Ellips(319,132,200,75);
  FloodFill(80,132,6,6);

  Color(Black,Red,Black);
  GotoXY(31,3);
  Write(' Pascal/Fast v2.2-3 ');

  Color(White,Blue,Black);
  GotoXY(18,21);
  Write(' ***   CGRAPH.PAS module demonstration   *** ');

  MoveTo(161,159);
  { "U" }
  LineRel( 16, 0); LineRel( 0,-22); LineRel( 32,  0); LineRel(  0,22);
  LineRel( 16, 0); LineRel( 0,-44); LineRel(-16,-11); LineRel(-32, 0);
  LineRel(-16,11); LineRel(48,  0); LineRel(  0, 11); LineRel(-32, 0);
  LineRel(-16,11); LineRel( 0, 22); MoveRel( 80,  0);
  { "K" }
  LineRel( 16,  0); LineRel(  0,-22); LineRel( 32, 0); LineRel(0, 22);
  LineRel( 16,  0);
  LineRel(  0,-22); LineRel(-16, -5); LineRel( 16,-6); LineRel(0,-22);
  LineRel(-16,  0); LineRel(  0, 22); LineRel(-32, 0); LineRel(0,-22);
  LineRel(-16,  0); LineRel(  0, 55); MoveRel( 80, 0);
  { "N" }
  LineRel( 16,  0); LineRel(  0,-22); LineRel(32, 0); LineRel(  0,22);
  LineRel( 16,  0);
  LineRel(  0,-55); LineRel(-16,  0); LineRel( 0,22); LineRel(-32, 0);
  LineRel(  0,-22); LineRel(-16,  0); LineRel( 0,55); MoveRel( 80, 0);
  { "C" }
  LineRel( 16,  0); LineRel(  0,-44); LineRel(24, 0); LineRel(  0,44);
  LineRel( 16,  0);
  LineRel(  0,-44); LineRel(  8,  0); LineRel(0,-22); LineRel(-16, 0);
  LineRel(  0, 11);
  LineRel(-48,  0); LineRel(  0, 55);

  FloodFill(120,132,Green,Yellow);

  FOR i:=0 TO 7 DO
  BEGIN
   j:=i*70;
   Rectangle(j+40,20,j+105,30);
   Bar(j+41,21,j+104,29,i)
  END;

  REPEAT UNTIL KeyPressed;
  Color(White,Dblue,Dblue);
  ClrScr;            

END.

