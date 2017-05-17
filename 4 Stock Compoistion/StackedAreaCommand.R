rm(list=ls()) #Clear the workspace and load necessary packages
#############
#USER INPUTS#
#############
 #print as a pdf?
  ifpdf = FALSE
 #observed, model-lc, model-totmort
  catchtype = "model-lc"

  #CLB1702
 #print as a pdf?
  ifpdf = FALSE
    maxyear = 2016
 #observed, model-lc, model-totmort
  catchtype = "model-lc"
   #input files that YOU provide
    setwd("C:\\zWork\\C&E\\2017 StockCompStacked\\")
    auxcat     = read.delim("CLB1702auxCatch.txt",header=TRUE)
    fisherymap = read.delim("9806fisherymap.txt",header=TRUE)
    stockmap   = read.delim("9806stockmap.txt",header=TRUE)
   #input files from the CLB directory
    tmpdir = setwd("C:\\zWork\\C&E\\2017 CLB\\CLB1702")
    aabmcat    = read.csv("1702P_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("1702P_fish_ISBM_CCC.csv", header=TRUE)
    obscat     = read.csv("obsCatch.csv", header=TRUE)
    modfishery = read.csv("fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("stockCodes.csv", header=TRUE)
    comp = StockCompData(stockmap = stockmap, fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    cat_1702 = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2017 StockCompStacked\\clb1701 figures"


 #Phase 2 Base  Period Calibration
 #print as a pdf?
  ifpdf = FALSE
    maxyear = 2016
 #observed, model-lc, model-totmort
  catchtype = "model-lc"
   #input files that YOU provide
    setwd("C:\\zWork\\C&E\\2017 StockCompStacked\\")
    auxcat     = read.delim("bpP2auxCatch.txt",header=TRUE)
    fisherymap = read.delim("bpP2fisherymap.txt",header=TRUE)
    stockmap   = read.delim("bpP2stockmap.txt",header=TRUE)
   #input files from the CLB directory
    tmpdir = setwd("C:\\zWork\\C&E\\2017 StockCompStacked\\April2017Ph2AnnualCalibNoTweakingBPC_V1-8")
    aabmcat    = read.csv("bpP22017P_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("bpP22017P_fish_ISBM_CCC.csv", header=TRUE)
    obscat     = read.csv("obsCatch.csv", header=TRUE)
    modfishery = read.csv("fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("stockCodes.csv", header=TRUE)
    comp_bpP2 = StockCompData(stockmap = stockmap, fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    cat_bpP2 = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2017 StockCompStacked\\clb1701 figures"

#write some output
	write.csv(cat_bpP2, "bpP2clb - cat file.csv", row.names=FALSE)
	write.csv(cat_1702, "1702clb - cat file.csv", row.names=FALSE)

