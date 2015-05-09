PRO odop_pict, ENCAPSULATED=enc, BORDER=border
COMMON NET1, R, S, xramp, yramp
COMMON NET2, x_dim, y_dim, z_dim, dx, eta
COMMON PAR1, radius, sigma_start, sigma_krit, sigma_end, var
COMMON PAR2, n_epoche, n_stim, k_max, tau, dt, dsigma
COMMON PLOTPARAMS, ppvar1, ppvar2, ppvar3, ppvar4
COMMON READWRITE, n_save, offset, n_digits

; Postscript-File oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
	psp, "odop_pict", /TIMES, /ENC
ENDIF ELSE psp, "odop_pict", /TIMES

; all fonts --> postscript fonts
!P.FONT=0

; Dimensionen der Seite bestimmen (cm)
textwidth  = 11.
textheight =  8.7
voffset    =  2.
hoffset    =  2.

; Seite einrichten
DEVICE, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset, /COLOR, BITS_PER_PIXEL=8

; Rahmen um die Seite zeichnen
IF KEYWORD_SET(border) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

; Plotabmessungen und -abstaende festlegen (cm)
plt_xsz  = 6.
plt_ysz  = 6.0
plt_offx = 1.6
plt_offy = 1.0

; Abstaende festlegen (cm)
ymrgn = 4.0
xmrgn = 3.5

; charsizes festlegen
plotchsz = 0.8
lablchsz = 2.5

@~/idl/siegrid/col
Readmap,2
r = REBIN(r,x_dim*4,y_dim*4,z_dim)
TVSCL, ATAN(r(*,*,2),r(*,*,3)), 0., 0, XSIZE=11, /CENT
pos=[0/textwidth,0/textheight,11/textwidth,(8.66666)/textheight]
LOADCT, 0
CONTOUR, R(*,*,4), XSTYL=5, YSTYL=5, LEVELS=[0.0], THICK=8, /NORMAL, /NOERASE, POSITION=pos, C_COLORS=[0,0,0]

psexit
END
