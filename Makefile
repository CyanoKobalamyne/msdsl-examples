all: rc_model.btor

%.btor: synthesize_%.ys %.sv
	yosys $<

%.sv: generate_%.py
	python $< > $@

clean:
	rm -rf *.btor rc_model.sv

.PHONY: all clean
