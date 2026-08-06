# Configuração do latexmk para este template.
# Com este arquivo, um único `latexmk thesis.tex` resolve TODAS as etapas:
# XeLaTeX, biber, a lista de abreviaturas e siglas e o glossário. Também é lido
# pelo Overleaf.

# XeLaTeX (1 = pdflatex, 4 = lualatex, 5 = xelatex) — a classe carrega as TTF
# de packages/fonts/ via fontspec, que não funciona sob pdfLaTeX.
$pdf_mode = 5;

# Bibliografia com biber (NÃO bibtex — os .bst em packages/ são legado).
$bibtex_use = 2;
$biber = 'biber %O %S';

# Listas do pacote glossaries, ambas geradas por makeglossaries:
#   .acn -> .acr  = lista de abreviaturas e siglas (pré-textual)
#   .glo -> .gls  = glossário (pós-textual, só se o autor usar \newword)
# As duas regras são necessárias: o latexmk dispara pela extensão que mudou, e
# um trabalho sem glossário nunca mexe no .glo.
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
sub run_makeglossaries {
    return system("makeglossaries \"$_[0]\"");
}

# Fallback para documentos que ainda usem o pacote nomencl DIRETAMENTE (a
# classe não usa mais: \nomenclature agora alimenta o glossaries). Sem .nlo no
# projeto, esta regra simplesmente nunca dispara.
add_cus_dep('nlo', 'nls', 0, 'run_makenomenclature');
sub run_makenomenclature {
    return system("makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"");
}

# Arquivos gerados, para que `latexmk -c` os remova.
push @generated_exts, 'nlo', 'nls', 'glo', 'gls', 'glg', 'acn', 'acr', 'alg',
                      'glsdefs', 'ilg', 'ist', 'loa', 'lol', 'loq', 'mw';
