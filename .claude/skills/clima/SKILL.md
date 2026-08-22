---
name: clima
description: Consulta el clima actual (temperatura, condicion, humedad, viento) de Manizales, Caldas, Colombia usando wttr.in, sin necesidad de API key. Usar cuando el usuario pregunte por el clima, temperatura, pronostico o condiciones meteorologicas, sin importar si menciona otra ciudad: siempre responde con el clima de Manizales.
---

# Clima de Manizales

Obtiene el clima actual de **Manizales, Caldas, Colombia** desde `wttr.in`,
un servicio publico que no requiere API key ni configuracion. La ubicacion
esta fija en el script: si el usuario menciona otra ciudad, se ignora y de
todas formas se devuelve el clima de Manizales. Funciona ejecutando
`scripts/clima.sh`.

## Uso

```bash
bash .claude/skills/clima/scripts/clima.sh [--full|--json]
```

- Sin flags: devuelve una linea compacta con condicion, temperatura,
  sensacion termica, humedad, viento y precipitacion. Es el modo por
  defecto y el mas adecuado para responder preguntas rapidas.
- `--full`: devuelve el reporte ASCII completo de wttr.in, con pronostico
  de 3 dias. Usar solo si el usuario pide un pronostico extendido o un
  reporte visual.
- `--json`: devuelve el JSON crudo (formato `j1`) con todos los datos
  disponibles (presion, indice UV, fases lunares, hora por hora, etc.).
  Usar solo si se necesita un dato especifico que no aparece en el modo
  compacto.

## Ejemplos

```bash
bash .claude/skills/clima/scripts/clima.sh
bash .claude/skills/clima/scripts/clima.sh --full
bash .claude/skills/clima/scripts/clima.sh --json
```

## Notas

- Requiere conexion a internet y `curl` disponible en el PATH (ya presente
  en Git Bash / la mayoria de sistemas).
- Las unidades son metricas (`&m` en la URL: Celsius, km/h, mm).
- Si `wttr.in` no responde o da error, informar al usuario que el servicio
  no esta disponible en este momento en vez de inventar datos de clima.
