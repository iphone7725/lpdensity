{smcl}
{* *! version 0.1 07Jul2017}{...}

{title:Title}

{p 4 8}{cmd:lpbwdensity} {hline 2} Bandwidth Selection for Local Polynomial Density Estimation and Inference.{p_end}


{marker syntax}{...}
{title:Syntax}

{p 4 8}{cmd:lpbwdensity} {it:var} {ifin} 
[{cmd:,} 
{cmd:grid(}{it:var}{cmd:)} 
{cmd:p(}{it:#}{cmd:)}
{cmd:v(}{it:#}{cmd:)}
{cmd:bwselect(}{it:BwMethod}{cmd:)}
{cmd:kernel(}{it:KernelFn}{cmd:)}
{cmd:cweights(}{it:var}{cmd:)}
{cmd:pweights(}{it:var}{cmd:)}
{cmd:genvars(}{it:VarName}{cmd:)}
{cmd:separator(}{it:#}{cmd:)}
{cmd:regularize}
]{p_end}

{synoptset 28 tabbed}{...}

{marker description}{...}
{title:Description}

{p 4 8} {cmd:lpdensity} implements the bandwidth selector for local polynomial based density (and derivatives) estimation, proposed in 
{browse "http://www-personal.umich.edu/~cattaneo/papers/Cattaneo-Jansson-Ma_2017_LocPolDensity.pdf":Cattaneo, Jansson and Ma (2017a)}. 
See {browse "http://www-personal.umich.edu/~cattaneo/papers/Cattaneo-Jansson-Ma_2017_lpdensity.pdf":Cattaneo, Jansson and Ma (2017b)} for more 
implementation details and illustrations.{p_end}

{p 8 8}Companion {browse "www.r-project.org":R} functions are also available {browse "https://sites.google.com/site/nppackages/lpdensity":here}.{p_end}

{p 4 8}Related Stata and R packages useful for nonparametric estimation and inference are described in the following website:{p_end}

{p 8 8}{browse "https://sites.google.com/site/nppackages/":https://sites.google.com/site/nppackages/}{p_end}



{marker options}{...}
{title:Options}

{p 4 8}{opt gri:d}({it:var}) specifies the grid on which density is estimated. When set to default, grid points will be chosen as 0.05-0.95
percentiles of the data, with 0.05 step size.{p_end}

{p 4 8}{opt p}({it:#}) specifies the the order of the local-polynomial used to construct point estimates.
Default is {cmd:p(2)} (local quadratic regression).{p_end}

{p 4 8}{opt v}({it:#}) specifies the derivative of distribution function to be estimated. {cmd:v(0)} for
the distribution function, {cmd:v(1)} (default) for the density funtion, etc.{p_end}

{p 4 8}{opt bws:elect}({it:BwMethod}) specifies method for data-driven bandwidth selection. This option will be
ignored if {cmd:bw(}{it:var}{cmd:)} is provided.
Options are:{p_end}
{p 8 12}{opt mse-dpi} for mean squared error-optimal bandwidth selected for each grid point. This is the default option.{p_end}
{p 8 12}{opt imse-dpi} for integrated MSE-optimal bandwidth, common for all grid points.{p_end}
{p 8 12}{opt mse-rot} for rule-of-thumb bandwidth with Gaussian reference model.{p_end}
{p 8 12}{opt imse-rot} for integrated rule-of-thumb bandwidth with Gaussian reference model.{p_end}

{p 4 8}{opt ker:nel}({it:KernelFn}) specifies the kernel function used to construct the local-polynomial estimator(s). Options are: {opt triangular}, {opt epanechnikov}, and {opt uniform}.
Default is {opt triangular}.{p_end}

{p 4 8}{opt cw:eights}({it:var}) specifies weights used for counterfactual distribution construction.{p_end}
 
{p 4 8}{opt pw:eights}({it:var}) specifies weights used in sampling. Should be nonnegative.{p_end}

{p 4 8}{opt gen:vars}({it:VarName}) specified if new varaibles should be generated to store estimation results. If {it:VarName} is provided, the following new varaibles will be
generated: {p_end}
{p 8 12}{it:VarName_grid} (grid points), {p_end}
{p 8 12}{it:VarName_bw} (bandwidth), {p_end}
{p 8 12}{it:VarName_nh} (effective sample size).{p_end}

{p 4 8}{opt sep:arator}({it:#}) draw separator line after every {it:#} variables; default is separator(5).{p_end}

{p 4 8}{opt noreg:ularize} suppresses the feature that bandwidth is chosen such that at least 20 + {cmd:p(}{it:#}{cmd:)} + 1 observations will be included.{p_end}

    
{hline}
	
		
{marker examples}{...}
{title:Examples}

{p 4 8}Generate artifitial data:{p_end}
{p 8 8}{cmd:. set obs 1000}{p_end}
{p 8 8}{cmd:. set seed 42}{p_end}
{p 8 8}{cmd:. gen lpd_data = rnormal()}{p_end}

{p 4 8}MSE-optimal bandwidths for empirical quantiles: {p_end}
{p 8 8}{cmd:. lpbwdensity lpd_data}{p_end}

{p 4 8}Save estimation results to variables:{p_end}
{p 8 8}{cmd:. capture drop temp_*}{p_end}
{p 8 8}{cmd:. lpbwdensity lpd_data, genvars(temp)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{p 4 8}{cmd:lpbwdensity} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}sample size{p_end}
{synopt:{cmd:e(p)}}option {cmd:p(}{it:#}{cmd:)}{p_end}
{synopt:{cmd:e(v)}}option {cmd:v(}{it:#}{cmd:)}{p_end}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(bwselect)}}option {cmd:bwselect(}{it:BwMethod}{cmd:)}{p_end}
{synopt:{cmd:e(kernel)}}option {cmd:kernel(}{it:KernelFn}{cmd:)}{p_end}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(result)}}estimation result{p_end}

{title:References}

{p 4 8}Cattaneo, M. D., Michael Jansson, and Xinwei Ma. 2017a. {browse "http://www-personal.umich.edu/~cattaneo/papers/Cattaneo-Jansson-Ma_2017_LocPolDensity.pdf":Simple Local Polynomial Density Estimators}.{p_end}
{p 8 8}Working paper, University of Michigan.{p_end}

{p 4 8}Cattaneo, M. D., Michael Jansson, and Xinwei Ma. 2017b. {browse "http://www-personal.umich.edu/~cattaneo/papers/Cattaneo-Jansson-Ma_2017_lpdensity.pdf":lpdensity: Local Polynomial Density Estimation and Inference}.{p_end}
{p 8 8}Working paper, University of Michigan.{p_end}

{title:Authors}

{p 4 8}Matias D. Cattaneo, University of Michigan, Ann Arbor, MI.
{browse "mailto:cattaneo@umich.edu":cattaneo@umich.edu}.

{p 4 8}Michael Jansson, University of California at Berkeley, Berkeley, CA.
{browse "mailto:mjansson@econ.berkeley.edu":mjansson@econ.berkeley.edu}.

{p 4 8}Xinwei Ma, University of Michigan, Ann Arbor, MI.
{browse "mailto:xinweima@umich.edu":xinweima@umich.edu}.


