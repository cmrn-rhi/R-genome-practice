library("seqinr")

getncbiseq <- function(accession) {
  # retrieve sequence from NCBI via accession number
  # e.g. dengueseq <- getncbiseq("NC_001477")
  
  require("seqinr") # this function requires the SeqinR R package
  
  # first find which ACNUC database the accession is stored in:
  dbs <- c("genbank","refseq","refseqViruses","bacterial")
  numdbs <- length(dbs)
  for (i in 1:numdbs) {
    db <- dbs[i]
    choosebank(db)
    
    # check if the sequence is in ACNUC database 'db':
    resquery <- try(query(".tmpquery", paste("AC=", accession)), silent = TRUE)
    if (!(inherits(resquery, "try-error"))) {
      queryname <- "query2"
      thequery <- paste("AC=",accession,sep="")
      query2 <- query(`queryname`,`thequery`)
      
      # see if a sequence was retrieved:
      seq <- getSequence(query2$req[[1]])
      closebank()
      return(seq)
    }
    closebank()
  }
  print(paste("ERROR: accession",accession,"was not found"))
}
