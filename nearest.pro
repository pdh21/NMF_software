pro nearest, newlam, oldlam, inds
;find nearest neighbour for spectra and returns indicees in oldlam 
; newlam=lambda values you want (spectra)
; oldlam is array of values you are searching (e.g. templates)
;inds is an output array of indices for oldlam which are nearest to newlam values
;; newlam=oldlam[inds]
  inds=fltarr(n_elements(newlam))
  c=fltarr(n_elements(oldlam))
  for i=0, n_elements(newlam)-1 DO BEGIN
     for j=0, n_elements(oldlam)-1 DO BEGIN
        c[j]=0
        c[j]=abs(newlam[i]-oldlam[j])
     Endfor
     v=min(c,ind)
     inds[i]=ind
  ENDFOR
  return
END