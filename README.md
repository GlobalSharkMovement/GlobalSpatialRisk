# GlobalSpatialRisk
Repository containing raw data, R scripts and the GSMP Rpackage for the manuscript "Global spatial risk assessment of sharks under the footprint of fisheries"

## r_scripts

### \1a_dit

	\\1_dit_calc.r

		Calculate point density for individual daily geolocations.
		
		Additional notes:
		 - Example "track_points.csv" contains example data for script reproducibility purposes.

	\\2_dit_month_calc.r

		Calculate monthly shark relative density (Dit) for each individual shark in a spatial grid

### \1b_gfw

	\\1_create_gfw_raster.r

		Calculate monthly rasters of GFW and between-year averages
		
		Additional notes:
		 - Original data obtained from Global Fishing Watch https://globalfishingwatch.org/

### \2_fei

	\\1_fei_calc.r

		Calculate fishing exposure index (FEI) and percent overlap (%) for each ID in each month
		
		Additional notes:
		 - Example directory "\dit_month_from_1a\" contains example data for script reproducibility purposes, as an output of script "2_dit_month_calc.r".
		 - Example file "eg_grid_data.csv" contains example data for script reproducibility purposes.
		 - Example file "eg_metadata.csv" contains example data for script reproducibility purposes.


	\\2_fei_summ_stats.r

		Summary statistics of FEI or % for each ID
		
		Additional notes:
		 - Provided derived data for each tracked ID
		 
	\\3_fei_summ_stats_month.r

		Summary statistics of FEI or % for each ID, monthly
		
		Additional notes:
		 - Example directory "2_fei\examples\output\" contains example data for script reproducibility purposes, as an output of script "1_fei_calc.r"
		 

### \3_summ_table

	\\1_create_summ_table.r

		Summary statistics per species/region

### \4_risk_plot

	\\1_create_input_table.r

		Create input table for the risk plots; all species within a region

	\\2_risk_plot.r

		Risk plots; all species within a region

### \5_risk_plot_month

	\\1_fei_summ_stats_month.r

		Summary statistics for FEI or % for each ID per month

	\\2_create_input_table_month.r

		Create input table for the risk plots; monthly data for a given species within a region

	\\3_risk_plot_month.r

		Risk plots; monthly data for a given species within a region


# GSMP_Rpackage

	Package to calculate Fishing Exposure Index and Risk based on telemetry data
   

# raw_data

	Metadata

	Shark data

	Rasters of Dit, GFW and FEI