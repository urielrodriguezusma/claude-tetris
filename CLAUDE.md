# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Vanilla JavaScript Tetris using HTML5 Canvas. No build process, no dependencies, no package.json — just three files: `index.html`, `style.css`, `game.js`.

## Running

Open `index.html` directly in a browser, or serve it locally:

```bash
python3 -m http.server 8000
# or
npx serve .
```

There is no build, lint, or test tooling in this repo — changes are verified by opening the page and playing.

## Architecture

Everything lives in `game.js` as a single top-level script (no modules, no classes) operating on module-level `let` state (`board`, `current`, `next`, `score`, `lines`, `level`, `paused`, `gameOver`, `dropInterval`, etc.), initialized/reset by `init()`.

- **Board model**: `ROWS × COLS` matrix where each cell is `0` (empty) or a color index `1–7` identifying which piece locked there.
- **Pieces**: `PIECES` are square matrices; `current`/`next` are `{ type, shape, x, y }`. Rotation is `rotateCW` (transpose + reverse), not a lookup table of rotation states.
- **Collision** (`collide`) checks board bounds and existing locked cells; **wall kicks** (`tryRotate`) retry the rotated shape at x-offsets `[0, -1, 1, -2, 2]` before giving up.
- **Game loop** (`loop`, driven by `requestAnimationFrame`) accumulates elapsed time in `dropAccum` and advances the piece one row once `dropInterval` is exceeded, otherwise calling `lockPiece()`.
- **Locking a piece**: `lockPiece()` → `merge()` writes the piece into `board`, `clearLines()` removes full rows (score/level/`dropInterval` update here), then `spawn()` promotes `next` to `current` and generates a new `next` — if the new `current` immediately collides, `endGame()` fires.
- **Scoring**: `LINE_SCORES = [0, 100, 300, 500, 800]` × `level` for clears; hard drop adds 2 pts/row dropped, soft drop 1 pt/row. Level increments every 10 lines; `dropInterval = max(100, 1000 - (level-1)*90)`.
- **Rendering**: `draw()` clears and redraws the grid, locked board, ghost piece (`ghostY()` projects straight down, drawn at `globalAlpha 0.2`), and the current piece, in that order — so later layers sit on top. `drawNext()` renders the preview canvas separately.
- **Input**: a single `keydown` listener maps arrow keys / `X` / `Space` / `P` to movement, rotation, soft/hard drop, and pause; ignored while `paused` or `gameOver`.

When changing board dimensions or block size (`COLS`, `ROWS`, `BLOCK` in `game.js`), also update the `<canvas id="board">` `width`/`height` in `index.html` to match (`COLS × BLOCK`, `ROWS × BLOCK`).
