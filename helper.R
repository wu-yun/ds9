
library(maptools)
library(maps)
library(mapdata)
library(RColorBrewer)

cnmap <- readShapePoly('script/bou2_4p.shp')
cnmap@data$NAME[899]<-cnmap@data$NAME[898]
cnmap@data$NAME <- iconv(cnmap@data$NAME, from = 'CP936', to = 'UTF-8')

getColorParam <- function(provData,colorspace){
  n <- 6
  mypalette <- brewer.pal(n,colorspace)
  dmin <- min(provData)-1
  dmax <- max(provData)
  provcol <- mypalette[ceiling((provData-dmin)*n/(dmax-dmin))]
  return (provcol)
}

getLegendColor <- function(n,colorSpace){
  colors <-c()
  for(i in 1:n){
    colors <-c(colors,brewer.pal(n,colorSpace)[i])
  }
  return (colors)
}

getColor <- function(mapdata,provname,provcolor,othercolor){
  f=function(x,y) ifelse(x %in% y, which(y==x),0);
  colIndex = sapply(mapdata@data$NAME, f,provname);
  color <-c(othercolor,provcolor)[colIndex+1];
  return (color);
}

getLegendText <- function(n,provData){
  dmax <- max(provData)
  dmin <- min(provData)-1
  ltext <- c()
  for(i in 1:n){
    ltext <- c(ltext,format(ceiling((dmax-dmin)/n*(i-1)+dmin),scientific = TRUE,digits = 2))
  }
  return (ltext)
}

plotMap <- function(provname,provData,maptitle,colorspace){
  provname <- provname[provData!=0]
  provData <- provData[provData!=0]
  provColor <- getColorParam(provData,colorspace)
  plot(cnmap,col=getColor(cnmap,provname,provColor,"white"))
  title(main=maptitle, cex.main=3)
  legendtext <- getLegendText(6,provData)
  legendColor <- getLegendColor(6,colorspace)
  legend("bottom",legend=legendtext,horiz=TRUE, fill=legendColor)
}




