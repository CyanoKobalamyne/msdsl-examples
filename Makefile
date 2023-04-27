BUILDDIR = gen

all: $(BUILDDIR)/rc_model.btor

$(BUILDDIR)/%.btor: $(BUILDDIR)/synthesize_%.ys %.sv
	mkdir -p $(@D)
	yosys $<

%_model.sv: generate_%_model.py
	python $< > $@

$(BUILDDIR)/synthesize_%.ys: make_synthesis_script.sh
	mkdir -p $(@D)
	sh $< $*.sv $* $(BUILDDIR)/$*.btor > $@

clean:
	rm -rf $(BUILDDIR)

cleanall:
	rm -rf *_model.sv

.PHONY: all clean

.NOTINTERMEDIATE:
