PRO film3, ENC=enc, border=border

; postscript-file oeffnen
IF KEYWORD_SET(enc) THEN BEGIN
	psp,"film3",/times,/enc
ENDIF ELSE psp,"film3",/times

; all fonts --> postscript fonts
!P.FONT=0

; dimensionen der grafik bestimmen (cm)
textwidth  = 16.5
textheight = 28.5
voffset    =  2.
hoffset    =  1.7
DEVICE, /PORTRAIT, XSIZE=textwidth, YSIZE=textheight, XOFFSET=hoffset, YOFFSET=voffset

; rahmen um die grafik zeichnen
IF KEYWORD_SET(border) THEN PLOT, [0,0],[1,1], POSITION=[0,0,1,1], TICKLEN=0, /NOERASE, XTICKNAME=REPLICATE(" ",6), YTICKNAME=REPLICATE(" ",6)

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
OPENR, UNIT, "Map.0000", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
odop1 = 255 * (R(*,*,4)-MIN(R(*,*,4)))/(MAX(R(*,*,4))-MIN(R(*,*,4)))
odop1 = (255-odop1)>0

; bild1 laden
r = FLTARR(40,40,3)
OPENR, UNIT, "Map.5000", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,3)
od1 = 255 *(R(*,*,2)-MIN(R(*,*,2)))/(MAX(R(*,*,2))-MIN(R(*,*,2)))
od1 = (255-od1)>0

; bild2 laden
r = FLTARR(40,40,5)
OPENR, UNIT, "Map.0023", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
odop2 = 255 * (R(*,*,4)-MIN(R(*,*,4)))/(MAX(R(*,*,4))-MIN(R(*,*,4)))
odop2 = (255-odop2)>0

; bild2 laden
r = FLTARR(40,40,3)
OPENR, UNIT, "Map.5023", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,3)
od2 = 255 * (R(*,*,2)-MIN(R(*,*,2)))/(MAX(R(*,*,2))-MIN(R(*,*,2)))
od2 = (255-od2)>0

; bild3 laden
r = FLTARR(40,40,5)
OPENR, UNIT, "Map.0060", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
odop3 = 255 * (R(*,*,4)-MIN(R(*,*,4)))/(MAX(R(*,*,4))-MIN(R(*,*,4)))
odop3 = (255-odop3)>0

; bild1 laden
r = FLTARR(40,40,3)
OPENR, UNIT, "Map.5060", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,3)
od3 = 255 * (R(*,*,2)-MIN(R(*,*,2)))/(MAX(R(*,*,2))-MIN(R(*,*,2)))
od3 = (255-od3)>0

; bild4 laden
r = FLTARR(40,40,5)
OPENR, UNIT, "Map.0154", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,5)
odop4 = 255 * (R(*,*,4)-MIN(R(*,*,4)))/(MAX(R(*,*,4))-MIN(R(*,*,4)))
odop4 = (255-odop4)>0

; bild4 laden
r = FLTARR(40,40,3)
OPENR, UNIT, "Map.5154", /GET_LUN
READU, UNIT, r
FREE_LUN, UNIT
r = REBIN(r,4*40,4*40,3)
od4 = 255 * (R(*,*,2)-MIN(R(*,*,2)))/(MAX(R(*,*,2))-MIN(R(*,*,2)))
od4 = (255-od4)>0

im_offx1   = textwidth - im_xsz - .5
TV, ROT(odop1,90), (im_offx+im_offx1)/2., 3+im_offy+3*im_ysz+3*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT
TV, ROT(odop2,90), im_offx, im_offy+2*im_ysz+2*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
TV, ROT(odop3,90), im_offx, im_offy+1*im_ysz+1*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
TV, ROT(odop4,90), im_offx, im_offy+0*im_ysz+0*ymrgn-0.5, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
ARROW, ((im_offx+im_offx1+im_xsz)/2.)/textwidth, (3+im_offy+3*im_ysz+3*ymrgn+1.0)/textheight, (7.5)/textwidth, (19.5)/textheight, /NORMAL, THICK=5, /SOLID, HTHICK=3
ARROW, ((im_offx+im_offx1+im_xsz)/2.)/textwidth, (3+im_offy+3*im_ysz+3*ymrgn+1.0)/textheight, (13.5)/textwidth, (19.5)/textheight, /NORMAL, THICK=5, /SOLID, HTHICK=3

; labels ausgeben
psshows, 2.6/textwidth, (im_offy-0.7+1*im_ysz+0*ymrgn+1.0)/textheight, '!{32}~', SIZE=label_chsz*2, /NORMAL, /XCENTER
psshows, 2.6/textwidth, (im_offy-0.7+1*im_ysz+0*ymrgn+0.8)/textheight, '!{32}~', SIZE=label_chsz*2, /NORMAL, /XCENTER
psshows, 1.1/textwidth, 0, '!{32}t/!{31}t', SIZE=label_chsz*2, /NORMAL, ROTATE=-90
ARROW, 2.6/textwidth, 1, 2.6/textwidth, 0.2/textheight, /NORMAL, THICK=10, HTHICK=4, HSIZE=800, /SOLID

im_offx   = textwidth - im_xsz - .5
TV, ROT(od2,90), im_offx, im_offy+2*im_ysz+2*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
TV, ROT(od3,90), im_offx, im_offy+1*im_ysz+1*ymrgn+1.0, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 
TV, ROT(od4,90), im_offx, im_offy+0*im_ysz+0*ymrgn-0.5, XSIZE=im_xsz, YSIZE=im_ysz, /CENT 

psexit
END
