# adisp
display an array of RGB values

## Usage

```
d←adisp.new
```
`d` is an instance of class adisp.

```
d←d.MakeWindow y
```
`y` is the `(height,width)` of the new window.

```
r←d.draw y
```
`y` is an array of shape `(rows,cols,⍵)` where ⍵ can be: 
- ⍬ or 1: grayscale
- 2: grayscale and alpha
- 3: RGB
- 4: RGBA

and `y` contains integers between 0 and 255 (inclusive).

`r` is either 0 or 1:
- 0: failed to draw 
- 1: continue drawing

```
d←adisp.window
```
The same as `adisp.new.MakeWindow 740 700`

```
d←adisp.Window y
```
The same as `adisp.new.MakeWindow y`

## Example
Game of Life:
```apl
      Life←{↑1 ⍵∨.∧3 4=+/,¯1 0 1∘.⊖¯1 0 1∘.⌽⊂⍵}
      {adisp.window{_←⎕DL÷8 ⋄ ⍺.Draw(⊃∘255 0⍤0)⍵:⍺ ∇ Life ⍵ ⋄ 0}⍵}?100 100⍴2
```

