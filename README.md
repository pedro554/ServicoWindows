# ServicoWindows

Exemplo de uso da unit `ServicoWindows.pas` em uma aplicação Delphi VCL.

O projeto de demonstração usa a unit `Unit1.pas` para controlar e consultar o serviço do Firebird chamado `FirebirdServerDefaultInstance`.

## Adicionando ao projeto

Inclua `ServicoWindows.pas` no projeto e adicione `ServicoWindows` à cláusula `uses`:

```delphi
uses
  ServicoWindows;
```

Os métodos são declarados como `class function`, portanto não é necessário criar uma instância da classe.

## Parar o serviço

```delphi
if TServicoWindows.Parar('FirebirdServerDefaultInstance') then
  ShowMessage('Serviço parado.');
```

## Iniciar o serviço

```delphi
if TServicoWindows.Iniciar('FirebirdServerDefaultInstance') then
  ShowMessage('Serviço iniciado.');
```

## Reiniciar o serviço

```delphi
if TServicoWindows.Reiniciar('FirebirdServerDefaultInstance') then
  ShowMessage('Serviço reiniciado.');
```

## Verificar se está ativo

```delphi
if TServicoWindows.IsAtivo('FirebirdServerDefaultInstance') then
  ShowMessage('Ativo')
else
  ShowMessage('Inativo');
```

## Verificar se existe

```delphi
if TServicoWindows.Existe('FirebirdServerDefaultInstance') then
  ShowMessage('O serviço existe')
else
  ShowMessage('O serviço não existe');
```

## Consultar o status

```delphi
ShowMessage(
  TServicoWindows.StatusToString(
    TServicoWindows.Status('FirebirdServerDefaultInstance')
  )
);
```

## Observações

- Substitua `FirebirdServerDefaultInstance` pelo nome interno do serviço desejado.
- O nome interno pode ser diferente do nome exibido no Gerenciador de Serviços.
- Consultas como `Existe`, `Status` e `IsAtivo` normalmente funcionam com usuário comum.
- Iniciar, parar ou reiniciar o serviço pode exigir permissões administrativas, conforme as permissões configuradas no Windows.
- Os métodos retornam `Boolean`; quando retornarem `False`, a operação não foi concluída.

## Projeto de demonstração

Os botões de `Unit1.pas` correspondem às operações abaixo:

| Botão | Operação |
| --- | --- |
| Button1 | Parar |
| Button2 | Iniciar |
| Button3 | Reiniciar |
| Button4 | Verificar se está ativo |
| Button5 | Verificar se existe |
| Button6 | Exibir o status formatado |
