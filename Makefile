BUILDDIR = gen
MODEL_SCRIPTS = $(wildcard generate_*_model.py)
MODEL_SOURCES = $(patsubst generate_%.py,%.sv,$(MODEL_SCRIPTS))
WRAPPER_SOURCES = $(wildcard *_wrapper.sv)
BTOR_FILES = $(patsubst %.sv,$(BUILDDIR)/%.btor,$(WRAPPER_SOURCES))
TESTBENCH_SOURCES = $(wildcard *_testbench.sv)
TESTBENCH_BINARIES = $(patsubst %.sv,$(BUILDDIR)/%.vvp,$(TESTBENCH_SOURCES))
TESTBENCH_OUTPUTS = $(patsubst %.vvp,%.vcd,$(TESTBENCH_BINARIES))
LIB_SOURCES = $(wildcard lib/*.sv)

all: $(BTOR_FILES) $(TESTBENCH_OUTPUTS)

%.vcd: %.vvp
	./$<

$(BUILDDIR)/%.vvp: %.sv $(LIB_SOURCES)
	iverilog -g2005-sv -Ilib -D'DUMP_FILE_PATH="$(BUILDDIR)/$*.vcd"' -s $* -o $@ $<

$(BUILDDIR)/%.btor: $(BUILDDIR)/synthesize_%.ys %.sv $(MODEL_SOURCES) $(LIB_SOURCES)
	mkdir -p $(@D)
	yosys $<

%_model.sv: generate_%_model.py
	python $< > $@

$(BUILDDIR)/synthesize_%.ys: make_synthesis_script.sh
	mkdir -p $(@D)
	sh $< $*.sv $* $(BUILDDIR)/$*.btor > $@

clean:
	rm -rf $(BUILDDIR)

cleanall: clean
	rm -rf *_model.sv

.PHONY: all clean

.NOTINTERMEDIATE:
