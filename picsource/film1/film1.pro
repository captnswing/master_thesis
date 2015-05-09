PRO film1, ENC=enc, border=border

; postscript-file oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
	psp,"film1",/times,/enc
ENDIF ELSE psp,"film1",/times

; all fonts --> postscript fonts
!P.FONT=0

; dimensionen der grafik bestimmen (cm)
textwidth  = 16.5
textheight = 25.5
voffset    =  2.
hoffset    =  1.7
DEVICE, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset, BITS_PER_PIXEL=8, /COLOR

; rahmen um die grafik zeichnen
IF KEYWORD_SET(border) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

; colortable
ncolors    = !D.N_COLORS
opcolors   = 16
red   = BYTE(FINDGEN(ncolors)/(ncolors-opcolors-1)*255)	
blue  = BYTE(FINDGEN(ncolors)/(ncolors-opcolors-1)*255)	
green = BYTE(FINDGEN(ncolors)/(ncolors-opcolors-1)*255)	
col1=[0,100,180,255,255,255,255,255,255,210,140,40,0,0,0,0]
col2=[0,0,0,0,0,90,150,210,255,255,255,255,255,200,140,80]
col3=[255,255,255,122,0,0,0,0,0,0,0,0,0,50,150,255]
red((ncolors-opcolors):*)   = col1
green((ncolors-opcolors):*) = col2
blue((ncolors-opcolors):*)  = col3
grey                        = 0.8 * [255B,255B,255B]
factor = [0.0502409,0.1768052,0.50592,1]
RESTORE, "ranges.dat"

; abstaende festlegen (cm)
ymrgn     = 1.2
xmrgn     = 1.6

; bildabmessungen und -abstaende festlegen (cm)
im_xsz    = 4.7
im_ysz    = 4.7
im_offx   = 4.7
im_offy   = 2.0

; sizes festlegen
label_chsz = 2

; bild1 laden
r = FLTARR(40,40,5)
OPENR, UNIT, "Map.0050", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
od1 = R(*,*,4)
op1 = (ATAN(R(*,*,2),R(*,*,3))+!DPI)/!DPI*(opcolors-1)/2
op1 = FIX(op1+0.5)
op1 = BYTE(op1) + BYTE(ncolors-opcolors)
od1 = 255 * (R(*,*,4) - range(0,4))/(range(1,4) - range(0,4))

red((ncolors-opcolors):*)   = factor(0) * (col1-grey(0)) + grey(0)  
green((ncolors-opcolors):*) = factor(0) * (col2-grey(1)) + grey(1)
blue((ncolors-opcolors):*)  = factor(0) * (col3-grey(2)) + grey(2)
TVLCT, red, green, blue
TV, ROT(op1,90), im_offx, im_offy+3*im_ysz+3*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT

; bild2 laden
r = FLTARR(40,40,5)
OPENR, UNIT, "Map.0130", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
op2 = (ATAN(R(*,*,2),R(*,*,3))+!DPI)/!DPI*(opcolors-1)/2
op2 = FIX(op2+0.5)
op2 = BYTE(op2) + BYTE(ncolors-opcolors)
od2 = 255 * (R(*,*,4) - range(0,4))/(range(1,4) - range(0,4))
red((ncolors-opcolors):*)   = factor(1) * (col1-grey(0)) + grey(0)  
green((ncolors-opcolors):*) = factor(1) * (col2-grey(1)) + grey(1)
blue((ncolors-opcolors):*)  = factor(1) * (col3-grey(2)) + grey(2)
TVLCT, red, green, blue
TV, ROT(op2,90), im_offx, im_offy+2*im_ysz+2*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 

; bild3 laden
r = FLTARR(40,40,5)
OPENR, UNIT, "Map.0260", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
op3 = (ATAN(R(*,*,2),R(*,*,3))+!DPI)/!DPI*(opcolors-1)/2
op3 = FIX(op3+0.5)
op3 = BYTE(op3) + BYTE(ncolors-opcolors)
od3 = 255 * (R(*,*,4) - range(0,4))/(range(1,4) - range(0,4))
red((ncolors-opcolors):*)   = factor(2) * (col1-grey(0)) + grey(0)  
green((ncolors-opcolors):*) = factor(2) * (col2-grey(1)) + grey(1)
blue((ncolors-opcolors):*)  = factor(2) * (col3-grey(2)) + grey(2)
TVLCT, red, green, blue
TV, ROT(op3,90), im_offx, im_offy+1*im_ysz+1*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 

; bild4 laden
r = FLTARR(40,40,5)
OPENR, UNIT, "Map.0400", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
op4 = (ATAN(R(*,*,2),R(*,*,3))+!DPI)/!DPI*(opcolors-1)/2
op4 = FIX(op4+0.5)
op4 = BYTE(op4) + BYTE(ncolors-opcolors)
od4 = 255 * (R(*,*,4) - range(0,4))/(range(1,4) - range(0,4))
red((ncolors-opcolors):*)   = factor(3) * (col1-grey(0)) + grey(0)  
green((ncolors-opcolors):*) = factor(3) * (col2-grey(1)) + grey(1)
blue((ncolors-opcolors):*)  = factor(3) * (col3-grey(2)) + grey(2)
TVLCT, red, green, blue
TV, ROT(op4,90), im_offx, im_offy+0*im_ysz+0*ymrgn-0.5, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 

LOADCT, 0

; labels ausgeben
psshows, 2.6/textwidth, (im_offy-0.7+3*im_ysz+2*ymrgn+1.9)/textheight, '!{32}-', SIZE=label_chsz*2, /NORMAL, /XCENTER
psshows, 2.6/textwidth, (im_offy-0.7+2*im_ysz+1*ymrgn+1.9)/textheight, '!{32}-', SIZE=label_chsz*2, /NORMAL, /XCENTER
psshows, 1.6/textwidth, (im_offy-0.7+3*im_ysz+2*ymrgn+1.9)/textheight, '!{32}T!m!DOD!d!b!U*!u', SIZE=label_chsz, /NORMAL, /XCENTER, ROTATE=-90
psshows, 1.6/textwidth, (im_offy-0.7+2*im_ysz+1*ymrgn+1.9)/textheight, '!{32}T!m!DOP!d!b!U*!u', SIZE=label_chsz, /NORMAL, /XCENTER, ROTATE=-90
psshows, 2.6/textwidth, (im_offy-0.7+1*im_ysz+0*ymrgn+1.0)/textheight, '!{32}~', SIZE=label_chsz*2, /NORMAL, /XCENTER
psshows, 2.6/textwidth, (im_offy-0.7+1*im_ysz+0*ymrgn+0.8)/textheight, '!{32}~', SIZE=label_chsz*2, /NORMAL, /XCENTER
psshows, 1.1/textwidth, 0, '!{32}t/!{31}t', SIZE=label_chsz*2, /NORMAL, ROTATE=-90
ARROW, 2.6/textwidth, 0.98, 2.6/textwidth, 0.2/textheight, /NORMAL, THICK=10, HTHICK=4, HSIZE=800, /SOLID

im_offx   = textwidth - im_xsz - .5

TV, ROT(255-od1,90), im_offx, im_offy+3*im_ysz+3*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
TV, ROT(255-od2,90), im_offx, im_offy+2*im_ysz+2*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
TV, ROT(255-od3,90), im_offx, im_offy+1*im_ysz+1*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
TV, ROT(255-od4,90), im_offx, im_offy+0*im_ysz+0*ymrgn-0.5, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 

psexit
END
