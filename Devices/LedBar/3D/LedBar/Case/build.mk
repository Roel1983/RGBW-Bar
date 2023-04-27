include $(wildcard Case/*/build.mk)

Case/MainboardKicadPcb.inc: $(KICAD_PCB_TO_SCAD_PY) $(MAINBOARD_KICAD_PCB)
	$(PYTHON) $(KICAD_PCB_TO_SCAD_PY) $(MAINBOARD_KICAD_PCB) $@
