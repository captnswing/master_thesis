PRO Init, rad, SHOW=show, EPOCHE=epoche, STIMULI=stim, DIGITS=digits, SEED=seed
COMMON NET1, R, S, xramp, yramp
COMMON NET2, x_dim, y_dim, z_dim, dx, eta
COMMON PAR1, radius, sigma_start, sigma_krit, sigma_end, var
COMMON PAR2, n_epoche, n_stim, k_max, tau, dt, dsigma
COMMON PLOTPARAMS, ppvar1, ppvar2, ppvar3, ppvar4
COMMON READWRITE, n_save, offset, n_digits

; check correct invocation
CASE N_PARAMS() OF
	1:    radius = rad
	ELSE: MESSAGE, 'Aufruf: "Init, radius, <EPOCHE=num>, <STIMULI=num>, <DIGITS=num>, </SHOW>"'
ENDCASE

; parameters, parameters, parameters .....
stim_perbox = 50
eta_rel     = 0.025
x_dim       = 182-50
y_dim       = 134-30
z_dim       = 5
dx          = 1/FLOAT(x_dim)
CASE z_dim OF 
	3:    var = (radius^2/3)
	4:    var = (radius^2/4)
	5:    var = (radius^2/4)
	ELSE:	MESSAGE, "'z_dim' muss entweder 3 oder 4 sein!"
ENDCASE
eta         = eta_rel * var
sigma_krit  = sigmakrit()
sigma_start = sigma_krit*1.10
sigma_end   = sigma_krit*0.90
k_max       = kmax(SIGMA=sigma_krit)
tau         = 1./abs(lambda(K=k_max, SIGMA=sigma_end))
tau_relax   = 1./(eta*k_max^2)
dt          = MIN([tau/5.,tau_relax/40.])
dsigma      = (sigma_start - sigma_end) / (20*tau)
minepoche   = (sigma_start-sigma_end)/(dt*dsigma)
CASE z_dim OF 
	3:    minstim = (2*radius)/(2*sigma_end)^z_dim * stim_perbox
	4:    minstim = (!DPI*radius^2)/(2*sigma_end)^z_dim * stim_perbox
	5:    minstim = (2*!DPI*radius^3)/(2*sigma_end)^z_dim * stim_perbox
	ELSE:	MESSAGE, "'z_dim' muss entweder 3,4 oder 5 sein!"
ENDCASE
n_stim      = Roundup(minstim)
n_epoche    = Roundup(minepoche) * 5
n_digits    = 4

; keywords override default settings
IF (N_ELEMENTS(stim) GT 0) THEN n_stim = stim
IF (N_ELEMENTS(digits) GT 0) THEN n_digits = digits
IF (N_ELEMENTS(epoche) GT 0) THEN n_epoche = epoche

; make up startconfiguration
R = FLTARR(x_dim,y_dim,z_dim)
FOR i=0,x_dim-1 DO R(i,*,0) = i*dx
R(*,*,1) = TRANSPOSE(R(*,*,0))
xramp = R(*,*,0)
yramp = R(*,*,1)

; SEED festsetzen
IF (N_ELEMENTS(seed) EQ 0) THEN seed  = LONG(68743543)

; create the 'n_stim' random z_dim-vectors
; that will be presented to the net
S = FLTARR(n_stim,z_dim)
S(*,0:1) = 0.5
CASE z_dim OF 
	3: S(*,2) = 2 * radius * (RANDOMU(seed,n_stim)-0.5)
	4: BEGIN
			index = INDGEN(n_stim)
			REPEAT BEGIN
				S(index,2) = 2 * radius * (RANDOMU(seed,N_ELEMENTS(index))-0.5)
				S(index,3) = 2 * radius * (RANDOMU(seed,N_ELEMENTS(index))-0.5)
				check = S(*,2)^2 + S(*,3)^2
				index = WHERE(check GT radius^2)
			ENDREP UNTIL (index(0) EQ -1)
		END
	5: S(*,2) = 2 * radius * (RANDOMU(seed,n_stim)-0.5)
ENDCASE

; print + plot everything
IF KEYWORD_SET(show) THEN BEGIN
	ppvar1 = minstim
	ppvar2 = minepoche
	plotparams, /TEXT
	oldpmulti = !P.MULTI
	!P.MULTI = [0,2,2]
	IF z_dim GT 4 THEN !P.MULTI = [0,2,3]
	FOR i=0,z_dim-1 DO SURFACE, R(*,*,i)
	!P.MULTI = oldpmulti
ENDIF

RETURN 
END
