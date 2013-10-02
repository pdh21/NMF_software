FUNCTION MY_CHISQ,x,y ,error

;;procedure to calculate chi squared statistic
;;INPUTS
;;      x = vector containing the values you are interested in
;;      error = vector containing the values of the error
;;      associated with each x. This wants to be sigma
;;OUTPUTS
;;     chisq = chi squared statistic of the distribution


;;INPUTS
;;     x = the observed value
;;     y = the expected value


  difference = x - y
  IF n_params() eq 3 then begin
     diffOverErr = difference/error

     chisq = total(diffOverErr^2)


  ENDIF ELSE BEGIN
     chisq=total(difference^2)
  ENDELSE
  RETURN, chisq

END 