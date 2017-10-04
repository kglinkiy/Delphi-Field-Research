unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    V: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button1Enter(Sender: TObject);
    procedure Button2Enter(Sender: TObject);
    procedure Button3Enter(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure BitBtn2Enter(Sender: TObject);
    procedure BitBtn3Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit3, Unit4, zastavka, main, Unit7, Unit5;

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
form6.show;
end;

procedure TForm2.BitBtn1Enter(Sender: TObject);
begin
image1.Top:=bitbtn1.Top ;
image1.Left:=bitbtn1.Left-150;
image1.Visible:=true;
end;

procedure TForm2.BitBtn2Enter(Sender: TObject);
begin
image1.Top:=bitbtn2.Top ;
image1.Left:=bitbtn2.Left-150;
image1.Visible:=true;
end;

procedure TForm2.BitBtn3Enter(Sender: TObject);
begin
image1.Top:=bitbtn3.Top ;
image1.Left:=bitbtn3.Left-150;
image1.Visible:=true;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
form3.show;
form2.close;
end;

procedure TForm2.Button1Enter(Sender: TObject);
begin
image1.Top:=button1.Top ;
image1.Left:=button1.Left-150;
image1.Visible:=true;
end;

procedure TForm2.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_escape then application.Terminate;
if key=VK_F1 then   button1.Click          ;
 if key=VK_F2 then   button2.Click        ;
 if key=VK_F3 then   button3.Click       ;
 if key=VK_F4 then   bitbtn1.Click      ;
 if key=VK_F5 then   bitbtn2.Click     ;
 if key=vk_f6  then bitbtn3.Click        ;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
demo.show;
end;

procedure TForm2.Button2Enter(Sender: TObject);
begin
image1.Top:=button2.Top ;
image1.Left:=button2.Left-150;
image1.Visible:=true;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
fmain.show;
form2.Close;
end;

procedure TForm2.Button3Enter(Sender: TObject);
begin
image1.Top:=button3.Top ;
image1.Left:=button3.Left-150;
image1.Visible:=true;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
FORM4.SHOW;

end;

procedure TForm2.Button5Click(Sender: TObject);
begin
fexitsure.show;
form2.close;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_escape then application.Terminate;
if key=VK_F1 then   button1.Click          ;
 if key=VK_F2 then   button2.Click        ;
 if key=VK_F3 then   button3.Click       ;
 if key=VK_F4 then   bitbtn1.Click     ;
 if key=VK_F5 then   bitbtn2.Click  ;
 if key=vk_f6  then   bitbtn3.Click;

end;

end.

