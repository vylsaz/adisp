# adisp
Display an array

Inspired by [APixeL](https://github.com/TabbyTranspose/APixeL)

## Usage

```
d ← adisp.window
```
The same as `adisp.new.MakeWindow 0`

```
d ← adisp.Window y
```
The same as `adisp.new.MakeWindow y`

```
d ← adisp.new
```
`d` is an instance of class adisp.

```
d ← d.MakeWindow y
```
`y` is the `(height,width)` of the new window. 
If `y` is `0`, use the default of HTMLRenderer.

```
r ← d.Draw y
```
`y` is an array of shape `(height,width)` containing 
32-bit integers, which are the colors of each pixel.

`r` is either 0 or 1:
- 0: window is closed
- 1: window is not closed

```
c ← adisp.RGBA y
```
Convert the rank 1 cells of `y` (0.0-1.0 float `r g b a`) to the 
corresponding color array of shape `(¯1↓⍴y)`.

```
c ← adisp.RGB y
```
Convert the rank 1 cells of `y` (0.0-1.0 float `r g b`) to the 
corresponding color array of shape `(¯1↓⍴y)`.

```
c ← adisp.Gray y
```
Convert each of `y` (luminance, 0.0-1.0 float) to the corresponding 
color integer.

```
c ← adisp.Hex y
```
`y` is color in one of these hexadecimal forms: 
- `'RGB'` (each letter is duplicated, = `'RRGGBB'`)
- `'RGBA'` (each letter is duplicated, = `'RRGGBBAA'`)
- `'RRGGBB'`
- `'RRGGBBAA'`

`c` is the corresponding color.

```
r ← adisp.ToRGBA y
```
Convert color `y` back to the RGBA components `r`.

## Example
Game of Life:
```apl
Life←{↑1 ⍵∨.∧3 4=+/,¯1 0 1∘.⊖¯1 0 1∘.⌽⊂⍵}
{adisp.window{_←⎕DL÷8 ⋄ ⍺.(Draw Gray)~⍵:⍺ ∇ Life ⍵ ⋄ 0}⍵}?100 100⍴2
```

