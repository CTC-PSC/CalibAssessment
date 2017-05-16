rm(list=ls()) #Clear the workspace and load necessary packages
#############
#USER INPUTS#
#############

 #global params
  ifpdf = FALSE
  maxyear = 2016
  catchtype = "model-lc"
  #CLB1702
   #input files that YOU provide
    setwd("C:\\zWork\\C&E\\2017 StockCompStacked\\")
    auxcat     = read.delim("CLB1702auxCatch.txt",header=TRUE)
    seakaddon  = read.delim("CLB1702SEAKaddon.txt",header=TRUE)
    fisherymap = read.delim("9806fisherymap.txt",header=TRUE)
    stockmap   = read.delim("9806stockmap.txt",header=TRUE)
    #stockmap   = read.delim("9806stockmap by stock.txt",header=TRUE)
   #input files from the CLB directory
    tmpdir = setwd("C:\\zWork\\C&E\\2017 CLB\\CLB1702")
    aabmcat    = read.csv("1702P_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("1702P_fish_ISBM_CCC.csv", header=TRUE)
    obscat     = read.csv("obsCatch.csv", header=TRUE)
    modfishery = read.csv("fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("stockCodes.csv", header=TRUE)
   #setwd to output dir
    setwd("C:\\zWork\\C&E\\2017 StockCompStacked\\clb1702 figures")
   #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2017 StockCompStacked\\clb1702 figures - seak addon"

 #run r scipts
  #create the data input file
   source("C:\\zWork\\C&E\\2017 StockCompStacked\\StackedAreaData - seak addon.R")
  #mod comp file name
   modcompfilename = paste("ModelStockCompClb", substr(maxyear+1,3,4), "XX.txt", sep="")
  #create the figures
   source("C:\\zWork\\C&E\\2017 StockCompStacked\\StackedAreaFigures.R")

