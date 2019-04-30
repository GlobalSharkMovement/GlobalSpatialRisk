rstFun <- function(dta, res = 1, ext = matrix(c(-180, 90,
                                                180, 90,
                                                180, -90,
                                                -180, -90),
                                              ncol = 2, byrow = TRUE), ...)
{
  library(raster)

  # Transform data into a Spatial Dataframe
  colnames(dta)[1] <- 'longitude'
  colnames(dta)[2] <- 'latitude'

  coordinates(dta) <- ~ longitude + latitude
  proj4string(dta) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

  # Empty raster to hold data
  r <- raster(ncols = sum(abs(range(ext[,1])))/res,
              nrows = sum(abs(range(ext[,2])))/res,
              crs = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") )
  extent(r) <- ext

  # Create raster with data
  rst <- rasterize(dta, r, field = names(dta)[1],
                    fun = ...,
                    crs = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") )

  return(rst)

} # end raster function
