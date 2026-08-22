#!/usr/bin/env bash
# Obtiene el clima actual de Manizales, Caldas, Colombia desde wttr.in
# (no requiere API key). La ubicacion esta fija: cualquier otro argumento
# que no sea un flag reconocido se ignora.
#
# Uso:
#   clima.sh [--full|--json]
#
#   --full      Reporte completo en ASCII (arte + pronostico 3 dias).
#   --json      Salida JSON cruda (formato j1) para parseo detallado.
#
# Sin flags, imprime una linea compacta: ubicacion, condicion, temperatura,
# sensacion termica, humedad, viento y precipitacion.

set -euo pipefail

LOCATION="Manizales,Caldas,Colombia"
MODE="compact"

for arg in "$@"; do
  case "$arg" in
    --full) MODE="full" ;;
    --json) MODE="json" ;;
    *) ;; # se ignora: la ubicacion es fija
  esac
done

# URL-encode espacios en la ubicacion
LOCATION="${LOCATION// /+}"

case "$MODE" in
  compact)
    FORMAT='%l:+%C+%t+(sensacion+%f)+|+Humedad:%h+|+Viento:%w+|+Precip:%p'
    curl -fsS "https://wttr.in/${LOCATION}?m&format=${FORMAT}"
    echo
    ;;
  full)
    curl -fsS "https://wttr.in/${LOCATION}?m"
    ;;
  json)
    curl -fsS "https://wttr.in/${LOCATION}?format=j1"
    ;;
esac
