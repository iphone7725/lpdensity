********************************************************************************
** LPDENSITY Stata Package  
** Do-file for Numerica Illustration
** Authors: Matias D. Cattaneo, Michael Jansson and Xinwei Ma
********************************************************************************
** hlp2winpdf, cdn(lpdensity) replace
** hlp2winpdf, cdn(lpbwdensity) replace
********************************************************************************
** net install rddensity, from(https://sites.google.com/site/nppackages/lpdensity/stata) replace
********************************************************************************
clear all
set more off
mata: mata mlib index
set scheme sj

********************************************************************************
** Data
********************************************************************************
import delimited "lpdensity_data.csv", encoding(ISO-8859-1)clear
sum v1

********************************************************************************
** estimation with bandwidth 0.5 on provided grid points
********************************************************************************
// generate grid -2 to 1 by 0.5
gen grid = -2.5 + 0.5 * _n if _n <= 7

lpdensity v1, grid(grid) bw(0.5)
lpdensity v1, grid(grid) bw(0.5) level(90) // 90% CI


********************************************************************************
** estimation with bandwidth 0.5 on quantiles, with and without bias correction
********************************************************************************
lpdensity v1, bw(0.5)
lpdensity v1, bw(0.5) q(2) // conventional CI


********************************************************************************
** simple plot
********************************************************************************
capture drop grid
gen grid = -2.05 + 0.05 * _n if _n <= 61

lpdensity v1, grid(grid) bw(0.5) plot

********************************************************************************
** density plot with splitted data
********************************************************************************
gen gridl = grid if grid <= 0.01
gen gridr = grid if grid >= -0.01

// compute relative sample size
qui count if v1 <= 0
local scalel = r(N) / 2000
qui count if v1 >= 0
local scaler = r(N) / 2000

// run lpdensity and save results
qui lpdensity v1 if v1 <= 0, grid(gridl) bw(0.5) scale(`scalel') genvars(figl)
qui lpdensity v1 if v1 >= 0, grid(gridr) bw(0.5) scale(`scaler') genvars(figr)

twoway 	(rarea figl_CI_l figl_CI_r figl_grid, sort color(gs11)) ///
		(rarea figr_CI_l figr_CI_r figr_grid, sort color(gs11)) ///
		(line figl_f_p figl_grid, lcolor(black) sort lwidth(medthin) lpattern(solid)) ///
		(line figr_f_p figr_grid, lcolor(black) sort lwidth(medthin) lpattern(solid)), ///
		legend(cols(2) order(3 "point estimate" 1 "95% C.I." )) ///
		title("") xtitle("v1") ytitle("")
		
drop figl_* figr_*
		
********************************************************************************
** bandwidth
********************************************************************************
capture drop grid
gen grid = -2.5 + 0.5 * _n if _n <= 7

lpbwdensity v1, grid(grid) // MSE-optimal bandwidth
lpbwdensity v1, grid(grid) bwselect(imse-dpi) // IMSE-optimal bandwidth
		





