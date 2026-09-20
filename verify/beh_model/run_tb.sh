#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="${TMPDIR:-/tmp}/cf_refbuf_tb"
iverilog -g2005 -o "$OUT" \
  "$ROOT/hdl/gl/CF_REFBUF.v" \
  "$ROOT/verify/beh_model/CF_REFBUF_core.v" \
  "$ROOT/verify/beh_model/tb_CF_REFBUF.v"
vvp "$OUT"
