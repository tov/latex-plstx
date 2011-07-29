PDFLATEX	= pdflatex
LATEX		= latex
MAKEINDEX	= makeindex

PKG		= plstx

all: $(PKG).sty $(PKG).pdf

$(PKG).pdf: $(PKG).sty $(PKG).ind $(PKG).gls

%.sty:	%.ins %.dtx
	$(RM) $@ listproc.sty
	$(LATEX) $<

%.pdf:	%.dtx
	$(LATEX) $<
	$(PDFLATEX) $<

%.idx %.glo:	%.dtx %.sty
	$(LATEX) $<

%.ind:	%.idx
	$(MAKEINDEX) -s gind.ist $<

%.gls:	%.glo
	$(MAKEINDEX) -s gglo.ist -o $@ $<


CLEAN = $(PKG).ind $(PKG).idx \
	$(PKG).gls $(PKG).glo $(PKG).aux $(PKG).log \
	$(PKG).out $(PKG).dvi $(PKG).ilg $(PKG).hd \
	$(PKG).toc

VCLEAN = $(CLEAN) $(PKG).pdf $(PKG).sty listproc.sty

clean:
	$(RM) $(CLEAN)

vclean:
	$(RM) $(VCLEAN)
