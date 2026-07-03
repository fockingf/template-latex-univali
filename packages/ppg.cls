%%
%% Customizacoes do abnTeX2 (http://abnTeX2.googlecode.com) para o 
%% Programa de Pós Graduação em Computação 
%% UNIVALI
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% 
%%
%% Further information about abnTeX2 are available on 
%% http://abntex2.googlecode.com/
%% Atualizado para ABNT NBR 6023:2025 e ABNT NBR 14724:2024 em 2026.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{packages/ppg}[2026/04/23 v3 Baseado em abnTeX2 - Teses/Dissertações Univali (NBR 14724:2024, NBR 6023:2025, NBR 10520:2023)]

% Permite incluir PDFs gerados em versão 1.7 (capa e contra-capa).
% Guardado: \pdfminorversion só existe no pdfTeX; sob XeLaTeX/LuaLaTeX a versão
% do PDF é controlada pelo xdvipdfmx, e a primitiva seria indefinida.
\ifdefined\pdfminorversion \pdfminorversion=7 \fi

\RequirePackage{xifthen}
\RequirePackage{ifxetex}        % Verifica se a compilacao ocorre por xetex
\RequirePackage{ifluatex}       % Verifica se a compilacao ocorre por luatex

%===================================================================
% Declaração de opções
%===================================================================
% Opções:
% 	qualificação:   Formata documento para qualificação
%	doutorado:      Formata documento para tese de doutorado
% 	mestrado:       Formata documento para dissertação de mestrado
% 	pre-defesa:     Formata documento para versão de defesa (utilizado apenas para versão completa)
%   pro-defesa:     Formata documento para versão final (utilizado apenas para versão completa)
%   impressão:      Formata documento para versão de impressão
% -----------------------------------------------------------------

\DeclareOption*{%
    \PackageWarning{ppg}{Unknown option ‘\CurrentOption’}%
}

\newboolean{opt-qualificacao}
\setboolean{opt-qualificacao}{false}
\DeclareOption{qualificacao}{
    \setboolean{opt-qualificacao}{true}
}

\newboolean{opt-doutorado}
\DeclareOption{doutorado}{
    \setboolean{opt-doutorado}{true}
}
\DeclareOption{mestrado}{
    \setboolean{opt-doutorado}{false}
}
\ExecuteOptions{doutorado}

% Níveis de graduação/especialização (TCC, monografias etc.).
% Quando ativos, têm precedência sobre mestrado/doutorado.
%   graduacao | tcc        -> "Trabalho de Conclusão de Curso", grau Bacharel
%   especializacao | monografia -> "Monografia", grau Especialista
\newboolean{opt-graduacao}
\setboolean{opt-graduacao}{false}
\DeclareOption{graduacao}{\setboolean{opt-graduacao}{true}}
\DeclareOption{tcc}{\setboolean{opt-graduacao}{true}}

\newboolean{opt-especializacao}
\setboolean{opt-especializacao}{false}
\DeclareOption{especializacao}{\setboolean{opt-especializacao}{true}}
\DeclareOption{monografia}{\setboolean{opt-especializacao}{true}}

\newboolean{opt-pre-defesa}
\DeclareOption{pre-defesa}{
    \setboolean{opt-pre-defesa}{true}
}
\DeclareOption{pos-defesa}{
    \setboolean{opt-pre-defesa}{false}
}
\ExecuteOptions{pos-defesa}

\newboolean{opt-impressao}
\setboolean{opt-impressao}{false}
%\newcommand{\colorlinks}{true}
\DeclareOption{impressao}{
    \setboolean{opt-impressao}{true}
   % \renewcommand{\colorlinks}{true}
}

% Repassa demais opções a abntex	
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}

% Repassa os três idiomas principais para o pacote Babel
\PassOptionsToPackage{spanish, english, brazil}{babel}

\ProcessOptions\relax


%===================================================================
% Herança da classe `abntex2' e inclusão de pacotes e arquivos necessários
%===================================================================
\LoadClass[% -- opções da classe memoir --
	12pt,				% tamanho da fonte
	openright,			% capítulos começam em pagina impar (insere pagina vazia caso preciso)
	oneside,			% para impressão em verso e anverso trocar para twoside
	a4paper,			% tamanho do papel. 
	chapter=TITLE		% títulos de capítulos convertidos em letras maiusculas
	]{abntex2}
	

%===================================================================
% Pacotes fundamentais 
%===================================================================
\RequirePackage{morewrites}     % Resolve o erro “No room for a new \write”
% cmap so funciona/faz sentido no pdfTeX (gera CMap ToUnicode para PDF
% pesquisavel). Sob XeLaTeX/LuaLaTeX isso ja e nativo e o cmap apenas emite
% "pdftex not detected - exiting"; por isso so o carregamos no pdfTeX.
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage{cmap}			% Mapear caracteres especiais no PDF
\fi
\RequirePackage{lmodern}		% Usa a fonte Latin Modern.
\RequirePackage{lastpage}		% Usado pela Ficha catalográfica
\RequirePackage{indentfirst}	% Indenta o primeiro paragrafo de cada secção.
\RequirePackage{color, xcolor}  % Controle das cores
\RequirePackage{colortbl}       % Controle das cores das células da tabela(utilizado no titulo)
\RequirePackage{graphicx}		% Inclusão de gráficos
\RequirePackage{caption}        % Pacote para definição dos captions
\RequirePackage{subcaption}     % Pacote para definição dos subcaptions(ambientes de subfigures)
\RequirePackage{microtype} 		% para melhorias de justificacao
\RequirePackage{pdfpages}       % Inclusao de arquivos PDF
\RequirePackage{hyphenat}       % Pacote para retirar a hifenizacao do preambulo
\RequirePackage{xstring}        % Pacate para manipulacao de Strings
\RequirePackage{etoolbox}       % Pacote utilizado para armazenamento de resumos
\RequirePackage{amsthm, amsfonts, amsmath, amssymb} % Pacote para a definicao dos ambientes matematicos
\RequirePackage{mathptmx}       % Usando times para equações, opcional
\RequirePackage{listings}       % Pacote para formatação de diversos códigos fontes
\RequirePackage{algorithm, algpseudocode}  % Pacote para escrever algoritmos em pseudo-codigo
\RequirePackage{nomencl}        % Pacote para criacao da Lista de Siglas
% Evita "Package tracklang Warning: No `datatool' support for dialect ...": o
% glossaries carrega o datatool-base, que tenta carregar locales para cada
% dialeto do babel rastreado (spanish, brazil...), inexistentes no datatool.
% Nao usamos formatacao numerica/locale do datatool, entao nolocale desliga
% esse carregamento e silencia os avisos sem perda de funcionalidade.
\PassOptionsToPackage{nolocale}{datatool-base}
\RequirePackage[noredefwarn,translate=false,nonumberlist,style=list,toc]{glossaries}
% backref removido: incompatível com biblatex (NBR 6023:2025)
\RequirePackage{float}          % Pacote para criação de novos ambientes
% Bibliografia: biblatex-abnt (NBR 6023:2025 — cobertura completa)
\RequirePackage[backend=biber,
    style=abnt,
    backref=true,           % habilita backreferences (páginas onde a obra foi citada)
    % titulo em NEGRITO (padrao do biblatex-abnt): a opcao "ittitles" poria o
    % titulo em italico; o guia UNIVALI (cap. 3) e os exemplos usam negrito.
    repeatfields,
    maxcitenames=3,
    % NBR 6023:2025 §3.3.1: ate 3 autores, lista todos; 4+ autores, primeiro
    % autor seguido de "et al." (opcao permitida pelo guia UNIVALI).
    maxbibnames=3,
    minbibnames=1
]{biblatex}
% NBR 6023:2025 + UNIVALI/Sibiun: referências alinhadas à esquerda, sem recuo
\setlength{\bibhang}{0pt}
% Tradução das strings de backreference para português
\DefineBibliographyStrings{brazil}{%
    backrefpage  = {Citado na p\'{a}gina},
    backrefpages = {Citado nas p\'{a}ginas},
}
\DefineBibliographyStrings{english}{%
    backrefpage  = {Cited on page},
    backrefpages = {Cited on pages},
}
% NBR 14724:2024 §5.2: referências em espaço simples, separadas entre si
% por um espaço simples em branco.
\setlength\bibitemsep{\baselineskip}

% NBR 6023:2025 — em "parte de obra" (trabalho de evento ou capitulo/parte de
% livro), o destaque (negrito) vai no titulo do documento como um todo
% (anais/proceedings ou titulo do livro, no campo booktitle, apos "In:"), e
% nao no titulo da parte/subtitulo.
%
% O biblatex-abnt envolve o booktitle no formato "booktitle" (que ja aplica
% \mkbibbold), MAS o conteudo e impresso via \printfield[upperfirst], cujo
% formato faz "\normalfont\FirstWordUpper" — o \normalfont anula o negrito.
% Resultado: o booktitle nunca sai em negrito. Corrige-se redefinindo o
% bibmacro booktitle para imprimir o titulo com um formato em negrito que
% NAO chama \normalfont; o subtitulo (booksubtitle) permanece normal.
\DeclareFieldFormat{bookbold}{\textbf{\FirstWordUpper{#1}}}
\renewbibmacro*{booktitle}{%
  \ifboolexpr{%
    test {\iffieldundef{booktitle}}%
    and%
    test {\iffieldundef{booksubtitle}}%
  }%
    {}%
    {\printtext[booktitle]{%
      \usebibmacro{booktitleiskey}{%
        \printfield[bookbold]{booktitle}%
      }{%
        \printfield[bookbold]{booktitle}%
      }%
      \iffieldendswithpunct{booktitle}{%
        \normalfont{\setunit*{\addspace}}%
      }{%
        \normalfont{\setunit*{\subtitlepunct}}%
      }%
      \printfield[normalfont]{booksubtitle}}%
      \newunit}%
  \printfield{booktitleaddon}%
}%

% NBR 6023:2025 — data desconhecida: imprime "[s.d.]" automaticamente.
% O biblatex-abnt preenche "[S.l.]"/"[s.n.]" para local/editora ausentes,
% mas NÃO trata data ausente; sem isto, a data simplesmente não é impressa.
% Gatilho: entradas SEM campo de data/year recebem "[s.d.]".
\DefineBibliographyStrings{brazil}{%
    nodate = {s\adddot d\adddot},
}
\DefineBibliographyStrings{english}{%
    nodate = {n\adddot d\adddot},
}
\renewbibmacro*{date}{%
    \iffieldundef{year}
      {\printtext[brackets]{\bibstring{nodate}}}%
      {\iftoggle{extradate}{\printdateextra}{\printdate}}%
    \printunit{\addperiod\addspace}%
}
\RequirePackage{environ}        % Pacote para definicao de ambientes
\RequirePackage[absolute]{textpos} % Pacote para posicionamento do texto
\RequirePackage{eso-pic}        % Pacote para incluir imagem de fundo
\RequirePackage{adjustbox}      % Pacote para ajuste do tamanho do nome do autor na capa


%===================================================================
% Comando para configuração do tipo de trabalho
%===================================================================

\providecommand*{\tipoexemplar}{}
\providecommand*{\degree}{}
\providecommand*{\tipodocurso}{}
\providecommand*{\exam}{}
\providecommand*{\arealabel}{}

% Configuracao do texto do preambulo
\addto\captionsenglish{% ingles
    \renewcommand{\exam}{ in partial fulfillment of the requirements for the degree}
}
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\exam}{ como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}
}

% Configuracao da situacao do trabalho entregue
\ifthenelse{\boolean{opt-pre-defesa}}{
    \addto\captionsenglish{% ingles
        \renewcommand{\tipoexemplar}{EXAMINATION BOARD PRESENTATION COPY}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\tipoexemplar}{EXEMPLAR DE DEFESA}
    }
}{
    \addto\captionsenglish{% ingles
        \renewcommand*{\tipoexemplar}{FINAL VERSION}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\tipoexemplar}{VERS{\~A}O FINAL}
    }
}

% Concordância do verbo de apresentação no preâmbulo:
% "apresentada" (Tese/Dissertação/Monografia) ou "apresentado" (TCC).
\providecommand*{\imprimirapresentacao}{}
\addto\captionsbrazil{\renewcommand{\imprimirapresentacao}{apresentada}}
\addto\captionsenglish{\renewcommand{\imprimirapresentacao}{submitted}}

% Configuracao do tipo de trabalho.
% Precedência: graduacao > especializacao > doutorado > mestrado.
\ifthenelse{\boolean{opt-graduacao}}{
    % --- GRADUAÇÃO (TCC) ---
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{Bachelor}
        \renewcommand{\tipodocurso}{Undergraduate}
        \tipotrabalho{Undergraduate thesis}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\degree}{Bacharel}
        \renewcommand{\tipodocurso}{Gradua{\c c}{\~a}o}
        \tipotrabalho{Trabalho de Conclus{\~a}o de Curso}
        \renewcommand{\imprimirapresentacao}{apresentado}
        \renewcommand{\tipoexemplar}{}
    }
    \addto\captionsenglish{\renewcommand{\tipoexemplar}{}}
}{\ifthenelse{\boolean{opt-especializacao}}{
    % --- ESPECIALIZAÇÃO (Monografia) ---
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{Specialist}
        \renewcommand{\tipodocurso}{Specialization student}
        \tipotrabalho{Monograph}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\degree}{Especialista}
        \renewcommand{\tipodocurso}{Especializa{\c c}{\~a}o}
        \tipotrabalho{Monografia}
        \renewcommand{\tipoexemplar}{}
    }
    \addto\captionsenglish{\renewcommand{\tipoexemplar}{}}
}{\ifthenelse{\boolean{opt-doutorado}}{
    % --- DOUTORADO ---
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{of the Doctorate}
        \renewcommand{\tipodocurso}{Doctorate Candidate}
        \tipotrabalho{Doctoral dissertation}
    }
    \addto\captionsbrazil{% portugues-brasil
        \ifthenelse{\equal{\imprimirgenero}{M}}{\renewcommand{\degree}{Doutor}}{\renewcommand{\degree}{Doutora}}
        \renewcommand{\tipodocurso}{Doutorado}
        \tipotrabalho{Tese}
    }
}{
    % --- MESTRADO ---
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{of the Master}
        \renewcommand{\tipodocurso}{Master student}
        \tipotrabalho{Master dissertation}
    }
    \addto\captionsbrazil{% portugues-brasil
        \ifthenelse{\equal{\imprimirgenero}{M}}{\renewcommand{\degree}{Mestre}}{\renewcommand{\degree}{Mestra}}
        \renewcommand{\tipodocurso}{Mestrado}
        \tipotrabalho{Disserta{\c c}{\~a}o}
    }
}}}

% Configuracao do tipo de trabalho como QUALIFICACAO de DOUTORADO ou MESTRADO
% (não se aplica a graduação/especialização)
\ifthenelse{\boolean{opt-qualificacao} \and \not\boolean{opt-graduacao} \and \not\boolean{opt-especializacao}}{
    \addto\captionsenglish{% ingles
        \renewcommand{\exam}{ as part of the qualifying exam requisites of the}
        \tipotrabalho{Master's thesis}
        \renewcommand{\tipoexemplar}{}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\exam}{ para o Exame de Qualifica{\c c}{\~a}o, como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}
        \tipotrabalho{Dissertação}
        \renewcommand{\tipoexemplar}{}
    }
}{}

% Configuracao do texto impresso no Preambulo
\addto\captionsenglish{% ingles
    \renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~\imprimirapresentacao~to the \imprimirinstituicao,\exam~\degree~\imprimirespecialidade. \textit{\tipoexemplar}}}
    \renewcommand{\arealabel}{Research line}
}
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~\imprimirapresentacao~ao \imprimirinstituicao,\exam~\degree~\imprimirespecialidade. \textit{\tipoexemplar}}}
    \renewcommand{\arealabel}{Linha de Pesquisa}
}


%===================================================================
% Comando auxiliares
%===================================================================

% Comando para marcar texto para revisao
\newcommand{\rev}[1]{\textcolor{red}{[#1]}}

% Agrupa um elemento gráfico (figura, tabela ou quadro) e a sua FONTE numa
% caixa com a largura do próprio elemento. Assim, com o conjunto centralizado
% (\centering), a fonte fica alinhada à MARGEM ESQUERDA DO ELEMENTO, e não à
% margem do texto (NBR 14724:2024, 5.8/5.9; guia UNIVALI, 5.7).
% Uso (dentro de figure/table/quadro, após \caption e \label):
%   \centering
%   \elementocomfonte{<elemento: \includegraphics/tikzpicture/tabular>}{Fonte: ...}
% A fonte usa \ABNTEXfontereduzida — a MESMA fonte reduzida do título/legenda
% (\caption), para que título e fonte fiquem em tamanho "menor e uniforme"
% (NBR 14724:2024, 5.1).
\newsavebox{\ppgelembox}
\newcommand{\elementocomfonte}[2]{%
  \sbox{\ppgelembox}{#1}%
  \begin{minipage}{\wd\ppgelembox}%
    \usebox{\ppgelembox}\par
    \vspace{2pt}{\ABNTEXfontereduzida\raggedright #2\par}%
  \end{minipage}%
}

% Legendas utilizadas em Figuras / Tabelas / Etc.
\newcommand{\fautor}{\legend{Fonte: Elaborada pelo autor.}}
\newcommand{\fadaptada}[2][]{\legend{Fonte: Adaptada de \textcite[#1]{#2}.}}
\newcommand{\fdireta}[2][]{\legend{Fonte: \textcite[#1]{#2}.}}
\newcommand{\fdadospesquisa}{\legend{Fonte: Dados da pesquisa.}}

\addto\captionsenglish{% ingles
    % Legendas utilizadas em Figuras / Tabelas / Etc.
    \renewcommand{\fautor}{\legend{Source: Elaborated by the author.}}
    \renewcommand{\fdadospesquisa}{\legend{Source: Research data.}}
}
% fadaptada e fdireta em inglês: redefinidas fora de \addto para evitar
% conflito com biblatex (\protected@edef não aceita #1 dentro de \addto)
\AtBeginDocument{%
  \IfStrEq{\imprimiridioma}{EN}{%
    \renewcommand{\fadaptada}[2][]{\legend{Source: Adapted from \textcite[#1]{#2}.}}%
    \renewcommand{\fdireta}[2][]{\legend{Source: \textcite[#1]{#2}.}}%
  }{}%
}

% Automatiza o processo de aspas
\newcommand{\aspas}[1]{``{#1}''}

% Palavras-chave do resumo
\newcommand{\palavraschave}{}


%====================================================================
% Pacote para criação da lista de siglas e abreviaturas
%===================================================================

% Configuracao do pacote nomencl
% Tamanho da Label da sigla
\setlength{\nomlabelwidth}{0.15\hsize} 
% Separa as abreviaturas de suas definições com pontos (....)
\renewcommand{\nomlabel}[1]{#1 \hfill}
\setlength{\nomitemsep}{-.05in} 
% Comando necessário para a criação da lista de abreviaturas
\makenomenclature
% Traduz o titulo da lista de abreviaturas
\renewcommand{\nomname}{\listadesiglasname}

% Comando para criação de abreviaturas e siglas
\def\sigla{\@ifstar\@sigla\@@sigla}
% Apenas faz o registro na tabela de siglas
\def\@sigla#1#2{\nomenclature{#1}{#2}}          % \sigla*{}{} 
% Faz o registro na tabela de siglas e insere os dados no corpo do documento
\def\@@sigla#1#2{#2 (#1)\nomenclature{#1}{#2}}  % \sigla{}{}


%===================================================================
% Pacote para criação do GLOSSÁRIO
%===================================================================
% Gera o índice do Glossário
\makeglossaries
% Traduz o nome do glossário
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\glossaryname}{Gloss\'ario}
}

% Contador de definicoes do Glossario
\newcounter{count_glossario}
% Comando para simplificar a definicao de palavras no glossario
\newcommand{\newword}[2]{%
    \stepcounter{count_glossario}% Incrementa o contador do glossario
    \newglossaryentry{Def.\arabic{count_glossario}}{%
        name={#1:},%
        description={#2},%
    }%
}

% Alteracao no formato do nome do glossario que aparece no sumario
\ifthenelse{\boolean{ABNTEXupperchapter}}{
    \renewcommand{\glssettoctitle}[1]{%
        \renewcommand{\glossarytoctitle}{%
            \texorpdfstring{\MakeTextUppercase{\csname @glotype@#1@title\endcsname}}{\csname @glotype@#1@title\endcsname}
        }
    }
}{}


%===================================================================
% Pacotes de citacoes
%===================================================================

% Bloco de configuração do backref removido: incompatível com biblatex


%===================================================================
% Definição/Alteração de comandos utilizados
%===================================================================

% Permite comandos com @ no nome
\makeatletter

% Comando para selecionar o idioma principal do texto
\providecommand{\imprimiridioma}{PT}
\newcommand{\idioma}[1]{
    \renewcommand{\imprimiridioma}{#1}
    \IfEq{\imprimiridioma}{EN}{}{
        \IfEq{\imprimiridioma}{PT}{}{
            \PackageError{ppg}{Ilegal parameter of idioma}{
                Unknow language "#1"!
                Please, use "PT" to portuguese language or "EN" to english language. The option must be in uppercase.
            }
            \stop
        }
    }
}
% Checagem dos dialetos da língua portuguesa
\newcommand*{\IfLangPortuguese}{%
  \iflanguage{brazil}\@firstoftwo\@secondoftwo%
}

% Comando para definir o titulo em português
\providecommand{\imprimirtituloPT}{}
\newcommand{\tituloPT}[1]{\renewcommand{\imprimirtituloPT}{#1}}%

% Comando para definir o titulo em inglês
\providecommand{\imprimirtituloEN}{}
\newcommand{\tituloEN}[1]{\renewcommand{\imprimirtituloEN}{#1}}%

\providecommand{\imprimirmaintitle}{}
\IfLangPortuguese{\renewcommand{\imprimirmaintitle}{\imprimirtituloPT}}{\renewcommand{\imprimirmaintitle}{\imprimirtituloEN}}

\addto\captionsenglish{% inglês
    \titulo{\imprimirtituloEN}
}
\addto\captionsbrazil{% português-brasil
    \titulo{\imprimirtituloPT}
}

% Comando para definir o gênero do autor (M = Masculino / F = Feminino)
\providecommand{\imprimirgenero}{M}
\newcommand{\genero}[1]{
    \renewcommand{\imprimirgenero}{#1}
    \IfEq{\imprimirgenero}{M}{}{
        \IfEq{\imprimirgenero}{F}{}{
            \PackageError{ppg}{Ilegal parameter of genero}{
                Unknow gender "#1"!
                Please, use "M" or "F". The option must be in uppercase.
            }
            \stop
        }
    }
}

% Comando para definição do nome e sobrenome do autor
\renewcommand\autor[2][Nome para Referencia]{
    
    \StrCount{#2}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#2}{\space}\strfirstautor\strsecondautor

    \global\def\@authname{\strfirstautor}
    \global\def\@authsurn{\strsecondautor}
    \def\ABNTautordata{\@authname~\@authsurn}
    \renewcommand{\imprimirautor}{\@authname~\@authsurn}
    \def\ABNTautorreferencia{#1}
    \def\ABNTautordatabib{\@authsurn, \@authname}
    \global\def\@author{\@authname~\@authsurn}
}

% Retira os dois pontos (:) que vem por padrão da classe Abntex2
\addto\captionsbrazil{% português-brasil
    \renewcommand{\orientadorname}{Orientador}
    \renewcommand{\coorientadorname}{Coorientador}
}
\addto\captionsenglish{% ingles
    \renewcommand{\orientadorname}{Advisor}
    \renewcommand{\coorientadorname}{Co-advisor}
}

% Redefinição do comando de orientador
\renewcommand{\orientador}[3][\orientadorname]{

    \StrCount{#3}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#3}{\space}\strfirstorientador\strsecondorientador
    
    % Captura o valor de #1 antes de entrar no \addto (compatibilidade biblatex)
    \edef\@tmpOrientadorRotulo{#1}%
    \addto\captionsbrazil{% portugues-brasil
        \expandafter\renewcommand\expandafter{\csname imprimirorientadorRotulo\endcsname}{\@tmpOrientadorRotulo}%
    }
    \addto\captionsenglish{
        \renewcommand{\imprimirorientadorRotulo}{\orientadorname}
    }
    \newcommand{\titulacaoorientador}{#2}
    \def\ABNTorientadordatabib{\strsecondorientador, \strfirstorientador}
    \renewcommand{\imprimirorientador}{\strfirstorientador~\strsecondorientador}
}

% Redefinição do comando de co-orientador
\renewcommand{\coorientador}[3][\coorientadorname]{

    \StrCount{#3}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#3}{\space}\strfirstcoorientador\strsecondcoorientador
    
    % Captura o valor de #1 antes de entrar no \addto (compatibilidade biblatex)
    \edef\@tmpCoorientadorRotulo{#1}%
    \addto\captionsbrazil{% portugues-brasil
        \expandafter\renewcommand\expandafter{\csname imprimircoorientadorRotulo\endcsname}{\@tmpCoorientadorRotulo}%
    }
    \addto\captionsenglish{
        \renewcommand{\imprimircoorientadorRotulo}{\coorientadorname}
    }
    \newcommand{\titulacaocoorientador}{#2}
    \def\ABNTcoorientadordatabib{\strsecondcoorientador, \strfirstcoorientador}
    \renewcommand{\imprimircoorientador}{\strfirstcoorientador~\strsecondcoorientador}
}

% Comando para definição da área de concentração
\providecommand{\imprimirarea}{}
\newcommand{\area}[1]{\renewcommand{\imprimirarea}{#1}}

% Comando para definição da especialidade do Titulo
\providecommand{\imprimirespecialidade}{}
\newcommand{\especialidade}[1]{\renewcommand{\imprimirespecialidade}{#1}}

% Comando para definição do nome do Programa
\providecommand{\imprimirprograma}{}
\providecommand{\imprimirsiglaprograma}{}
\newcommand{\programa}[2]{
    \renewcommand{\imprimirsiglaprograma}{#1}
    \renewcommand{\imprimirprograma}{#2}
}

% Comando para definição da Universidade
\providecommand{\imprimiruniversidade}{}
\newcommand{\universidade}[1]{\renewcommand{\imprimiruniversidade}{#1}}

% Cabeçalho da instituição impresso no TOPO da CAPA (várias linhas, será
% exibido em maiúsculas/negrito). Redefina no preâmbulo com \capainstituicao{}.
% Útil para TCC/monografia (ex.: nome do Curso de Graduação em vez do PPG).
\providecommand{\imprimircapainstituicao}{%
  UNIVERSIDADE DO VALE DO ITAJA\'I\\[6pt]
  ~\\[6pt]
  PROGRAMA DE P\'OS-GRADUA\c{C}\~AO EM\\
  COMPUTA\c{C}\~AO APLICADA~(\imprimirsiglaprograma)}
\newcommand{\capainstituicao}[1]{\renewcommand{\imprimircapainstituicao}{#1}}

% Sinaliza se o usuário chamou \curso{} explicitamente (evita que o curso
% padrão PPGC sobrescreva \area/\especialidade definidos manualmente).
\newif\if@ppgCursoSet\@ppgCursoSetfalse

% Comando para definição do programa de Pós-Graduação, Especialidade do Titulo e Instituição
\newcommand{\curso}[1]{
\@ppgCursoSettrue

\addto\captionsbrazil{
    \universidade{Univali}
    \instituicao{Programa de P{\'o}s-Gradua{\c c}{\~a}o em Computação Aplicada -- PPGCA}
}
\addto\captionsenglish{% ingles
    \universidade{Univali}
    \instituicao{Graduate Program in Applied Computing -- PPGCA}
}

% PPGC ===========================================================
    \ifthenelse{\equal{#1}{PPGC}}{
        \addto\captionsbrazil{
            \area{Sistemas Embarcados e Distribuídos} %Sistemas Inteligentes e Educacionais
            \programa{PPGCA}{Programa de P{\'o}s-Gradua{\c c}{\~a}o em Computação Aplicada}
            \especialidade{em Computação Aplicada}
        }
        \addto\captionsenglish{% ingles
            \area{Embedded and Distributed Systems} %Intelligent and Educational Systems
            \especialidade{Program in Applied Computing}
        }
    }{

% Outros cursos ======================================================
% Qualquer outro valor é tratado como o NOME da instituição/curso a ser
% impresso no preâmbulo (ex.: \curso{Curso de Ciência da Computação -- UNIVALI}).
% Defina você mesmo \area{} e \especialidade{} no preâmbulo (thesis.tex).
        \addto\captionsbrazil{\instituicao{#1}}
        \addto\captionsenglish{\instituicao{#1}}
                    }
                }
            

% Redefinicao do comando \date do Latex
\renewcommand{\date}[3]{%
  \gdef\@day{#1}%
  \gdef\@month{#2}%
  \gdef\@year{#3}%
}

% Define a data
\date{\number\day}{\number\month}{\number\year}

% Redefinição do comando de data do ABNTex
\renewcommand{\data}[3]{%
    \date{#1}{#2}{#3}%
}

% Nome do Mês
% Monthname: redefinido fora de \addto\captions para compatibilidade com biblatex
\providecommand*{\Monthname}{}
\renewcommand\Monthname[1][EMPTY]{%
  \iflanguage{brazil}{%
    \ifnum1=#1Janeiro\else
    \ifnum2=#1Fevereiro\else
    \ifnum3=#1Mar{\c c}o\else
    \ifnum4=#1Abril\else
    \ifnum5=#1Maio\else
    \ifnum6=#1Junho\else
    \ifnum7=#1Julho\else
    \ifnum8=#1Agosto\else
    \ifnum9=#1Setembro\else
    \ifnum10=#1Outubro\else
    \ifnum11=#1Novembro\else
    \ifnum12=#1Dezembro\else
    \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
  }{%
    \ifnum1=#1January\else
    \ifnum2=#1February\else
    \ifnum3=#1March\else
    \ifnum4=#1April\else
    \ifnum5=#1May\else
    \ifnum6=#1June\else
    \ifnum7=#1July\else
    \ifnum8=#1August\else
    \ifnum9=#1September\else
    \ifnum10=#1October\else
    \ifnum11=#1November\else
    \ifnum12=#1December\else
    \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
  }%
}

% Opção para exibir a lista de figuras
\newcommand{\incluilistadefiguras}{
  \gdef\@incluilistadefiguras{true}
}


% Opção para exibir a lista de tabelas
\newcommand{\incluilistadetabelas}{
  \gdef\@incluilistadetabelas{true}
}

% Opcao para exibir a lista de siglas
\newcommand{\incluilistadesiglas}{
  \gdef\@incluilistadesiglas{true}
}

% Opcao para exibir a lista de simbolos
\newcommand{\incluilistadesimbolos}{
  \gdef\@incluilistadesimbolos{true}
}

% Opaco para exibir a lista de quadros
\newcommand{\incluilistadequadros}{
  \gdef\@incluilistadequadros{true}
}

% Opção para exibir a lista de algoritmos
\newcommand{\incluilistadealgoritmos}{
  \gdef\@incluilistadealgoritmos{true}
}

% Opção para exibir a lista de códigos
\newcommand{\incluilistadecodigos}{
  \gdef\@incluilistadecodigos{true}
}

% Comando para inclusão da ficha catalográfica
\newboolean{opt-fichacatalografica}
\setboolean{opt-fichacatalografica}{false}
\newcommand{\incluifichacatalografica}[1]{
    % Incluir um arquivo externo como ficha catalografica
    \setboolean{opt-fichacatalografica}{true}%
    \gdef\@arquivofichacatalografica{#1}%
}

% Comando para inclusão da folha de aprovação (versão final)
\newboolean{opt-folhadeaprovacao}
\setboolean{opt-folhadeaprovacao}{false}
\newcommand{\incluifolhadeaprovacao}[1]{%
    \setboolean{opt-folhadeaprovacao}{true}%
    \gdef\@arquivofolhaaprovacao{#1}%
}


%===================================================================
% Definição dos ambientes matemáticos
%===================================================================

\providecommand*{\theoremaname}{Theorem}
\providecommand*{\proposicaoname}{Proposition}
\providecommand*{\lemaname}{Lemma}
\providecommand*{\corolarioname}{Corollary}
\providecommand*{\exemploname}{Example}
\providecommand*{\observacaoname}{Note}
\providecommand*{\definicaoname}{Definition}
\providecommand*{\demonstracaoname}{Demonstration}

\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\theoremaname}{Teorema}
    \renewcommand{\proposicaoname}{Proposi{\c c}{\~a}o}
    \renewcommand{\lemaname}{Lema}
    \renewcommand{\corolarioname}{Corol{\'a}rio}
    \renewcommand{\exemploname}{Exemplo}
    \renewcommand{\observacaoname}{Observa{\c c}{\~a}o}
    \renewcommand{\definicaoname}{Defini{\c c}{\~a}o}
    \renewcommand{\demonstracaoname}{Demonstra{\c c}{\~a}o}
}

\theoremstyle{definition}
\newtheorem{teorema}{\theoremaname}
\newtheorem{proposicao}{\proposicaoname}
\newtheorem{lema}{\lemaname}
\newtheorem{corolario}{\corolarioname}
\newtheorem{exemplo}{\exemploname}
\newtheorem{observacao}{\observacaoname}
\newtheorem{definicao}{\definicaoname}
\newenvironment{demonstracao}{\begin{proof}[\demonstracaoname]}{\end{proof}}


%===================================================================
% Criação dos Ambientes Flutuantes para Quadros
%===================================================================

\newcommand{\listquadroname}{Lista de quadros}
\newcommand{\quadroname}{Quadro}
\newcommand{\quadrorefname}{Quadro}
\newcommand{\chartautorefname}{Quadro}

\addto\captionsenglish{% ingles
    \renewcommand{\listquadroname}{List of charts}
    \renewcommand{\quadroname}{Chart}
    \renewcommand{\quadrorefname}{Chart}
    \renewcommand{\chartautorefname}{Chart}
}

\newfloat{quadro}{htbp}{loq}[chapter]
\floatname{quadro}{\quadroname}
\floatstyle{plaintop}
\restylefloat{quadro}
\newlistof{listofquadros}{loq}{\listquadroname}
\newlistentry{quadro}{loq}{0}
\renewcommand{\thequadro}{\thechapter.\@arabic\c@quadro}
\setfloatadjustment{quadro}{\centering}

\renewcommand{\cftquadroname}{\quadroname\space}
\renewcommand*{\cftquadroaftersnum}{\hfill\textendash\hfill}

%-------------------------------------------------------------------
% cleveref — referências automáticas com nome do elemento
% Carregado APÓS hyperref (já carregado pelo abntex2) e APÓS
% a definição dos floats customizados (quadro, algoritmo)
%-------------------------------------------------------------------
\RequirePackage[brazilian,nameinlink]{cleveref}

% Registro do ambiente quadro
\crefname{quadro}{Quadro}{Quadros}
\Crefname{quadro}{Quadro}{Quadros}

% Registro do ambiente algorithm (algoritmo)
\crefname{algorithm}{Algoritmo}{Algoritmos}
\Crefname{algorithm}{Algoritmo}{Algoritmos}

% Registro de figure e table em português
\crefname{figure}{Figura}{Figuras}
\Crefname{figure}{Figura}{Figuras}
\crefname{table}{Tabela}{Tabelas}
\Crefname{table}{Tabela}{Tabelas}

% Registro de equation, chapter e section
\crefname{equation}{Equação}{Equações}
\Crefname{equation}{Equação}{Equações}
\crefname{chapter}{Capítulo}{Capítulos}
\Crefname{chapter}{Capítulo}{Capítulos}
\crefname{section}{Seção}{Seções}
\Crefname{section}{Seção}{Seções}


%===================================================================
% Criação dos Ambientes Flutuantes para Algoritmos
%===================================================================

\newcommand{\listalgoritmoname}{Lista de algoritmos}
\newcommand{\algoritmoname}{Algoritmo}
\newcommand{\algoritmorefname}{Algoritmo}
\newcommand{\algorithmautorefname}{Algoritmo}

\addto\captionsenglish{% inglês
    \renewcommand{\listalgoritmoname}{List of algorithms}
    \renewcommand{\algoritmoname}{Algorithm}
    \renewcommand{\algoritmorefname}{Algorithm}
    \renewcommand{\algorithmautorefname}{Algorithm}
}

% Altera o rotulo a ser usando no elemento pre-textual "Lista de algoritmos"
\renewcommand{\listalgorithmname}{\listalgoritmoname}%
% Altera o nome padrão do rotulo
\floatname{algorithm}{\algoritmoname}

% Configura a ``Lista de algoritmos'' conforme as regras da ABNT (para abnTeX2)
\begingroup
  \let\newcounter\@gobble\let\setcounter\@gobbletwo
  \globaldefs\@ne \let\c@loldepth\@ne
  \newlistof{algorithmt}{loa}{\listalgorithmname}
  \newlistentry{algorithmt}{loa}{0}
\endgroup

\let\oldlistofalgorithms\listofalgorithms
\newcommand{\NEWnumberline}[1]{\hspace*{-12pt}\algoritmoname~#1~~\textendash~~}%
\renewcommand{\listofalgorithms}{%
  \let\OLDnumberline\numberline%
  \let\numberline\NEWnumberline%
  \oldlistofalgorithms%
  \let\numberline\OLDnumberline%
}%

% Cria um novo ambiente "algoritmo" que inclui o ambiente "algorithm"
\newenvironment{algoritmo}[1][htb]{
  \begin{algorithm}[#1]%
}{\end{algorithm}}


%===================================================================
% Criação dos Ambientes Flutuantes para Cogidos
%===================================================================

\newcommand{\listcodigoname}{Lista de c{\'o}digos-fonte}
\newcommand{\codigoname}{C{\'o}digo-fonte}
\newcommand{\codigorefname}{C{\'o}digo-fonte}
\newcommand{\sourcecodeautorefname}{C{\'o}digo-fonte}

\addto\captionsenglish{% ingles
    \renewcommand{\listcodigoname}{List of source codes}
    \renewcommand{\codigoname}{Source code}
    \renewcommand{\codigorefname}{Source code}
    \renewcommand{\sourcecodeautorefname}{Source code}
}

% Altera o nome padrao do rotulo 
\renewcommand{\lstlistingname}{\codigoname}
% Altera o rotulo a ser usando no elemento pre-textual "Lista de codigos"
\renewcommand{\lstlistlistingname}{\listcodigoname}

% Configura a ``Lista de codigos'' conforme as regras da ABNT (para abnTeX2)
\begingroup
  \let\newcounter\@gobble\let\setcounter\@gobbletwo
  \globaldefs\@ne \let\c@loldepth\@ne
  \newlistof{listings}{lol}{\lstlistlistingname}
  \newlistentry{lstlisting}{lol}{0}
\endgroup

\renewcommand{\cftlstlistingaftersnum}{\hfill\textendash\hfill}

\let\oldlstlistoflistings\lstlistoflistings
\renewcommand{\lstlistoflistings}{%
   \begingroup%
   \let\oldnumberline\numberline%
   \renewcommand{\numberline}{\lstlistingname\space\oldnumberline}%
   \oldlstlistoflistings%
   \endgroup%
}
   
\def\lst@numbersymbol{}
\lst@Key{numbersymbol}{}{\def\lst@numbersymbol{#1}}
\lst@Key{numbers}{none}{%
    \let\lst@PlaceNumber\@empty
    \lstKV@SwitchCases{#1}%
    {%
      none&\\%
      left&\def\lst@PlaceNumber{%
        \llap{%
          \normalfont\lst@numberstyle{\thelstnumber\lst@numbersymbol}\kern\lst@numbersep%
        }%
      }\\%
        right&\def\lst@PlaceNumber{%
          \rlap{%
            \normalfont\kern\linewidth\kern\lst@numbersep\lst@numberstyle{\lst@numbersymbol\thelstnumber}%
          }%
        }%
    }%{\PackageError{Listings}{Numbers #1 unknown}\@ehc}
}

% Cria um ambiente "codigo" estilizando o ambiente "lstlisting" 
\newcounter{countcodigo}
\setcounter{countcodigo}{1}
\lstnewenvironment{codigo}[1][]
  {\lstset{basicstyle=\ttfamily\ABNTEXfontereduzida,
            numbers=left, 
            numbersep=6pt,
            numberstyle=\ABNTEXfontereduzida,
            frame=tb,
            framerule=0.8pt,
            xleftmargin=20.25pt,
            framexleftmargin=21.25pt,
            framexbottommargin=5pt,
            framextopmargin=5pt,
            abovecaptionskip=10pt,
            numbersymbol=$:$,
            #1
          }
}
{\setcounter{countcodigo}{\value{lstnumber}}}

\addto\captionsbrazil{% portugues-brasil
    \algrenewcommand\algorithmicend{\textbf{fim}}
    \algrenewcommand\algorithmicdo{\textbf{fa{\c c}a}}
    \algrenewcommand\algorithmicwhile{\textbf{enquanto}}
    \algrenewcommand\algorithmicfor{\textbf{para}}
    \algrenewcommand\algorithmicif{\textbf{se}}
    \algrenewcommand\algorithmicthen{\textbf{ent{\~a}o}}
    \algrenewcommand\algorithmicelse{\textbf{sen{\~a}o}}
    \algrenewcommand\algorithmicreturn{\textbf{retorna}}
    \algrenewcommand\algorithmicfunction{\textbf{fun{\c c}{\~a}o}}
    \algrenewcommand\algorithmicforall{\textbf{para todo}}
    \algrenewcommand\algorithmicloop{\textbf{la{\c c}o}}
    \algrenewcommand\algorithmicrepeat{\textbf{repita}}
    \algrenewcommand\algorithmicuntil{\textbf{at{\'e}}}
    \algrenewcommand\algorithmicprocedure{\textbf{procedimento}}
    \algrenewcommand\algorithmicrequire{\textbf{Requer:}}
    \algrenewcommand\algorithmicensure{\textbf{Assegure:}}
}
\addto\captionsenglish{% english
    \algrenewcommand\algorithmicend{\textbf{end}}
    \algrenewcommand\algorithmicdo{\textbf{do}}
    \algrenewcommand\algorithmicwhile{\textbf{while}}
    \algrenewcommand\algorithmicfor{\textbf{for}}
    \algrenewcommand\algorithmicif{\textbf{if}}
    \algrenewcommand\algorithmicthen{\textbf{then}}
    \algrenewcommand\algorithmicelse{\textbf{else}}
    \algrenewcommand\algorithmicreturn{\textbf{return}}
    \algrenewcommand\algorithmicfunction{\textbf{function}}
    \algrenewcommand\algorithmicforall{\textbf{for all}}
    \algrenewcommand\algorithmicloop{\textbf{loop}}
    \algrenewcommand\algorithmicrepeat{\textbf{repeat}}
    \algrenewcommand\algorithmicuntil{\textbf{until}}
    \algrenewcommand\algorithmicprocedure{\textbf{procedure}}
    \algrenewcommand\algorithmicrequire{\textbf{Require:}}
    \algrenewcommand\algorithmicensure{\textbf{Ensure:}}
}

% Rearranja os finais de cada estrutura
\algrenewtext{EndWhile}{\algorithmicend\ \algorithmicwhile}
\algrenewtext{EndFor}{\algorithmicend\ \algorithmicfor}
\algrenewtext{EndIf}{\algorithmicend\ \algorithmicif}
\algrenewtext{EndFunction}{\algorithmicend\ \algorithmicfunction}


%===================================================================
% Comando para configurar os captions no documento
%===================================================================
\renewcommand{\ABNTEXfontereduzida}{\fontsize{10}{12}\selectfont} % Legendas e fontes em 10 pt exatos (NBR 14724:2024, 5.1 — "menor e uniforme")
\DeclareCaptionFont{ABNTEXfontereduzida}{\ABNTEXfontereduzida}
% Designativo ("Figura N –") em negrito; título e fonte em 10 pt redondo — mesmo tamanho (uniforme)
\captionsetup{position=above, labelfont={ABNTEXfontereduzida,bf}, font=ABNTEXfontereduzida}

\DeclareCaptionFormat{listing}{\hrule height.8pt depth0pt #1#2#3}
% Legenda de código-fonte uniforme com figuras/tabelas: tamanho reduzido,
% sem negrito (NBR 14724:2024, 5.1 — "menor e uniforme"). Posição acima é
% definida por captionpos=t no \lstdefinestyle (thesis.tex), conforme 5.8.
\captionsetup[lstlisting]{singlelinecheck=false, margin=0pt, labelsep=endash, labelfont={ABNTEXfontereduzida,bf}, font=ABNTEXfontereduzida}
\captionsetup[algorithm]{singlelinecheck=false, margin=0pt,labelsep=endash,labelfont={ABNTEXfontereduzida,bf}, font=ABNTEXfontereduzida}


%===================================================================
% Dedicatória
%===================================================================

% Comando para definição da dedicatória
\def\textodedicatoria{\@ifstar\@textodedicatoria\@@textodedicatoria}
% Inclui texto de um arquivo como dedicatória
\def\@textodedicatoria#1{\gdef\@dedicatoria{\input{#1}}} % \textodedicatoria*{}{} 
% Inclui o texto como dedicatoria
\def\@@textodedicatoria#1{\gdef\@dedicatoria{#1}}       % \textodedicatoria{}{}

% Criacao da dedicatoria
% NBR 14724:2024 §5.2.4: dedicatória alinhada do meio da mancha gráfica até
% a margem direita, na parte inferior da página.
\newcommand{\inserededicatoria}{
    \@ifundefined{@dedicatoria}{}{
      \begin{dedicatoria}
        \vspace*{\fill}
        \hspace*{.5\textwidth}%
        \begin{minipage}{.5\textwidth}
          \raggedleft
          \textit{\@dedicatoria}
        \end{minipage}
        \vspace*{2cm}
      \end{dedicatoria}
    }
}


%===================================================================
% Agradecimentos
%===================================================================

% Comando para definição dos agradecimentos
\def\textoagradecimentos{\@ifstar\@textoagradecimentos\@@textoagradecimentos}
% Inclui texto de um arquivo como agradecimentos
\def\@textoagradecimentos#1{\gdef\@agradecimentos{\input{#1}}} % \textoagradecimentos*{}{}
% Inclui o texto como agradecimentos
\def\@@textoagradecimentos#1{\gdef\@agradecimentos{#1}} % \textoagradecimentos{}{}

% Criação dos agradecimentos
\newcommand{\insereagradecimentos}
{
  \@ifundefined{@agradecimentos}{}{
    \begin{agradecimentos}
      \@agradecimentos
    \end{agradecimentos}
  }
}


%===================================================================
% Epigrafe
%===================================================================

% Comando para definição da epigrafe
\def\textoepigrafe{\@ifstar\@textoepigrafe\@@textoepigrafe}
% Inclui texto de um arquivo como epigafe
\def\@textoepigrafe#1{\gdef\@epigrafe{\input{#1}}}      % \textoepigrafe*{}{} 
% Inclui o texto como epigafe
\def\@@textoepigrafe#1{\gdef\@epigrafe{#1}}             % \textoepigrafe{}{}
% Criacao da epigafe
% NBR 14724:2024 §5.2.4: epígrafe alinhada do meio da mancha gráfica até
% a margem direita, na parte inferior da página.
\newcommand{\insereepigrafe}
{
  \@ifundefined{@epigrafe}{}{
    \begin{epigrafe}
      \vspace*{\fill}
      \hspace*{.5\textwidth}%
      \begin{minipage}{.5\textwidth}
        \raggedleft
        \textit{\@epigrafe}
      \end{minipage}
      \vspace*{2cm}
    \end{epigrafe}
  }
}


%===================================================================
% Lista de Símbolos
%===================================================================

% Comando para inserir símbolos na lista de símbolos
\newcommand{\simbolo}[2]{
  \addcontentsline{los}{simbolo}{\ensuremath{#1} --- #2}%
}

% Apresentacao dos simbolos na lista de simbolos
\newcommand\l@simbolo[2]{\par #1}

% Criacao da lista de simbolos
\newcommand{\inserelistadesimbolos}
{
  \@ifundefined{@incluilistadesimbolos}{}{
     \pretextualchapter{\listadesimbolosname}
     {\setlength{\parindent}{0cm}
       \@starttoc{los}
     }
     \cleardoublepage
  }
}


%===================================================================
% Ficha Catalografica
%===================================================================

\newcommand{\inserefichacatalografica}
{
    \@ifundefined{@arquivofichacatalografica}{
        \PackageError{ICMC}{Some file is missing}{
            A ficha catalografica nao foi inserida!
        }
    }{
        \begin{fichacatalografica}
            % Aceita tanto um PDF (gerado pela biblioteca) quanto um .tex
            % diagramado com o modelo ABNT (esqueleto preenchivel).
            \IfEndWith{\@arquivofichacatalografica}{.tex}{%
                \input{\@arquivofichacatalografica}%
            }{%
                \includepdf{\@arquivofichacatalografica}%
            }
        \end{fichacatalografica}
    }
}

% Folha de aprovacao (versao final). Usa o ambiente folhadeaprovacao da
% abntex2; o conteudo vem de um .tex preenchivel (modelo do Apendice C).
\newcommand{\inserefolhadeaprovacao}{%
    \ifthenelse{\boolean{opt-folhadeaprovacao}}{%
        \begin{folhadeaprovacao}
            \makeatletter\input{\@arquivofolhaaprovacao}\makeatother
        \end{folhadeaprovacao}
    }{}%
}


%===================================================================
% Resumo
%===================================================================

% Comando para definição dos resumos e palavras-chave
\newcounter{numresumo}
\newcommand{\textoresumo}[3][\languagename]{
  \stepcounter{numresumo}%
  \csdef{res-language-\thenumresumo}{#1}
  \csdef{res-text-\thenumresumo}{#2}
  \csdef{res-keywords-\thenumresumo}{#3}
  \IfStrEq{#1}{\languagename}{\renewcommand{\palavraschave}{#3}}{}
}

\newcommand{\xselectlanguage}[1]{\begingroup\edef\x{\endgroup\noexpand\selectlanguage{#1}}\x}
\newenvironment{xotherlanguage}[1]{%
  \begingroup%
  \edef\temp{\endgroup\noexpand\otherlanguage{#1}}%
  \temp%
  \ignorespaces%
}{\endotherlanguage\ignorespacesafterend}

\providecommand{\imprimirlanguage}{brazil}

% Criacao do resumo e palavras chaves no documento
\newcommand{\insereresumo}
{

% Titulos do Resumo
\csdef{res-title-english}{Abstract}
\csdef{res-title-brazil}{Resumo}
\csdef{res-title-french}{R{\'e}sum{\'e}}
\csdef{res-title-spanish}{Resumen}
% Labels: Palavras-chave
\csdef{res-label-keywords-english}{Keywords}
\csdef{res-label-keywords-brazil}{Palavras-chave}
\csdef{res-label-keywords-french}{Mots-cl{\'e}s}
\csdef{res-label-keywords-spanish}{Palabras clave}

% Contador das palavras-chave
\newcounter{count}
\setcounter{count}{0}
  
  \whileboolexpr
    { test {\ifnumcomp{\value{count}}{<}{\thenumresumo}} }%
    {
        \stepcounter{count}
        
        \renewcommand{\imprimirlanguage}{\csuse{res-language-\thecount}}
        
        \if@openright\cleardoublepage\else\clearpage\fi
        \phantomsection
        \begin{resumo}[\csuse{res-title-\csuse{res-language-\thecount}}]
                % Resumo conforme NBR 6028:2021 / NBR 14724:2024 (guia UNIVALI):
                % cabecalho + paragrafo unico + palavras-chave, sem cabecalho de
                % auto-referencia bibliografica nem bloco de metadados.
                \begin{xotherlanguage}{\imprimirlanguage}
                    \csuse{res-text-\thecount}
                    
                    \vspace{\onelineskip}
                    
                    \noindent
                    \textbf{\csuse{res-label-keywords-\csuse{res-language-\thecount}}:}
                    \@tempswafalse
                        \@for\next:=\csuse{res-keywords-\thecount}\do
                        {\if@tempswa,~\else\@tempswatrue\fi\next}.
                \end{xotherlanguage}
        \end{resumo}
    }
}


%===================================================================
% Definição de comandos a serem inseridos diretamente no inicio do documento
%===================================================================

\newcommand{\inserelistadefiguras}
{
  \@ifundefined{@incluilistadefiguras}{}{
    \pdfbookmark[0]{\listfigurename}{lof}
    \listoffigures*
    \cleardoublepage
  }
}

\newcommand{\inserelistadetabelas}
{
  \@ifundefined{@incluilistadetabelas}{}{
    \pdfbookmark[0]{\listtablename}{lot}
    \listoftables*
    \cleardoublepage
  }
}

\newcommand{\inserelistadesiglas}
{
  \@ifundefined{@incluilistadesiglas}{}{
    \pdfbookmark[0]{\listadesiglasname}{listadesiglas}
    \printnomenclature
    \cleardoublepage
  }
}

\newcommand{\inserelistadequadros}
{
  \@ifundefined{@incluilistadequadros}{}{
    \pdfbookmark[0]{\listquadroname}{loq}
    \listofquadros*
    \cleardoublepage
  }
}

\newcommand{\inserelistadealgoritmos}
{
  \@ifundefined{@incluilistadealgoritmos}{}{
    \pdfbookmark[0]{\listalgoritmoname}{alg}
    \listofalgorithms
    \cleardoublepage
  }
}

\newcommand{\inserelistadecodigos}
{
  \@ifundefined{@incluilistadecodigos}{}{
    \pdfbookmark[0]{\lstlistlistingname}{lol}
    \begin{KeepFromToc}
    \lstlistoflistings
    \end{KeepFromToc}
    \cleardoublepage
  }
}


%===================================================================
% Configuração da fonte utilizada na capa exigida pelo ICMC
%===================================================================

\newcommand{\@ppgFont}[2][]{\fontsize{#2}{#2}\ifthenelse{\isempty{#1}}{}{\fontspec[Mapping = tex-text, Path = packages/fonts/]{#1}}}

\ifthenelse{\boolean{luatex} \or \boolean{xetex}}{
  % Configuracao da fonte para a compilacao por XeLaTeX ou LuaLaTeX
  \RequirePackage{fontspec}
  \ifxetex
    \RequirePackage{xltxtra}
  \fi
    \newfontfamily{\arial}[
        Ligatures=TeX, % recommended
        Mapping         = tex-text,
        Path            = packages/fonts/,
        BoldFont        = *bd,
        ItalicFont      = *i,
        BoldItalicFont  = *bi]{arial}
    
    % Fonte 12 em toda a capa/folha de rosto (NBR 14724:2024 e guia UNIVALI).
    \newcommand\@ppgTitulo{\bfseries}
    \newcommand\@ppgAutorCapa{\@ppgFont{12}}
    \newcommand\@ppgPrograma{\@ppgFont{12}}
    \newcommand\@ppgTipoTrabalho{\@ppgFont{12}}
    \newcommand\@ppgAutorFolhaRosto{\@ppgFont{12}}
    \newcommand\@ppgTituloFolhaRosto{\@ppgFont{12}\bfseries}
    \newcommand\@ppgOrientador{\@ppgFont{12}}
    \newcommand\@ppgPreambulo{\@ppgFont{12}}
    \newcommand\@ppgLocalData{\@ppgFont{12}}
    \newcommand\@ppgCarimbo{\@ppgFont{11}}
    \newcommand\@ppgSVPG{\@ppgFont{8}}
}{
    % Configuracao da fonte para a compilacao por pdfLaTeX
    \RequirePackage[T1]{fontenc}	    	% Selecao de codigos de fonte.
    % inputenc removido: UTF-8 é o padrão no LaTeX (>=2018) e carregá-lo após o
    % biblatex gerava o aviso "Load 'inputenc' before biblatex". O biblatex
    % detecta utf8 automaticamente.

    \newcommand\@ppgTitulo{\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@ppgAutorCapa{\fontsize{14pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@ppgPrograma{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@ppgTipoTrabalho{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@ppgAutorFolhaRosto{\fontsize{13pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@ppgTituloFolhaRosto{\fontsize{17pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@ppgOrientador{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@ppgPreambulo{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@ppgLocalData{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@ppgCarimbo{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@ppgSVPG{\fontsize{8pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
}


%===================================================================
% Configuracao do modelo de capa exigido pelo programa do ICMC
%===================================================================

% Configuração para reduzir tamanho do Titulo da capa automaticamente
% Comandos de fonte @icmc* usados na capa — equivalentes aos @ppg* do bloco pdfLaTeX
\newcommand\@icmcTitulo{\selectfont\usefont{T1}{phv}{b}{n}}
\newcommand\@icmcAutorCapa{\fontsize{14pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}

% Comandos @PPG* (maiúsculos) usados na folha de rosto — aliases dos @ppg* (minúsculos)
% Definidos após o bloco condicional xetex/pdftex para garantir que @ppg* já existam
\AtBeginDocument{%
  \providecommand\@PPGAutorFolhaRosto{\@ppgAutorFolhaRosto}%
  \providecommand\@PPGTituloFolhaRosto{\@ppgTituloFolhaRosto}%
  \providecommand\@PPGOrientador{\@ppgOrientador}%
  \providecommand\@PPGPreambulo{\@ppgPreambulo}%
  \providecommand\@PPGLocalData{\@ppgLocalData}%
  \providecommand\@PPGCarimbo{\@ppgCarimbo}%
}
\NewEnviron{fittext}{\def\trysize{14pt}\retry}

\def\retry{%
  \expandafter\@firstofone
  {
    \edef\trysize{\the\dimexpr\trysize-0.1pt\relax}%
    \sbox0{%
      \begin{minipage}{144mm}%
        \linespread{1.0}
        \begingroup\edef\x{
          \endgroup\noexpand\fontsize{\trysize}{\trysize}\noexpand\@icmcTitulo%
        }%
        \x\BODY
      \end{minipage}%
    }%
  }%
  \dimen0=\dimexpr\ht0+\dp0\relax
  \ifdim\dimen0>.4\textwidth
    \expandafter\retry
  \else
    \expandafter\parindent0pt\begin{minipage}[c][47mm][c]{144mm}\usebox{0}\end{minipage}
  \fi
}
  
% alterando a capa
% Formata o titulo conforme os Apendices A/B do guia UNIVALI: parte antes
% do ":" (titulo) em MAIUSCULAS; parte apos (subtitulo) na caixa do metadado.
\newcommand{\@ppgFmtTitulo}{%
  \begingroup
  \fullexpandarg
  \IfSubStr{\imprimirtitulo}{:}{%
    \StrBefore{\imprimirtitulo}{:}[\@ppgTitPrin]%
    \StrBehind{\imprimirtitulo}{:}[\@ppgTitSub]%
    \noexpandarg
    \MakeUppercase{\@ppgTitPrin}:\@ppgTitSub%
  }{%
    \noexpandarg
    \MakeUppercase{\imprimirtitulo}%
  }%
  \endgroup
}

% Posicionamento ABSOLUTO da capa/folha de rosto ancorado ao no `current page`
% do TikZ (remember picture/overlay) — a referencia mais robusta e portavel para
% posicao de pagina: ancora na geometria real do PDF, identica em qualquer motor
% (MiKTeX, TeX Live/Overleaf) e independente da titlingpage/topskip. Requer 2
% passadas de compilacao (o latexmk/Overleaf fazem isso automaticamente).
\RequirePackage{tikz}
\usetikzlibrary{calc}% para distribuir autor/titulo entre dois nos (sintaxe !frac!)
\renewcommand{\imprimircapa}{%
  \begin{capa}%
    % Posicionamento ABSOLUTO (TikZ current page): instituicao no TOPO (a 3 cm),
    % local/ano no RODAPE (~2 cm); autor e titulo IGUALMENTE DISTRIBUIDOS entre o
    % fim da instituicao e o local (autor a 1/3, titulo a 2/3 -> tres espacos
    % iguais). Margem esquerda 3 cm, largura = \textwidth.
    \begin{tikzpicture}[remember picture, overlay]
      % (1) instituicao no TOPO, topo do texto exatamente a 3 cm (no `inst`).
      % \topskip=0 + \SingleSpacing (locais ao no) zeram o espaco que o vbox
      % reserva acima da 1a linha, p/ o topo coincidir com 3 cm em qualquer motor.
      \node[anchor=north west, inner sep=0pt, text width=\textwidth, align=center] (inst)
        at ([xshift=3cm, yshift=-3cm]current page.north west) {%
          \setlength{\topskip}{0pt}\SingleSpacing
          {\@ppgPrograma\bfseries \imprimircapainstituicao\par}};
      % (4) local/ano no RODAPE, ultima linha (Ano) a ~2 cm da borda (no `local`).
      \node[anchor=south west, inner sep=0pt, text width=\textwidth, align=center] (local)
        at ([xshift=3cm, yshift=2cm]current page.south west) {%
          \begin{SingleSpace}{\@ppgLocalData \imprimirlocal\\[3pt] \@year\par}\end{SingleSpace}};
      % (2) autor a 1/3 entre o fim da instituicao (inst.south) e o local (local.north)
      \node[text width=\textwidth, align=center] at ($(inst.south)!1/3!(local.north)$) {%
          {\@ppgAutorCapa\bfseries \nohyphens{\MakeUppercase{\imprimirautor}}\par}};
      % (3) titulo a 2/3 -> autor e titulo ficam igualmente distribuidos
      \node[text width=\textwidth, align=center] at ($(inst.south)!2/3!(local.north)$) {%
          \begin{Spacing}{1.5}{\@ppgTituloFolhaRosto \nohyphens{\@ppgFmtTitulo}\par}\end{Spacing}};
    \end{tikzpicture}%
    \null% garante que a pagina da capa seja composta
  \end{capa}%
}

% folha de rosto
\newboolean{carimbo-folha-rosto}
\setboolean{carimbo-folha-rosto}{true}
\renewcommand{\folhaderostocontent}{%
  % POSICIONAMENTO ABSOLUTO (TikZ current page) — ver \imprimircapa. Apendice B:
  % autor no TOPO (a 3 cm), local/ano no RODAPE (~2 cm); titulo e nota de natureza
  % IGUALMENTE DISTRIBUIDOS entre o autor e o local (titulo a 1/3, nota a 2/3 ->
  % tres intervalos iguais), como na capa. Nota alinhada do meio da mancha a direita.
  \begin{tikzpicture}[remember picture, overlay]
    % (1) autor no TOPO, a 3 cm (no `aut`). \topskip=0 local ao no zera o espaco
    % que o vbox reserva acima do texto (ver \imprimircapa).
    \node[anchor=north west, inner sep=0pt, text width=\textwidth, align=center] (aut)
      at ([xshift=3cm, yshift=-3cm]current page.north west) {%
        \setlength{\topskip}{0pt}\SingleSpacing
        {\@ppgAutorFolhaRosto \nohyphens{\MakeUppercase{\imprimirautor}}\par}};
    % (4) local/ano no RODAPE, ~2 cm da borda (no `local`).
    \node[anchor=south west, inner sep=0pt, text width=\textwidth, align=center] (local)
      at ([xshift=3cm, yshift=2cm]current page.south west) {%
        {\@PPGLocalData \imprimirlocal\\ \@year\par}};
    % (2) titulo a 1/3 entre o autor (aut.south) e o local (local.north)
    \node[text width=\textwidth, align=center] at ($(aut.south)!1/3!(local.north)$) {%
        \begin{Spacing}{1.5}{\@PPGTituloFolhaRosto\nohyphens{\@ppgFmtTitulo}\par}\end{Spacing}};
    % (3) nota de natureza a 2/3 (do meio da mancha a direita)
    \abntex@ifnotempty{\imprimirpreambulo}{%
      \node[text width=\textwidth] at ($(aut.south)!2/3!(local.north)$) {%
        \noindent\hspace*{.43\textwidth}%
        \begin{minipage}{8.4cm}
          \begin{SingleSpace}
            {\@PPGPreambulo\imprimirpreambulo}%

            \vspace{5pt}
            {\@PPGPreambulo\arealabel: \nohyphens{\imprimirarea}}%

            \vspace{5pt}
            {\@PPGOrientador\imprimirorientadorRotulo: \titulacaoorientador{} \nohyphens{\imprimirorientador}}%
            \abntex@ifnotempty{\imprimircoorientador}{%
                \\{\@PPGOrientador\imprimircoorientadorRotulo: \titulacaocoorientador{} \nohyphens{\imprimircoorientador}}%
            }%
          \end{SingleSpace}
        \end{minipage}};
    }%
  \end{tikzpicture}%
  \null% garante que a pagina da folha de rosto seja composta
} %folha de rosto


%===================================================================
% Configuração dos Estilo dos Capitulo
%===================================================================

% Sinaliza se o capitulo atual e um apendice/anexo (para prefixar APÊNDICE/ANEXO
% no titulo). Ligado pelos ambientes apendicesenv/anexosenv (ver apos \chapterstyle).
\newif\ifppgapendice\ppgapendicefalse

\makechapterstyle{ppg}{%
  \renewcommand{\chapterheadstart}{} 
  
  % Secção secundaria (Section) Caixa baixa, Negrito
  \renewcommand*{\cftsectionfont}{\bfseries}
  % Secção terciaria (Subsection) Caixa baixa, italico (sem negrito) — Apendice
  % D do guia UNIVALI: secao terciaria no sumario aparece em italico, nao em
  % negrito. Destaque gradativo (NBR 6024): maiusc-negrito > negrito > italico.
  \renewcommand*{\cftsubsectionfont}{\itshape}
  % Secção quaternaria (Subsubsection) Caixa baixa, REDONDO (sem destaque) —
  % a terciaria ja usa italico; manter a quaternaria tambem em italico faria os
  % dois niveis colidirem. Destaque gradativo: ... > italico (1.1.1) > redondo.
  \renewcommand*{\cftsubsubsectionfont}{\normalfont}
  % Secao quinquenaria (Subsubsubsection) Caixa baixa, redondo
  \renewcommand*{\cftparagraphfont}{\normalsize}

  % tamanhos de fontes de chapter e part
  \setlength{\beforechapskip}{0pt}
  % Padroniza titulos de capitulos e secoes em Times (fonte romana/serifada do corpo)
  \renewcommand{\ABNTEXchapterfont}{\rmfamily}
  \renewcommand{\ABNTEXsectionfont}{\rmfamily}
  \renewcommand{\ABNTEXsubsectionfont}{\rmfamily}
  \renewcommand{\ABNTEXsubsubsectionfont}{\rmfamily}
  \renewcommand{\ABNTEXsubsubsubsectionfont}{\rmfamily}
  % NBR 14724:2024 (5.1): fonte tamanho 12 para todo o texto; titulos nao
  % estao entre as excecoes (que devem ser MENORES). Todos os niveis de
  % titulo ficam em 12 pt (\normalsize), diferenciados so por negrito,
  % italico e maiusculas.
  \renewcommand{\ABNTEXchapterfontsize}{\normalsize}
  \renewcommand{\ABNTEXsectionfontsize}{\normalsize}
  \renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}
  \renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}
  \renewcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize}
  \renewcommand{\chaptitlefont}{\ABNTEXchapterfont\bfseries\ABNTEXchapterfontsize}
  
  % tamanhos de fontes de section, subsection, subsubsection e subsubsubsection
  \setsecheadstyle{\ABNTEXsectionfont\ABNTEXsectionfontsize\bfseries\ABNTEXsectionupperifneeded}
  % Seção terciária em itálico SEM negrito (Apêndice D / NBR 6024 — destaque gradativo)
  \setsubsecheadstyle{\ABNTEXsubsectionfont\ABNTEXsubsectionfontsize\itshape\ABNTEXsubsectionupperifneeded}
  % Seção quaternária em REDONDO (sem itálico) para não colidir com a terciária
  \setsubsubsecheadstyle{\ABNTEXsubsubsectionfont\ABNTEXsubsubsectionfontsize\ABNTEXsubsubsectionupperifneeded}
  \setsubsubsubsecheadstyle{\ABNTEXsubsubsubsectionfont\ABNTEXsubsubsubsectionfontsize\ABNTEXsubsubsubsectionupperifneeded}
 
  % impressao do numero do capitulo
  \renewcommand{\chapternamenum}{}
  
  % impressao do nome do capitulo
  \renewcommand{\printchaptername}{}
    
  % impressao do titulo do capitulo
  % Padrao ABNT NBR 14724:2024 / guia UNIVALI, sem elementos decorativos
  % (sem caixa preta, numero gigante ou reguas): secao primaria numerada
  % alinhada a esquerda ("1 TITULO"); titulos sem indicativo numerico
  % (resumo, sumario, referencias, etc.) centralizados. Negrito, maiusculas.
  \def\printchaptertitle##1{%
    \setboolean{ABNTEXupperchapter}{true}%
    \ifthenelse{\boolean{abntex@innonumchapter}}{%
        \centering\chaptitlefont\ABNTEXchapterupperifneeded{##1}%
    }{%
        % Em apendice/anexo, prefixa o nome do capitulo ("APÊNDICE A Titulo"); em
        % capitulos normais, so "1 Titulo". \ifppgapendice e ligado pelos
        % ambientes apendicesenv/anexosenv (ver patch abaixo).
        \raggedright\chaptitlefont
        \ifppgapendice\MakeUppercase{\@chapapp}\space\fi
        \thechapter\hspace{0.5em}\ABNTEXchapterupperifneeded{##1}%
    }%
  }

  % impressao do numero do capitulo     	
  \renewcommand{\printchapternum}{%
    \setboolean{abntex@innonumchapter}{false}%
  }
  \renewcommand{\afterchapternum}{}
  
  % impressao do capitulo nao numerado
  \renewcommand\printchapternonum{%
    \setboolean{abntex@innonumchapter}{true}%
  }
}
\chapterstyle{ppg}

% Liga o prefixo APÊNDICE/ANEXO no titulo dos capitulos dentro desses ambientes
% (o titulo passa a "APÊNDICE A ..." / "ANEXO A ..."); capitulos normais ficam "1 ...".
\AtBeginEnvironment{apendicesenv}{\ppgapendicetrue}
\AtBeginEnvironment{anexosenv}{\ppgapendicetrue}


%===================================================================
% Configurações diversas
%===================================================================

% informacoes do PDF
\hypersetup{
        unicode=true, % Codificacao dos caracteres especiais no Bookmark
		pdftitle={\@title}, 
		pdfauthor={\@author},
    	pdfsubject={\imprimirpreambulo},
	    pdfcreator={LaTeX with abnTeX2/IoTec -Univali (v1.0)},
		pdfkeywords={\palavraschave}, 
		%colorlinks={\colorlinks},   % colored links
    	linkcolor=blue,          	% color of internal links
    	citecolor=blue,        		% color of links to bibliography
    	filecolor=magenta,      	% color of file links
		urlcolor=blue,
		bookmarksdepth=4
}

% Define as cores basicas utilizadas no documento
\definecolor{blue}{RGB}{41,5,195}
\definecolor{white}{RGB}{255,255,255}
\definecolor{black}{RGB}{0,0,0}
\definecolor{blue-capa}{RGB}{16,62,93}

% Corrige warning gerado pelo uso do comando \uppercase
\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{%v
    \renewcommand{\bibsection}{%
        \chapter*{\bibname}
        \bibmark
        \ifnobibintoc\else
        \phantomsection
        \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{\bibname}}{\bibname}}
        \fi
        \prebibhook
    }
}{}

% Niveis de subsecoes
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}

% Ajusta o espacamento dos paragrafos do resumo
\setlength{\absparsep}{18pt}

% O tamanho do paragrafo e dado por:
\setlength{\parindent}{1.3cm}

% Controle do espacamento entre um paragrafo e outro:
\setlength{\parskip}{0.2cm}  % tente tambem \onelineskip

% Pasta padrao para as imagens
\graphicspath{{imagens/}{images/}}

% Nome do local (cidade) impresso na capa e na folha de rosto.
% Redefina no preâmbulo (thesis.tex) com \local{Sua Cidade}.
\local{Itaja\'i}

% Curso padrão (PPGC) aplicado apenas como FALLBACK: se o usuário não chamar
% \curso{} no preâmbulo. Assim, \area/\especialidade definidos manualmente
% (OPÇÃO B: TCC/monografia/outros cursos) não são sobrescritos pelos do PPGCA.
\RequirePackage{etoolbox}
\AtEndPreamble{\if@ppgCursoSet\else\curso{PPGC}\fi}

% Indice remissivo
\makeindex


%===================================================================
% Configuracoes para definir idioma principal do documento
%===================================================================

\def\HyLang@DeclareLang#1#2#3{%
    \expandafter\HyLang@addto
        \csname extras#1\expandafter\endcsname
        \csname HyLang@#2\endcsname
    \begingroup
      \edef\x{\endgroup
        #3%
      }%
    \x
    \@namedef{HyLang@#1@done}{}%
  \begingroup
    \edef\x##1##2{%
      \noexpand\ifx##2\relax
        \errmessage{No definitions for language #2' found!}%
      \noexpand\fi
      \endgroup
      \noexpand\define@key{Hyp}{#1}[]{%
        \noexpand\@ifundefined{HyLang@#1@done}{%
          \noexpand\HyLang@addto{\noexpand##1}{\noexpand##2}%
          #3%
          \noexpand\@namedef{HyLang@#1@done}{}%
        }{}%
      }%
    }%
  \expandafter\x\csname extras#1\expandafter\endcsname
                \csname HyLang@#2\endcsname
}
% repeat the known language declarations
\HyLang@DeclareLang{english}{english}{}
\HyLang@DeclareLang{brazil}{portuges}{}
\HyLang@DeclareLang{spanish}{spanish}{}

\addto\extrasenglish{%
  \def\chapterautorefname{Chapter}%
}


%===================================================================
% Configuracoes ao iniciar documento
%===================================================================
\AtBeginDocument{

    % Altera o idioma principal caso o documento seja redigido em ingles
    \IfStrEq{\imprimiridioma}{EN}{
        \selectlanguage{english}
        % bibliographystyle removido: biblatex-abnt não usa .bst
    }{}
    
    % Centraliza o caption das tabelas do IBGE, conforme recomendacao
    \renewcommand{\configurecaptions}{\captionstyle[singlelinecheck=on]{}}
    
    % suporte a alguns sequencias comuns do LaTeX, como -- para travessão
    \ifxetex
        \defaultfontfeatures{Mapping=tex-text}
        % Corpo em Times New Roman, empacotado em packages/fonts/ (como o Arial),
        % carregado via fontspec para ser portátil (Overleaf e MiKTeX).
        \setmainfont[Path=packages/fonts/, Ligatures=TeX,
            BoldFont=*bd, ItalicFont=*i, BoldItalicFont=*bi]{times}
    \else
        \ifluatex
            \defaultfontfeatures{Mapping=tex-text}
            \setmainfont[Path=packages/fonts/, Ligatures=TeX,
                BoldFont=*bd, ItalicFont=*i, BoldItalicFont=*bi]{times}
        \fi
    \fi
    
    \pretextual
    
    % Capa
    \ifthenelse{\boolean{opt-impressao}}{}{
        \imprimircapa
    }

    % Folha de rosto e Ficha catalografica (se houver)
    \ifthenelse{\boolean{opt-fichacatalografica}}{
        % (o * indica que havera a ficha bibliografica)
        \imprimirfolhaderosto*{}
		\inserefichacatalografica
		\newpage
    }{
        \imprimirfolhaderosto{}
    }

    % Folha de rosto unica, no idioma do documento (NBR 14724:2024 / guia
    % UNIVALI). O resumo/abstract bilingue cobre a exigencia de lingua
    % estrangeira, dispensando uma segunda folha de rosto em ingles.

    % Folha de aprovacao (versao final; ausente na qualificacao)
    \inserefolhadeaprovacao

    % DEDICATORIA / AGRADECIMENTO / EPIGRAFE
    \inserededicatoria
    \insereagradecimentos
    \insereepigrafe

    % RESUMOS
    \insereresumo

    % Insere as Listas que forem setadas no documento
    \inserelistadefiguras
    \inserelistadequadros    
    \inserelistadealgoritmos
    \inserelistadecodigos
    \inserelistadetabelas
    \inserelistadesiglas
    \inserelistadesimbolos

	\pdfbookmark[0]{\contentsname}{toc}
    \tableofcontents*
    \cleardoublepage
    
    % Configuracao dos caracteres especiais utilizados no pacote <listings>
    \lstset{%
        frame=top,
        frame=bottom,
        breakatwhitespace=false,         
        breaklines=true,                 
        keepspaces=true,                 
        numbers=left,                    
        numbersep=5pt,                  
        showspaces=false,                
        showstringspaces=false,
        showtabs=false,                  
        tabsize=2,
        inputencoding=utf8,
        extendedchars=true,
        literate=%
        {é}{{\'{e}}}1
        {è}{{\`{e}}}1
        {ê}{{\^{e}}}1
        {ë}{{\¨{e}}}1
        {É}{{\'{E}}}1
        {Ê}{{\^{E}}}1
        {û}{{\^{u}}}1
        {ù}{{\`{u}}}1
        {â}{{\^{a}}}1
        {à}{{\`{a}}}1
        {á}{{\'{a}}}1
        {ã}{{\~{a}}}1
        {Á}{{\'{A}}}1
        {Â}{{\^{A}}}1
        {Ã}{{\~{A}}}1
        {ç}{{\c{c}}}1
        {Ç}{{\c{C}}}1
        {õ}{{\~{o}}}1
        {ó}{{\'{o}}}1
        {ô}{{\^{o}}}1
        {Õ}{{\~{O}}}1
        {Ó}{{\'{O}}}1
        {Ô}{{\^{O}}}1
        {î}{{\^{i}}}1
        {Î}{{\^{I}}}1
        {í}{{\'{i}}}1
        {Í}{{\'{I}}}1
        {Ú}{{\'U}}1
        {ú}{{\'u}}1
        {Ü}{{\"U}}1
        {ü}{{\"u}}1
    }
    
    % Numeracao continua do elementos do presentes no documento
    \counterwithout{quadro}{chapter}
    \counterwithout{lstlisting}{chapter}
    
    \mainmatter

    % Retira espaco extra obsoleto entre as frases.
    \frenchspacing
}


% Sem contracapa decorativa: o guia UNIVALI 2025 e a NBR 14724:2024 nao
% preveem pagina final com logo/identificacao da instituicao.

% ---
% Finaliza comandos com @ no nome
\makeatother

% listings e xcolor já carregados no preâmbulo da classe (não recarregar).
%New colors defined below
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

%Code listing style named "mystyle"
\lstdefinestyle{mystyle}{
  backgroundcolor=\color{backcolour}, commentstyle=\color{codegreen},
  keywordstyle=\color{magenta},
  numberstyle=\tiny\color{codegray},
  stringstyle=\color{codepurple},
  basicstyle=\ttfamily\footnotesize,
  breakatwhitespace=false,         
  breaklines=true,                 
  captionpos=b,                    
  keepspaces=true,                 
  numbers=left,                    
  numbersep=5pt,                  
  showspaces=false,                
  showstringspaces=false,
  showtabs=false,                  
  tabsize=2
}

\lstset{
    language=Matlab,
    breaklines=true,
    basicstyle=\ttfamily,
    numbers=left,
    numberstyle=\tiny\color{gray},
    stepnumber=1,
    numbersep=5pt,
    backgroundcolor=\color{white},
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    frame=single,
    rulecolor=\color{black},
    tabsize=2,
    captionpos=b,
    breakatwhitespace=false,
    keywordstyle=\color{blue},
    commentstyle=\color{green},
    stringstyle=\color{magenta}
}