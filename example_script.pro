;+
; NAME:
; example_script
;
;
;
; PURPOSE:
; An example script to show:
; 1) how to fit a spectrum with the 7 NMF components
; 2) produce a plot of spectrum with fits (as in Figure C1 in Hurley
; et al 2013)
; 3) how to classify a gaalxy spectrum using the 5 Cluster GMM
; modelling in Hurley et al. 2013)
;
;
; CATEGORY:
;
;
;
; CALLING SEQUENCE:
; example_script
;
;
; INPUTS:
; NONE
;
;
; OPTIONAL INPUTS:
; NONE
;
;
; KEYWORD PARAMETERS:
; NONE
;
;
; OUTPUTS:
; postscipt plot plot
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
;
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
; v1.0 Peter Hurley, Sussex
;-

pro example_script
;----------------load up spectrum--------------------------
;read in example spectrum (in this case IRAS_10378+1108)
readcol, './IRAS_10378+1108.dat',lambda,flux,sigma,format='F'
;move spectrum to restframe
z=0.13622
lambda=lambda/(1.0+z)

;----------------load up components-----------------------
restore,'./NMF_components.sav'


;-----------------fit components-------------------------
NMF7_fit,lambda,flux,sigma,wavelength,H,weights, CHI_nu=chi_nu



;----------------Spectrum and fit plot------------------
;create NMF fit plot (as in Figure C1 in Hurley et al. 2013)
set_plot, 'ps'
device, filename='./example_IRAS_10378+1108fit.ps',/col
!p.font=1
!p.thick=4
!x.thick=4
!y.thick=4
!p.CHARSIZE=1.0
!p.charthick=2
colarray=[fsc_color('brown'),fsc_color('red'), fsc_color('orange'),fsc_color('Spring Green'),fsc_color('Dark Green'),fsc_color('blue'),fsc_color('magenta')]
sed_ind=where(flux gt 0.0)
plot,lambda[sed_ind],flux[sed_ind],position=[0.2,0.5,0.8,0.9],xtickname=REPLICATE(' ', 10),ytitle='Flux density (Jy)'
model=weights##H
oplot,wavelength,model,linestyle=2
for i=0,6 DO BEGIN
oplot,wavelength,weights[i]##H[*,i],color=colarray[i]
ENDFOR
nearest,lambda[sed_ind],wavelength,inds
residuals=(flux[sed_ind]-model[inds])
plot,lambda[sed_ind],residuals,position=[0.2,0.25,0.8,0.45], /noerase,xtitle='Wavelength (microns)',ytitle='Residuals (Jy)'
closeps
;------------------------------------------------------------


;---------------Classification using GMM 5 clusters-----------------------
GMM_NMF_classifier,lambda,flux,sigma,prob_clust
print,'----------classification probability--------------'
print, '    Sy1','    Sbrst', '    Sy2','    Sy1.5', '    Dusty'
print,prob_clust[*]/100.0, format='('+strtrim(5,2)+'F8.2)'


end
