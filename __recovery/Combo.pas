unit Combo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.StdCtrls, UAppLookupComboBox;

type
  TForm2 = class(TForm)
    FDConnection1: TFDConnection;
    cbbid: TAppLookupComboBox;
    DataSource1: TDataSource;
    Consulta: TFDQuery;
    FDQuery2: TFDQuery;
    Consultaid: TFDAutoIncField;
    Consultanome_completo: TWideStringField;
    Consultausuario: TWideStringField;
    Consultasenha: TWideStringField;
    Consultaativo: TBooleanField;
    Consultaadministrador: TBooleanField;
    Consultacriado_em: TDateTimeField;
    Consultaatualizado_em: TDateTimeField;
    DataSource2: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure conexao;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

{ TForm2 }

procedure TForm2.conexao;
begin
  FDConnection1.Close;
  FDConnection1.LoginPrompt := False;
  FDConnection1.Connected := True;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  conexao;
  Consulta.Open;
  FDQuery2.Open;
  FDQuery2.Append;
end;

end.
