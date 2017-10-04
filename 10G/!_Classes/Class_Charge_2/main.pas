unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,system.Types,
  Vcl.Buttons, Vcl.Grids, ComObj ;


type


//===========================================CLASS CHARGE
	Charge = class
        private
        	_q : real;
          _pos : TPoint;
          _checked : boolean;
          _color : TColor;
        public
        constructor New(q : real; pos: TPoint);
    end;
//===========================================CLASS SPACE
	Space = class
    	private
        	_charges : array of Charge;
          _cntCharges : integer;

                   public
  _canvas : TCanvas;
 constructor New(canvas : TCanvas; gridPeriod : integer);

procedure PointMove(x0:integer;y0:integer;vx0:real;vy0:real);
procedure AddCharge(position:tpoint;chargeq:real);
procedure RemoveCharge(numbercharge:integer);
procedure MoveCharge(numbercharge:integer);
procedure Draw(linenumber:array of integer;DropOut:integer);
procedure DrawGrid(gridperiod:integer);
procedure redraw;
procedure scopedraw(point1:tpoint;color:tcolor);
procedure opilki;
procedure LineFromPoint(pointdraw:tpoint);
procedure gridtospace(stringgrid1:tstringgrid);
function colour(eint:real):tcolor;
    end;

//====================================================
  TfMain = class(TForm)
    pbMain: TPaintBox;
    btndelete: TBitBtn;
    Panel1: TPanel;
    labelededit1: TLabeledEdit;
    Button1: TButton;
    StringGrid1: TStringGrid;
    exitbtn: TBitBtn;
    btnaccept: TBitBtn;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    savebutton: TBitBtn;
    loadbutton: TBitBtn;
    statbtn: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Image1: TImage;
    RadioButton3: TRadioButton;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    TrackBar2: TTrackBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure CleanScreen;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure pbMainPaint(Sender: TObject);
    procedure pbMainClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure statbtnClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
    procedure btnacceptClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function foolproof(labele1:tlabelededit):real;
    procedure savebuttonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure labelededit1Change(Sender: TObject);
    procedure pbMainDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2KeyPress(Sender: TObject; var Key: Char);
    procedure exitbtnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure exitbtnEnter(Sender: TObject);
    procedure Button1Enter(Sender: TObject);
    procedure btndeleteEnter(Sender: TObject);
    procedure loadbuttonClick(Sender: TObject);
    function degree(x:real;y:integer):real;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  excel:variant;
  fMain: TfMain;
  chargeq:real;
  MySpace : Space;
  gridperiod:integer ;
  pt:tpoint;
  point0,point1:tpoint;
implementation

{$R *.dfm}

uses Unit2, Unit4;

	constructor Charge.New(q: real; pos: TPoint);
    begin
self._q := q;
self._pos := pos;
if(q<0)then
self._color := clBlue
else
self._color := clRed;
end;
function SaveAsExcelFile(stringGrid: TstringGrid; FileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row, Col: Integer;
  GridPrevFile: string;
  XLApp, Sheet: OLEVariant;
begin
  Result := False;
  XLApp  := CreateOleObject('Excel.Application');
  try
    XLApp.Visible := False;
    XLApp.Workbooks.Add(xlWBatWorkSheet);
    Sheet      := XLApp.Workbooks[1].WorkSheets[1];
    Sheet.Name := 'My Sheet Name';
    for col := 0 to stringGrid.ColCount - 1 do
      for row := 0 to stringGrid.RowCount - 1 do
        Sheet.Cells[row + 1, col + 1] := stringGrid.Cells[col, row];
    try
      XLApp.Workbooks[1].SaveAs(FileName);
      Result := True;
    except
      // КАКАЯ БЛИН ОШИБКА!!!!!!!
    end;
  finally
    if not VarIsEmpty(XLApp) then
    begin
      XLApp.DisplayAlerts := False;
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;

function Tfmain.degree(x: Real; y: Integer):Real;
var
i:integer;
j:real;

begin
j:=1;
 if y>=0 then
begin
for i := 0 to y-1 do
begin
j:=j*x;
end;
end
else begin
for i := 0 to y+1 do
begin
j:=j/x;
end;
end;
result:=j
end;


procedure TfMain.BitBtn1Click(Sender: TObject);
begin
panel1.Visible:=false;
myspace.scopedraw(point1,clwhite);
pbmain.Canvas.Pen.Color:=clblack;
pbmain.canvas.pen.Width:=1;
myspace.DrawGrid(20);
myspace.redraw;
end;

procedure TfMain.btnacceptClick(Sender: TObject);
begin
chargeq:=FOOLPROOF(LABELEDEDIT1);
myspace.addcharge(pOINt1,chargeq);
panel1.Visible:=false;
pbmain.canvas.Pen.Color:=clwhite;
pbmain.canvas.pen.Width:=5;
myspace.scopedraw(point1,clwhite);
myspace.redraw;
myspace.DrawGrid(20);
statbtn.click;
end;

procedure  Space.PointMove(x0:integer;y0:integer;vx0:real;vy0:real);
var
counter2,counter,k:integer;
x,y:real;
q:real;
f,dt,dx,dy:real;
cosa,sina,m:real;
v,l,vx,vy,dvx,dvy:real;
r,e,ex,ey,eint:real;
begin
self._canvas.Ellipse(x0,y0,x0+5,y0+10);
m:=1;
q:=1000     ;
dt:=0.0001;
k:=0;
x:=x0;
y:=y0;
vx:=vx0;
vy:=vy0;
k:=0;
for k := 0 to 1900000 do
begin
ex:=0;
ey:=0;
eint:=0;
for counter2 := 0 to self._cntcharges-1 do   //through oharges influence
  begin
  r:=sqrt(sqr(self._charges[counter2]._pos.x-x)+sqr(self._charges[counter2]._pos.y-y));
  if r<>0 then      cosa:=(x-self._charges[counter2]._pos.x  )/r ;
  if r<>0 then         sina:=(y-self._charges[counter2]._pos.y  )/r  ;
  if (r<>0)   then
    begin
     e:=self._charges[counter2]._q*(1/fmain.degree(r/10,fmain.Trackbar2.Position)  );
    end;
  ex:=ex+(e)*cosa;
  ey:=ey+(e)*sina;
  end;
//eint:=sqrt(sqr(ex)+sqr(ey));
vx:=vx+ex*dt*q/m;
vy:=vy+ey*dt*q/m;
x:=x+vx*dt;
y:=y+vy*dt;
self._canvas.Pixels[round(x),round(y)]:=clRed;
end;
vx:=0;
vy:=0;
end;



procedure TfMain.btnClearClick(Sender: TObject);
var
numbercharge:integer;
begin
myspace.RemoveCharge(numbercharge);
end;

procedure TfMain.btndeleteClick(Sender: TObject);
begin
setlength(myspace._charges,0);
myspace._cntCharges:=0;
pbmain.Canvas.Rectangle(0,0,pbmain.Width,pbmain.Height);
pbmain.Canvas.FloodFill(pbmain.width,pbmain.height,clwhite,fsborder);

pbmain.Canvas.Pen.Width:=1;
pbmain.Canvas.Pen.Color:=clblack;
myspace.DrawGrid(20);
statbtn.Click;
end;

procedure TfMain.btndeleteEnter(Sender: TObject);
begin
image1.Left:=btndelete.Left-100;
image1.top:=btndelete.Top;
end;

procedure TfMain.Button1Click(Sender: TObject);
var
stuff:array of integer   ;
  i:integer;
begin
//fmain.CleanScreen;
setlength(stuff,100);
for i := 0 to 99 do  stuff[i]:=trackbar1.Position;
if (radiobutton2.Checked=true) or (radiobutton3.Checked=true) then   myspace.Draw(stuff,5 );
if (radiobutton1.Checked=true) then   myspace.opilki;
for i := 0 to 0 do
myspace.PointMove(400,200+20*i,1000,0);
end;



procedure TfMain.Button1Enter(Sender: TObject);
begin
image1.Left:=button1.Left-100;
image1.top:=button1.Top;
end;

procedure TfMain.Button2Click(Sender: TObject);
begin
panel2.visible:=false;
myspace.RemoveCharge(myspace._cntCharges-1);
//bitbtn1.Click;
end;

procedure TfMain.Button2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#27  then button2.Click;

end;

procedure TfMain.Button3Click(Sender: TObject);
begin
myspace.opilki
end;

procedure TfMain.CleanScreen;
begin
pbmain.Canvas.Rectangle(0,0,pbmain.Width,pbmain.Height);
pbmain.Canvas.FloodFill(round(pbmain.width/2),round(pbmain.height/2),clwhite,fsborder);
myspace.DrawGrid(20);
myspace.redraw;
end;

procedure TfMain.exitbtnClick(Sender: TObject);
begin
fmain.Close;
form2.show;
end;

procedure TfMain.exitbtnEnter(Sender: TObject);
begin
image1.Left:=exitbtn.Left-100;
image1.Top:=exitbtn.Top;
end;

procedure TfMain.exitbtnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (panel1.Visible=false) and (panel2.Visible=false) then
begin
if key=vk_f1 then form4.show;
pbmain.Canvas.pen.color:=clwhite;
pbmain.Canvas.pen.width:=1;
pbmain.Canvas.rectangle(point1.X-5,point1.Y-5,point1.X+5,point1.Y+5);
pbmain.Canvas.Pen.Style:=pssolid;
pbmain.Canvas.pen.Color:=clsilver;
pbmain.Canvas.MoveTo(point1.X-5,point1.Y);
pbmain.Canvas.lineTo(point1.X+5,point1.Y);
pbmain.Canvas.MoveTo(point1.X,point1.Y-5);
pbmain.Canvas.lineTo(point1.X,point1.Y+5);
pbmain.Canvas.pen.width:=1;
if (key=vk_right) and (point1.X<=pbmain.Width) then point1.x:=point1.x+20;  //arrow controls
if (key=vk_down)and (point1.Y<=pbmain.Height)  then point1.y:=point1.y+20;
if (key=vk_left) and (point1.x>=0) then point1.x:=point1.x-20;
if (key=vk_up)and (point1.y>=0) then point1.y:=point1.y-20;
if key=vk_f7 then  myspace.LineFromPoint(point1);
if key=vk_f4 then  btndelete.Click;
if key=vk_f2  then savebutton.Click;
if key=vk_f3 then loadbutton.Click;
pbmain.Canvas.pen.Color:=clred;
pbmain.Canvas.rectangle(point1.X-5,point1.Y-5,point1.X+5,point1.Y+5);
end;
end;

function TfMain.foolproof(labele1: tlabelededit): real;
VAR
isOk:boolean;
  i: Integer;
begin
try
result:=strtofloat(labele1.Text)
except
panel2.Left:=point1.X;
panel2.Top:=point1.Y;
panel2.visible:=true;
result:=0;
end;
end;


procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{
try
  Excel.Quit;
except
end;
CanClose:=True;
Excel:=Unassigned; }

end;

procedure TfMain.FormCreate(Sender: TObject);
begin
MySpace := Space.New(pbMain.Canvas,10);
point1:=point(0,0)
end;




procedure TfMain.FormKeyPress(Sender: TObject; var Key: Char);
var
i:integer;//simple counter
z:integer;//what charge to delete;
begin
if panel2.Visible=true then
begin
if key=#27 then button2.Click;
end
else
begin
if PANEL1.Visible=TRUE  then
begin
if (key=#101) and (trackbar1.Position<25) then
begin
trackbar1.SetFocus;
trackbar1.Position:=trackbar1.position+1;
labelededit1.SetFocus;
end;
if (key=#113) and (trackbar1.Position>5) then
  begin
  trackbar1.SetFocus;
  trackbar1.Position:=trackbar1.position-1 ;
  labelededit1.SetFocus;
end;
  if key=#27 then bitbtn1.Click;
  if key=#13 then btnaccept.Click;
end
else
begin
//fmain.CleanScreen;
//myspace.redraw;
//myspace.DrawGrid(20);
pbmain.Canvas.pen.color:=clwhite;
pbmain.Canvas.pen.width:=1;
pbmain.Canvas.rectangle(point1.X-5,point1.Y-5,point1.X+5,point1.Y+5);
pbmain.Canvas.Pen.Style:=pssolid;
pbmain.Canvas.pen.Color:=clsilver;
pbmain.Canvas.MoveTo(point1.X-5,point1.Y);
pbmain.Canvas.lineTo(point1.X+5,point1.Y);
pbmain.Canvas.MoveTo(point1.X,point1.Y-5);
pbmain.Canvas.lineTo(point1.X,point1.Y+5);
pbmain.Canvas.pen.width:=1;
if (key=#100) and (point1.X<=pbmain.Width) then point1.x:=point1.x+20;  //wasd controls
if (key=#115)and (point1.Y<=pbmain.Height)  then point1.y:=point1.y+20;
if (key=#97) and (point1.x>=0) then point1.x:=point1.x-20;
if (key=#119)and (point1.y>=0) then point1.y:=point1.y-20;
//---- functional hotkeys
if Key=#13 then button1.Click;
if key=#27 then exitbtn.Click;
if key=#127 then  btndelete.Click;
if (key=#09)  and (radiobutton1.Checked=true)  then radiobutton2.Checked:=true ;
if (key=#09)  and (radiobutton2.Checked=true)  then radiobutton1.Checked:=true ;
if key=#08 then                //deleting charges
begin
for i := 0 to myspace._cntCharges-1 do
 begin
 if (myspace._charges[i]._pos=point1) and (
 myspace._cntCharges>=1) then z:=i;
 end;
myspace.RemoveCharge(z);
statbtn.click;
end;
pbmain.Canvas.pen.Color:=clred;
pbmain.Canvas.rectangle(point1.X-5,point1.Y-5,point1.X+5,point1.Y+5);
if key=#32 then begin
fmain.CleanScreen;
myspace.redraw;
myspace.DrawGrid(20);
panel1.Left:=point1.X+40;
panel1.top:=point1.y+40;
panel1.Visible:=true;
myspace.redraw;
myspace.scopedraw(point1,clred);
labelededit1.SetFocus;
END;
if (key=#108) or (key=#76) then loadbutton.Click;
if (key=#107)  or (key=#75) then savebutton.Click;

end;
end;


end;

procedure TfMain.labelededit1Change(Sender: TObject);
begin
//if  (labelededit1.text[length(labelededit1.Text)-1]='e') or (labelededit1.text[length(labelededit1.Text)-1]='q') then labelededit1.text[length(labelededit1.Text)]:=''
end;

procedure TfMain.loadbuttonClick(Sender: TObject);
const
  xlCellTypeLastCell = $0000000B;
var
 Excel: variant;
 WorkSheet: OLEVariant;
      i, j: word;
         S: string;
       x,y: integer;
  FileName: WideString;
begin
fmain.CleanScreen;
myspace.DrawGrid(20);
FileName:='charges.xls';
     Excel := CreateOleObject('Excel.Application');
     Excel.Workbooks.Open(FileName);
     Excel.Visible:=false;
     WorkSheet := Excel.Workbooks[ExtractFileName(FileName)].WorkSheets[1];
WorkSheet.Cells.SpecialCells(xlCellTypeLastCell,EmptyParam).Activate;
     x := Excel.ActiveCell.Row;
     y := Excel.ActiveCell.Column;
     StringGrid1.RowCount := x;
     StringGrid1.ColCount := y;
     for i := 1 to x do
       for j := 1 to y do
        begin
          S := Excel.Sheets[1].Cells[i,j].Text;
        StringGrid1.Cells[j-1,i-1]:=s;
                  end;
       myspace.gridtospace(stringgrid1);
       myspace.redraw;
end;

procedure TfMain.pbMainClick(Sender: TObject);
begin
if PANEL1.Visible=TRUE  then
ELSE
BEGIN
//deleting mistakes of youth(key usage rectangle)
fmain.CleanScreen;
myspace.redraw;
pbmain.Canvas.pen.color:=clwhite;
pbmain.Canvas.pen.width:=1;
pbmain.Canvas.rectangle(point1.X-5,point1.Y-5,point1.X+5,point1.Y+5);
pbmain.Canvas.Pen.Style:=pssolid;
pbmain.Canvas.pen.Color:=clsilver;
pbmain.Canvas.MoveTo(point1.X-5,point1.Y);
pbmain.Canvas.lineTo(point1.X+5,point1.Y);
pbmain.Canvas.MoveTo(point1.X,point1.Y-5);
pbmain.Canvas.lineTo(point1.X,point1.Y+5);
pbmain.Canvas.pen.width:=1;
//----------------------
myspace.DrawGrid(20);
getcursorpos(pt)   ;
point0:=screentoclient(pt)  ;
point1:=point(round(point0.X/20)*20,round(point0.y/20)*20 ) ;
 //setting point of charge
 //showing panel
panel1.Left:=point1.X-40;
panel1.top:=point1.y+40;
panel1.Visible:=true;
myspace.redraw;
myspace.scopedraw(point1,clred);
END;
end;

procedure TfMain.pbMainDblClick(Sender: TObject);
var
z,i:integer;
pos:tpoint;
begin
getcursorpos(pos);
pos:=screentoclient(pos);
pos:=point(round(pos.X/20)*20,round(pos.Y/20)*20);
for i := 0 to myspace._cntCharges-1 do
 begin
 if (myspace._charges[i]._pos=pos) and (myspace._cntCharges>=1) then z:=i;
 end;
myspace.RemoveCharge(z);
statbtn.click;

end;

procedure TfMain.pbMainPaint(Sender: TObject);
begin
pbmain.Canvas.Pen.Width:=1;
pbmain.Canvas.Pen.Color:=clblack;
myspace.DrawGrid(20);

end;

procedure TfMain.savebuttonClick(Sender: TObject);
begin
 if SaveAsExcelFile(stringGrid1, 'charges.xls') then
    ShowMessage('Данные сохранены успешно.Загрузка завершена /100%/');
end;
procedure TfMain.statbtnClick(Sender: TObject);
var
  i: Integer;
begin
//if   stringgrid1.Visible=false then stringgrid1.Visible:=true else stringgrid1.Visible:=false   ;
 stringgrid1.rowcount:= myspace._cntCharges+1;
 for i := 0 to myspace._cntCharges-1 do
 begin
stringgrid1.Cells[0,0]:='№ ';
stringgrid1.Cells[1,0]:='Заряд';
stringgrid1.Cells[2,0]:=' (X)' ;
stringgrid1.Cells[3,0]:=' (Y)' ;
if myspace._charges[i]._q<>0 then
begin
stringgrid1.Cells[1,i+1]:=floattostr(myspace._charges[i]._q );
stringgrid1.Cells[2,i+1]:=inttostr(myspace._charges[i]._pos.X) ;
stringgrid1.Cells[3,i+1]:=inttostr(myspace._charges[i]._pos.y);
stringgrid1.Cells[0,i+1]:=inttostr(i+1);
  end;
 end;

end;
procedure Space.AddCharge(position:tpoint;chargeq:real);
var
chargepos:tpoint;
begin
chargepos:=position;
SETLENGTH(self._charges,(self._CNTCHARGES+1));
self._charges[self._cntcharges]:=charge.New(chargeq,point(round(chargepos.x/20)*20,round(chargepos.y/20)*20))     ;
self._canvas.Pen.Width:=3;
self._canvas.Pen.Color:=self._charges[self._cntCharges]._color;
self._canvas.Create.Ellipse((round(chargepos.X/20)*20+10),(round(chargepos.Y/20)*20+10),round(chargepos.X/20)*20-10,round(chargepos.Y/20)*20-10);
self._cntcharges:=self._cntcharges+1;
self._canvas.Pen.Width:=1;
self._canvas.pen.Color:=clblack ;
end;





function Space.colour(eint:real): tcolor;
var
i:integer;
a,b,k:real;
//scalar:real;
red,green,blue,z1:byte;
emax:real;

begin
k:=0.4;
emax:=-10000;
for i := 0 to self._cntCharges-1 do
begin
if (self._charges[i]._q/100)>emax then emax:=(self._charges[i]._q/100);
end;
 if eint<>0 then b:=ln(abs(eint/emax))*k;
if b<-5 then b:=-5 ;
if b>0 then b:=0;
b:=b+5;
b:=5-b;
z1:=round((b-trunc(b))*255);
         if (b<=1) and (b>=0) then
         begin
          red:=255;
          green:=z1;
          blue:=0;
         end;
          if (b<=2) and (b>=1) then
         begin
         red:=255-z1;
         green:=255;
         blue:=0;
         end;
          if (b>=2) and (b<=3)  then
         begin
          red:=0;
          green:=255;
          blue:=z1;
         end;
          if (b>=3) and (b<=4)  then
         begin
          red:=0;
          green:=255-z1;
          blue:=255;
         end;
          if (b<=5) and (b>=4)then
         begin
           red:=0     ;
           green:=0  ;
           blue:=255;
         end;
      result:=rgb(red,green,blue)
end;

procedure Space.Draw(linenumber:array of integer;dropout:integer);
var
ex,ey,e,eint,x,y,r,cosa,sina,angle:real;
counter,counter1,counter2,curve:integer; //0-charge,1-line,2-influence
linecolor:tcolor;

begin
fmain.progressbar1.position:=0;
fmain.progressbar1.max:=(self._cntcharges);
for counter := 0 to self._cntcharges-1  do     //cycle which cycles through charges
begin
  for counter1 :=0   to linenumber[counter] do    //through different angles of start
  begin
    curve:=0;    //crutch  for length
    angle:=(counter1/linenumber[counter])*2*pi;
    x:=self._charges[counter]._pos.X+dropout*cos(angle);
    y:=self._charges[counter]._pos.y+dropout*sin(angle);
      while (x<self._canvas.ClipRect.Width)and (y<self._canvas.ClipRect.Height) and (x>0) and (y>0) and (curve<20000) do
      begin
      ex:=0    ;
      ey:=0   ;
      eint:=0;
         for counter2 := 0 to self._cntcharges-1 do   //through oharges influence
         begin
          r:=sqrt(sqr(self._charges[counter2]._pos.x-x)+sqr(self._charges[counter2]._pos.y-y));
          if r<>0 then      cosa:=(x-self._charges[counter2]._pos.x  )/r ;
          if r<>0 then         sina:=(y-self._charges[counter2]._pos.y  )/r  ;
          if (r<>0)   then
           begin
           if (self._charges[counter]._q>0) then e:=self._charges[counter2]._q/r else  e:=-1*self._charges[counter2]._q/r ;
           end;
           ex:=ex+(e)*cosa;
           ey:=ey+(e)*sina;
          end;
          eint:=sqrt(sqr(ex)+sqr(ey)); //summary
          if eint<>0 then         x:=x+ex/eint;
          if eint<>0 then      y:=y+ey/eint;
      if fmain.RadioButton2.Checked=true  then  linecolor:=clblack else   linecolor:=myspace.colour(eint);
          self._canvas.Pixels[round(x),round(y)]:=linecolor;
          self._canvas.Pixels[round(x)+1,round(y)]:=linecolor;
          curve:=curve+1;
         end;
       end;
        fmain.progressBar1.Position:=fmain.TrackBar1.Position+1;
     end;

   end;


procedure Space.RemoveCharge(numbercharge:integer);
var
chargepos:tpoint;
r:integer;
begin
fmain.CleanScreen;
self._canvas.pen.width:=3;
self._canvas.pen.color:=clwhite;
 if (numbercharge>=0) and  (numbercharge<=self._cntcharges-1) then self._canvas.Ellipse(self._charges[numbercharge]._pos.X-10,self._charges[numbercharge]._pos.y-10,self._charges[numbercharge]._pos.X+10,self._charges[numbercharge]._pos.y+10);
self._canvas.pen.width:=1;
 if (numbercharge>=0) and  (numbercharge<=self._cntcharges-1) then self._charges[numbercharge]._q:=0;
if self._cntCharges>=2 then
     begin
     for r := numbercharge to self._cntCharges-2 do
 begin
    self._charges[r]:=self._charges[r+1];
 end;
 end;
 self._cntcharges:=self._cntcharges-1;

setlength(self._charges,self._cntCharges);
myspace.redraw;
 myspace.DrawGrid(20);
 end;
procedure Space.scopedraw(point1: tpoint;color:tcolor);
begin
self._canvas.pen.Width:=5;
self._Canvas.Pen.Color:=color;
self._Canvas.MoveTo(point1.X+10,point1.Y+10);
self._Canvas.lineTo(point1.X+40,point1.Y+40);
self._Canvas.MoveTo(point1.X-10,point1.Y+10);
self._Canvas.lineTo(point1.X-40,point1.Y+40);
self._Canvas.MoveTo(point1.X,point1.Y-15);
self._Canvas.lineTo(point1.X,point1.Y-40);
self._Canvas.Pen.Color:=clblack;
self._canvas.pen.Width:=1;
end;

PROCEDURE space.DrawGrid(gridperiod: Integer);
var
i,z:integer;
begin
i:=0;
z:=0;
 self._canvas.pen.width:=1;
  while i<=self._canvas.ClipRect.Width do
begin
self._canvas.pen.Color:=clSILVER;
self._canvas.MoveTo(i,0);
self._canvas.LineTo(i,self._canvas.ClipRect.Height);
i:=i+gridperiod;
end;
while z<=self._canvas.ClipRect.Width do
begin
self._canvas.pen.Color:=clSILVER;
self._canvas.MoveTo(0,z);
self._canvas.LineTo(self._canvas.ClipRect.Width,z);
z:=z+gridperiod;
    end;

end;

procedure Space.gridtospace(stringgrid1: tstringgrid);
var
i,z:integer;

begin
for z := 0 to self._cntCharges-1 do self.RemoveCharge(z);
fmain.CleanScreen;
myspace.DrawGrid(20);
for  i:=1 to stringgrid1.RowCount-1 do
 begin
 self.addcharge(point(strtoint(stringgrid1.Cells[2,i]),strtoint(stringgrid1.Cells[3,i])),strtofloat(stringgrid1.Cells[1,i]));
  end;
end;

procedure Space.LineFromPoint(pointdraw: tpoint);
  var
  ex,ey,e,emax,emin,eint,x,y,r,cosa,sina,angle:real;
  counter,counter1,counter2,curve,sign:integer; //0-charge,1-line,2-influence
  linecolor:tcolor;
  i: Integer;
begin
  fmain.progressbar1.position:=0;
for i := 1 to 2 do
  begin
  x:=pointdraw.x;
  y:=pointdraw.y;
      while (x<self._canvas.ClipRect.Width)and (y<self._canvas.ClipRect.Height) and (x>0) and (y>0) and (curve<20000) do
      begin
      ex:=0    ;
      ey:=0   ;
      eint:=0;
      for counter2 := 0 to self._cntcharges-1 do   //through oharges influence
         begin
          r:=sqrt(sqr(self._charges[counter2]._pos.x-x)+sqr(self._charges[counter2]._pos.y-y));
          if r<>0 then      cosa:=(x-self._charges[counter2]._pos.x)/r ;
          if r<>0 then         sina:=(y-self._charges[counter2]._pos.y)/r  ;
          if (r<>0)   then
            begin
            if i=1 then    e:=self._charges[counter2]._q/(r*r*r) else  e:=-1*self._charges[counter2]._q/(r*r*r)
            end;
          ex:=ex+(e)*cosa;
          ey:=ey+(e)*sina;
         end;
        eint:=sqrt(sqr(ex)+sqr(ey))  ; //summary
        if eint<>0 then         x:=x+ex/eint;
        if eint<>0 then      y:=y+ey/eint;
        linecolor:=clblack;
        self._canvas.Pixels[round(x),round(y)]:=linecolor;
        curve:=curve+1;
      end;
  end;
end;
procedure Space.MoveCharge(numbercharge: integer);
begin
end;

constructor Space.New(canvas: TCanvas; gridPeriod: integer);
begin
self._canvas:=canvas;
self._cntCharges:=0 ;
end;



procedure Space.opilki;
var
ex,ey,e,emax,emin,eint,x,y,r,cosa,sina,angle:real;
counter,counter1,counter2,curve,sign:integer; //0-charge,1-line,2-influence
linecolor:tcolor;
begin
fmain.progressbar1.position:=0;
fmain.progressbar1.max:=round(self._cntcharges);
fmain.CleanScreen;
begin
for counter := 0 to self._cntcharges-1  do     //cycle which cycles through charges
begin
  for counter1 :=0   to 15 do    //through different angles of start
  begin
    curve:=0;    //crutch  for length
    angle:=(counter1/15)*2*pi;
    x:=self._charges[counter]._pos.X+(10*counter1)*cos(angle);
    y:=self._charges[counter]._pos.y+(10*counter1)*sin(angle);
      while (x<self._canvas.ClipRect.Width)and (y<self._canvas.ClipRect.Height) and (x>0) and (y>0) and (curve<20000) do
      begin
      ex:=0    ;
      ey:=0   ;
      eint:=0;
         for counter2 := 0 to self._cntcharges-1 do   //through oharges influence
         begin
          r:=sqrt(sqr(self._charges[counter2]._pos.x-x)+sqr(self._charges[counter2]._pos.y-y));
          if r<>0 then      cosa:=(x-self._charges[counter2]._pos.x)/r ;
          if r<>0 then      sina:=(y-self._charges[counter2]._pos.y)/r  ;
          if (r<>0)   then
          begin
         if (self._charges[counter]._q>0) then sign:=1 else  sign:=-1 ;
         if (self._charges[counter]._q>0) then e:=self._charges[counter2]._q/sqr(r) else  e:=-1*self._charges[counter2]._q/(r*r*r*r*r) ;
          end;
          ex:=ex+(e)*cosa;
          ey:=ey+(e)*sina;
         end;
         eint:=sqrt(sqr(ex)+sqr(ey)); //summary
         if eint<>0 then         x:=x+4*ey/eint;
         if eint<>0 then      y:=y-4*ex/eint;
         linecolor:=clblack;
         self._canvas.Pixels[round(x),round(y)]:=linecolor;
         curve:=curve+1;
         end;
       end;
       fmain.progressbar1.position:=fmain.progressbar1.position+1;
     end;
        end;
 end;

procedure Space.redraw;
var
i:integer;
begin
for i := 0 to self._cntCharges-1 do
begin
self._canvas.Pen.Width:=3;
self._canvas.Pen.Color:=self._charges[i]._color;
self._canvas.Ellipse(self._charges[i]._pos.X+10,self._charges[i]._pos.y+10,self._charges[i]._pos.X-10,self._charges[i]._pos.y-10);
self._canvas.Pen.Width:=1;
end;
end;

end.
