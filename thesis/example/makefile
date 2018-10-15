.PHONY: all install uninstall clean
.DEFAULT_GOAL := all

# To specify the location of pdflatex edit the macro below or use
# make $(target) TEX=$(path_to_pdflatex)
TEX = pdflatex

all:
	$(TEX) *.tex
	@echo; echo "Example built!"

install:
	$(MAKE) all

clean:
	@echo $(TEX)
	$(RM) *.aux *.bbl *.bcf *.blg *.glg *.glo *.gls *.ist *.log *.out *.pdf *.run.xml *.synctex.gz *.toc
	@echo; echo "Example cleaned!"

uninstall:
	$(MAKE) clean
