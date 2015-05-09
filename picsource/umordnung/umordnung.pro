PRO umordnung, ENCAPSULATED=enc

; Dimensionen der Seite bestimmen (cm)
textwidth  = 19.7
textheight = 10.
voffset    =  2.5
hoffset    =  0.5

; Seite einrichten
; Postscript-File oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
	psp, "umordnung", /TIMES, /ENC, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset
ENDIF ELSE psp, "umordnung", /TIMES, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset 

; Rahmen um die Seite zeichnen
IF NOT(KEYWORD_SET(enc)) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

; all fonts --> postscript fonts
!P.FONT=0

; Plotabmessungen und -abstaende festlegen (cm)
xsz   = 5.5
ysz   = 4
xoff  = 13.5
yoff  = 0.7
ymrgn = 1
xmrgn = 3.0

; charsizes festlegen
plotchsz = 0.8
lablchsz = 2.5
xrange = [0,26]
yrange = [-1,1.]

; Positions
x1   = xoff+0*xmrgn+0*xsz
x2   = xoff+0*xmrgn+1*xsz
y1   = yoff+0*ymrgn+0*ysz
y2   = yoff+0*ymrgn+1*ysz
pos1 = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

x1   = xoff+0*xmrgn+0*xsz
x2   = xoff+0*xmrgn+1*xsz
y1   = yoff+1*ymrgn+1*ysz
y2   = yoff+1*ymrgn+2*ysz
pos2 = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

t = 0
corr = 0

RESTORE,"idlsave.dat"
RESTORE,"Map.0000.corr"
corr1 = corr(0,40:*)
RESTORE,"Map.2800.corr"
corr2 = corr(0,40:*)

r1 = FLTARR(40,40,3)
OPENR, UNIT, "Map.0000",/GET_LUN
READU, UNIT, r1
FREE_LUN, UNIT

r2 = FLTARR(40,40,3)
OPENR, UNIT, "Map.2800",/GET_LUN
READU, UNIT, r2
FREE_LUN, UNIT

PLOT, corr1 , YTITLE="C(x)", POSITION=pos1, XRANGE=xrange, YRANGE=yrange, FONT=0, CHARSIZE=plotchsz, /NOERASE, THICK=3, XTHICK=3, YTHICK=3, XSTYLE=1
OPLOT, [0,xrange(1)], [0,0], THICK=5
psshows, 12.5, -1.32, "!{32}x", /DATA, /XCENTER
PLOT, corr2 , YTITLE="C(x)", POSITION=pos2, XRANGE=xrange, YRANGE=yrange, FONT=0, CHARSIZE=plotchsz, /NOERASE, THICK=3, XTHICK=3, YTHICK=3, XSTYLE=1
OPLOT, [0,xrange(1)], [0,0], THICK=5
psshows, 12.5, -1.32, "!{32}x", /DATA, /XCENTER
 
xsz   = 6.5
ysz   = 5
xoff  = 1.7
yoff  = (textheight-ysz)/2

x1   = xoff+0*xmrgn+0*xsz
x2   = xoff+0*xmrgn+1*xsz
y1   = yoff+0*ymrgn+0*ysz
y2   = yoff+0*ymrgn+1*ysz
pos3 = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

PLOT, FINDGEN(100)/100*800, t, POSITION=pos3, /NOERASE, XTICKS=4, XTICKNAME=REPLICATE(" ",5), CHARSIZE=plotchsz,YTICKS=5, YTICKNAME=REPLICATE(" ",6), THICK=3, XTHICK=3, YTHICK=3
OPLOT,[180,180],[0,0.05], THICK=5
psshows, 90, -0.005, "!{32}lineare", /DATA, /XCENTER
psshows, 90, -0.0095, "!{32}Instabilitaet", /DATA, /XCENTER
psshows, 500, -0.005, "!{32}nichtlineare", /DATA, /XCENTER
psshows, 500, -0.0095, "!{32}Umordnung", /DATA, /XCENTER
psshows, 790, -0.005, "!{32}t", /DATA, /XCENTER, SIZE=1.5
psshows, -70, 0.048, "!{32}o", /DATA, /XCENTER, SIZE=1.6
;psshows, -70, 0.048, "!{31}<|#100!D!{32}i!{31}!d|!U2!u>", /DATA, /XCENTER, SIZE=1.5
ARROW, 140, t(140/8.), 1250, 0.005, /DATA, THICK=3
ARROW, 570, t(570/8.), 1250, 0.055, /DATA, THICK=3
TVSCL, r2(*,*,2), XSIZE=1.25, YSIZE=1.25, 9.3, 6.9, /CENT
TVSCL, r1(*,*,2), XSIZE=1.25, YSIZE=1.25, 9.3, 3.0, /CENT
IF KEYWORD_SET(enc) THEN BEGIN
    psexit
ENDIF ELSE psq, /gh
END
