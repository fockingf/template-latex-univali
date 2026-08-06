# Template de Trabalho Acadêmico — UNIVALI

Template LaTeX reutilizável para **TCC, monografias, dissertações de mestrado e
teses de doutorado**, em conformidade com as normas ABNT adotadas pela UNIVALI:

- **NBR 14724:2024** — apresentação de trabalhos acadêmicos
- **NBR 6023:2025** — referências
- **NBR 10520:2023** — citações

Baseado em [abnTeX2](https://www.abntex.net.br/). O texto vem preenchido com
*lorem ipsum* e placeholders — substitua pelo seu conteúdo.

> Guia institucional de referência: **UNIVALI — Livro digital para elaboração de
> trabalhos acadêmicos** (guia da Biblioteca/PPG), disponível em
> <https://portal.univali.br/biblioteca/normas-e-procedimentos#orientacoes>.

## Como começar

1. **Escolha o tipo de trabalho** na primeira linha de `thesis.tex`, na opção do
   `\documentclass` (veja a tabela abaixo).
2. **Preencha os metadados** (título PT/EN, autor, orientador, data, curso) no
   início de `thesis.tex`, **e também o resumo, o abstract e as palavras-chave**
   nos blocos `\textoresumo[brazil]{...}` e `\textoresumo[english]{...}`.
3. **Escreva os capítulos** em `tex/*.tex` (substitua o lorem ipsum).
4. **Cadastre as referências** em `referencias.bib` e cite com `\parencite{}` /
   `\textcite{}` (citação direta curta com `\enquote{}`; longa com o ambiente
   `citacao` — veja "Recursos demonstrados").
5. **Compile** (veja "Compilação").

## Tipos de trabalho (opções do `\documentclass`)

Escolha **um** nível. Combine com os modificadores quando fizer sentido.

| Opção                       | Tipo de trabalho             | Grau               |
|-----------------------------|------------------------------|--------------------|
| `graduacao` ou `tcc`        | Trabalho de Conclusão de Curso | Bacharel         |
| `especializacao` ou `monografia` | Monografia              | Especialista       |
| `mestrado`                  | Dissertação                  | Mestre / Mestra    |
| `doutorado` (padrão)        | Tese                         | Doutor / Doutora   |

Modificadores: `qualificacao` (só mestrado/doutorado), `pre-defesa`,
`pos-defesa` (padrão), `impressao`.

Exemplos:
```latex
\documentclass[tcc]{packages/ppg}
\documentclass[especializacao]{packages/ppg}
\documentclass[mestrado,qualificacao]{packages/ppg}
\documentclass[doutorado,pos-defesa]{packages/ppg}
```

### Paginação: frente única ou frente e verso

Por padrão o template é **frente única (`oneside`)**: o número da página fica
**sempre no canto superior direito**, a 2 cm da borda (NBR 14724:2024, 5.3) — ideal
para entrega em PDF.

Para **impressão frente e verso**, abra `packages/ppg.cls` e, na opção do
`\LoadClass[...]{abntex2}` (por volta da linha 113), troque `oneside` por `twoside`.
Isso é tratado automaticamente pela classe base:

- **margens espelhadas** — 3 cm no lado interno (lombada) e 2 cm no externo,
  alternando anverso/verso;
- **numeração alternando o canto** — anverso à direita, verso à esquerda;
- **páginas em branco** inseridas para os capítulos abrirem sempre em página ímpar.

Nenhum outro ajuste é necessário; basta recompilar. A regra dos 3 cm da capa/folha
de rosto, a ficha no verso da folha de rosto e os tamanhos de fonte permanecem
conformes em ambos os modos.

**Abertura de capítulo (NBR 14724:2024, 5.2.2).** Um capítulo é uma *seção primária*,
e a norma pede: em **frente e verso**, ele deve começar em **página ímpar (anverso)**
— inserindo uma página em branco quando necessário; em **frente única**, basta
começar em **nova página**. A classe já faz isso automaticamente (opção `openright`):
você não precisa de nenhum comando extra ao criar um capítulo — apenas
`\chapter{...}` + `\input{tex/...}` no `thesis.tex`.

### Curso / instituição

A pós-graduação em Computação Aplicada da UNIVALI já vem pré-configurada via
`\curso{PPGC}`. Para **qualquer outro curso** (inclusive TCC/monografia), passe o
nome completo e defina a área e a especialidade você mesmo:

```latex
\curso{Curso de Ciência da Computação -- UNIVALI}
\area{Engenharia de Software}
\especialidade{em Ciência da Computação}   % completa "...título de Bacharel em Ciência da Computação"
```

Para mudar o cabeçalho impresso no topo da **capa**, use `\capainstituicao{...}`
(opcional; só é necessário se não usar o PPGCA). A cidade da capa/folha de rosto
é definida com `\local{...}`.

## Compilação

**Pré-requisitos (build local):** uma distribuição TeX recente — **TeX Live**
(Linux/macOS/Windows) ou **MiKTeX** (Windows) — que inclua `xelatex`, `biber`,
`makeindex`, `makeglossaries` e, opcionalmente, `latexmk`. Quem compila no
**Overleaf** não precisa instalar nada (veja abaixo).

Use **XeLaTeX** ou **LuaLaTeX** (não pdfLaTeX — o template usa as fontes Arial e
Times em `packages/fonts/` via `fontspec`). A bibliografia usa **biber**.

**O jeito mais simples é `latexmk thesis.tex`**: o `latexmkrc` do template já
seleciona o XeLaTeX e executa biber, a lista de siglas e o glossário nas
etapas certas.

À mão, a sequência completa é:

```sh
xelatex thesis
biber thesis                                    # referências
makeindex -s nomencl.ist -o thesis.nls thesis.nlo   # lista de abreviaturas e siglas
makeglossaries thesis                           # glossário (só se usar \newword)
xelatex thesis
xelatex thesis
```

> **Atenção:** a lista de abreviaturas e siglas vem do pacote `nomencl` e é
> gerada por **`makeindex` com o estilo `nomencl.ist`** — *não* por
> `makeglossaries`, que cuida apenas do glossário pós-textual. Se essa etapa não
> rodar, `\printnomenclature` não imprime nem o título e a lista simplesmente
> **desaparece do PDF, sem erro**. Na dúvida, confira se o `thesis.nls` foi
> criado.

No **Overleaf**: Menu → *Settings* → *Compiler* = **XeLaTeX**; documento
principal = `thesis.tex`. O Overleaf executa biber automaticamente e também lê o
`latexmkrc` do projeto, portanto a lista de siglas e o glossário saem prontos —
sem etapa manual. O arquivo é gravado **sem ponto** no nome justamente por causa
do Overleaf: a interface e a sincronização com o GitHub lidam mal com dotfiles.
Ele precisa ficar na raiz do projeto, ao lado do `thesis.tex`. Depois de
adicioná-lo, use *Recompile* → **Clear cached files** na primeira compilação.

## Estrutura de arquivos

```
template/
├── thesis.tex            # arquivo principal: opções, metadados, inclusão dos capítulos
├── referencias.bib       # base de referências (biblatex)
├── latexmkrc             # etapas do build (XeLaTeX, biber, siglas, glossário)
├── packages/
│   ├── ppg.cls           # classe UNIVALI (formatação ABNT) — não precisa editar
│   └── fonts/            # fontes Arial e Times (TTF)
├── imagens/              # suas figuras
└── tex/
    ├── _placeholders.tex # utilitário \figuraplaceholder (pode remover no fim)
    ├── introducao.tex
    ├── fundamentacao-teorica.tex
    ├── materiais-e-metodos.tex
    ├── resultados.tex
    ├── conclusao.tex
    └── pre-textual/      # dedicatória, agradecimentos, epígrafe, declaração de IA
```

## Recursos demonstrados nos capítulos

O texto de exemplo já traz, pronto para copiar, os principais elementos ABNT:

**Citações (NBR 10520:2023)** — em `tex/fundamentacao-teorica.tex`:
- Indireta: `\parencite{}` → (Sobrenome, ano); `\textcite{}` → Sobrenome (ano);
  `\parencite[p. 12]{}` → com página. Pela NBR 10520:2023, o sobrenome vem em
  caixa baixa (só a inicial maiúscula) **também entre parênteses** — não mais em
  caixa alta; o estilo biblatex-abnt do template já produz assim.
- Direta **curta** (até 3 linhas): `\enquote{...}` — aspas curvas; **nunca** a aspa reta `"`
- Direta **longa** (mais de 3 linhas): ambiente `citacao` (recuo 4 cm, fonte menor,
  espaço simples, sem aspas)
- `grifo nosso`, supressão `[...]` e `apud` (citação de citação)
- Nota de rodapé (`\footnote`)
- **Sigla na primeira menção** (`\sigla{}{}`, NBR 14724:2024, 5.6) — escreve o nome
  completo com a sigla entre parênteses e já a cadastra na lista pré-textual

**Ilustrações, tabelas e código** — legenda acima, fonte abaixo (ver seção própria):
- Figura (com placeholder `\figuraplaceholder`) e gráfico `pgfplots`
- Tabela `booktabs` (aberta, dados numéricos) e `quadro` (com bordas, dados textuais)
- Listagem de código (`lstlisting`) e **algoritmo** em pseudocódigo (ambiente `algorithm`)

**Estrutura e listas:**
- Equação numerada e referenciável (`\autoref{eq:...}`)
- Numeração progressiva **até o 5º nível** (seção → subseção → … → quinária)
- `itemize`, `enumerate` e **alíneas** ABNT (`a) b) c)` + subalíneas)
- Listas de figuras, tabelas, quadros, algoritmos, códigos e **siglas**
  — cadastre cada item no preâmbulo com `\nomenclature[A]{p.}{Página}`
  (abreviaturas) ou `\nomenclature[S]{ABNT}{Associação...}` (siglas); a classe
  agrupa os dois sob os subtítulos *Abreviaturas* e *Siglas* na lista
  pré-textual. Alternativa para usar **dentro do texto**:
  `\sigla{IBGE}{Instituto Brasileiro...}` cadastra **e** escreve "Instituto
  Brasileiro... (IBGE)" ali mesmo, atendendo à NBR 14724:2024, 5.6 (na primeira
  menção, a sigla vem entre parênteses precedida do nome completo) — demonstrado
  em `tex/fundamentacao-teorica.tex`. `\sigla*{}{}` só cadastra; `\sigla[A]{}{}`
  manda a entrada para o grupo *Abreviaturas* (o padrão é *Siglas*)
- **Glossário** pós-textual (opcional, depois das Referências): defina os termos
  no preâmbulo com `\newword{termo}{definição}` (chaves automáticas `Def.1`,
  `Def.2`…) e cite-os no texto com `\gls{Def.1}` — ou use `\glsaddall` para
  listar todos. Só entradas **usadas** são impressas; sem nenhuma, o
  `\printglossary` não gera página

**Pré e pós-textuais:**
- Resumo (PT) + *abstract* (EN) com palavras-chave; dedicatória, agradecimentos,
  epígrafe e declaração de uso de IA generativa
- Ficha catalográfica e folha de aprovação (elementos da versão final)
- **Apêndice** e **anexo** de exemplo
- **Referências de todos os tipos** em `referencias.bib`: livro (`@book`), artigo
  (`@article`), trabalho em evento (`@inproceedings`), fonte on-line (`@online`) e
  dissertação/tese (`@mastersthesis`/`@phdthesis`)

## Figuras, tabelas e quadros (legenda e fonte)

Conforme a NBR 14724:2024 (5.8/5.9): a **legenda** vai **acima** (centralizada) e a
**fonte** vai **abaixo, alinhada à margem esquerda do elemento** — ambas em tamanho
**menor e uniforme**. Para isso, envolva o elemento (imagem, `tikzpicture` ou
`tabular`) com **`\elementocomfonte{<elemento>}{Fonte: ...}`**, que mede a largura do
elemento e alinha a fonte à sua borda esquerda:

```latex
\begin{figure}[!htb]
  \caption{Sua legenda.}        % legenda ACIMA, centralizada
  \label{fig:minha}
  \centering
  \elementocomfonte{\includegraphics[width=0.7\textwidth]{imagens/figura.png}}%
    {Fonte: Elaborada pelo autor (\the\year{}).}
\end{figure}
```

O mesmo vale para `table` (tabular `booktabs`) e `quadro` (tabular com bordas) — veja
os exemplos prontos em `tex/fundamentacao-teorica.tex`, `tex/resultados.tex` e
`tex/materiais-e-metodos.tex`. Use `\figuraplaceholder{largura}{altura}{caminho}`
como espaço reservado enquanto não tiver a imagem real.

## Títulos de seção (destaque gradativo)

Os níveis de seção são destacados **gradativamente** (NBR 6024), de forma **idêntica
no texto e no sumário**. O tamanho **não** muda (tudo em 12 pt); só o peso/estilo:

| Nível | Exemplo | Aparência |
|-------|---------|-----------|
| Primária (capítulo) | `1 INTRODUÇÃO`        | MAIÚSCULAS + negrito |
| Secundária          | `1.1 Conceito`        | Negrito |
| Terciária           | `1.1.1 Técnica`       | Redondo (sem negrito) |
| Quaternária         | `1.1.1.1 Detalhe`     | *Itálico* |
| Quinária            | `1.1.1.1.1 Item`      | Redondo |

Esse esquema segue a **prática acadêmica** comum. O guia UNIVALI (Apêndice D) adota,
alternativamente, **terciária em itálico** e **quaternária redonda** — também válido
pela NBR 6024. Para trocar, ajuste **em par** (título ↔ sumário, para não quebrar a
identidade exigida pela norma) em `packages/ppg.cls`: `\setsubsecheadstyle` com
`\cftsubsectionfont`, e `\setsubsubsecheadstyle` com `\cftsubsubsectionfont`.

## Elementos opcionais

O template vem com **todos os elementos habilitados, para demonstração**. No
`thesis.tex`, ajuste ao seu trabalho:
- `\incluifichacatalografica{...}` e `\incluifolhadeaprovacao{...}` — ficha
  catalográfica e folha de aprovação são da **versão final** (após a defesa);
  **comente-as** na qualificação.
- `\incluilistade...` (figuras, tabelas, quadros, algoritmos, códigos, siglas) —
  mantenha apenas as listas cujos elementos você realmente usa (lista sem elemento
  sai vazia).
- ambientes `apendicesenv` (apêndices) e `anexosenv` (anexos) — remova se não tiver.

## Fontes de referência

As decisões de formatação codificadas em `packages/ppg.cls` seguem as normas
ABNT e o guia institucional da UNIVALI:

- **ABNT NBR 14724:2024** — Informação e documentação — Trabalhos acadêmicos —
  Apresentação.
- **ABNT NBR 6023:2025** — Informação e documentação — Referências — Elaboração.
- **ABNT NBR 10520:2023** — Informação e documentação — Citações em documentos.
- **ABNT NBR 6024** — Numeração progressiva das seções de um documento.
- **UNIVALI** — *Livro digital para elaboração de trabalhos acadêmicos* (guia
  institucional da Biblioteca/PPG), disponível em
  <https://portal.univali.br/biblioteca/normas-e-procedimentos#orientacoes>.
- **[abnTeX2](https://www.abntex.net.br/)** — classe LaTeX base que implementa a
  ABNT, sobre a qual o `ppg.cls` é construído.

> Os PDFs das normas ABNT são protegidos por direitos autorais e **não** são
> redistribuídos neste repositório; consulte-os pela ABNT ou pela Biblioteca da
> UNIVALI.

## Licença

Este template é derivado do **[abnTeX2](https://www.abntex.net.br/)** e é
distribuído sob a **LaTeX Project Public License (LPPL) v1.3** — a mesma do
abnTeX2 —, permitindo uso, cópia, modificação e redistribuição nos termos da
licença. As fontes empacotadas em `packages/fonts/` (Arial e Times) permanecem
sujeitas às suas próprias licenças. Veja <https://www.latex-project.org/lppl/>.
