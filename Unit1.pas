unit Unit1;

interface

uses
  ServicoWindows,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  LServico: TServicoWindows;
begin
  LServico := nil;
  try
    LServico := TServicoWindows.Create;
    LServico.Parar('FirebirdServerDefaultInstance');
  finally
    LServico.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LServico: TServicoWindows;
begin
  LServico := nil;
  try
    LServico := TServicoWindows.Create;
    LServico.Iniciar('FirebirdServerDefaultInstance');
  finally
    LServico.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  LServico: TServicoWindows;
begin
  LServico := nil;
  try
    LServico := TServicoWindows.Create;
    LServico.Reiniciar('FirebirdServerDefaultInstance');
  finally
    LServico.Free;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  LServico: TServicoWindows;
begin
  LServico := nil;
  try
    LServico := TServicoWindows.Create;
    if LServico.IsAtivo('FirebirdServerDefaultInstance') then
      ShowMessage('Ativo')
    else
      ShowMessage('Inativo');
  finally
    LServico.Free;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  LServico: TServicoWindows;
begin
  LServico := nil;
  try
    LServico := TServicoWindows.Create;
    if LServico.Existe('FirebirdServerDefaultInstance') then
      ShowMessage('Existe')
    else
      ShowMessage('Não existe');
  finally
    LServico.Free;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  LServico: TServicoWindows;
begin
  LServico := nil;
  try
    LServico := TServicoWindows.Create;
    ShowMessage(
      LServico.StatusToString(
        LServico.Status('FirebirdServerDefaultInstance')
      )
    );
  finally
    LServico.Free;
  end;
end;

end.
