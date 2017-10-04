unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfInfo = class(TForm)
    returnbtn: TBitBtn;
    procedure returnbtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fInfo: TfInfo;

implementation

{$R *.dfm}

procedure TfInfo.returnbtnClick(Sender: TObject);
begin
finfo.Close;
end;

end.
