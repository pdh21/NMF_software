pro closeps

;+
; NAME:
;	CLOSEPS
;
; Based on Seb's ENDPS
;
; To be used together with closeps, e.g.
;
; openps
;
; Plot Commands...
;
; closeps
;
; PURPOSE:
;	Close a PS file with "suitable" plot parameters
; MODIFICATION HISTORY:
;	11 May 2006	Written by Mattia Vaccari
;-

on_error,2

device, /close
set_plot, 'X'
!p.thick=0
!x.thick=0
!y.thick=0
!p.charsize=0
!p.charthick=0
;!x.charsize=0
;!y.charsize=0
;!p.font=-1

end
