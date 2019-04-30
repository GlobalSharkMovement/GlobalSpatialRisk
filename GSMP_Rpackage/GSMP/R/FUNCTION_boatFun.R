boatFun <- function(orgLs, yrMon,
                    type = NULL, impRes = 0.01,
                    res = 1, ext =  matrix(c(-180, 90,
                                             180, 90,
                                             180, -90,
                                             -180, -90),
                                           ncol = 2, byrow = TRUE),
                    ncores = 1)
{
  library(foreach)
  library(data.table)

  # Loop for each year-Month
  # CAN BE PARALLELIZED...
  print('Processing in parallel... ')
  cl = parallel::makeCluster(ncores)
  doParallel::registerDoParallel(cl, cores = ncores)

  rstStk <- foreach::foreach(mon = unique(yrMon),
                   .export = ls(),
                   .packages = (.packages()),
                   .combine = stack) %dopar%{


                     # Read data
                     tblLs <- lapply(orgLs[yrMon == mon], fread)
                     orgTbl <- do.call(rbind, tblLs)
                     orgTbl <- as.data.frame(orgTbl)

                     # Select gear type
                     if(!is.null(type))
                     {
                       orgTbl <- orgTbl[orgTbl$geartype == type, ]

                       geartype <- type
                     } else {
                       geartype <- 'all'
                     }


                     # Convert Lat and Long to correct format
                     orgTbl[, c('lat_bin', 'lon_bin')] <- orgTbl[, c('lat_bin', 'lon_bin')]/100
                     orgTbl[, c('lat_bin', 'lon_bin')] <- orgTbl[, c('lat_bin', 'lon_bin')] + (impRes/2)


                     #### Convert into 1 degree data ####

                     rstTbl <- orgTbl[, c('lon_bin','lat_bin','fishing_hours')]
                     colnames(rstTbl)[1:2] <- c('longitude', 'latitude')


                     # Create year-month raster
                     rst <- GSMP::rstFun(dta = rstTbl, res = res,ext = ext, sum, na.rm = TRUE)

                     # Remove 0 hours fishing (transit)
                     rst[rst == 0] <- NA
                      plot(rst)

                     # Convert to daily
                     rst <- rst/24

                       names(rst) <- paste0(geartype,'_', mon)

                     return(rst)

                   } # end loop for each year-month

    # Close open cluster connection
  parallel::stopCluster(cl)
  closeAllConnections()

  return(rstStk)
}
