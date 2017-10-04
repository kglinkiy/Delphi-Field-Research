unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfExitsure = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure BitBtn2Enter(Sender: TObject);
    procedure BitBtn2Exit(Sender: TObject);
    procedure BitBtn1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fExitsure: TfExitsure;

implementation

{$R *.dfm}

uses Unit2;

procedure TfExitsure.BitBtn1Click(Sender: TObject);
begin
application.terminate;
end;

procedure TfExitsure.BitBtn1Enter(Sender: TObject);
begin
bitbtn1.font.Color:=clred
end;

procedure TfExitsure.BitBtn1Exit(Sender: TObject);
begin
bitbtn1.Font.Color:=clblack;
end;

procedure TfExitsure.BitBtn2Click(Sender: TObject);
begin

fexitsure.closemodal ;
form2.show;
end;

procedure TfExitsure.BitBtn2Enter(Sender: TObject);
begin
bitbtn2.font.Color:=clred
end;

procedure TfExitsure.BitBtn2Exit(Sender: TObject);
begin
bitbtn2.Font.Color:=clblack;
end;

end.
