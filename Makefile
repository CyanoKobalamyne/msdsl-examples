BUILDDIR = gen

all: $(BUILDDIR)/rc_model.btor

$(BUILDDIR)/%.btor: synthesize_%.ys %.sv
	mkdir -p $(@D)
	yosys $<

%.sv: generate_%.py Makefile
	python $< > $@

synthesize_%.ys: make_synthesis_script.sh Makefile
	sh $< $*.sv $* $(BUILDDIR)/$*.btor > $@

clean:
	rm -rf $(BUILDDIR) rc_model.sv

.PHONY: all clean

.NOTINTERMEDIATE:
