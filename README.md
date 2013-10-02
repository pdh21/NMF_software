NMF_software
============

Software for fitting and classifying IRS galaxy spectra with the NMF components described in Hurley et al. 2013

An example idl script (example_script.pro) is provided to demonstrate the fitting and classifying procedures.

To run the code:

1) Download into a suitable directory within your IDL path

2) Download the bvls.pro script from http://www-astro.physics.ox.ac.uk/~mxc/idl/bvls.pro

3) Start idl within the NMF_software directory and run example_script.pro

4) IDL should output a postscript plot (example_IRAS_10378+1108fit.ps) of the NMF fit and give 
the probability of being in the Sy1, Sbrst, Sy2, Sy1.5 or Dusty cluster

5) The NMF components and wavelength array are contained within NMF_components.sav (for use within idl), as well as NMF_components.ascii
for use outside idl.

Feel free to edit/use code and NMF_components and classifier, but please cite Hurley et al. 2013.


List of files and description:
==============================

GMM_NMF_classifier.pro: Calculates the probability of belonging to one of the 5 clusters

GMMclusters.sav: IDL structure containing normalisation, centres and covariance matrices to decribe each cluster

IRAS_10378+1108.dat: Example IRS spectrum

NMF7_fit.pro: Main code to fit the 7 NMF componentns to a galaxy spectrum (requires bvls.pro)

NMF_components.ascii: Wavelength and flux density of NMF components in ascii form for use outside IDL

NMF_components.sav: Wavelength and flux density of NMF components in IDL's native '.sav' format. 

ajs_gaussnd.pro: Calculates the pdf value for each of the five clusters, at any point in NMF space. (uses GMMclusters.sav)

closeps.pro: Useful bit of IDL code to to tidy up postscript device within IDL when plotting

example_script.pro: Example IDL script to demonstrate use of NMF components and classifier

my_chisq.pro: Calculates chi square
nearest.pro: Does nearest neighbour interpolation
