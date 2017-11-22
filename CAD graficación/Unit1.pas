// ===========================================================================
// = Desarrollado por: Erik Leonardo Espinosa Machuca version alpha 0.1      =
// = Disclaimer (Todos Los derechos Reservados 2017-2018 (R) )               =
// = Prohibida su copia, reproducción, ingenieria inversa, distribucion sin  =
// = Autorizacion, decompilación, modificacion del codigo fuente, etc.       =
// =             DISTRIBUCIÓN UNICAMENTE CON FINES EDUCATIVOS                =
// ===========================================================================
unit Unit1;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,Grids, StdCtrls, math, Menus;

type
  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    GuardarImagen1: TMenuItem;
    Salirdelprograma1: TMenuItem;
    Manipulaci1: TMenuItem;
    LimpiarEspaciodeTrabajo1: TMenuItem;
    Forma1: TMenuItem;
    Lineadedospuntos1: TMenuItem;
    Polilinea1: TMenuItem;
    Bezier1: TMenuItem;
    Arco1: TMenuItem;
    Circulo1: TMenuItem;
    riangulo1: TMenuItem;
    Elipse1: TMenuItem;
    Grid1: TStringGrid;
    Grid2: TStringGrid;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    CheckBox3: TCheckBox;
    Color1: TMenuItem;
    Colordecontorno1: TMenuItem;
    Colorderelleno1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LimpiarEspaciodeTrabajo1Click(Sender: TObject);
    procedure Colordecontorno1Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Bezier1Click(Sender: TObject);
    procedure Arco1Click(Sender: TObject);
    procedure Elipse1Click(Sender: TObject);
    procedure Circulo1Click(Sender: TObject);
    procedure riangulo1Click(Sender: TObject);
    procedure Polilinea1Click(Sender: TObject);
    procedure Lineadedospuntos1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  clics,nb,ter,opera,renglon:Integer;
  escala: Real;
  cont1,cont2,cont3:Integer;
  r,g,b,rell1,rell2,rell3:Integer;

implementation

{$R *.dfm}
// paleta de colores
function GetHTMLColor(cl:Tcolor;IsBackColor:Boolean):String;
 var
 rgbColor:TColorRef;

 begin
   if IsBackColor then
   result:='bg'
   else
   result:='';
   rgbcolor:=colortorgb(cl);
   result:=result+ 'Color:="#'+
   format('%.2x%.2x%.2x',
   [GetRValue(rgbcolor),
   GetGValue(rgbcolor),
   GetBValue(rgbcolor)])+'"';
   r:=getRValue(rgbcolor);
   g:=getgvalue(rgbcolor);
   b:=getbvalue(rgbcolor);

    end;

// fin paleta de colores


 // dda
procedure dda (x1,y1,x2,y2,c1,c2,c3:integer;image1:timage);
var
k:integer;
dx,dy:integer;
steps:integer;
x_mas,y_mas:real;
x,y:real;
begin
dx:=x2-x1;
dy:=y2-y1;
if abs(dx)>abs(dy) then
begin
steps:=abs(dx);
end
else
begin
steps:=abs(dy);
end;
x_mas:=dx/steps;
y_mas:=dy/steps;
x:=trunc(x1);
y:=trunc(y1);
for k:=1 to steps do
begin
x:=x+(x_mas);
y:=y+(y_mas);
image1.canvas.pixels[trunc(x),trunc(y)]:=rgb(c1,c2,c3);
end;
end;
// termina dda

// elipse
   procedure elipse(xc,yc,r1,r2,angi,angf,c1,c2,c3:Integer;image1:Timage);
var
i:Integer;
x,y,ang:Real;
begin
 ang:=angi;
 for i := angi*10 to angf*10  do
  begin
   x:=xc+r1*cos(degtorad(ang));
   y:=yc+r2*sin(degtorad(ang));
   image1.Canvas.Pixels[trunc(x),trunc(y)]:=rgb(c1,c2,c3);
   ang:=ang+0.1;
  end;
end;
// elipse termina

//circulo
     procedure circulo(angi,angf,c1,c2,c3:Integer;Grid1:TStringGrid;image1:Timage);
var
i:Integer;
begin
 for i := 1 to grid1.RowCount - 1 do
  begin
   elipse(strtoint(grid1.Cells[0,i-1]),
       strtoint(grid1.Cells[1,i-1]),
       (strtoint(grid1.Cells[0,i])-strtoint(grid1.Cells[0,i-1])),
       (strtoint(grid1.Cells[0,i])-strtoint(grid1.Cells[0,i-1])),
       angi,angf,c1,c2,c3,image1);
  end;
end;
//circulo termina

// elipse2
 procedure elipse2(angi,angf,c1,c2,c3:Integer;Grid1:TStringGrid;image1:Timage);
var
i:Integer;
begin
 for i := 1 to grid1.RowCount - 1 do
  begin
   elipse(strtoint(grid1.Cells[0,i-1]),
       strtoint(grid1.Cells[1,i-1]),
       (strtoint(grid1.Cells[0,i])-strtoint(grid1.Cells[0,i-1])),
       (strtoint(grid1.Cells[0,i])-strtoint(grid1.Cells[0,i-1]))+60,
       angi,angf,c1,c2,c3,image1);
  end;
end;
//elipse2 termina

// polilinea
procedure polilineas(c1,c2,c3:Integer;Grid1:TStringGrid;image1:Timage);
var
i:Integer;
begin
 for i := 1 to grid1.RowCount - 1 do
  begin
   dda(strtoint(grid1.Cells[0,i-1]),
       strtoint(grid1.Cells[1,i-1]),
       strtoint(grid1.Cells[0,i]),
       strtoint(grid1.Cells[1,i]),c1,c2,c3,image1);
  end;
  dda(strtoint(grid1.Cells[0,i-1]),
       strtoint(grid1.Cells[1,i-1]),
       strtoint(grid1.Cells[0,0]),
       strtoint(grid1.Cells[1,0]),c1,c2,c3,image1);
end;
// polilinea termina

//creacion bezier
procedure bezier(c1,c2,c3:Integer;grid1:TStringGrid;image1:timage);
var
ba:array [0..3] of tpoint;
begin
 image1.Canvas.Pen.Width:=4;
 image1.Canvas.Pen.Color:=rgb(c1,c2,c3);
 ba[0].x:=strtoint(grid1.Cells[0,0]);
 ba[0].y:=strtoint(grid1.Cells[1,0]);
 ba[1].x:=strtoint(grid1.Cells[0,1]);
 ba[1].y:=strtoint(grid1.Cells[1,1]);
 ba[2].x:=strtoint(grid1.Cells[0,2]);
 ba[2].y:=strtoint(grid1.Cells[1,2]);
 ba[3].x:=strtoint(grid1.Cells[0,3]);
 ba[3].y:=strtoint(grid1.Cells[1,3]);
image1.Canvas.PolyBezier(ba);
//bezier termina
 end;
procedure TForm1.Arco1Click(Sender: TObject);
begin
 Grid1.RowCount:=2;
 Grid2.RowCount:=2;
 nb:=7;
end;

procedure TForm1.Bezier1Click(Sender: TObject);
begin
Grid1.RowCount:=4;
 Grid2.RowCount:=4;
 nb:=9;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked=true then
begin
opera:=1;
end;
if checkbox1.Checked=false then
begin
  opera:=0;
end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
    if checkbox1.Checked=true then
begin
opera:=1;
end;
if checkbox1.Checked=false then
begin
  opera:=0;
end;

end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
if checkbox3.Checked=true then
begin
opera:=4;
end;
if checkbox3.Checked=false then
opera:=0;
end;

procedure TForm1.Circulo1Click(Sender: TObject);
begin
Grid1.RowCount:=2;
 Grid2.RowCount:=2;
 nb:=4
end;

procedure TForm1.Colordecontorno1Click(Sender: TObject);
begin
  with TColorDialog.Create(self) do
  try
    if Execute then
    begin
      gethtmlcolor(color,true);


    end;
  finally
    Free;
  end;
end;

procedure TForm1.Elipse1Click(Sender: TObject);
begin
Grid1.RowCount:=2;
 Grid2.RowCount:=2;
 nb:=8;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
clics:=0;
nb:=0;
ter:=0;
opera:=0;
r:=0;
g:=0;
b:=0;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var
dx,dy,i,ang,tx,ty:Integer;
xo,yo,xn,yn,dx1,dy1,escala:Real;
begin

    case opera of
  0: //Dibujar formas
   begin
    Grid1.Cells[0,clics]:=inttostr(x);
    Grid1.Cells[1,clics]:=inttostr(y);
    clics:=clics+1;
    if ((clics=3) and (nb=1)) then
     begin
      polilineas(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=4) and (nb=2)) then
     begin
      polilineas(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=4) and (nb=3)) then
     begin
      polilineas(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=2) and (nb=4)) then
     begin
      circulo(0,360,cont1,cont2,cont3,grid1,image1);
      clics:=0;
    end;
    if ((clics=5) and (nb=5)) then
     begin
      polilineas(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=2) and (nb=6)) then
     begin
      polilineas(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=2) and (nb=7)) then
     begin
      circulo(180,360,cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=2) and (nb=8)) then
     begin
      elipse2(0,360,cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=4) and (nb=9)) then
     begin
      bezier(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=6) and (nb=10)) then
     begin
      polilineas(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
    if ((clics=ter) and (nb=11)) then
     begin
      polilineas(cont1,cont2,cont3,grid1,image1);
      clics:=0;
     end;
   end;
   // dibujar formas fin
     1: //Dejar de mover
   begin
    opera:=0;
   end;
    2: //cortar
   begin
    for i := 0 to grid1.RowCount - 1 do
     begin
      dx:=x-strtoint(grid1.Cells[0,i]);
      dy:=y-strtoint(grid1.Cells[1,i]);
      if ((abs(dx)<5) and (abs(dy)<5)) then
       begin
        opera:=3;
        renglon:=i;
       end;
     end;
   end;
    3: // dejar de cortar
   begin
    opera:=0;
   end;
    4:// rotar
   begin
    //rota polilineas
    if ((nb=1)or(nb=2)or(nb=3)or(nb=5)or(nb=6)or(nb=10)or(nb=11)) then
     begin
      ang:=strtoint(edit2.Text);
      polilineas(255,255,255,grid1,image1);
      for i := 0 to grid1.RowCount - 1 do
       begin
        xo:=strtofloat(grid1.Cells[0,i]);
        yo:=strtofloat(grid1.Cells[1,i]);
        xn:=x+(xo-x)*cos(degtorad(ang))-(yo-y)*sin(degtorad(ang));
        yn:=y+(yo-y)*cos(degtorad(ang))+(xo-x)*sin(degtorad(ang));
        grid1.Cells[0,i]:=inttostr(trunc(xn));
        grid1.Cells[1,i]:=inttostr(trunc(yn));
       end;
      polilineas(cont1,cont2,cont3,grid1,image1);
     end;
    //rota circulo
    if nb=4 then
     begin
      ang:=strtoint(edit2.Text);
      circulo(0,360,255,255,255,grid1,image1);
      for i := 0 to grid1.RowCount - 1 do
       begin
        xo:=strtofloat(grid1.Cells[0,i]);
        yo:=strtofloat(grid1.Cells[1,i]);
        xn:=x+(xo-x)*cos(degtorad(ang))-(yo-y)*sin(degtorad(ang));
        yn:=y+(yo-y)*cos(degtorad(ang))+(xo-x)*sin(degtorad(ang));
        grid1.Cells[0,i]:=inttostr(trunc(xn));
        grid1.Cells[1,i]:=inttostr(trunc(yn));
       end;
      circulo(0,360,cont1,cont2,cont3,grid1,image1);
     end;
    //rota arco
    if nb=7 then
     begin
      ang:=strtoint(edit2.Text);
      circulo(180,360,255,255,255,grid1,image1);
      for i := 0 to grid1.RowCount - 1 do
       begin
        xo:=strtofloat(grid1.Cells[0,i]);
        yo:=strtofloat(grid1.Cells[1,i]);
        xn:=x+(xo-x)*cos(degtorad(ang))-(yo-y)*sin(degtorad(ang));
        yn:=y+(yo-y)*cos(degtorad(ang))+(xo-x)*sin(degtorad(ang));
        grid1.Cells[0,i]:=inttostr(trunc(xn));
        grid1.Cells[1,i]:=inttostr(trunc(yn));
       end;
      circulo(180,360,cont1,cont2,cont3,grid1,image1);
     end;
    //rota elipse
    if nb=8 then
     begin
      ang:=strtoint(edit2.Text);
      elipse2(0,360,255,255,255,grid1,image1);
      for i := 0 to grid1.RowCount - 1 do
       begin
        xo:=strtofloat(grid1.Cells[0,i]);
        yo:=strtofloat(grid1.Cells[1,i]);
        xn:=x+(xo-x)*cos(degtorad(ang))-(yo-y)*sin(degtorad(ang));
        yn:=y+(yo-y)*cos(degtorad(ang))+(xo-x)*sin(degtorad(ang));
        grid1.Cells[0,i]:=inttostr(trunc(xn));
        grid1.Cells[1,i]:=inttostr(trunc(yn));
       end;
      elipse2(0,360,cont1,cont2,cont3,grid1,image1);
     end;
    //rota curva bezier
    if nb=9 then
     begin
      ang:=strtoint(edit2.Text);
      bezier(255,255,255,grid1,image1);
      for i := 0 to grid1.RowCount - 1 do
       begin
        xo:=strtofloat(grid1.Cells[0,i]);
        yo:=strtofloat(grid1.Cells[1,i]);
        xn:=x+(xo-x)*cos(degtorad(ang))-(yo-y)*sin(degtorad(ang));
        yn:=y+(yo-y)*cos(degtorad(ang))+(xo-x)*sin(degtorad(ang));
        grid1.Cells[0,i]:=inttostr(trunc(xn));
        grid1.Cells[1,i]:=inttostr(trunc(yn));
       end;
      bezier(cont1,cont2,cont3,grid1,image1);
     end;
   end;
    5:   //reflexion en x
  begin
   //reflexion en x polilineas
   if ((nb=1)or(nb=2)or(nb=3)or(nb=5)or(nb=6)or(nb=10)or(nb=11)) then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dx:=x-strtoint(grid1.Cells[0,i]);
       grid1.Cells[0,i]:=inttostr(x+dx);
      end;
     polilineas(cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en x circulo
   if nb=4 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dx:=x-strtoint(grid1.Cells[0,i]);
       grid1.Cells[0,i]:=inttostr(x+dx);
      end;
     circulo(0,360,cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en x arco
   if nb=7 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dx:=x-strtoint(grid1.Cells[0,i]);
       grid1.Cells[0,i]:=inttostr(x+dx);
      end;
     circulo(180,360,cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en x elipse
   if nb=8 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dx:=x-strtoint(grid1.Cells[0,i]);
       grid1.Cells[0,i]:=inttostr(x+dx);
      end;
     elipse2(0,360,cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en x curva bezier
   if nb=9 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dx:=x-strtoint(grid1.Cells[0,i]);
       grid1.Cells[0,i]:=inttostr(x+dx);
      end;
     bezier(cont1,cont2,cont3,grid1,image1);
    end;
  end;
  6: // reflexion en y
  begin
   //reflexion en y polilineas
   if ((nb=1)or(nb=2)or(nb=3)or(nb=5)or(nb=6)or(nb=10)or(nb=11)) then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dy:=y-strtoint(grid1.Cells[1,i]);
       grid1.Cells[1,i]:=inttostr(y+dy);
      end;
     polilineas(cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en y circulo
   if nb=4 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dy:=y-strtoint(grid1.Cells[1,i]);
       grid1.Cells[1,i]:=inttostr(y+dy);
      end;
     circulo(0,360,cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en y arco
   if nb=7 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dy:=y-strtoint(grid1.Cells[1,i]);
       grid1.Cells[1,i]:=inttostr(y+dy);
      end;
     circulo(180,360,cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en y elipse
   if nb=8 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dy:=y-strtoint(grid1.Cells[1,i]);
       grid1.Cells[1,i]:=inttostr(y+dy);
      end;
     elipse2(0,360,cont1,cont2,cont3,grid1,image1);
    end;
   //reflexion en y curva bezier
   if nb=9 then
    begin
     for i := 0 to grid1.RowCount - 1 do
      begin
       dy:=y-strtoint(grid1.Cells[1,i]);
       grid1.Cells[1,i]:=inttostr(y+dy);
      end;
     bezier(cont1,cont2,cont3,grid1,image1);
    end;
  end;
  7: // 3d paralelo
  begin
   //3d polilineas
   if ((nb=1)or(nb=2)or(nb=3)or(nb=5)or(nb=6)or(nb=10)or(nb=11)) then
    begin
     tx:=x-strtoint(grid1.Cells[0,0]);
     ty:=y-strtoint(grid1.Cells[1,0]);
     for i := 0 to grid1.RowCount - 1 do
      begin
       grid2.Cells[0,i]:=inttostr(strtoint(grid1.Cells[0,i])+tx);
       grid2.Cells[1,i]:=inttostr(strtoint(grid1.Cells[1,i])+ty);
      end;
     polilineas(cont1,cont2,cont3,grid2,image1);
     for i := 0 to grid1.RowCount - 1 do
      begin
      dda(strtoint(grid1.Cells[0,i]),
          strtoint(grid1.Cells[1,i]),
          strtoint(grid2.Cells[0,i]),
          strtoint(grid2.Cells[1,i]),cont1,cont2,cont3,image1);
      end;
    end;
   //3d circulo
   if nb=4 then
    begin
     tx:=x-strtoint(grid1.Cells[0,0]);
     ty:=y-strtoint(grid1.Cells[1,0]);
     for i := 0 to grid1.RowCount - 1 do
      begin
       grid2.Cells[0,i]:=inttostr(strtoint(grid1.Cells[0,i])+tx);
       grid2.Cells[1,i]:=inttostr(strtoint(grid1.Cells[1,i])+ty);
      end;
     circulo(0,360,cont1,cont2,cont3,grid2,image1);
     for i := 0 to grid1.RowCount - 1 do
      begin
      dda(strtoint(grid1.Cells[0,i]),
          strtoint(grid1.Cells[1,i]),
          strtoint(grid2.Cells[0,i]),
          strtoint(grid2.Cells[1,i]),cont1,cont2,cont3,image1);
      end;
    end;
   //3d arco
   if nb=7 then
    begin
     tx:=x-strtoint(grid1.Cells[0,0]);
     ty:=y-strtoint(grid1.Cells[1,0]);
     for i := 0 to grid1.RowCount - 1 do
      begin
       grid2.Cells[0,i]:=inttostr(strtoint(grid1.Cells[0,i])+tx);
       grid2.Cells[1,i]:=inttostr(strtoint(grid1.Cells[1,i])+ty);
      end;
     circulo(180,360,cont1,cont2,cont3,grid2,image1);
     for i := 0 to grid1.RowCount - 1 do
      begin
      dda(strtoint(grid1.Cells[0,i]),
          strtoint(grid1.Cells[1,i]),
          strtoint(grid2.Cells[0,i]),
          strtoint(grid2.Cells[1,i]),cont1,cont2,cont3,image1);
      end;
    end;
   //3d elipse
   if nb=8 then
    begin
     tx:=x-strtoint(grid1.Cells[0,0]);
     ty:=y-strtoint(grid1.Cells[1,0]);
     for i := 0 to grid1.RowCount - 1 do
      begin
       grid2.Cells[0,i]:=inttostr(strtoint(grid1.Cells[0,i])+tx);
       grid2.Cells[1,i]:=inttostr(strtoint(grid1.Cells[1,i])+ty);
      end;
     elipse2(0,360,cont1,cont2,cont3,grid2,image1);
     for i := 0 to grid1.RowCount - 1 do
      begin
      dda(strtoint(grid1.Cells[0,i]),
          strtoint(grid1.Cells[1,i]),
          strtoint(grid2.Cells[0,i]),
          strtoint(grid2.Cells[1,i]),cont1,cont2,cont3,image1);
      end;
    end;
   //3d curva bezier
   if nb=9 then
    begin
     tx:=x-strtoint(grid1.Cells[0,0]);
     ty:=y-strtoint(grid1.Cells[1,0]);
     for i := 0 to grid1.RowCount - 1 do
      begin
       grid2.Cells[0,i]:=inttostr(strtoint(grid1.Cells[0,i])+tx);
       grid2.Cells[1,i]:=inttostr(strtoint(grid1.Cells[1,i])+ty);
      end;
     bezier(cont1,cont2,cont3,grid2,image1);
     for i := 0 to grid1.RowCount - 1 do
      begin
      dda(strtoint(grid1.Cells[0,i]),
          strtoint(grid1.Cells[1,i]),
          strtoint(grid2.Cells[0,i]),
          strtoint(grid2.Cells[1,i]),cont1,cont2,cont3,image1);
      end;
    end;
  end;
  9:// rellenar
  begin

   image1.Canvas.FloodFill(x,y,rgb(cont1,cont2,cont3),FsBorder);
   image1.Canvas.Brush.Color:=rgb(rell1,rell2,rell3);
  end;
end;
end;

procedure TForm1.LimpiarEspaciodeTrabajo1Click(Sender: TObject);
begin
clics:=0;
Grid1.rows [0].Clear;
grid1.rows[1].Clear;
image1.Picture := nil;
opera:=0;
end;

procedure TForm1.Lineadedospuntos1Click(Sender: TObject);
begin
 Grid1.RowCount:=2;
 Grid2.RowCount:=2;
 nb:=6;
end;

procedure TForm1.Polilinea1Click(Sender: TObject);
begin
ter:=strtoint(inputbox('Clicks','Numero de puntos:','2'));
 Grid1.RowCount:=ter;
 Grid2.RowCount:=ter;
 nb:=11;
end;

procedure TForm1.riangulo1Click(Sender: TObject);
begin
Grid1.RowCount:=3;
Grid2.RowCount:=3;
nb:=1;
end;

end.

