# TAppLookupComboBox para Delphi

Componente visual customizado para Delphi que estende o `TCustomComboBox` para oferecer funcionalidades avançadas de Lookup e Busca por Aproximação em datasets.

## Principais Funcionalidades

- **Data-Binding Completo (DB-Aware)**: Integração total com datasets através das propriedades `DataSource` e `DataField` para armazenamento da seleção.
- **Lookup Profissional**: Suporte a `ListSource`, `ListField` e `KeyField`, permitindo exibir um nome amigável enquanto armazena um ID técnico.
- **Busca por Aproximação**: Filtra os itens da lista em tempo real conforme o usuário digita, utilizando busca por sub-string (`LIKE %texto%`).
- **Lista Inteligente**: 
    - Ao abrir o dropdown pela seta, exibe a lista completa de registros.
    - Ao digitar, exibe apenas os resultados filtrados.
    - Após a seleção, limpa o filtro para que a lista completa esteja disponível na próxima interação, mantendo o item selecionado.
- **Integração com a IDE**: Propriedades nomeadas conforme padrões VCL para reconhecimento imediato no Object Inspector do Delphi.
- **Atalhos Úteis**: Tecla `ESC` limpa a pesquisa e restaura a lista completa instantaneamente.

## Como Instalar

1. Abra o arquivo `IdealBuscaCombo.dpk` no seu Delphi.
2. Clique com o botão direito no projeto e selecione **Install**.
3. O componente estará disponível na paleta de componentes `IdalBuscaCombo`.
