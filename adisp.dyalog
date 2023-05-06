:Class adisp
  (⎕IO ⎕ML)←0 1

  :Field Public  id←''
  :Field Public  hr
  :Field Private stop←0

  GetHTML←{
    h←'<!DOCTYPE html>'
    h,←'<html>'
    h,←'<head>'
    h,←'<title>Array Display</title>'
    h,←'<meta charset="UTF-8">'
    h,←'<style>'
    h,←'canvas {'
    h,←'image-rendering: pixelated;'
    h,←'width:  100%;'
    h,←'height: 100%;'
    h,←'}'
    h,←'</style>'
    h,←'</head>'
    h,←'<body>'
    h,←'<canvas id="MyCanvas"></canvas>'
    h,←'<script>'
    h,←'const socket = new WebSocket("ws://dyalog_root/");'
    h,←'const canvas = document.getElementById("MyCanvas");'
    h,←'const ctx = canvas.getContext("2d");'
    h,←'let img = new ImageData(canvas.width, canvas.height);'
    h,←'let q = Promise.resolve();'
    h,←'socket.addEventListener("message", e => {'
    h,←'q = q.then(async () => {'
    h,←'if (typeof e.data === "string") {'
    h,←'const [h, w] = JSON.parse(e.data);'
    h,←'canvas.height = h;'
    h,←'canvas.width = w;'
    h,←'}'
    h,←'else if (e.data instanceof Blob) {'
    h,←'const buf = await e.data.arrayBuffer();'
    h,←'const arr = new Uint8ClampedArray(buf, 1);'
    h,←'img = new ImageData(arr, canvas.width);'
    h,←'}'
    h,←'});'
    h,←'});'
    h,←'const draw = t => {'
    h,←'ctx.putImageData(img, 0, 0);'
    h,←'window.requestAnimationFrame(draw);'
    h,←'};'
    h,←'window.requestAnimationFrame(draw);'
    h,←'</script>'
    h,←'</body>'
    h,←'</html>'
    h
  }
  :Field Private Shared ReadOnly HTML←GetHTML 0

  ∇ t←new
    :Access Public Shared
    t←⎕NEW adisp
  ∇

  ∇ b←isClosed
    :Access Public
    b←stop
  ∇

  ∇ r←Draw img;siz;buf
    :Access Public

    r←0
    :If stop≡1 ⋄ :Return ⋄ :EndIf

    :Select ≢⍴img
    :Case 2 ⋄ img←(,⍤0)img
    :Case 3
    :Else ⋄ 'rank of an image should be 2 or 3'⎕SIGNAL 4
    :EndSelect

    :Select ⊢⌿⍴img
    :Case 1 ⋄ img←({255,⍨3⍴⍵}⍤1)img
    :Case 2 ⋄ img←({⍵[0 0 0 1]}⍤1)img
    :Case 3 ⋄ img←({⍵,255}⍤1)img
    :Case 4
    :Else ⋄ 'need 1 2 3 or 4 values for color'⎕SIGNAL 5
    :EndSelect

    :While id≡'' ⋄ ⎕DL 0.05 ⋄ :EndWhile

    siz←1 ⎕JSON 2↑⍴img
    buf←255,,img
    r←siz{6::0
      _←hr.WebSocketSend id ⍺ 1 1
      1⊣hr.WebSocketSend id ⍵ 1 2
    }buf
  ∇

  ∇ OnUpgrade arg
    :Access Private
    id←2⊃arg
  ∇

  ∇ OnClose arg
    :Access Private
    stop←1
  ∇

  ∇ t←MakeWindow win_size;ev;pa;msg
    :Access Public
    :If id≢'' ⋄ 'Reload the window'⎕SIGNAL 16 ⋄ :EndIf
    ev←('WebSocketUpgrade' 'OnUpgrade')('Close' 'OnClose')
    pa←('Event',⍥⊆ev)('Coord' 'Pixel')('Size'win_size)('HTML'HTML)
    {_←'hr'⎕WC'HTMLRenderer',⍥⊆⍵ ⋄ ⎕DQ'hr'}&pa
    t←⎕THIS
  ∇

  ∇ w←Window win_size
    :Access Public Shared
    w←new.MakeWindow win_size
  ∇

  ∇ w←window
    :Access Public Shared
    w←new.MakeWindow 740 700
  ∇

  ∇ r←FromF f
    :Access Public Shared
    r←⌊255×f
  ∇

:EndClass
