all: rc_model.btor

%.btor: synthesize_%.ys %.sv
	yosys $<

%.sv: generate_%.py
	python $< > $@

synthesize_%.ys: make_synthesis_script.sh
	sh $< $* > $@

clean:
	rm -rf *.btor rc_model.sv

.PHONY: all clean

.NOTINTERMEDIATE:
