# Guia de Instalação: IdealBuscaCombo

Este guia explica como instalar e utilizar o componente `TAppLookupComboBox`, um `LookupComboBox` editável com busca por aproximação dinâmica.

## 🚀 Como Instalar no Delphi

Siga estes passos para que o componente apareça na sua **Tool Palette**:

1.  **Abra o Pacote**:
    - No Delphi, abra o arquivo [IdealBuscaCombo.dproj](file:///d:/Combo%20Lookup%20Delphi/IdealBuscaCombo.dproj).

2.  **Verifique a Unit**:
    - No `Project Manager`, certifique-se de que o arquivo [UAppLookupComboBox.pas](file:///d:/Combo%20Lookup%20Delphi/UAppLookupComboBox.pas) está dentro da pasta `Contains`.

3.  **Compile e Instale**:
    - Clique com o botão direito no projeto `IdealBuscaCombo.bpl` no `Project Manager`.
    - Clique em **Compile**.
    - Clique com o botão direito novamente e selecione **Install**.
    - Uma mensagem aparecerá confirmando que o componente `TAppLookupComboBox` foi registrado.

4.  **Localize na Tool Palette**:
    - Abra um Form qualquer.
    - Na **Tool Palette**, procure pela aba **IdealBuscaCombo**.
    - Arraste o componente para o seu formulário.

---

## 🛠️ Funcionalidades

- **Busca por Aproximação (Like)**: Digite qualquer parte do texto e o combo filtrará automaticamente o `DataSet`.
- **Área de Edição Real**: Diferente do combo comum, este permite ver o cursor e o texto enquanto você digita.
- **Auto DropDown**: A lista de resultados se abre automaticamente conforme a digitação.
- **Tecla ESC**: Limpa o texto digitado, remove os filtros do `DataSet` e reseta a seleção.

---

## 📝 Como Configurar no Designer

1.  **ListSource**: Conecte ao seu `TDataSource` que contém os dados da lista.
2.  **ListField**: Nome do campo que será exibido (ex: `'NOME'`).
3.  **KeyField**: Nome do campo chave (ex: `'ID'`).

> [!IMPORTANT]
> O `DataSet` conectado ao `ListSource` deve estar **Ativo** para que a busca funcione.

---

## 🔧 Requisitos de Sistema
- Delphi 10.2 / 10.4 ou superior.
- VCL Framework.
