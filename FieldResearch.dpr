program FieldResearch;

uses
  Forms,
  zastavka in 'zastavka.pas' {Form6},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  main in '10G\!_Classes\Class_Charge_2\main.pas' {fMain},
  Unit5 in 'Unit5.pas' {fExitsure},
  Unit7 in 'Unit7.pas' {Demo},
  Unit8 in 'Unit8.pas' {Form8},
  Unit9 in 'Unit9.pas' {MathModel},
  Unit10 in 'E:\Delphi Field Research\Unit10.pas' {fInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfExitsure, fExitsure);
  Application.CreateForm(TDemo, Demo);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TMathModel, MathModel);
  Application.CreateForm(TfInfo, fInfo);
  Application.Run;
end.
