unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, GraphType,
  SimulatorThreads, SimulatorCrt, SimulatorGraphics;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image1Paint(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  OffscreenImage: TBitmap;
  RawImage: TRawImage;
  Description: TRawImageDescription;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  OffscreenImage := TBitmap.Create;

  //RawImage := OffscreenImage.RawImage;
  //Description := RawImage.Description;
  //writeln('RawImage', ' Depth = ', binStr(Description.Depth,8));
  //writeln('RawImage', ' BitsPerPixel = ', binStr(Description.BitsPerPixel,8));
  //writeln('RawImage', ' TRawImageByteOrder = ', BoolToStr(Description.ByteOrder = riboLSBFirst));

  OffscreenImage.Width := Image1.Width;
  OffscreenImage.Height := Image1.Height;
  OffscreenImage.Canvas.Pen.Color := clWhite;
  OffscreenImage.Canvas.Brush.Color := clBlack;
  OffscreenImage.Canvas.FillRect(0, 0, OffscreenImage.Width, OffscreenImage.Height);

  Image1.Canvas.FillRect(0, 0, Image1.Width, Image1.Height); // show this image

  simulatorcrt.OffscreenImage := OffscreenImage;
  simulatorcrt.preInit;

  simulatorgraphics.OffscreenImage := OffscreenImage;

  simulatorthreads.Image1 := Image1;
  simulatorthreads.OffscreenImage := OffscreenImage;
  simulatorthreads.startThreads;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  SimulatorCrt.KeyPressedState := True;
  SimulatorCrt.KeyPressedChar := Key;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SimulatorCrt.KeyPressedState := False;
  SimulatorCrt.KeyPressedChar := '?';
end;

procedure TForm1.FormClick(Sender: TObject);
begin

end;

procedure TForm1.Image1Paint(Sender: TObject);
begin
  Image1.Canvas.Draw(0, 0, OffscreenImage); // copy the offscreen bitmap to the visible image
end;

end.

