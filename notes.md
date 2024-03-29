
## Notes - _R. Cameron_

### Retrieving genome sequence data (SeqinR)

	getncbiseq("accession_num")

	# store as variable; vector object, nucleotides will be lowercase.
	seqvector <- getncbiseq("accession_num")

	# print out subsequence of the sequence by indexing.
	seqvector[1:50]

### Writing sequence data out as a FASTA file (SeqinR)

	write.fasta()

	# write to fasta file that contains the sequence and the assigned sequence label.
	write.fasta(names="seqlabel", sequences=seqvector, file.out="file-name.fasta")

### Reading sequence data into R (SeqinR)

	# read fasta file into R and store (list object).
	seqlist <- read.fasta(file = "file-name.fasta")

	# store sequence in vector variable.
	seqvector <- seqlist[[1]]

### Length of a DNA sequence

	# returns sequence length since each vector element contains one nucleotide.
	length(seqvector)

### Base composition of a DNA sequence (with & without SeqinR)

	# count number of occurences of the four nucleotides A, C, G, and T.
	table(seqvector)

	# SeqinR count() function: table of number of occurences at specified length.
	count(seqvector, 1)

	# example output:
		a    c    g    t
		3426 2240 2770 2299

### GC Content of DNA (SeqinR)

	# returns fraction of bases in sequence that are Gs or Cs.
	GC(seqvector)

### DNA "Words" (e.g. Codons)

	# SeqinR count() function: table of number of occurences at specified length.
	count(seqvector, 3)
	
	# example output:
		aaa aac aag aat aca acc acg act aga agc agg agt ata atc atg att 
		388 237 280 203 294 176  94 156 334 184 237 135 141 137 292 138 
		caa cac cag cat cca ccc ccg cct cga cgc cgg cgt cta ctc ctg ctt 
		273 198 227 203 236 106  60 121  70  51  69  71 131 121 186 116 
		gaa gac gag gat gca gcc gcg gct gga ggc ggg ggt gta gtc gtg gtt 
		346 197 249 184 169 129  58 144 354 132 160 141  73 106 192 136 
		taa tac tag tat tca tcc tcg tct tga tgc tgg tgt tta ttc ttg ttt 
		101  88 133 118 202 112  49 134 218 133 321 160  95 133 162 139 

	# store variable; table object.
	seqtable <- count(seqvector, 3)

	# extract values. e.g. ATG counts (292)
	seqtable[[15]]
	# alt.
	seqtable[["atg"]]
	
### Writing to a Delimited Text File

	write.csv(seqtable, "seqtable.csv")

	# do not include row names.
	write.csv(seqtable, "seq-table.csv", row.names=FALSE)

	# store such that special attributes of data structures are preserved.
	dump("seqtable", "seq-table.Rdmpd")


### Find the Complement String

	# returns complement DNA string; non-ACTG returned NA.
	comp()
