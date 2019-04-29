library(pdftools)
library(png)

pdf_convert("report.pdf")
# try resize="1200x1800"
# from https://stackoverflow.com/questions/33177437/imagemagick-convert-pdf-to-png-with-fixed-width-or-height

# Dimensions of 1 page.
imgwidth <- 612
imgheight <- 792

# Grid dimensions.
gridwidth <- 30
gridheight <- 15

# Total plot width and height.
spacing <- 1
totalwidth <- (imgwidth+spacing) * (gridwidth)
totalheight <- (imgheight+spacing) * gridheight

# Plot all the pages and save as PNG.
png("all_pages.png", round((imgwidth+spacing)*gridwidth/7), round((imgheight+spacing)*gridheight/7))
par(mar=c(0,0,0,0))
plot(0, 0, type='n', xlim=c(0, totalwidth), ylim=c(0, totalheight), asp=1, bty="n", axes=FALSE)
for (i in 1:448) {
  fname <- paste("report_", i, ".png", sep="")
  img <- readPNG(fname)
  
  x <- (i %% gridwidth) * (imgwidth+spacing)
  y <- totalheight - (floor(i / gridwidth)) * (imgheight+spacing)
  
  rasterImage(img, xleft=x, ybottom = y-imgheight, xright = x+imgwidth, ytop=y)
}
dev.off()