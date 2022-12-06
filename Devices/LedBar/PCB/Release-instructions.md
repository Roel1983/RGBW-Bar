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
- Save the *LedBar.sch* schematic
- Update the page info of page1 of *Subboards/Subboards.sch*:
  - go to any page except the first one
  - Go to  `File` -> `Page Settings`
  - Check the  `Export to other sheets`
  - Click `OK`

- Go back to *LedBar.sch* schematics and force save it to fix the page numbers
- Generate the netlist files for
  - *LedBar.sch*
  - *Mainboard/Mainboard.sch*
  - *Subboards/subboards.sch*
- For each PBC:
  - Load netlist files
  - `Update PCB from schematic`
  - `Perform design rule check`
  - Update revision text on `B.SilkS` layer
    - Revision
    - Date

## Plot schematic

- Open *LedBar.sch*
- `File` -> `Plot...`
- Set fields:
  - Output directory: `Release/` 
  - Output format: `PDF`
  - Page size: `A4`
  - Plot border and title block: `checked`
- Click `Plot all Pages`

## Generate production files

The production files (Gerber and drill files) differ per manufacturer. The following sub chapters show how to generate for each of them.

### Generate Gerber and JLCPCB

For each PCB:

- Open *<PCB>.kicad_pcb*
- `File` -> `Plot...`
- Output directory: `Release/JLCPCB/RGBW-Bar[_<PCB>]`
- See for further instructions: https://support.jlcpcb.com/article/149-how-to-generate-gerber-and-drill-files-in-kicad

# Commit and tag

Add all the files:

`git add -u`

Make sure all files are added (or properly ignored)

`git status`

Commit:

`git commit -m "Released LedBar PCB <version>"`

Tag:

`git tag -a Device_LEDBar_PCB_<version> -m"<Version> of the LEDBar PCB" [commit]`

Push

`git push`

`git push origin Device_LEDBar_PCB_<version>`

# Order

Board thickness should be 1.2mm thick.

## Order at JLCPBC

TODO.
