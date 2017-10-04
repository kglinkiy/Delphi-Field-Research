unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,system.Types,Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
 //procedure cleanrect();
  TDemo = class(TForm)


    PaintBox1: TPaintBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    exitbtn: TBitBtn;
    Image1: TImage;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
    procedure exitbtnEnter(Sender: TObject);
    procedure BitBtn2Enter(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure BitBtn3Enter(Sender: TObject);
 //     procedure cleanrect(paintbox:tpaintbox);
       private
    { Private declarations }
    procedure cleanrect(paintbox:tpaintbox;stepx:integer;stepy:integer) ;
  public

    { Public declarations }

  end;

var
  Demo: TDemo;
 implementation
{$R *.dfm}

uses Unit2;

procedure tdemo.cleanrect(paintbox:tpaintbox;stepx:integer;stepy:integer);//clearing and drawing gripd
var
countx,county:integer;
begin
county:=0;
countx:=0 ;
paintbox.Canvas.Rectangle(0,0,paintbox.Width,paintbox.Height);
paintbox.Canvas.FloodFill(paintbox.width,paintbox.height,clwhite,fsborder);
while countx<=paintbox.Width do
begin
 paintbox.Canvas.Pen.Color:=clsilver;
 paintbox.Canvas.MoveTo(countx,0);
 paintbox.Canvas.LineTo(countx,paintbox.Height);
 countx:=countx+stepx;
 paintbox.Canvas.Pen.Color:=clblack;
end;
while county<=paintbox.height do
 begin
 paintbox.Canvas.Pen.Color:=clsilver;
 paintbox.Canvas.MoveTo(0,county);
 paintbox.Canvas.LineTo(paintbox.Width,county);
 county:=county+stepy;
 paintbox.Canvas.Pen.Color:=clblack;
 end;
end;
procedure TDemo.exitbtnClick(Sender: TObject);
begin
form2.show;
demo.Close;
end;

procedure TDemo.exitbtnEnter(Sender: TObject);
begin
image1.Left:=exitbtn.Left-100;
image1.top:=exitbtn.Top;
image1.Visible:=true ;

end;

procedure TDemo.BitBtn1Click(Sender: TObject);
var
charge:array of integer;
points:array of tpoint;
linenumber,distance,k,z,m,i,length,startx,starty,heights,distcharge:integer;
e,r,cosa,sina:array of real;
counter,counter1:integer;//counter for all drawing operations
angle,x,y,eint,ex,ey:real;
begin
length:=400;
linenumber:=2 ;
startx:=240 ;
heights:=200;
starty:=200;
distance:=30;
//distcharge:=30;//distance between  charges(in math model)
counter:=round(length/distance) ;
//counter1:= round(length/distcharge);   //distance between charges of condensor
setlength(points,counter*2);
setlength(r,counter*2) ;
setlength(charge,counter*2) ;
setlength(e,counter*2) ;
setlength(cosa,counter*2) ;
setlength(sina,counter*2) ;
          demo.cleanrect(paintbox1,30,30);
for i := 0 to counter-1 do
begin
 points[i]:=point(startx+i*distance,starty);
 points[i+counter]:=point(startx+i*distance,starty+heights)  ;
 charge[i]:=1;
 charge[i+counter]:=-1
 end;
  for m := 0 to counter-1 do
  begin
   for z := 1 to linenumber do
   begin
   angle:=2*pi*(z/linenumber);
   x:=points[m].X+2*cos(angle) ;
   y:=points[m].y+2*sin(angle)  ;
   k:=0  ;
   while (x<paintbox1.Width) and  (y<paintbox1.Height)and (x>0) and (y>0)and  (k<500) do
    begin
    ex:=0;
    ey:=0;
    for i := 0 to counter*2-1 do
    begin
    paintbox1.canvas.rectangle(points[0].x,points[0].y-5,points[counter-1].X,points[counter-1].Y+5);
    paintbox1.canvas.rectangle(points[counter].x,points[counter].y-5,points[counter*2-1].X,points[counter*2-1].Y+5);
                                                                     //drawing lines for condensor
                                                                      //  paintbox1.Canvas.Pixels[points[i].x,points[i].y]:=clblack  ;
    r[i]:=sqrt(sqr(x-points[i].X)+sqr(y-points[i].y)) ;
    if r[i]<>0 then                 e[i]:=charge[i]/sqr(r[i])  ;
    if r[i]<>0 then        cosa[i]:=(x-points[i].X)/r[i];
    if r[i]<>0 then              sina[i]:=(y-points[i].y)/r[i];
    ex:=ex+e[i]*cosa[i] ;
    ey:=ey+e[i]*sina[i] ;
    end;
   eint:=sqrt(sqr(ex)+sqr(ey));
   paintbox1.Canvas.Pixels[round(x),round(y)]:=clblack  ;
   x:=x+(ex/eint);
   y:=y+(ey/eint) ;
   k:=k+1;                                                                                                                            end;
   end;
  end;
 end;

procedure TDemo.BitBtn1Enter(Sender: TObject);
begin
image1.Left:=exitbtn.Left-100;
image1.top:=bitbtn1.Top;
image1.Visible:=true ;

end;

procedure TDemo.BitBtn2Click(Sender: TObject);  //2 charge positive and negative
var
q1,q2,q3,npixel, x1,x2,x3,y1,y2,y3,i,k,linenumber,m:integer;
r1,r2,r3,e1,e2,e3,sina1,cosa1,sina2,cosa2,sina3,cosa3,ex,ey, e,x,y,z:real;
             xord,ycord:array of integer  ;
begin
demo.cleanrect(paintbox1,30,30);
q1:=1   ;
q3:=1;
k:=0;
x1:=250;
x3:=550    ;
y1:=400 ;
y3:=400;
linenumber:=30;
npixel:=10 ;
paintbox1.Canvas.Ellipse(x1-5,y1-5,x1+5,y1+5);
paintbox1.Canvas.Ellipse(x3-5,y3-5,x3+5,y3+5);
setlength(xord,2);
setlength(ycord,2);
xord[0]:=x1;
xord[1]:=x3;
ycord[0]:=y1;
ycord[1]:=y3;
for m := 0 to  1 do
 begin
 for i:=1 to linenumber do
  begin
  z:=(i/linenumber);
    x:=xord[m]+npixel*cos(3.1415*2*z)        ;
  y:=ycord[m]+npixel*sin(3.1415*2*z)   ;
  while (x<paintbox1.width) and (y<paintbox1.height) and (x>0) and (y>0) do
   begin
   r1:=sqrt(sqr(x-x1)+sqr(y-y1))  ;      //distance betwwen first charge and point
   r3:=sqrt(sqr(x-x3)+sqr(y-y3)) ;    //between second charge             ;
   e1:=(q1/sqr(r1));
   e3:=(q3/sqr(r3));
   sina1:=(y-y1)/r1   ;
   sina3:=(y-y3)/r3 ;
   cosa1:=(x-x1)/r1;
   cosa3:=(x-x3)/r3;
   ex:=e1*cosa1+e3*cosa3  ;
   ey:=e1*sina1+e3*sina3;
   e:=sqrt(sqr(ex)+sqr(ey));
   paintbox1.Canvas.Pixels[round(x),round(y)]:=clblack ;
   x:=x+(ex/e);
   y:=y+(ey/e) ;
   end;
  end;
 end;
end;


procedure TDemo.BitBtn2Enter(Sender: TObject);
begin
image1.Left:=exitbtn.Left-100;
image1.top:=bitbtn2.Top;
image1.Visible:=true ;

end;

procedure TDemo.BitBtn3Click(Sender: TObject);
var
q1,q2,q3,npixel, x1,x2,x3,y1,y2,y3,i,k,linenumber,m:integer;
r1,r2,r3,e1,e2,e3,sina1,cosa1,sina2,cosa2,sina3,cosa3,ex,ey, e,x,y,z:real;
             xord,ycord:array of integer  ;
begin
              demo.cleanrect(paintbox1,30,30);

q1:=1   ;
q3:=-1;
k:=0;
x1:=250;
x3:=550    ;
y1:=400 ;
y3:=400;
linenumber:=30;
npixel:=5 ;
paintbox1.Canvas.Ellipse(x1-5,y1-5,x1+5,y1+5);
paintbox1.Canvas.Ellipse(x3-5,y3-5,x3+5,y3+5);
setlength(xord,2);
setlength(ycord,2);
xord[0]:=x1;
xord[1]:=x3;
ycord[0]:=y1;
ycord[1]:=y3;
for m := 0 to 1 do
begin
for i:=1 to linenumber do
begin
z:=(i/linenumber);
x:=xord[m]+npixel*cos(3.1415*2*z)        ;
y:=ycord[m]+npixel*sin(3.1415*2*z)   ;
k:=0;
while (x<paintbox1.width) and (y<paintbox1.height) and (x>0) and (y>0)and  (k<2000)   do
begin
r1:=sqrt(sqr(x-x1)+sqr(y-y1))  ;      //distance betwwen first charge and point
r3:=sqrt(sqr(x-x3)+sqr(y-y3)) ;    //between second charge             ;
e1:=(q1/sqr(r1));
e3:=(q3/sqr(r3));
sina1:=(y-y1)/r1   ;
sina3:=(y-y3)/r3 ;
cosa1:=(x-x1)/r1;
cosa3:=(x-x3)/r3;
ex:=(e1*cosa1+e3*cosa3)   ;
ey:=(e1*sina1+e3*sina3);
e:=sqrt(sqr(ex)+sqr(ey));
paintbox1.Canvas.Pixels[round(x),round(y)]:=clblack;
if m=0 then
begin
x:=x+(ex/e);
y:=y+(ey/e) ;
end;
if m=1 then
begin
x:=x-(ex/e);
y:=y-(ey/e) ;
end;
k:=k+1;
end;
end;
end;
end;

procedure TDemo.BitBtn3Enter(Sender: TObject);
begin
image1.Left:=exitbtn.Left-100;
image1.top:=bitbtn3.Top;
image1.Visible:=true ;
end;

end.
