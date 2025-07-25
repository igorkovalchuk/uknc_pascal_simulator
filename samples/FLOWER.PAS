
// FLOWER.PAS from Pascal/Fast distribution
PROGRAM FLOWER;

{$i cGraph}

PROCEDURE DrawFlower (x, y, radius, n: INTEGER; a1, a3, a5: REAL);
CONST
  Aspect = 0.65;
  p = 0.01745329; { 3.14159 / 180.0 }
VAR
  b1, b3, b5, q, r, dg, rd, cosRd, sinRd: REAL;
BEGIN
  q := a1 + a3 + a5;
  b1 := radius * a1 / q; b3 := radius * a3 / q; b5 := radius * a5 / q;
  dg := 360.0;
  REPEAT
    rd := dg * p; q := n * rd;
    r := ABS(b1 * SIN(q * 0.5) + b3 * SIN(q * 1.5) + b5 * SIN(q * 2.5));
    cosRd := COS(rd); sinRd := SIN(rd);
    MoveTo(x, y); LineRel(ROUND(r*cosRd), ROUND(r*sinRd*Aspect));
    PutPixel(x+ROUND((R+4.0)*cosRd), y+ROUND((R+4.0)*sinRd*Aspect));
    Dg := Dg - 0.5;
  UNTIL Dg = 0.0;

  SetColor(Dblue);

  q := radius / 10.0;
  REPEAT
    n := 345;
    REPEAT
      PutPixel(x+ROUND(q*COS(n*p)), y+ROUND(q*SIN(n*p)*Aspect));
      n := n - 15;
    UNTIL n < 0;
    q := q - radius / 50.0
  UNTIL q < 0.0;

END {DrawFlower};

BEGIN
  InitGraph;
  Color(White, Dblue, Black);
  ClrScr;
  SetColor(White);
  DrawFlower(GetMaxX DIV 2, GetMaxY DIV 2, GetMaxY, 5, 1.0, 0.25, 0.1);
END.

