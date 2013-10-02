;+
; NAME:
; GMM_NMF_classifier
;
;
; PURPOSE:
; give probability of belonging to one of the 5 clusters defined
; in Hurley et al. 2103
;
;
; CATEGORY:
;
;
;
; CALLING SEQUENCE:
;
;
;
; INPUTS:
; lambda=wavelength of spectrum to classify
; flux= flux density of spectrum to classify
; sigma=uncertianty of spectrum (in same units as flux)
;
;
; OPTIONAL INPUTS:
;
;
;
; KEYWORD PARAMETERS:
;
;
;
; OUTPUTS:
; prob_clust=a 5 element array containing probability of being in one
; of the five clusters
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
; v1.0 by Peter Hurley, Sussex
;-

pro get_GMM_cluster_pdf,weights,GMMstruct,probs
;-------- used by GMM_NMF_classifier----------
; uses ajs_gaussnd.pro by A. Smith
no_gaussians=n_elements(GMMstruct)
probs=fltarr(no_gaussians)
for j=0,no_gaussians -1 DO BEGIN
probs[j]=ajs_gaussnd(amp=GMMstruct[j].prob,weights,mean=GMMstruct[j].centres,cov=GMMstruct[j].covar)
ENDFOR
return
end

pro GMM_NMF_classifier, lambda, flux, sigma,prob_clust
restore, './NMF_software/NMF_components.sav'
restore, './NMF_software/GMMclusters.sav'
;GMM classifier works by comparing objects with spectra normalised over the 5-15micron range
av_ind=where(lambda gt 5 and lambda lt 15)
flux=flux/avg(flux[av_ind])
sigma=sigma/avg(flux[av_ind])
NMF7_fit,lambda,flux,sigma,wavelength,H,weights, CHI_nu=chi_nu
get_GMM_cluster_pdf,weights,clusters,probs
pdf_temp=total(probs[*],/cumulative)/total(probs[*])
prob_clust=fltarr(5)

;to work out the probability of belonging in each class,
;we randomly assign a galaxy to one of the clusters, with probabiluty
;proportional to the pdf for each cluster (See Hurley et al. 2013 
;for more details) we do this 100 times
for k=0,99 DO BEGIN
rand=randomu(seed,1)
ind_pdf_temp=where(pdf_temp gt rand[0])
prob_clust[ind_pdf_temp[0]]=prob_clust[ind_pdf_temp[0]]+1
endfor
end


