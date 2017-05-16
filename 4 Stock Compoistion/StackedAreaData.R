
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
  #Re-order and drop superfolous columns
   DataToR = DataToR[c("fishery","fisheryNameLong","fisheryNameLong","year","stock","catch","pcatch")]
   names(DataToR) = c("FisheryNum","FisheryName","FisheryNameLong","Year","StockGroup","Catch","PropinCatch")
  #write table to output directory
   setwd(this_is_the_place)
   write.table(x=DataToR, file=paste("ModelStockCompClb", substr(maxyear+1,3,4), "XX.txt", sep=""), sep="\t", row.names=FALSE)
 #
setwd(odir)

#1 -
#9 -
#29 - nbc s
#31 - wcvi

  #calculate stock comp of model catch by proportion in catch, with special logic if there's no model catch (e.g. NA handling)
   stockcomp.nom.lc.numeric.driver = with(allcat, tapply(nomcat, list(year, fishery, stock.acro), sum))
   stockcomp.nom.lc.percent.driver = stockcomp.nom.lc.numeric.driver
   for(i in 1:dim(stockcomp.nom.lc.percent.driver)[2]) stockcomp.nom.lc.percent.driver[,i,] = ifelse(stockcomp.nom.lc.numeric.driver[,i,]==0, 0, stockcomp.nom.lc.numeric.driver[,i,]/rowSums(stockcomp.nom.lc.numeric.driver[,i,]))

#9806 (25 fishery strata)

#phase 2 BPC (47 fishery strata)
#SEAK AABM T
perctable = stockcomp.nom.lc.percent.driver[,1,][23:38,]
criteria = apply(stockcomp.nom.lc.percent.driver[,1,][23:38,], 2, mean)>0.15
perctable[,criteria]
rowSums(perctable[,criteria])

#SEAK AABM S
perctable = stockcomp.nom.lc.percent.driver[,27,][23:38,]
criteria = apply(stockcomp.nom.lc.percent.driver[,27,][23:38,], 2, mean)>0.05
perctable[,criteria]
rowSums(perctable[,criteria])

#NBC AABM T
perctable = stockcomp.nom.lc.percent[,3,][23:38,]
criteria = apply(stockcomp.nom.lc.percent[,3,][23:38,], 2, mean)>0.05
perctable[,criteria]
rowSums(perctable[,criteria])

#NBC AABM S
perctable = stockcomp.nom.lc.percent[,29,][23:38,]
criteria = apply(stockcomp.nom.lc.percent[,29,][23:38,], 2, mean)>0.05
perctable[,criteria]
rowSums(perctable[,criteria])

#WCVI AABM T
perctable = stockcomp.nom.lc.percent[,5,][23:38,]
criteria = apply(stockcomp.nom.lc.percent[,5,][23:38,], 2, mean)>0.05
perctable[,criteria]
rowSums(perctable[,criteria])

#WCVI AABM S
perctable = stockcomp.nom.lc.percent[,31,][23:38,]
criteria = apply(stockcomp.nom.lc.percent[,31,][23:38,], 2, mean)>0.05
perctable[,criteria]
rowSums(perctable[,criteria])
