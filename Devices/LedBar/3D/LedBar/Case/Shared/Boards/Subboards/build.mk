Case/Shared/Boards/Subboards/SubboardsKicadPcb.inc: $(KICAD_PCB_TO_SCAD_PY) $(SUBBOARDS_KICAD_PCB)
	$(PYTHON) $(KICAD_PCB_TO_SCAD_PY) $(SUBBOARDS_KICAD_PCB) $@ Subboards

all: Case/Shared/Boards/Subboards/SubboardsKicadPcb.inc
