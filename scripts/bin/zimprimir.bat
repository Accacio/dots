@echo off
set id=zimprimir.tex
if exist %id% (
    del %id%
)

(
echo ^\documentclass^[numbers,a5paper,12pt^]{article}
echo ^\usepackage^{amsmath,amssymb^}
echo \usepackage[utf8]{inputenc}
echo \usepackage{hyperref}
echo ^\usepackage^[brazil^]^{babel^}
echo ^\usepackage^{graphicx^}

echo ^\usepackage^{algorithmic^}

echo \usepackage{algorithm}
 
echo \usepackage{float} 
echo \usepackage{color} 
echo \usepackage{epstopdf} 
echo \usepackage{epsfig} 
echo \usepackage{pdfpages}
 
echo \usepackage{hypcap}
 
echo \usepackage{pdflscape}
echo \usepackage{geometry} 
echo \begin{document}
) >>%id%

FOR %%f in (.\*.pdf .\*.png .\*.jpg) DO (

echo \phantomsection \addcontentsline{toc}{section}{%%~nf} \includepdf[pages=-]{./%%~nxf}
echo.)>>%id%


(
echo \end{document}
)>>%id%


pdflatex.exe -synctex=1 -interaction=nonstopmode %id%

FOR %%f in (*.pdf *.JPG *.JPEG *.bat) DO (attrib +R %%f 2>nul)

del /q *.* 2>nul

FOR %%f in (*.pdf *.JPG *.JPEG *.bat) DO (attrib -R %%f 2>nul)