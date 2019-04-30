# dta <- ID|date|x|y

ditFun <- function(dta){

	#### 1: Number of days after tagging ####

	for(i in unique(dta$ID))
	{
	  #  i <- unique(dta$ID)[1]
	  
	  trackDate <- as.Date(dta$date[dta$ID == i])
	  
	  # First day of the track
	  day1 <- min(trackDate)
	  
	  # Time distance to the start of the track  
	  dta$dayNum[dta$ID == i] <- (trackDate - day1)+1
	  
	} # End loop for each ID


	#### 2: Basic time weighting scheme ####

	# For all species, weight each location by the inverse number of IDs for the same relative day of their track #
	  
	  for (it in unique(dta$dayNum)) # Loop for each location
	  {
		#    it <- 1
		
		# IDs with a "t" location
		ijt <- dta$ID[dta$dayNum == it]
		
		# Number of IDs with a "t" location
		njt <- length(ijt) 
		
		# Weight for the "t" location of the "i" individual's track
		wit <- 1/njt
		
		dta$wit[(dta$ID %in% ijt) & (dta$dayNum == it)] <- wit
		
	  } # End Loop for each location
	  
	   
	  #### 3: Implement threshold relative day of the track beyond which location weights are set equal to the weight on that threshold day ####

	  # Track length #
	  
	  # Add empty vector to hold data
	  trackLgt <- NA
	  
	  # Table to save shark days at liberty
	  idTbl <- data.frame('id' = unique(dta$ID), 'daysLib' = NA)

	  for(i in unique(dta$ID)) # Loop for each ID
	  {
		#    i <- unique(dta$ID)[69]
		
		trackLgt[which(unique(dta$ID) == i)] <- max(dta$dayNum[dta$ID == i])
		
		if(is.na(max(dta$dayNum[dta$ID == i])))
		{
		  print(dta$ID[dta$ID == i])
		}
		
		# Save track length for each shark
		idTbl$daysLib[idTbl$ID == i] <- max(dta$dayNum[dta$ID == i])
		
	  } # End loop for each ID
	  

	  # Threshold percentile after which all weights are equal
	  thrPerc <- quantile(trackLgt, (wthr/100))
	  
	  # Minimum day to equalise
	  eqDay <- min(dta$dayNum[dta$dayNum >= thrPerc])
	  
	  # Weight to equalise
	  eqWeight <- unique(dta$wit[dta$dayNum == eqDay])
	  
	  # Set all days after threshold to equal weight
	  dta$wit[dta$dayNum >= thrPerc] <- eqWeight
		 
		
	  # Track length stats
	  lenStats <- data.frame(
	  'av' = mean(trackLgt), # Mean
	  'sd' = sd(trackLgt), # Standard dev
	  'min' = min(trackLgt), # Min
	  'max' = max(trackLgt), # Max
	  'med' = median(trackLgt), # Median
	  'q85' = thrPerc, # Quartile 85 
	  'eqWeight' = eqWeight) # Weight value to equalise
		
	#### 4: Normalization to account for unequal species sample sizes ####
	  
	  # Normalize weights of all species to 1
	  wit <- dta$wit#[dta$spp == j]
	  sumWit <- sum(dta$wit)#[dta$spp == j])
	  
	  # Relative density contribution
	  dta$dit <- wit/sumWit
	  
	return(dta)
}