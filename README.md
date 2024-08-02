# adisp
Display an array

Inspired by [APixeL](https://github.com/TabbyTranspose/APixeL)

## Usage

```
d ← adisp.New a
```
`d` is an instance of class adisp.
`a` are args to be used when creating HTMLRenderer.

```
d ← adisp.window
```
The same as `New ⍬`

```
d ← adisp.Window s
```
The same as `New ('Coord' 'Pixel')('Size' s)`

```
r ← d.Draw c
```
`c` is an array of shape `(height,width)` containing 
32-bit integers, which are the colors of each pixel.

`r` is either 0 or 1:
- 0: window is closed
- 1: window is not closed

```
c ← adisp.RGBA f
```
Convert the rank 1 cells of `f` (0.0-1.0 float `r g b a`) to the 
corresponding color array of shape `(¯1↓⍴f)`.

```
c ← adisp.RGB f
```
Convert the rank 1 cells of `f` (0.0-1.0 float `r g b`) to the 
corresponding color array of shape `(¯1↓⍴f)`.

```
c ← adisp.Gray y
```
Convert each of `y` (luminance, 0.0-1.0 float) to the corresponding 
color integer.

```
c ← adisp.Hex h
```
`h` is color in one of these hexadecimal forms: 
- `'RGB'` (each letter is duplicated, = `'RRGGBB'`)
- `'RGBA'` (each letter is duplicated, = `'RRGGBBAA'`)
- `'RRGGBB'`
- `'RRGGBBAA'`

`c` is the corresponding color.

```
f ← adisp.ToRGBA c
```
Convert color `c` back to the RGBA components `f`.

## Example
Game of Life:
```apl
Life←{↑1 ⍵∨.∧3 4=+/,¯1 0 1∘.⊖¯1 0 1∘.⌽⊂⍵}
{adisp.window{_←⎕DL÷8 ⋄ ⍺.(Draw Gray)~⍵:⍺ ∇ Life ⍵ ⋄ 0}⍵}?100 100⍴2
```

