#### Function to plot kobes (Fig3 and 4)  ####
# dta <- data.frame
# xNam <- X axis to be plotted. Defaults to 'mean_effort'
# yNam <- y axis to be plotted. Defaults to 'mean_overlap'
# gp <- grouping factor
# xSdUp  <- Upper SD for x axis. Defaults to 0
# xSdLow <- Lower SD for x axis. Defaults to 0
# ySdUp <- Upper SD for y axis. Defaults to 0
# ySdLow <- Lower SD for x axis. Defaults to 0
# v <- vector x,y x <- effort threshold; y <- overlap threshold
# colPlt <- Colour vector to colour geom_points. Defaults to Species colour as in paper (References). NULL returns automatically coloured points
# gline <- connect points by a line?

kobePlot <- function(dta, xNam = 'mean_effort', yNam = 'mean_overlap', gp = 'Spp',
                     xSdUp = 0, xSdLow = 0, ySdUp = 0, ySdLow = 0,
                     v, colPlt = colScale, gline = FALSE,
                     cutPlt = xxmax, xBks = seq(0,cutPlt, length.out = 10),
                     cutY = 100, yBks = seq(0,cutY, length.out = 5),...)
  {
    library(ggplot2)

    # Species point Colour scale
    colScale <- c(
      # PGL
      rgb(3, 78, 123, max = 255),
      # CLE
      rgb(253, 141, 60, max = 255),
      # IOX
      rgb(177, 0, 38, max = 255),
      # CLO
      rgb(54, 144, 192, max = 255),
      # LNA
      rgb(116, 169, 207, max = 255),
      # LDI
      rgb(254, 178, 76, max = 255),
      # CFA
      rgb(5, 112, 176, max = 255),
      # SPH
      rgb(0, 0, 0, max = 255),
      # GCU
      rgb(75, 75, 75, max = 255),
      # RTY
      rgb(0, 60, 48, max = 255),
      # CCA
      rgb(252, 78, 42, max = 255))

    # xMAX
    xxmax <- max(dta$upSD_effort, na.rm = TRUE)

    # x labels
    xLab <- formatC(xBks, format = "e", digits = 1)

      xxmax[cutPlt>xxmax] <- cutPlt

    # Extract x and y risk thresholds
    F40.F20 <- v[1]
    So  <- v[2]


    #### Plot kobe base ####
    kobe <- ggplot(dta,
                   aes(x = eval(parse(text = xNam)),
                       y = eval(parse(text = yNam)))) +
      # Remove background
      theme_bw() +
      # Scale axis
      xlab(xNam) +
      ylab(yNam) +
      scale_x_continuous(limits=c(0,xxmax), breaks = xBks, labels = xLab) +
      scale_y_continuous(limits=c(0,100), breaks = yBks) +
      # Vertical x labels
      theme(axis.text.x = element_text(angle = 90, hjust = 1))

    # Green square (Bottom left)
    kobe <- kobe +
      geom_rect(xmin = 0, xmax = F40.F20, ymin = 0, ymax = So,
                fill = alpha('green3',0.2), col = 'black', linetype = 'dotted')
    # Yellow sqare (Bottom right)
    kobe <- kobe +
      geom_rect(xmin = F40.F20, xmax = xxmax, ymin = 0, ymax = So,
                fill = alpha('gold',0.2), col = 'black', linetype = 'dotted')#, alpha = 0.015)

    # Yellow sqare (top Left)
    kobe <- kobe +
      geom_rect(xmin = 0, xmax = F40.F20, ymin = So, ymax = 100,
                fill = alpha('gold',0.2), col = 'black', linetype = 'dotted')#, alpha = 0.015)

    # Red sqare (top Right)
    kobe <- kobe +
      geom_rect(xmin = F40.F20, xmax = xxmax, ymin = So, ymax = 100,
                fill = alpha('red2',0.2), col = 'black', linetype = 'dotted')#, alpha = 0.015)

    # SD bars
    kobePts <- kobe +
      # Vertical bars (y axis)
      geom_errorbar(aes(x = eval(parse(text = xNam)),
                        ymin = eval(parse(text = ySdLow)),
                                    ymax = eval(parse(text = ySdUp)),
                        width  = rep(0, length(unique(dta[,gp])))), col = 'darkgrey', size=0.5) +
      # Horizontal bars (x axis)
      geom_errorbarh(aes(y = eval(parse(text = yNam)),
                         xmin= eval(parse(text = xSdLow)),
                         xmax= eval(parse(text = xSdUp)),
                     height  = rep(0, length(unique(dta[,gp])))), col = 'darkgrey', size=0.5)


    if(gline)
    {
      # Line connecting points
      kobePts <- kobePts + geom_path(aes(x = eval(parse(text = xNam)),
                                          y = eval(parse(text = yNam))))
    }



    # Points
    kobePts <- kobePts + geom_point(aes(x = eval(parse(text = xNam)),
                                        y = eval(parse(text = yNam)),
                                        col = eval(parse(text = gp))),
                                        shape = 19, size = 4) +
                labs(col = gp)# colour = yr #

    if(!is.null(colPlt))
    {
      kobePts <- kobePts + scale_colour_manual(values = colPlt)
    }


    # Add ablines to cut image
#    kobePts <- kobePts +
      # Vertical line
#      geom_vline(xintercept = cutPlt, linetype="dashed",
#                                          color = "Red", size=1.5) +
#      geom_hline(yintercept = cutY, linetype="dashed",
#                 color = "Green", size=1.5)

    print(kobePts)
  }
