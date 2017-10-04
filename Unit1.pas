unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  charge=class
  private
    _q:Real      ;
    _pos:TPoint;
    //1-point,2-sphere,3-cylinder,4-plane
    _OBJTYPE:                Integer  ;
    _r:Integer       ;
    _height:integer ;
    _width:Integer ;
                      _checked:BOOLean;
                      _color:TColor;
    public
           //  constructor new(q:Real;pos:TPoint;r:Integer);overload ;
         // constructor new(q:Real;pos:TPoint;r:Integer;height:Integer);overload;
                  constructor new(q:Real;pos:TPoint;r:Integer;height:Integer;width:Integer);
         //   constructor new(q:Real;pos:TPoint;r:Integer;height:integer);overload;
                    end;
                    space=class
                    private
                      charges:array of charge;
                      _cntcharger:Integer;
                      _gridp:Integer ;
                                          _canvas:TCanvas;
                      public

                                                            constructor new(canvas:TCanvas;gridp:Integer);
                        {
                           procedure    AddCharge()   ;
                           procedure    removeCharge()   ;
                           procedure    draw()   ;
                           procedure    movecharge()   ;
                           procedure    drawgrid()   ;
                                                       }
                             end;

  TForm1 = class(TForm)
    pb1: TPaintBox;
    edtq: TLabeledEdit;
    btnaccpt: TButton;
    edtr: TLabeledEdit;
    edth: TLabeledEdit;
    edtw: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
        c1:charge;
implementation

{$R *.dfm}

          constructor            charge.new(q:Real;pos:TPoint;r:Integer;height:Integer;width:Integer);
          begin


self._q:=q           ;
  self._pos:=Pos    ;
  if (q<0)  then
  Self._color:=clBlue
  else Self._color:=clred;
       if (not(r>=0)and (height>=0) and (width>=0)) then
       begin
         if ((width>=0) and (r<0)) then
         begin
           Self._objtype:=4
           end
               else

            if (height>=0) then
                            Self._OBJTYPE:=3
                            else
                            Self._OBJTYPE :=2

         end
         else Self._objtype:=0;
         Self._checked:=False;
       end;
end.
end;

end.