PRO wavelength, ENCAPSULATED=enc

; Dimensionen der Seite bestimmen (cm)
textwidth  = 20.
textheight = 10.
voffset    =  0.5
hoffset    =  0.5

; Seite einrichten
; Postscript-File oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
    psp, "wavelength", /HELVETICA, /ENC, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset
ENDIF ELSE psp, "wavelength", /HELVETICA, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset 

; Rahmen um die Seite zeichnen
IF NOT(KEYWORD_SET(enc)) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

; all fonts --> postscript fonts
!P.FONT=0

; Plotabmessungen und -abstaende festlegen (cm)
xsz   = 6.5
ysz   = 7.0
xoff  = 2.0
yoff  = 1.8
ymrgn = 4.0
xmrgn = 3.5

; charsizes festlegen
plotchsz = 0.8
lablchsz = 2.5

; Positions
x1   = xoff+0*xmrgn+0*xsz
x2   = xoff+0*xmrgn+1*xsz
y1   = yoff+0*ymrgn+0*ysz
y2   = yoff+0*ymrgn+1*ysz
pos1 = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

x1   = xoff+1*xmrgn+1*xsz
x2   = xoff+1*xmrgn+2*xsz
y1   = yoff+0*ymrgn+0*ysz
y2   = yoff+0*ymrgn+1*ysz
pos2 = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

x1   = xoff+2*xmrgn+2*xsz
x2   = xoff+2*xmrgn+3*xsz
y1   = yoff+0*ymrgn+0*ysz
y2   = yoff+0*ymrgn+1*ysz
pos3 = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

number_s88 = indgen(6)+1
Lambda_OD_s88 = [660., 725., 820., 870., 1158., 850.]
Lambda_OP_s88 = [915., 920., 1100., 1190., 1375., 1020.]

number_s94 = indgen(9)/2.+11
Lambda_OD_control = [850., 830., 800., 770., 1000., 930., 940., 1020., 960.]
Lambda_OD_squint = [1200., 1180., 1150., 1160., 1200., 1250., 1220., 1270., 1250.]

number_ob93 = indgen(6)+1
Lambda_OD_ob93 = [903., 773., 796., 829., 829., 800.]
Lambda_OP_ob93 = [768., 645., 621., 719., 676., 647.]


PLOT, Lambda_OD_s88/1000., number_s88, PSYM=6, XRANGE=[0,1.4], YRANGE=[0,7.], XSTYLE=8, YSTYLE=9, YTICKS=7, THICK=5, XTHICK=5, YTHICK=5, POSITION=pos1, /NOERASE
OPLOT, Lambda_OP_s88/1000., number_s88, PSYM=5, THICK=5
psshows, 0.7, -1.5, "!{31}L!{32} [mm]", /DATA, SIZE=1, /XCENTER
psshows, 0.7, 7.6, '!{32}Katzen', /DATA, /XCENTER, SIZE=1.5
psshows, -0.18, 7.1, '!{32}##', /DATA, /XCENTER, SIZE=1.5

PLOT, Lambda_OD_ob93/1000., number_s88, PSYM=6, XRANGE=[0,1.2], YRANGE=[0,7.], XSTYLE=8, YSTYLE=9, YTICKS=7, THICK=5, XTHICK=5, YTHICK=5, POSITION=pos2, /NOERASE
OPLOT, Lambda_OP_ob93/1000., number_ob93, PSYM=5, THICK=5
psshows, 0.6, -1.5, "!{31}L!{32} [mm]", /DATA, SIZE=1, /XCENTER
psshows, 0.6, 7.6, '!{32}Affen', /DATA, /XCENTER, SIZE=1.5
psshows, -0.15, 7.1, '!{32}##', /DATA, /XCENTER, SIZE=1.5

IF KEYWORD_SET(enc) THEN BEGIN
    psexit
ENDIF ELSE psq, /gh
END
