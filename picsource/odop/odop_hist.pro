PRO odop_hist, ENCAPSULATED=enc, BORDER=border

; Postscript-File oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
	psp, "odop_hist", /HELVETICA, /ENC
ENDIF ELSE psp, "figure", /HELVETICA

; all fonts --> postscript fonts
!P.FONT=0

; Dimensionen der Seite bestimmen (cm)
textwidth  = 20.0
textheight =  7.5
voffset    =  0.5
hoffset    =  0.5

; Seite einrichten
DEVICE, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset

; Rahmen um die Seite zeichnen
IF KEYWORD_SET(border) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

; Plotabmessungen und -abstaende festlegen (cm)
plt_xsz  = 5.1
plt_ysz  = 5.5
plt_offx = 0.5
plt_offy = 0.75

; Abstaende festlegen (cm)
ymrgn = 1.0
xmrgn = 1.5

; charsizes festlegen
plotchsz = 0.75
lablchsz = 2.5

theorie = 100*[0.0386839, 0.0426856, 0.0475767, 0.0609160, 0.0689195, 0.0835927, 0.112050, 0.133393, 0.180080, 0.232103]
theorie = REBIN(theorie, 5)
 
strabcat = 100*[0.119685, 0.146457, 0.188976, 0.262992, 0.281890]

affe = 10*[0.25, 0.59, 1.00, 1.42, 1.71]/1.4
affe = 100*affe/TOTAL(affe)
print, affe

; Positions
x1  = 1*plt_offx+0*xmrgn+0*plt_xsz
x2  = 1*plt_offx+0*xmrgn+1*plt_xsz
y1  = 1*plt_offy+0*plt_ysz
y2  = 1*plt_offy+1*plt_ysz
pos = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]
 
PLOT, (FINDGEN(5)+0.5), theorie, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,5], YRANGE=[0,35], YSTYLE=1, XSTYLE=1, XTICKS=10, XTICKN=[' ',' 0-18',' ','18-36',' ','36-54',' ','54-72',' ','72-90',' '], CHARSIZE=plotchsz, THICK=10, /NODATA
polx = REBIN(FINDGEN(6),12,/SAMPLE)
poly = [0,REBIN(theorie,10,/SAMPLE),0]
psshows, 2.5, 37, '!{32}Feature-Map', /DATA, /XCENTER, SIZE=1.5
POLYFILL, polx, poly, COLOR=150
PLOT, (FINDGEN(5)+0.5), theorie, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,5], YRANGE=[0,35], YSTYLE=1, XSTYLE=1, XTICKS=10, XTICKN=[' ',' 0-18',' ','18-36',' ','36-54',' ','54-72',' ','72-90',' '], CHARSIZE=plotchsz, THICK=5, XTHICK=5, YTHICK=5
OPLOT,[0,1],[theorie(0),theorie(0)], THICK=5
OPLOT,[4,5],[theorie(4),theorie(4)], THICK=5
psshows, -.75, (31.5)/30.*35, '!{32}/', /DATA, /YCENTER, SIZE=1.2
psshows, -.9, (32)/30.*35, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, -.6, (31)/30.*35, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, 5.1, -2.6, '!{31}#176', /DATA, SIZE=1.4


; Positions
x1  = 2*plt_offx+1*xmrgn+1*plt_xsz
x2  = 2*plt_offx+1*xmrgn+2*plt_xsz
y1  = 1*plt_offy+0*plt_ysz
y2  = 1*plt_offy+1*plt_ysz
pos = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

PLOT, (FINDGEN(5)+0.5), strabcat, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,5], YRANGE=[0,35], YSTYLE=1, XSTYLE=1, XTICKS=10, XTICKN=[' ',' 0-18',' ','18-36',' ','36-54',' ','54-72',' ','72-90',' '], CHARSIZE=plotchsz, THICK=10, /NODATA
polx = REBIN(FINDGEN(6),12,/SAMPLE)
poly = [0,REBIN(strabcat,10,/SAMPLE),0]
psshows, 2.5, 37, '!{32}strabismische Katze', /DATA, /XCENTER, SIZE=1.5
POLYFILL, polx, poly, COLOR=150
PLOT, (FINDGEN(5)+0.5), strabcat, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,5], YRANGE=[0,35], YSTYLE=1, XSTYLE=1, XTICKS=10, XTICKN=[' ',' 0-18',' ','18-36',' ','36-54',' ','54-72',' ','72-90',' '], CHARSIZE=plotchsz, THICK=5, XTHICK=5, YTHICK=5
OPLOT,[0,1],[strabcat(0),strabcat(0)], THICK=5
OPLOT,[4,5],[strabcat(4),strabcat(4)], THICK=5
psshows, -.75, (31.5)/30.*35, '!{32}/', /DATA, /YCENTER, SIZE=1.2
psshows, -.9, (32)/30.*35, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, -.6, (31)/30.*35, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, 5.1, -2.6, '!{31}#176', /DATA, SIZE=1.4

; Positions
x1  = 3*plt_offx+2*xmrgn+2*plt_xsz
x2  = 3*plt_offx+2*xmrgn+3*plt_xsz
y1  = 1*plt_offy+0*plt_ysz
y2  = 1*plt_offy+1*plt_ysz
pos = [x1/textwidth,y1/textheight,x2/textwidth,y2/textheight]

PLOT, (FINDGEN(5)+0.5), affe, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,5], YRANGE=[0,35], YSTYLE=1, XSTYLE=1, XTICKS=10, XTICKN=[' ',' 0-18',' ','18-36',' ','36-54',' ','54-72',' ','72-90',' '], CHARSIZE=plotchsz, THICK=10, /NODATA
polx = REBIN(FINDGEN(6),12,/SAMPLE)
poly = [0,REBIN(affe,10,/SAMPLE),0]
psshows, 2.5, 37, '!{32}Affe', /DATA, /XCENTER, SIZE=1.5
POLYFILL, polx, poly, COLOR=150
PLOT, (FINDGEN(5)+0.5), affe, POSITION=pos, PSYM=10, /NOERASE, XRANGE=[0,5], YRANGE=[0,35], YSTYLE=1, XSTYLE=1, XTICKS=10, XTICKN=[' ',' 0-18',' ','18-36',' ','36-54',' ','54-72',' ','72-90',' '], CHARSIZE=plotchsz, THICK=5, XTHICK=5, YTHICK=5
OPLOT,[0,1],[affe(0),affe(0)], THICK=5
OPLOT,[4,5],[affe(4),affe(4)], THICK=5
psshows, -.75, (31.5)/30.*35, '!{32}/', /DATA, /YCENTER, SIZE=1.2
psshows, -.9, (32)/30.*35, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, -.6, (31)/30.*35, '!{31}#176', /DATA, /YCENTER, SIZE=1.2
psshows, 5.1, -2.6, '!{31}#176', /DATA, SIZE=1.4

psexit
END

