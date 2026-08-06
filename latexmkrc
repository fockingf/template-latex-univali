# Configuração do latexmk para este template.
# Com este arquivo, um único `latexmk thesis.tex` resolve TODAS as etapas:
# XeLaTeX, biber, a lista de abreviaturas e siglas (nomencl) e o glossário
# (glossaries). Também é lido pelo Overleaf.

# XeLaTeX (1 = pdflatex, 4 = lualatex, 5 = xelatex) — a classe carrega as TTF
# de packages/fonts/ via fontspec, que não funciona sob pdfLaTeX.
$pdf_mode = 5;

# Bibliografia com biber (NÃO bibtex — os .bst em packages/ são legado).
$bibtex_use = 2;
$biber = 'biber %O %S';

# Lista de abreviaturas e siglas (pacote nomencl): thesis.nlo -> thesis.nls.
# É makeindex com o estilo nomencl.ist, e NÃO makeglossaries. Sem esta etapa
# \printnomenclature não imprime nada — nem o título — e a lista desaparece
# silenciosamente do PDF.
add_cus_dep('nlo', 'nls', 0, 'run_makenomenclature');
sub run_makenomenclature {
    return system("makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"");
}

# Glossário pós-textual (pacote glossaries): thesis.glo -> thesis.gls.
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
sub run_makeglossaries {
    return system("makeglossaries \"$_[0]\"");
}

# Arquivos gerados, para que `latexmk -c` os remova.
push @generated_exts, 'nlo', 'nls', 'glo', 'gls', 'glg', 'ilg', 'ist',
                      'loa', 'lol', 'loq', 'mw';
