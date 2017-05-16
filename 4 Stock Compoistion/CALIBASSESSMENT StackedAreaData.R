odir = getwd()

#data massage
 #model fishery
  modfishery = fisherymap[c("fishery","fisheryNameLong")]
 #observed catch data (2 data formats)
  #if the number of columns greater than 3, implies format 2
  #NOTE, routine ASSUMES fisheries are in numerical order. a must!
   if(ncol(auxcat)>3) {
    nauxfish = ncol(auxcat)-1
    fnumbers = substring(colnames(auxcat)[2:ncol(auxcat)],2,4)
    fnumbers = sort(rep(as.numeric(fnumbers), nrow(auxcat)))
    years = rep(auxcat$Year, length(2:ncol(auxcat)))
    temp = data.frame(year=years, fishery=fnumbers)
    temp$obs_catch_nom = do.call(c, auxcat[,-1])
    auxcat = temp
   }
  allobscat = rbind(auxcat, obscat)
  allobscat = allobscat[ order(allobscat$year, allobscat$fishery), ]

 #model stock comp calculations 
  #format model catch data
   allcat = rbind(aabmcat, isbmcat) #combine isbm and aabm fishery catch
   allcat$nomcat = rowSums(allcat[,5:6]) # Term.catch + preTerm.catch
   allcat$totcat = rowSums(allcat[,5:20]) # The kitchen sink
   allcat = subset(allcat, year <= maxyear)
  #add stock comp mappings, similar to a 'vlookup' 
   allcat=merge(stockmap, allcat, by = "stock") # Append stock mapping to data frame
  #calculate stock comp of catch by 'whole' fish
   stockcomp.nom.lc.numeric = with(allcat, tapply(nomcat, list(year, fishery, stock.group.order), sum))
  #calculate stock comp of model catch by proportion in catch, with special logic if there's no model catch (e.g. NA handling)
   stockcomp.nom.lc.percent = stockcomp.nom.lc.numeric
   for(i in 1:dim(stockcomp.nom.lc.percent)[2]) stockcomp.nom.lc.percent[,i,] = ifelse(stockcomp.nom.lc.numeric[,i,]==0, 0, stockcomp.nom.lc.numeric[,i,]/rowSums(stockcomp.nom.lc.numeric[,i,]))
 #convert data to the r format & calculate catch
  #format: 	FisheryName	FisheryNameLong	Year	StockGroup	Catch	PropinCatch
  #prelims
   nfisheries   = nrow(modfishery)
   nstockgroups = ncol(stockcomp.nom.lc.percent[,1,])
   nyears       = nrow(stockcomp.nom.lc.percent[,1,])
   minyear      = min(allcat$year)
  #FisheryName and FisheryNameLong
   DataToR = data.frame(fishery = sort(rep(modfishery$fishery, nyears*nstockgroups)))
   DataToR = merge(modfishery, DataToR, by="fishery")
  #Year
   DataToR$year = rep(sort(rep(minyear:maxyear, nstockgroups)), nfisheries)
  #StockGroup
   temp = sort(unique(stockmap$stock.group.order))
   temp = stockmap[match(temp, stockmap$stock.group.order),]$stock.group
   DataToR$stock = rep(temp, nfisheries*nyears)
  #Catch
   DataToR = merge(DataToR, allobscat, by=c("year","fishery"), sort=FALSE)
  #PropinCatch
   DataToR$catch = NA
   DataToR$pcatch = NA
   index = 1:nstockgroups
   for(i in 1:nfisheries) {
    for(j in 1:nyears) {
      DataToR[index,]$pcatch = stockcomp.nom.lc.percent[j,i,]
      DataToR[index,]$catch = DataToR[index,]$obs_catch_nom*stockcomp.nom.lc.percent[j,i,]
      index = index + nstockgroups
     }
    }
  #######################
  #Start of             #
  #SEAK Addon adjustment#
  #######################
	 #SEAK catch data (2 data formats)
	  #if the number of columns greater than 3, implies format 2
	  #NOTE, routine ASSUMES fisheries are in numerical order. a must!
	   if(ncol(seakaddon)>3) {
	    nauxfish = ncol(seakaddon)-1
	    fnumbers = substring(colnames(seakaddon)[2:ncol(seakaddon)],2,4)
	    fnumbers = sort(rep(as.numeric(fnumbers), nrow(seakaddon)))
	    years = rep(seakaddon$Year, length(2:ncol(seakaddon)))
	    temp = data.frame(year=years, fishery=fnumbers)
	    temp$stock = "SEAK"
	    temp$addon = do.call(c, seakaddon[,-1])
	    seak_addon = temp
	   }
	#Update "catch" field
	 DataToR[rownames(subset(DataToR, fishery==1&stock=="SEAK")),]$catch = subset(DataToR, fishery==1&stock=="SEAK")$catch + subset(seak_addon,fishery==1)$addon
	 DataToR[rownames(subset(DataToR, fishery==7&stock=="SEAK")),]$catch = subset(DataToR, fishery==7&stock=="SEAK")$catch + subset(seak_addon,fishery==7)$addon
	 DataToR[rownames(subset(DataToR, fishery==18&stock=="SEAK")),]$catch = subset(DataToR, fishery==18&stock=="SEAK")$catch + subset(seak_addon,fishery==18)$addon
	#Update "obs_catch_nom" field
	 DataToR[rownames(subset(DataToR, fishery==1)),]$obs_catch_nom = subset(DataToR, fishery==1)$obs_catch_nom + as.vector(mapply(rep, subset(seak_addon,fishery==1)$addon, nstockgroups))
	 DataToR[rownames(subset(DataToR, fishery==7)),]$obs_catch_nom = subset(DataToR, fishery==7)$obs_catch_nom + as.vector(mapply(rep, subset(seak_addon,fishery==7)$addon, nstockgroups))
	 DataToR[rownames(subset(DataToR, fishery==18)),]$obs_catch_nom = subset(DataToR, fishery==18)$obs_catch_nom + as.vector(mapply(rep, subset(seak_addon,fishery==18)$addon, nstockgroups))
	#Update "pcatch" field
	 DataToR$pcatch =  DataToR$catch/DataToR$obs_catch_nom
  #######################
  #End of               #
  #SEAK Addon adjustment#
  #######################
  #Re-order and drop superfolous columns
   DataToR = DataToR[c("fishery","fisheryNameLong","fisheryNameLong","year","stock","catch","pcatch")]
   names(DataToR) = c("FisheryNum","FisheryName","FisheryNameLong","Year","StockGroup","Catch","PropinCatch")
  #write table to output directory
   setwd(this_is_the_place)
   write.table(x=DataToR, file=paste("ModelStockCompClb", substr(maxyear+1,3,4), "XX.txt", sep=""), sep="\t", row.names=FALSE)
 #
setwd(odir)
