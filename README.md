# CF_REFBUF

> Precision Reference Buffer

Draft for designer review. The public GDS is an abstract; ChipFoundry
substitutes protected full geometry at tapeout.

This package ships one hard macro: `CF_REFBUF`.

## Overview

`CF_REFBUF` is a SkyWater 130 nm hard macro that buffers a 1.0 V or 1.2 V
reference onto an analog bus to drive capacitive loads. The buffer can be
tri-stated. A core supply (`vpwr`) and an external supply (`vpwre`) are
required, plus a boosted analog supply on `ng`.

`pd` is active-high power-down. `switchon` closes the output switch onto the
load. `out` is the tri-statable buffer output. `ref_1v2` is the reference
input. `nbias` is the bias-current input. `switchoff` is a test output.

Light and medium loads are handled by a correction amplifier. Very heavy loads
use a strong-drive path enabled by `boost`. Load feedback returns on `ch1` or
`ch2`; `ch_cont` selects the channel.

Macro size is 123.225 × 147.695 µm.

## Installation

```bash
pip install cf-ipm
ipm install CF_REFBUF --version 0.2.0 --include-drafts
```

Until the marketplace listing is published, install from a local catalog
override:

```bash
ipm install CF_REFBUF --version 0.2.0 --include-drafts --local-file ip/catalog.json
```

Use `hdl/gl/` as the blackbox, `layout/lef/` for P&R, `layout/gds/` for the
public abstract, and `timing/lib/` for characterized views that shipped with
this package.

## Features

- 1.0 V / 1.2 V reference buffer for capacitive loads
- Tri-statable output `out`
- Active-high power-down `pd`
- Output switch `switchon`
- Strong-drive enable `boost`
- Load-feedback channels `ch1` / `ch2` with select `ch_cont`
- Dual supply: core `vpwr` and external `vpwre`
- Boosted analog supply input `ng`
- Hard-macro size 123.225 × 147.695 µm

## Pinout

Customer documentation includes a pinout of the integration cell only.
Internal schematics and architecture block diagrams are not published.

![CF_REFBUF pinout](doc/generated/CF_REFBUF_pinout.svg)

Pin names and directions match the public abstract (`layout/lef/CF_REFBUF.lef`),
the blackbox stub (`hdl/gl/CF_REFBUF.v`), and `timing/lib/CF_REFBUF_*.lib`.

## Pin Description

Directions and widths are taken from the shipped Verilog, LEF, and Liberty.
Descriptions are from the packaging extract where they match that stub.

| Name | Direction | Width | Description |
|---|---|---:|---|
| `out` | output | 1 | Tri-statable buffer output onto the load. |
| `switchoff` | output | 1 | Test-mode control output. |
| `pd` | input | 1 | Power-down, active high. `0` = buffer active; `1` = buffer disabled. |
| `switchon` | input | 1 | Output switch. `0` = open (disconnected from the load); `1` = closed. |
| `boost` | input | 1 | Active-high enable for the strong-drive path. |
| `ch_cont` | input | 1 | Feedback-channel select. `1` = `ch1`; `0` = `ch2`. |
| `ch1` | input | 1 | Feedback from the load into the strong-drive path. |
| `ch2` | input | 1 | Feedback from the load into the strong-drive path. |
| `ref_1v2` | input | 1 | 1.0 V / 1.2 V reference input. |
| `nbias` | input | 1 | Bias-current input. Source typical 9.6 µA ±5%. |
| `ng` | input | 1 | Boosted analog supply. |
| `vpwr` | input | 1 | Core supply, about 1.6–2.0 V. |
| `vpwre` | input | 1 | External supply, about 1.65–5.5 V. |
| `vgnd` | input | 1 | Ground. |
| `vpb` | input | 1 | P-channel bulk. Tie to the core supply. |
| `vpbe` | input | 1 | HV P-channel bulk. Tie to the external supply. |
| `vnb` | input | 1 | N-channel / substrate bulk. Tie to ground. |

## Specifications

Headline operating range from the source extract: industrial temperature,
core supply about 1.6–2.0 V, external supply about 1.65–5.5 V, reference
1.0 V or 1.2 V. Pin capacitance, leakage, and voltage maps are in
`timing/lib/`.

## Timing Diagram

With `pd` held low, raising `switchon` charges the load toward `vref`. After
`switchon` falls, `out` tri-states and the load holds.

![CF_REFBUF timing](doc/generated/CF_REFBUF_timing_01.png)

## Limitations and Open Issues

- Verilog in `hdl/gl/` is a behavioral blackbox, not a SPICE-accurate model.
- Liberty is a leakage / pin-capacitance view (no timing tables).
- LEF supplies are `USE POWER` / `GROUND` (`vpwr`, `vpwre`, `vpb`, `vpbe`,
  `ng` power; `vgnd`, `vnb` ground).
- Public abstracts use Sky130 `prBoundary` 235/4 and OBS on blockage
  datatype 10.

## Tapeout History

This hard macro has high-volume commercial production history (millions of
units). Catalog and IPM maturity is Production.

This ChipFoundry SkyWater 130 nm package delivers an abstract for
integration. ChipFoundry substitutes protected full layout at tapeout.
The chipIgnite delivery of this package is not marked shuttle-proven until
a run returns.

| Version | Date | Notes |
|---|---|---|
| 0.1.0 | 2026-09-04 | First unpublished IPM draft from the chip-wrapper abstract. Four cells. No Liberty. |
| 0.1.1 | 2026-09-04 | Pin Description table on wrapper pin names. |
| 0.2.0 | 2026-09-04 | Single public cell: characterized analog core renamed to `CF_REFBUF`. Pinout matches Liberty (`switchon`, `pd`, `ref_1v2`, `ch1`/`ch2`, `boost`). Wrapper and glue cells dropped. Breaking change from 0.1.x. |
