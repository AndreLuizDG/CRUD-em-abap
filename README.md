# CRUD em ABAP (Create, Read, Update, Delete)

**Objetivo:** Este repositório contém um código-fonte em ABAP que implementa operações básicas de CRUD (Create, Read, Update, Delete) para o gerenciamento de informações sobre funcionários. O código utiliza a tabela `ztb_crud_algj` para armazenar dados e oferece uma interface de usuário por meio de uma tela de seleção.

## Instruções de Uso

1. Faça o download do código-fonte (`z_algj_39.abap`).
2. Importe o código para o ambiente SAP usando a transação `SE80` ou `SE38`.
3. Execute o programa utilizando a transação `SE38`.
4. Na tela de seleção, preencha os campos conforme necessário para realizar as operações CRUD.

## Funcionalidades

1. **Criar (CREATE):**
   - Selecione o radiobutton "Criar" e preencha os campos.
   - Clique em "Executar" para criar um novo registro de funcionário.

2. **Listar (READ):**
   - Selecione o radiobutton "Listar" e clique em "Executar" para visualizar todos os funcionários cadastrados.

3. **Atualizar (UPDATE):**
   - Selecione o radiobutton "Atualizar" e preencha o campo "Código do Funcionário" e os demais campos a serem atualizados.
   - Clique em "Executar" para salvar as alterações.

4. **Deletar (DELETE):**
   - Selecione o radiobutton "Deletar" e informe o "Código do Funcionário" a ser excluído.
   - Clique em "Executar" para remover o funcionário.

## Observações

- Certifique-se de ter acesso a um sistema SAP para executar e testar o código.
- As mensagens exibidas indicarão o sucesso ou falha das operações.
- O código inclui comentários explicativos para facilitar o entendimento.
- Este é um exemplo educacional e pode ser adaptado conforme necessário.

---

**Nota Importante:** Este código foi desenvolvido com o intuito de aprendizado e pode ser expandido conforme necessário. Sugestões e contribuições são bem-vindas para melhorar o entendimento e a aplicação dos conceitos apresentados.