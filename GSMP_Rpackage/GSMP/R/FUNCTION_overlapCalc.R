overlapCalc <- function(mon = c('01','02','03','04','05','06','07','08','09','10','11','12'),
                        sp, boatPath, shkPath, analyse = 'overlap', ncores = 1)
{
  # Clean rubbish
  gc()

  # PACKAGES #
  require(foreach)
  require(raster)


  # CAN BE PARALLELIZED...
  print('Processing in parallel... ')

  cl = parallel::makeCluster(ncores)
  doParallel::registerDoParallel(cl, cores = ncores)


  # Empty list to hold data
  spOverLs <- list()

  # Loop for each month
  for(m in mon)
  {
    #  m <- mon[1]

    # Read boat data
    boatRst <- raster(boatPath[grepl(paste0('_',m), basename(boatPath))])

  #  plot(boatRst)

    boatRst[is.na(boatRst)] <- NA


    # List of IDs for each species
    ids <- shkPath[grepl(paste0('_', m,'_'), basename(shkPath))]


    if(length(ids) == 0)
    {next}

    # Loop for each id

    overlapSp = foreach::foreach(id = ids, .export = ls(),
                                 .combine = rbind,
                                 .packages = (.packages())) %dopar%{

                                   # Read shark raster
                                   rst <- raster(id)

                                   # Raster to points
                                   rstPts <- as.data.frame(rasterToPoints(rst), xy = TRUE)

                                   if(nrow(rstPts) == 0)
                                   {next}

                                   coordinates(rstPts) <- ~ x + y


                                   if(analyse == 'overlap')
                                   {
                                     # Values of shark density (dit)
                                     dit <- as.numeric(unlist(rstPts@data))

                                     # Number of cells
                                     nCell <- rep(1, length(dit))

                                     # Total shark nCells
                                     nCellShr <- sum(nCell)

                                     # Total shark dit
                                     ditShr <- sum(dit)
                                   }

                                   # Extract number of days fishing for each grid cell of the shark
                                   nBoat <- raster::extract(boatRst, coordinates(rstPts))

                                   nBoat[is.na(nBoat)] <- 0

                                   if(analyse == 'overlap')
                                   {
                                     # Number of cells with a boat
                                     nCellBoat <- sum(nCell[which(nBoat>0)])

                                     # Calculate point overlap
                                     overlap <- (nCellBoat/nCellShr)*100

                                     # Add species and id
                                     overlapTbl <- data.frame('spp' = sp, 'id' = gsub(".tif", "", basename(id)), 'dit' = ditShr, nCellShr, nCellBoat, overlap)

                                   } else {

                                     # Join dit and number of boats in a table
                                     overlapTbl <- as.data.frame(rstPts)
                                     colnames(overlapTbl)[3] <- 'dit'

                                     overlapTbl$nBoats <- nBoat

                                     # Calculate point effort
                                     overlapTbl$effort <- overlapTbl$nBoats * overlapTbl$dit

                                     # Add species and id
                                     overlapTbl <- data.frame('spp' = sp, 'id' = gsub(".tif", "", id), overlapTbl)
                                   }
                                   return(overlapTbl)
                                 } # end loop for each id




    # Join all species in a list
    spOverLs[[which(mon == m)]] <- overlapSp

  } # End loop for each month


    parallel::stopCluster(cl)
    closeAllConnections()
  return(spOverLs)
}
