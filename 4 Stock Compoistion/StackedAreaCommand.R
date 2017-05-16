rm(list=ls()) #Clear the workspace and load necessary packages
#############
#USER INPUTS#
#############
 #print as a pdf?
  ifpdf = FALSE
 #observed, model-lc, model-totmort
  catchtype = "model-lc"

 #input directory
  inputdir = c("C:\\zWork\\C&E\\2016 StockCompStacked")
  setwd(inputdir)
  #CLB1402
   #input files from the CLB directory
    aabmcat    = read.csv("1402P_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("1402P_fish_ISBM_CCC.csv", header=TRUE)
    #obscat     = read.csv("CLB1402obsCatch.csv", header=TRUE) #for whatever reason, data in this file is incomplete
    obscat     = read.csv("CLB1402obsCatch - corrected.csv", header=TRUE)
    modfishery = read.csv("9806fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("9806stockCodes.csv", header=TRUE)
   #input files that YOU provide
    auxcat     = read.delim("CLB1402auxCatch.txt",header=TRUE)
    stockmap   = read.delim("9806stockmap.txt",header=TRUE)
    fisherymap = read.delim("9806fisherymap.txt",header=TRUE)
fisherymap = read.delim("9806fisherymap - test.txt",header=TRUE) 
   #max year (i.e. calibration number minus 1: e.g. CLB14 has a max year of 2013)
    maxyear = 2013
   #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2016 StockCompStacked\\clb1402 figures"

  #CLB1601
   #input files from the CLB directory
    aabmcat    = read.csv("1601P_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("1601P_fish_ISBM_CCC.csv", header=TRUE)
    #obscat     = read.csv("CLB1601obsCatch.csv", header=TRUE) #for whatever reason, data in this file is incomplete
    obscat     = read.csv("CLB1601obsCatch - corrected.csv", header=TRUE)
    modfishery = read.csv("9806fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("9806stockCodes.csv", header=TRUE)
   #input files that YOU provide
    auxcat     = read.delim("CLB1601auxCatch.txt",header=TRUE)
    stockmap   = read.delim("9806stockmap.txt",header=TRUE)
    fisherymap = read.delim("9806fisherymap.txt",header=TRUE)
    StockCompData(stockmap = stockmap, fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
   #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2016 StockCompStacked\\clb1601 figures"

  #CLB17bb w/old IDL
   #input files that YOU provide
    setwd("C:\\zWork\\C&E\\2016 StockCompStacked\\")
    auxcat     = read.delim("CLB1601auxCatch.txt",header=TRUE)
    fisherymap = read.delim("9806fisherymap.txt",header=TRUE)
    setwd("C:\\zWork\\C&E\\2017 CLB\\IDL Question\\")
    stockmap   = read.delim("9806stockmap - LYF.txt",header=TRUE)
   #input files from the CLB directory
    tmpdir = setwd("C:\\zWork\\C&E\\2017 CLB\\IDL Question\\CLB17bb - 2016 IDL")
    aabmcat    = read.csv("17bbP_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("17bbP_fish_ISBM_CCC.csv", header=TRUE)
    obscat     = read.csv("obsCatch.csv", header=TRUE)
    modfishery = read.csv("fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("stockCodes.csv", header=TRUE)
    comp.oldIDL = StockCompData(stockmap = stockmap, fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    cat.oldIDL = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
  #CLB17bb w/new IDL
   #input files from the CLB directory
    tmpdir = setwd("C:\\zWork\\C&E\\2017 CLB\\IDL Question\\CLB17bb - new IDL")
    aabmcat    = read.csv("17bbP_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("17bbP_fish_ISBM_CCC.csv", header=TRUE)
    obscat     = read.csv("obsCatch.csv", header=TRUE)
    modfishery = read.csv("fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("stockCodes.csv", header=TRUE)
    tmpdir = setwd("C:\\zWork\\C&E\\2016 StockCompStacked\\")
    comp.newIDL = StockCompData(stockmap = stockmap, fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    cat.newIDL = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
  #CLB17bb w/new IDL
   #input files from the CLB directory
    tmpdir = setwd("C:\\zWork\\C&E\\2017 CLB\\IDL Question\\CLB17bb - new IDL test")
    aabmcat    = read.csv("17bbP_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("17bbP_fish_ISBM_CCC.csv", header=TRUE)
    obscat     = read.csv("obsCatch.csv", header=TRUE)
    modfishery = read.csv("fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("stockCodes.csv", header=TRUE)
    tmpdir = setwd("C:\\zWork\\C&E\\2016 StockCompStacked\\")
    comp.newIDL2 = StockCompData(stockmap = stockmap, fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    cat.newIDL2 = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)


comp.oldIDL= subset(comp.oldIDL,StockGroup=="LYF") 
comp.newIDL= subset(comp.newIDL,StockGroup=="LYF")
setwd("C:\\zWork\\C&E\\2017 CLB\\IDL Question\\")
write.csv(comp.oldIDL, "oldIDL.csv")
write.csv(comp.newIDL, "newIDL.csv")
write.csv(comp.newIDL, "newIDL - urb sum test.csv")

   #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2016 StockCompStacked\\clb1601 figures"

  #2016 CLB w/new base
   #input files from the CLB directory
    aabmcat    = read.csv("2016Ph2AnnualTestRunOctCTCrunV1-6NewSummerNewGSflagNewMOCNOCfps\\2016P_fish_AABM_CCC.csv", header=TRUE)
    isbmcat    = read.csv("2016Ph2AnnualTestRunOctCTCrunV1-6NewSummerNewGSflagNewMOCNOCfps\\2016P_fish_ISBM_CCC.csv", header=TRUE)
    #obscat     = read.csv("2016Ph2AnnualTestRunOctCTCrunV1-6NewSummerNewGSflagNewMOCNOCfps\\obsCatch.csv", header=TRUE) #for whatever reason, data in this file is incomplete
    obscat     = read.csv("bpP2_2016obsCatch - corrected.csv", header=TRUE)
    modfishery = read.csv("2016Ph2AnnualTestRunOctCTCrunV1-6NewSummerNewGSflagNewMOCNOCfps\\fisheryCodes.csv", header=TRUE)
    modstocks  = read.csv("2016Ph2AnnualTestRunOctCTCrunV1-6NewSummerNewGSflagNewMOCNOCfps\\stockCodes.csv", header=TRUE)
   #input files that YOU provide
    auxcat     = read.delim("bpP2auxCatch.txt",header=TRUE)
    stockmap   = read.delim("bpP2stockmap.txt",header=TRUE)
    fisherymap = read.delim("bpP2fisherymap.txt",header=TRUE)
   #max year (i.e. calibration number minus 1: e.g. CLB14 has a max year of 2013)
    maxyear = 2015
   #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2016 StockCompStacked\\bpP2 figures"

 
 #modcomp output file
  modcompfilename<-paste("ModelStockCompClb", substr(maxyear+1,3,4), "XX.txt", sep="") #NOTE: naming convention linked to file output at the bottom

  #CLB1702
 #print as a pdf?
  ifpdf = FALSE
    maxyear = 2016
 #observed, model-lc, model-totmort
  catchtype = "model-lc"
   #input files that YOU provide
    setwd("C:\\zWork\\C&E\\2017 StockCompStacked\\")
    auxcat     = read.delim("CLB1701auxCatch.txt",header=TRUE)
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
    cat = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    #output directory
    this_is_the_place <- "C:\\zWork\\C&E\\2017 StockCompStacked\\clb1701 figures"



 #run program
  #create the data input file
   source("StackedAreaData.R")
  #create the figures
   source("StackedAreaFigures.R")
  #create catch figures
   source("")
  #calculate appendix h

#commpare model cat
    cat.newIDL2 = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    cat.newIDL2 = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
    cat.newIDL2 = CatchData(fisherymap = fisherymap, auxcat = auxcat, obscat = obscat, aabmcat = aabmcat, isbmcat = isbmcat, write_output = NULL)
 

