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

### Generate Gerber for JLCPCB

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

PCB thickness must be 1.2mm thick.

## Order at JLCPBC

|                         | RGBW-Bar                           | RGBW-Bar_Mainboard                 | RGBW-Bar_Subboards                 |
| ----------------------- | ---------------------------------- | ---------------------------------- | ---------------------------------- |
| Base Material           | FR-4                               | FR-4                               | FR-4                               |
| Layers                  | 2                                  | 2                                  | 2                                  |
| Dimension               |                                    | 63.5 mm* 73.66 mm                  | 63.5 mm* 23.11 mm                  |
| **PCB Qty**             | *10*                               | *10*                               | *10*                               |
| Product Type            | Industrial/Consumer electronics    | Industrial/Consumer electronics    | Industrial/Consumer electronics    |
| **Different Design**    | **4**                              | **1**                              | **3**                              |
| **Delivery Format**     | **Panel by Customer**              | **Single PCB**                     | **Panel by Customer**              |
| **PCB Thickness**       | **1.2**                            | **1.2**                            | **1.2**                            |
| Impedance Control       | no                                 | no                                 | no                                 |
| Layer Sequence          |                                    |                                    |                                    |
| **PCB Color**           | **White**                          | *Green*                            | **White**                          |
| **Silkscreen**          | **Black**                          | *White*                            | **Black**                          |
| Via Covering            | Tented                             | Tented                             | Tented                             |
| Surface Finish          | HASL(with lead)                    | HASL(with lead)                    | HASL(with lead)                    |
| Deburring/Edge rounding | No                                 | No                                 | No                                 |
| Outer Copper Weight     | 1                                  | 1                                  | 1                                  |
| Gold Fingers            | No                                 | No                                 | No                                 |
| Flying Probe Test       | Fully Test                         | Fully Test                         | Fully Test                         |
| Castellated Holes       | no                                 | no                                 | no                                 |
| Remove Order Number     | No                                 | No                                 | No                                 |
| Package Box             | With JLCPCB logo                   | With JLCPCB logo                   | With JLCPCB logo                   |
| Silkscreen Technology   | Ink-jet/Screen Printing Silkscreen | Ink-jet/Screen Printing Silkscreen | Ink-jet/Screen Printing Silkscreen |
| Confirm Production file | No                                 | No                                 | No                                 |
| Appearance Quality      | IPC Class 2 Standard               | IPC Class 2 Standard               | IPC Class 2 Standard               |
| Paper between PCBs      | No                                 | No                                 | No                                 |
| Material Type           | FR4-Standard TG 135-140            | FR4-Standard TG 135-140            | FR4-Standard TG 135-140            |
| 4-Wire Kelvin Test      | No                                 | No                                 | No                                 |

