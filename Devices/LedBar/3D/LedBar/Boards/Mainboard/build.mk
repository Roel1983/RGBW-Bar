Boards/Mainboard/MainboardKicadPcb.inc: $(KICAD_PCB_TO_SCAD_PY) $(MAINBOARD_KICAD_PCB)
	$(PYTHON) $(KICAD_PCB_TO_SCAD_PY) $(MAINBOARD_KICAD_PCB) $@ Mainboard
