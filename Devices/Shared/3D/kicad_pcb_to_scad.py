#!/usr/bin/python

import sys, argparse, re

exit_code = None

argParser = argparse.ArgumentParser(
	description = 'Reads a kicad PCB file and outputs the location and rotation of to an openscad file',
	epilog      = 'Create by: Roel Drost')
argParser.add_argument("inputfile",      help="The kicad PCB input file")
argParser.add_argument("outputfile",     help="The openSCAD output file")

args = argParser.parse_args()

with open(args.inputfile, 'r') as pcb_file:
	is_general_section = False;
	components = []
	aux_axis_origin = [0.0, 0.0]
	pcb_bounds = None
	pcb_thickness = None
	
	for line in pcb_file.readlines():

		# Board thickness
		if is_general_section:
			if re.match("^[ ]*[(]general", line):
				is_general_section = True
		else:
			m = re.match("^[ ]*[(]thickness (\d+(?:.\d+)?)[)].*$", line)
			if m:
				pcb_thickness = float(m.group(1))
			if re.match("^[ ]*[)].*$", line):
				is_general_section = False
		
		# Components
		m = re.match("^[ ]*[(]module ([^:]+:[^ ]+)(?: locked)? [(]layer ([FB]).Cu[)].*$", line)
		if m:
			components.append({
				"foot_print": m.group(1),
				"side"      : m.group(2)})

		m = re.match("^[ ]*[(]at (\d+(?:.\d+)?) (\d+(?:.\d+)?)(?: (\d+(?:.\d+)?))?.*", line)
		if m:
			components[-1]["at"] = (
				float(m.group(1)),
				float(m.group(2)),
				float(m.group(3) if m.group(3) else 0))

		m = re.match("^[ ]*[(]fp_text reference ([^ ]+) .*$", line)
		if m:
			components[-1]["reference"] = m.group(1)

		m = re.match("^[ ]*[(]aux_axis_origin (\d+(?:.\d+)?) (\d+(?:.\d+)?)[)].*$", line)
		if m:
			aux_axis_origin = [float(m.group(1)), float(m.group(2))]

		# Bounding box
		m = re.match("^[ ]*[(]gr_line [(]start (\d+(?:.\d+)?) (\d+(?:.\d+)?)[)] [(]end (\d+(?:.\d+)?) (\d+(?:.\d+)?)[)] [(]layer Edge.Cuts[)].*[)]$", line)
		if m:
			start_x = float(m.group(1))
			start_y = float(m.group(2))
			end_x   = float(m.group(3))
			end_y   = float(m.group(4))
			if pcb_bounds:
				pcb_bounds[0][0] = min(pcb_bounds[0][0], start_x, end_x)
				pcb_bounds[0][1] = max(pcb_bounds[0][1], start_x, end_x)
				pcb_bounds[1][0] = min(pcb_bounds[1][0], start_y, end_y)
				pcb_bounds[1][1] = max(pcb_bounds[1][1], start_y, end_y)
			else:
				pcb_bounds = [
					[min(start_x, end_x), max(start_x, end_x)],
					[min(start_y, end_y), max(start_y, end_y)]]

components.sort(key=lambda component: component["reference"])

component_var_name_prefix = "COMPONENT_"

with open(args.outputfile, 'w') as scad_file:
	scad_file.write("// DO NOT EDIT THIS FILE\n".format(sys.argv[0]))
	scad_file.write("// This file is generated by: {}\n".format(sys.argv[0]))
	scad_file.write("// Input file: {}\n".format(args.inputfile))
	scad_file.write("\n")
	scad_file.write("// Getter functions\n")
	scad_file.write("function ref_id(ref)  = ref[0];\n")
	scad_file.write("function ref_nr(ref)  = ref[1];\n")
	scad_file.write("function ref_str(ref) = str(ref_id(ref), ref_nr(ref));\n")
	scad_file.write("\n")
	scad_file.write("function at_side(at)  = at[0];\n")
	scad_file.write("function at_loc(at)   = at[1];\n")
	scad_file.write("function at_rot(at)   = at[2];\n")
	scad_file.write("\n")
	scad_file.write("function component_ref      (component) = component[0];\n")
	scad_file.write("function component_ref_id   (component) = ref_id (component_ref(component));\n")
	scad_file.write("function component_ref_nr   (component) = ref_nr (component_ref(component));\n")
	scad_file.write("function component_ref_str  (component) = ref_str(component_ref(component));\n")
	scad_file.write("function component_at       (component) = component[1];\n")
	scad_file.write("function component_at_side  (component) = at_side(component_at(component));\n")
	scad_file.write("function component_at_loc   (component) = at_loc (component_at(component));\n")
	scad_file.write("function component_at_rot   (component) = at_rot (component_at(component));\n")
	scad_file.write("function component_footprint(component) = component[2];\n")
	scad_file.write("\n")

	scad_file.write("// Board size\n")
	if pcb_thickness:
		scad_file.write("PCB_THICKNESS = {};\n".format(pcb_thickness))
	else:
		print("Error: No PCB_THICKNESS detected");
		exit_code = 1;
	if pcb_bounds:
		scad_file.write("PCB_BOUNDS = [[{}, {}], [{}, {}]];\n".format(
			pcb_bounds[0][0] - aux_axis_origin[0],
			pcb_bounds[0][1] - aux_axis_origin[0],
			aux_axis_origin[1] - pcb_bounds[1][1],
			aux_axis_origin[1] - pcb_bounds[1][0]))
	else:
		print("Error: No PCB_BOUNDS detected");
		exit_code = 2;
	scad_file.write("\n")

	scad_file.write("// Components\n")
	for component in components:
		scad_file.write('{} = [\n'.format(component_var_name_prefix + component["reference"]))
		scad_file.write('\t["{}", {}],\n'.format(
			re.match("(.*?)(\d+)", component["reference"]).group(1),
			re.match("(.*?)(\d+)", component["reference"]).group(2)))
		scad_file.write('\t["{}", [{}, {}], {}],\n'.format(
			component["side"],
			component["at"][0] - aux_axis_origin[0],
			aux_axis_origin[1] - component["at"][1],
			component["at"][2]))
		scad_file.write('\t"{}"];\n'.format(component["foot_print"]))
		scad_file.write('\n')
	if len(components) == 0:
		print("Error: No components detected");
		exit_code = 3;

	scad_file.write('ALL_COMPONENTS = [')
	is_first = True
	length   = 1000;
	for component in components:
		if is_first:
			is_first = False
		else:
			length += 2
			scad_file.write(', ')

		component_var_name = component_var_name_prefix + component["reference"]
		length += len(component_var_name)
		if length > 78:
			scad_file.write('\n  ')
			length = 2

		scad_file.write('{}'.format(component_var_name))
	scad_file.write('];')

if exit_code:
	sys.exit(exit_code)

