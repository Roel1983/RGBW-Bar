ifneq (, $(shell which python3))
PYTHON               ?= python3
else ifneq (, $(shell which python2))
PYTHON               ?= python2
else
PYTHON               ?= python
endif
KICAD_PCB_TO_SCAD_PY  = ../../../Shared/3D/kicad_pcb_to_scad.py
MAINBOARD_KICAD_PCB   = ../../PCB/Mainboard/Mainboard.kicad_pcb
SUBBOARDS_KICAD_PCB   = ../../PCB/Subboards/Subboards.kicad_pcb

IMAGES  = LedBar
OPENSCAD_ADDITION_ARGS = --imgsize 1920,1080

.PHONY: all
all:

include build.mk

include ../../../Shared/3D/build.mk

LedBar.png: $(IMAGESDIR)/LedBar.png
	cp $(IMAGESDIR)/LedBar.png LedBar.png
all: Case.png

Case.png: $(IMAGESDIR)/Case/Case.png
	cp $(IMAGESDIR)/Case/Case.png Case.png
all: Case.png

