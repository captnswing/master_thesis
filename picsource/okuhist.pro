PRO okuhist, ENCAPSULATED=enc, BORDER=border

; Postscript-File oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
	psp, "okuhist", /TIMES, /ENC
ENDIF ELSE psp, "figure", /TIMES

; all fonts --> postscript fonts
!P.FONT=0

; Dimensionen der Seite bestimmen (cm)
textwidth  = 21.2
textheight =  8.
voffset    =  0.5
hoffset    =  0.5

; Seite einrichten
DEVICE, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset

; Rahmen um die Seite zeichnen
IF KEYWORD_SET(border) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

; Plotabmessungen und -abstaende festlegen (cm)
plt_xsz  = 5.1
plt_ysz  = 5.5
plt_offx = 1.5
plt_offy = 1.0

; Abstaende festlegen (cm)
ymrgn = 4.0
xmrgn = 3.5

; charsizes festlegen
plotchsz = 0.75
lablchsz = 2.5

katze = [25,30,53,55,30,11,20]
katze = 100*FLOAT(katze)/TOTAL(katze)

affe = [180,165,155,65,170,230,255]
affe = 100*FLOAT(affe)/TOTAL(affe)

strabcat = [160,18,17,16,15,20,135]
strabcat = 100*FLOAT(strabcat)/TOTAL(strabcat)
!P.FONT=0

; Positions
x1  = 1*plt_offx+0*plt_xsz
x2  = 1*plt_offx+1*plt_xsz
y1  = 1*plt_offy+0*plt_ysz
y2  = 1*plt_offy+1*plt_ysz
pos = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]
 
PLOT, (FINDGEN(7)+0.5), katze, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,7], XSTYLE=5, YSTYLE=5, CHARSIZE=plotchsz, THICK=10, YRANGE=[0,30], XTHICK=5, YTHICK=5, /NODATA
psshows, 3.5, 32, '!{32}normalsichtige Katze', /DATA, /XCENTER, SIZE=1.2
polx = REBIN(FINDGEN(8),16,/SAMPLE)
poly = [0,REBIN(katze,14,/SAMPLE),0]
POLYFILL, polx, poly, COLOR=150
PLOT, (FINDGEN(7)+0.5), katze, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,7], XSTYLE=1, XTICKS=14, XTICKN=[' ','-1',' ',' ',' ',' ',' ','0',' ',' ',' ',' ',' ','+1',' '], CHARSIZE=plotchsz, THICK=5, YRANGE=[0,30], XTHICK=5, YTHICK=5
OPLOT,[0,1],[katze(0),katze(0)], THICK=5
OPLOT,[6,7],[katze(6),katze(6)], THICK=5
psshows, -1.00, 31.5, '!{32}/', /DATA, /YCENTER, SIZE=1.2
psshows, -1.20, 32, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, -0.85, 31, '!{31}#176', /DATA, /YCENTER, SIZE=1.2

; Positions
x1  = 2*plt_offx+1*plt_xsz
x2  = 2*plt_offx+2*plt_xsz
y1  = 1*plt_offy+0*plt_ysz
y2  = 1*plt_offy+1*plt_ysz
pos = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

PLOT, (FINDGEN(7)+0.5), strabcat, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,7], XSTYLE=1, XTICKS=14, XTICKN=[' ','-1',' ',' ',' ',' ',' ','0',' ',' ',' ',' ',' ','+1',' '], CHARSIZE=plotchsz, THICK=10, XTHICK=5, YTHICK=5
OPLOT,[0,1],[strabcat(0),strabcat(0)], THICK=10
OPLOT,[6,7],[strabcat(6),strabcat(6)], THICK=10
polx = REBIN(FINDGEN(8),16,/SAMPLE)
poly = [0,REBIN(strabcat,14,/SAMPLE),0]
psshows, 3.5, 54, '!{32}strabismische Katze', /DATA, /XCENTER, SIZE=1.2
POLYFILL, polx, poly, COLOR=150
PLOT, (FINDGEN(7)+0.5), strabcat, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,7], XSTYLE=1, XTICKS=14, XTICKN=[' ','-1',' ',' ',' ',' ',' ','0',' ',' ',' ',' ',' ','+1',' '], CHARSIZE=plotchsz, THICK=10, XTHICK=5, YTHICK=5, /NODATA
psshows, -1.00, (31.5)/30.*50, '!{32}/', /DATA, /YCENTER, SIZE=1.2
psshows, -1.20, (32)/30.*50, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, -0.85, (31)/30.*50, '!{31}#176', /DATA, /YCENTER, SIZE=1.2

; Positions
x1  = 3*plt_offx+2*plt_xsz
x2  = 3*plt_offx+3*plt_xsz
y1  = 1*plt_offy+0*plt_ysz
y2  = 1*plt_offy+1*plt_ysz
pos = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

PLOT, (FINDGEN(8)+0.5), affe, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,7], XSTYLE=1, XTICKS=14, XTICKN=[' ','-1',' ',' ',' ',' ',' ','0',' ',' ',' ',' ',' ','+1',' '], CHARSIZE=plotchsz, THICK=10, YRANGE=[0,30], XTHICK=5, YTHICK=5
OPLOT,[0,1],[affe(0),affe(0)], THICK=10
OPLOT,[6,7],[affe(6),affe(6)], THICK=10
polx = REBIN(FINDGEN(8),16,/SAMPLE)
poly = [0,REBIN(affe,14,/SAMPLE),0]
psshows, 3.5, 32, '!{32}normalsichtiger Affe', /DATA, /XCENTER, SIZE=1.2
POLYFILL, polx, poly, COLOR=150
PLOT, (FINDGEN(7)+0.5), affe, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,7], XSTYLE=1, XTICKS=14, XTICKN=[' ','-1',' ',' ',' ',' ',' ','0',' ',' ',' ',' ',' ','+1',' '], CHARSIZE=plotchsz, THICK=10, YRANGE=[0,30], XTHICK=5, YTHICK=5, /NODATA
psshows, -1.00, 31.5, '!{32}/', /DATA, /YCENTER, SIZE=1.2
psshows, -1.20, 32, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, -0.85, 31, '!{31}#176', /DATA, /YCENTER, SIZE=1.2

psexit
END
