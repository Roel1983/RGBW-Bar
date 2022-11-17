# Release instructions

For each PCB we need to do the following steps.

- Update information on schematic and PCB
- Plot schematic
- Plot mechanical files
- Generate production files 

## Update information on schematic and PCB

- Update the Page settings of the *LedBar.sch* schematics
  Go to `File` -> `Page Settings`
  Update the following fields, make sure to select `Export to other sheets`:
  - Issue Date
  - Revision
- Save the *LedBar.sch* schematic and
- Generate the netlist files for
  - *LedBar.sch*
  - *Mainboard/Mainboard.sch*
  - *Subboards/subboards.sch*

## Plot schematic

- Open *LedBar.sch*
- `File` -> `Plot...`
- Set fields:
  - Output directory: `Releases/<version>` 
  - Output format: `PDF`
  - Page size: `A4`
  - Plot border and title block: `checked`
- Click `Plot all Pages`

## Generate production files

The production files (Gerber and drill files) might differ per manufacturer. The following sub chapters show how to generate for each of them.

### Generate Gerber and JLCPCB

For each PCB:

- Open *<PCB>.kicad_pcb*
- `File` -> `Plot...`
- Output directory: `Releases/<version>/gerber/jlcpcb`
- See for further instructions: https://support.jlcpcb.com/article/149-how-to-generate-gerber-and-drill-files-in-kicad
- 

# Commit and tag

TODO : Don't forget to add the Release folder

# Order

TODO: Board thickness should be 1.0mm.

## Order at JLCPBC



# Resources

