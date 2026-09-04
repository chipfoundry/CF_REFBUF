# CF_REFBUF

> Precision Reference Buffer

Draft for designer review. This package is not marked silicon-proven. The
public GDS is an abstract; ChipFoundry substitutes protected full geometry at
tapeout.

This package ships four hard macros: `CF_REFBUF`, `CF_REFBUF_kryp`,
`CF_REFBUF_gluelogic`, and `CF_REFBUF_gluelogic_kryp`. Place `CF_REFBUF` as
the integration cell.

## Overview

`CF_REFBUF` is a SkyWater 130 nm hard macro that buffers a 1.0 V or 1.2 V
reference onto an analog bus to drive capacitive loads. The buffer can be
tri-stated. A core supply (`vpwr`) and an external supply (`vpwre`) are
required, plus a boosted analog supply on `ng`.

`PD` is active-high power-down. `swon` closes the output switch onto the load.
`out` is the tri-statable buffer output. `bias_out` is a companion bias
output. `ref1v2` is the reference input. `nbias` is the bias-current input.
`switchoff` is a test output. `PDB` and `hys_buf_bar` are additional digital
controls on the public abstract.

Light and medium loads are handled by a correction amplifier. Very heavy loads
use a strong-drive path enabled by on-chip control. Feedback from the load is
closed at chip level, not as extra pins on this abstract.

Macro size for `CF_REFBUF` / `CF_REFBUF_kryp` is 123.225 × 147.465 µm. The
glue cells are 14.41 × 8.22 µm.

## Installation

```bash
pip install cf-ipm
ipm install CF_REFBUF --version 0.1.0 --include-drafts
```

Use `hdl/gl/` as the blackbox, `layout/lef/` for P&R, and `layout/gds/` for the
public abstract. Characterized Liberty for this abstract pinout is not in this
package yet.

## Features

- 1.0 V / 1.2 V reference buffer for capacitive loads
- Tri-statable output `out`
- Active-high power-down `PD`
- Output switch `swon`
- Dual supply: core `vpwr` and external `vpwre`
- Boosted analog supply input `ng`
- Hard-macro size 123.225 × 147.465 µm

## Block Diagram

See the abstract boundary and pins in `layout/lef/CF_REFBUF.lef`. Optional
figures may be placed under `doc/`.

## Pin Description

### `CF_REFBUF` / `CF_REFBUF_kryp`

| Pin | Direction | Width |
|---|---|---|
| out | output | 1 |
| bias_out | output | 1 |
| switchoff | output | 1 |
| PD | input | 1 |
| PDB | input | 1 |
| swon | input | 1 |
| hys_buf_bar | input | 1 |
| nbias | input | 1 |
| ref1v2 | input | 1 |
| ng | input | 1 |
| vpwr | input | 1 |
| vpwre | input | 1 |
| vgnd | input | 1 |
| vpb | input | 1 |
| vpbe | input | 1 |
| vnb | input | 1 |

### `CF_REFBUF_gluelogic` / `CF_REFBUF_gluelogic_kryp`

| Pin | Direction | Width |
|---|---|---|
| swon_hv | input | 1 |
| switchoff | output | 1 |
| vnb | input | 1 |
| vgnd | input | 1 |
| vpb | input | 1 |
| vpwr | input | 1 |
| vpbe | input | 1 |
| vpwre | input | 1 |

## Specifications

Electrical values belong in Liberty when a characterized view matching this
abstract is added. This package does not invent PVT tables. Operating range
from the source extract: industrial temperature, core supply about 1.6–2.0 V,
external supply about 1.65–5.5 V, reference 1.0 V or 1.2 V.

## Timing Diagram

Timing diagrams are not synthesized from the stub. Enable, power-down, and
output-switch polarity must match the blackbox and Liberty when those files
are present in a release.

## Tapeout History

Not silicon proven in this ChipFoundry package version. Maturity is not
proven until a shuttle returns. Foundry merge substitutes full geometry for
the public abstract at tapeout.
