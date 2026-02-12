# TAppLookupComboBox para Delphi

O `TAppLookupComboBox` é um componente visual avançado que estende o `TCustomComboBox` para oferecer funcionalidades de **Lookup** e **Busca por Aproximação** com suporte total a **Data-Binding**.

---

## 🚀 Como Instalar no Delphi

Siga estes passos para registrar o componente na sua **Tool Palette**:

1.  **Abra o Pacote**: Abra o arquivo [IdealBuscaCombo.dproj](file:///d:/Combo%20Lookup%20Delphi/IdealBuscaCombo.dproj).
2.  **Verifique a Unit**: No `Project Manager`, certifique-se de que [UAppLookupComboBox.pas](file:///d:/Combo%20Lookup%20Delphi/UAppLookupComboBox.pas) está na pasta `Contains`.
3.  **Compile e Instale**:
    - Clique com o botão direito no projeto no `Project Manager` e selecione **Compile**.
    - Clique novamente com o botão direito e selecione **Install**.
4.  **Localize na Paleta**: O componente aparecerá na aba **IdalBuscaCombo**.

---

## 🛠️ Funcionalidades Principais

- **Data-Binding Completo (DB-Aware)**: Vincula a seleção a um campo de outro dataset via `DataSource` e `DataField`.
- **Lookup Profissional**: Exibe um campo amigável (`ListField`) enquanto armazena um valor de chave (`KeyField`).
- **Busca por Aproximação (Smart Filter)**:
    - Filtra dinamicamente conforme você digita (`LIKE %texto%`).
    - Abre o dropdown automaticamente apenas durante a digitação.
    - Se você abrir a lista pelo clique, ela exibe todos os registros originalmente.
- **Seleção Persistente**: Ao selecionar um item, o filtro é limpo para que a lista completa esteja disponível em um próximo clique.
- **Tecla ESC**: Limpa a pesquisa e restaura a lista completa instantaneamente.

---

## 📝 Como Configurar no Designer

1.  **Fonte da Lista (Lookup)**:
    - `ListSource`: Dataset que fornece as opções.
    - `ListField`: Campo para exibição de texto.
    - `KeyField`: Campo que contém o valor de chave (ID).
2.  **Destino do Dado (Seleção)**:
    - `DataSource`: Dataset onde o valor selecionado será salvo.
    - `DataField`: Campo no DataSource que receberá o valor do `KeyField`.

> [!IMPORTANT]
> O `DataSet` em `ListSource` deve estar **Ativo** para que a filtragem e a seleção funcionem corretamente.

---

## 🔧 Requisitos
- Delphi 10.2 / 10.4 ou superior.
- VCL Framework.

---

## 📞 Suporte
Desenvolvido para atender requisitos de busca dinâmica e lookup simplificado em sistemas legados e modernos.
