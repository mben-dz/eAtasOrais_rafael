unit eAtasOrais.Controller.Alunos;

interface

uses
  eAtasOrais.Controller.interfaces, eAtasOrais.Model.Interfaces, FMX.ListBox;

Type
  TControllerAlunos = Class(TInterfacedObject, iControllerAlunos)
    Private
     FConexaoSop : imodelConexaoSOP;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iControllerAlunos;
     Function Listar (periodo, Cod_cur, num_niv, num_tur: string;Lista : TListBox) : iControllerAlunos;
  End;

implementation

uses
  FireDAC.Comp.Client, eAtasOrais.Model.Factory;

{ TControllerAlunos }

constructor TControllerAlunos.Create;
begin
   FConexaoSOP := tModelFactory.New.Conexao;
end;

destructor TControllerAlunos.Destroy;
begin

  inherited;
end;

function TControllerAlunos.Listar(periodo, Cod_cur, num_niv, num_tur: string;
  Lista: TListBox): iControllerAlunos;
var
    Item        : TListBoxItem;
    FDados      :  TFDMemTable;
begin
    Result := self;
    lista.Items.Clear;
    FDados := FConexaoSOP.Alunos(Periodo, Cod_cur, Num_niv, Num_tur);
    FDados.First;
    while not Fdados.eof do
     begin
       Item := TListBoxItem.Create(lista);
       item.Text := FDados.FieldByName('Nom_alu').AsString;
       Item.ItemData.Detail := FDados.FieldByName('Cod_Coe').AsString;
       lista.AddObject(item);
       FDados.Next;
     end;
    FDados.DisposeOf;
end;

class function TControllerAlunos.New: iControllerAlunos;
begin
    Result := Self.Create;
end;

end.
