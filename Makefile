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
HEATPUMP_ASM = $(TARGET)heatpump.hba
HEATPUMP_BIN = $(TARGET)heatpump.hbx
WASHINGMACHINE_ASM = $(TARGET)washingmachine.hba
WASHINGMACHINE_BIN = $(TARGET)washingmachine.hbx
LAMP_ASM = $(TARGET)lamp.hba
LAMP_BIN = $(TARGET)lamp.hbx

all: compile png assemble

compile: $(BUILDDIR) 
	cd $(BUILDDIR) && $(HBC) $(HBC_FILE) -o $(ASM_PREFIX) -d $(DATATYPEDEF)

graph: $(BUILDDIR) 
	cd $(BUILDDIR) && $(HBC) $(HBC_FILE) -g $(DOT_FILE)

png: $(BUILDDIR) graph
	cd $(BUILDDIR) && dot -Tpng main.dot -o main.png

assemble: $(BUILDDIR) compile
	cd $(BUILDDIR) && $(HBA) -i $(HEATPUMP_ASM) -o $(HEATPUMP_BIN) -d $(DATATYPEDEF)
	cd $(BUILDDIR) && $(HBA) -i $(WASHINGMACHINE_ASM) -o $(WASHINGMACHINE_BIN) -d $(DATATYPEDEF)
	cd $(BUILDDIR) && $(HBA) -i $(LAMP_ASM) -o $(LAMP_BIN) -d $(DATATYPEDEF)

upload: $(BUILDDIR) assemble
	#cd $(BUILDDIR) && $(HBU) -r 10 -p $(HEATPUMP_BIN)
	#cd $(BUILDDIR) && $(HBU) -r 10 -p $(WASHINGMACHINE_BIN)
	cd $(BUILDDIR) && $(HBU) -r 10 -p $(LAMP_BIN)

$(BUILDDIR):
	@-mkdir $(BUILDDIR)

clean:
	@cd $(BUILDDIR) && rm -rf *

distclean:
	@rm -rf $(BUILDDIR)

.PHONY: clean distclean
