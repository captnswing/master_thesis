PRO koeffizient, ENCAPSULATED=enc

; Dimensionen der Seite bestimmen (cm)
textwidth  = 10.1
textheight =  9.5
voffset    =  2.5
hoffset    =  2.5

; Seite einrichten
; Postscript-File oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
	psp, "koeffizient", /TIMES, /ENC, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset
ENDIF ELSE psp, "koeffizient", /TIMES, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset

; Rahmen um die Seite zeichnen
IF NOT(KEYWORD_SET(enc)) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

; all fonts --> postscript fonts
!P.FONT=0

READ_GIF, "koeffizient.gif", im,r,g,b
TVLCT,r,g,b
TVSCL, -im
psshows,  0.68, 0.19, "!{31}!G{0}s", SIZE=1.5
psshows,  0.15, 0.28, "!{31}!G{0}h", SIZE=1.5
IF KEYWORD_SET(enc) THEN BEGIN
    psexit
ENDIF ELSE psq, /gh
END
