# CF_REFBUF

> Precision Reference Buffer

Draft for designer review. The public GDS is an abstract; ChipFoundry
substitutes protected full geometry at tapeout.

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
ipm install CF_REFBUF --version 0.1.1 --include-drafts
```

Until the marketplace listing is published, install from a local catalog
override:

```bash
ipm install CF_REFBUF --version 0.1.1 --include-drafts --local-file ip/catalog.json
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

## Pinout

Customer documentation includes a pinout of the integration cell only.
Internal schematics and architecture block diagrams are not published.

![CF_REFBUF pinout](doc/generated/CF_REFBUF_pinout.svg)

Pin names and directions match the public abstract (`layout/lef/CF_REFBUF.lef`)
and the blackbox stub (`hdl/gl/CF_REFBUF.v`). Glue cells are documented in the
pin table below; they are not shown on this pinout.

## Pin Description

Directions and widths are taken from the shipped Verilog in `hdl/gl/` and the
matching LEF. Descriptions are from the packaging extract where they match
that stub. `bias_out`, `PDB`, and `hys_buf_bar` are on the public abstract
and were not in the source pin list.

### `CF_REFBUF` / `CF_REFBUF_kryp`

| Name | Direction | Width | Description |
|---|---|---:|---|
| `out` | output | 1 | Tri-statable buffer output onto the load. |
| `bias_out` | output | 1 | Companion bias output on this abstract. |
| `switchoff` | output | 1 | Test-mode control output. |
| `PD` | input | 1 | Power-down, active high. `0` = buffer active; `1` = buffer disabled. |
| `PDB` | input | 1 | Additional digital control on this abstract. |
| `swon` | input | 1 | Output switch. `0` = open (disconnected from the load); `1` = closed. |
| `hys_buf_bar` | input | 1 | Active-low digital control on this abstract. |
| `nbias` | input | 1 | Bias-current input. Source typical 9.6 µA ±5%. |
| `ref1v2` | input | 1 | 1.0 V / 1.2 V reference input. |
| `ng` | input | 1 | Boosted analog supply. |
| `vpwr` | input | 1 | Core supply, about 1.6–2.0 V. |
| `vpwre` | input | 1 | External supply, about 1.65–5.5 V. |
| `vgnd` | input | 1 | Ground. |
| `vpb` | input | 1 | P-channel bulk. Tie to the core supply. |
| `vpbe` | input | 1 | HV P-channel bulk. Tie to the external supply. |
| `vnb` | input | 1 | N-channel / substrate bulk. Tie to ground. |

### `CF_REFBUF_gluelogic` / `CF_REFBUF_gluelogic_kryp`

| Name | Direction | Width | Description |
|---|---|---:|---|
| `swon_hv` | input | 1 | HV-side output-switch control. |
| `switchoff` | output | 1 | Test-mode control output. |
| `vnb` | input | 1 | N-channel / substrate bulk. Tie to ground. |
| `vgnd` | input | 1 | Ground. |
| `vpb` | input | 1 | P-channel bulk. Tie to the core supply. |
| `vpwr` | input | 1 | Core supply. |
| `vpbe` | input | 1 | HV P-channel bulk. Tie to the external supply. |
| `vpwre` | input | 1 | External supply. |

## Specifications

Electrical values belong in Liberty when a characterized view matching this
abstract is added. This package does not invent PVT tables. Operating range
from the source extract: industrial temperature, core supply about 1.6–2.0 V,
external supply about 1.65–5.5 V, reference 1.0 V or 1.2 V.

## Timing Diagram

With `PD` held low, raising `swon` charges the load toward `vref`. After
`swon` falls, `out` tri-states and the load holds.

The source figure labels the output-switch pin `switchon`; that net is `swon`
on this abstract.

![CF_REFBUF timing](doc/generated/CF_REFBUF_timing_01.png)

## Limitations and Open Issues

- Verilog in `hdl/gl/` is a behavioral blackbox, not a SPICE-accurate model.
- Characterized Liberty for this abstract pinout is not shipped. Do not use
  views whose pin names do not match `CF_REFBUF.lef`.
- `boost`, load-feedback, and channel-select controls are on-chip, not pins
  on this abstract.
- Glue cells (`CF_REFBUF_gluelogic`, `CF_REFBUF_gluelogic_kryp`) are 8-pin
  companions; they are not a substitute for the integration cell.
- LEF supplies are `USE POWER` / `GROUND` (`vpwr`, `vpwre`, `vpb`, `vpbe`,
  `ng` power; `vgnd`, `vnb` ground).

## Tapeout History

This hard macro has high-volume commercial production history (millions of
units). Catalog and IPM maturity is Production.

This ChipFoundry SkyWater 130 nm package delivers an abstract for
integration. ChipFoundry substitutes protected full layout at tapeout.
The chipIgnite delivery of this package is not marked shuttle-proven until
a run returns.

| Version | Date | Notes |
|---|---|---|
| 0.1.0 | 2026-09-04 | First unpublished IPM draft. Four public cells under `CF_REFBUF*` names. Pinout-only customer docs plus the charging timing figure. LEF supplies are `USE POWER`/`GROUND`. |
| 0.1.1 | 2026-09-04 | Pin Description table includes extract-backed prose on public LEF names. |
