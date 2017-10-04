unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.GIFImg,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Buttons;

type
  TMathModel = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
        private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MathModel: TMathModel;

implementation

{$R *.dfm}

uses Unit2;

procedure TMathModel.BitBtn1Click(Sender: TObject);
begin
  form2.show;
  mathmodel.Close;
end;

procedure TMathModel.BitBtn1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_escape  then
begin
 mathmodel.Close  ;
 form2.Show;
end;
end;

procedure TMathModel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_escape  then
begin
 mathmodel.Close  ;
 form2.Show;
end;
     end;
end.
