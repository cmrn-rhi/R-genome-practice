
# Exercises - DNA Sequence Statistics

#### Answers: _Rhiannon Cameron_

Reference: [A Little Book of R for Bioinformatics](https://a-little-book-of-r-for-bioinformatics.readthedocs.io/en/latest/src/chapter1.html)

_Answers assume having run the following:_ **library("seqinr")**


### Q1 - What are the last twenty nucleotides of the DEN-1 Dengue virus genome sequence?

    > dengue <- read.fasta(file="den1.fasta")
    > dengueseq <- dengue[[1]]
    > length(dengueseq)
    [1] 10735
    > dengueseq[10716:10735]
    [1] "c" "t" "g" "t" "t" "g" "a" "a" "t" "c" "a" "a" "c" "a" "g"
    [16] "g" "t" "t" "c" "t"
    
### Q2 - What is the length in nucleotides of the genome sequence for the bacterium _Mycobacterium leprae_ strain TN (accession NC_002677)?
  
    > lepraeTN <- getncbiseq("NC_002677")
    Error in acnucopen(bank, socket) : Database with name -->bacterial<-- is currently off for maintenance, please try again later. 
    
Bacterial database appears to be inaccessible by this call, at this time, as it still works to obtain DEN-1 sequence data.
    
    # manually obtained fasta file and imported data.
    > lepraeTN <- read.fasta(file="NC_002677-1.fasta")
    > lepraeTNseq <- lepraeTN[[1]]
    
    # saved copy, just because.
    > write.fasta(names="lepraeTN", sequences=lepraeTNseq, file.out="lepraeTN.fasta")
    
    > length(lepraeTNseq)
    [1] 3268203
    
### Q3 - How many of each of the four nucleotides A, C, T and G, and any other symbols, are there in the _Mycobacterium leprae_ TN genome sequence?

    > table(lepraeTNseq)
    lepraeTNseq
     a      c      g      t 
    687041 938713 950202 692247 
    
### Q4 - What is the GC content of the _Mycobacterium leprae_ TN genome sequence, when:
    
#### (i) ...all non-A/C/T/G nucleotides are included?
  
    > GC(lepraeseq, exact=TRUE)
    [1] 0.5779675
    # GC Content: 57.79675%
    
#### (ii) ...non-A/C/T/G nucleotides are discarded?
  
    > GC(lepraeTNseq) #default: exact=FALSE
    [1] 0.5779675
    # GC Content: 57.79675%
    
GC content is the same; therefore, the sequence must not contain any non-A/C/T/G nucleotides.
    
### Q5 - How many of each of the four nucleotides A, C, T and G are there in the complement of the _Mycobacterium leprae_ TN genome sequence?

    > lepraeTNseq_comp <- comp(lepraeTNseq)
    [1] - [995] # lists nucleotide sequence
    
    > count(lepraeTNseq_comp, 1)
         a      c      g      t 
    692247 950202 938713 687041 
    
### Q6 - How many occurrences of the DNA words CC, CG and GC occur in the _Mycobacterium leprae_ TN genome sequence?

    > count(lepraeTNseq, 2)

    aa     ac     ag     at     ca     cc     cg     ct     ga 
    149718 206961 170846 159516 224666 236971 306986 170089 203397 
    gc     gg     gt     ta     tc     tg     tt 
    293261 243071 210473 109259 201520 229299 152169 
    
    > lepraeTNseq_pairs <- count(lepraeTNseq, 2)
    > lepraeTNseq_pairs[["cc"]]
    [1] 236971
    > lepraeTNseq_pairs[["gg"]]
    [1] 243071
    > lepraeTNseq_pairs[["gc"]]
    [1] 293261
    
### Q7 - How many occurrences of the DNA words CC, CG and GC occur in the:

#### (i) ...first 1000 nucleotides of the _Mycobacterium leprae_ TN genome sequence?

    > lepraeTNseq_pairs_1000 <- count(lepraeTNseq[1:1000], 2)
    > lepraeTNseq_pairs_1000[["cc"]]
    [1] 82
    > lepraeTNseq_pairs_1000[["gg"]]
    [1] 39
    > lepraeTNseq_pairs_1000[["gc"]]
    [1] 63

#### (ii) ...last 1000 nucleotides of the _Mycobacterium leprae_ TN genome sequence?
    
    > length(lepraeTNseq)
    [1] 3268203
    > 3268203-999
    [1] 3267204
    > lepraeTNseq_pairs_last <- count(lepraeTNseq[3267204:3268203],2)
    > lepraeTNseq_pairs_last[["cc"]]
    [1] 81
    > lepraeTNseq_pairs_last[["gg"]]
    [1] 49
    > lepraeTNseq_pairs_last[["gc"]]
    [1] 75
    