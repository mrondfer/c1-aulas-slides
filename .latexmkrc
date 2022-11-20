# Output a pdf
# 1: pdflatex, as specified by $pdflatex variable (still largely in use)
# 2: postscript conversion, as specified by the $ps2pdf variable (useless)
# 3: dvi conversion, as specified by the $dvipdf variable (useless)
# 4: lualatex, as specified by the $lualatex variable (best)
# 5: xelatex, as specified by the $xelatex variable (second best)
$pdf_mode = 4;

# Show used CPU time. Looks like: https://tex.stackexchange.com/a/312224/120853
$show_time = 1;

$max_repeat=7;

set_tex_cmds("--shell-escape --synctex=1 --interaction=nonstopmode  %O %S");

# option 2 is same as 1 (run biber when necessary), but also deletes the
# regeneratable bbl-file in a clenaup (`latexmk -c`). Do not use if original
# bib file is not available!
$bibtex_use = 2;  # default: 1

# Change default `biber` call, help catch errors faster/clearer. See
# https://web.archive.org/web/20200526101657/https://www.semipol.de/2018/06/12/latex-best-practices.html#database-entries
$biber = "biber --validate-datamodel %O %S";

# By default compile only the file called 'main.tex'
@default_files = ('main.tex');

$cleanup_includes_cusdep_generated = 1;

$clean_ext = "synctex.gz %R-blx.bib run.xml snm nav pyg ist xdy fls glg glo log out";

# Convert .tex files to .pdf
add_cus_dep('tikz', 'pdf', 0, 'tikz2pdf');
sub tikz2pdf {
    rdb_add_generated( "$_[0].aux","$_[0].fdb_latexmk","$_[0].log", "$_[0].synctex.gz", "$_[0].fls" );
    system("lualatex --interaction=nonstopmode -outdir=./ -jobname=$_[0] $_[0].tikz");
    # system("latexmk -pdf -cd -quiet $_[0].tikz");
}