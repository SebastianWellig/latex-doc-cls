.PHONY: all install uninstall clean view
.DEFAULT_GOAL := all

OBJECTS = example.pdf

# To specify the location of pdflatex edit the macro below or use
# make $(target) TEX=$(path_to_pdflatex)
TEX = pdflatex
PDF = AcroRd32

all: $(OBJECTS)
	$(MAKE) view
	@echo; echo "Example built!"

# install:
# 	@echo "install not implemented"

view: $(OBJECTS)
	$(PDF) $(OBJECTS)&

%.pdf: %.tex
	$(TEX) $<

clean:
	@echo $(TEX)
	$(RM) *.aux *.bbl *.bcf *.blg *.glg *.glo *.gls *.ist *.log *.out *.run.xml *.synctex.gz *.toc
	$(RM) $(OBJECTS)
	@echo; echo "Example cleaned!"

# uninstall:
# 	@echo "uninstall not implemented"