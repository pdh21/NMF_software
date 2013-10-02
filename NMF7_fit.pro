;+
; NAME: NMF7_fit.pro
;
;
;
; PURPOSE: 
;Given a MIR IRS spectra of a galaxy, fit with the 7 NMF
; components described in Hurley et al. 2013.
;
;
;
; CATEGORY:
;
;
;
; CALLING SEQUENCE:
; NMF7_fit,lambda,flux,sigma,weights
;
;
;
; INPUTS:
; lambda=wavelength of spectrum (in microns)
; flux=flux density (e.g. in units of Jy)
; sigma=uncertianty (same units as flux)
;
; Requires wavelength and H from ./NMF_software/NMF_components.sav
; wavelength=wavelength of NMF7 set (ranging from 5 to 30 microns),
;      float array [499]
; H=components, double array[499,7]
; OPTIONAL INPUTS:
;
;
;
; KEYWORD PARAMETERS:
;
;
;
; OUTPUTS:
;weights= a fltarr containing the weights for the 7 NMF components
;
;
; OPTIONAL OUTPUTS:
;
;
;
; COMMON BLOCKS:
;
;
;
; SIDE EFFECTS:
;
;
;
; RESTRICTIONS:
;NMF7_fit makes use of the bvls idl code written by
; Michele Cappallari http://www-astro.physics.ox.ac.uk/~mxc/idl/
;
;
; PROCEDURE:
;
;
;
; EXAMPLE:
;
;
;
; MODIFICATION HISTORY:
; v1.0: Written by Peter Hurley, Sussex 2013
;-
pro NMF7_fit,lambda,flux,sigma,wavelength,H,weights, CHI_nu=chi_nu

;The NMF templates are only suitbale for 5 to 30 microns
;so only use range of data in this range
range=where(lambda gt 5 and lambda lt 30)
lambda=lambda[range]
flux=flux[range]
sigma=sigma[range]

;Interpolate the templates onto the wavelength grid of the data
nearest,lambda, wavelength, inds
;create an array to put the flux in (easier to deal with for bvls)
sed=fltarr(1,n_elements(lambda))

sed[0,*]=flux
esed=sed
esed[0,*]=sigma

;if sigma is less than 5% of flux, set to 5% of flux value
;(according to IRS handbook uncertianty should not be less than 5%)
;--------------------------------
eind=where(esed lt 0.05*flux,neind)
if neind gt 0 then esed[0,eind]=0.05*flux[eind]
;------------------------------------------

templates=H[inds,*]

sed_ind=where(sed[0,*] gt 0.0,ngood)
if ngood eq 0 then return
bet=(sed[0,sed_ind]/(esed[0,sed_ind]^2.0))#templates[sed_ind,*]
bet=reform(bet)

templates_temp=templates[sed_ind,*]
for j=0,n_elements(templates[0,*])-1 DO templates_temp[*,j]=templates[sed_ind,j]/esed[0,sed_ind]
alpha=templates_temp##transpose(templates_temp)
BND=fltarr(2,n_elements(templates[0,*]))
BND[0,*]=0.0
BND[1,*] =1.0E90
bvls, alpha,bet,BND,well,IERR=ierr,ITMAX=500
chi_nu=my_chisq(sed[0,sed_ind],well##templates[sed_ind,*],esed[0,sed_ind])/(ngood-7)
weights=well
return
end
