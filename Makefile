BUILDDIR = gen

all: $(BUILDDIR)/rc_model.btor

$(BUILDDIR)/%.btor: synthesize_%.ys %.sv
	mkdir -p $(@D)
	yosys $<

%_model.sv: generate_%_model.py Makefile
	python $< > $@

synthesize_%.ys: make_synthesis_script.sh Makefile
	sh $< $*.sv $* $(BUILDDIR)/$*.btor > $@

clean:
	rm -rf $(BUILDDIR)

cleanall:
	rm -rf *_model.sv

.PHONY: all clean

.NOTINTERMEDIATE:
