BUILDDIR = build
HBC := hbcomp
HBA := hbasm
HBU := hexaupload

TARGET = main

HBC_FILE = ../src/$(TARGET).hbc
DOT_FILE = $(TARGET).dot
ASM_PREFIX = $(TARGET)
DATATYPEDEF = datatypes.hbh

# TODO: Develop an automatic dependency generation for this.
PLUG1_ASM = mainlamp_a.hba
PLUG1_BIN = mainlamp_a.hbx

all: compile png assemble

compile: $(BUILDDIR) 
	cd $(BUILDDIR) && $(HBC) $(HBC_FILE) -o $(ASM_PREFIX) -d $(DATATYPEDEF)

graph: $(BUILDDIR) 
	cd $(BUILDDIR) && $(HBC) $(HBC_FILE) -g $(DOT_FILE)

png: $(BUILDDIR) graph
	cd $(BUILDDIR) && dot -Tpng main.dot -o main.png

assemble: $(BUILDDIR) compile
	cd $(BUILDDIR) && $(HBA) -i $(PLUG1_ASM) -o $(PLUG1_BIN) -d $(DATATYPEDEF)

upload: $(BUILDDIR) assemble
	cd $(BUILDDIR) && $(HBU) -p $(PLUG1_BIN)

$(BUILDDIR):
	@-mkdir $(BUILDDIR)

clean:
	@cd $(BUILDDIR) && rm -rf *

distclean:
	@rm -rf $(BUILDDIR)

.PHONY: clean distclean
