#.rs.restartR()

library(quanteda)
library(data.table)
library(sqldf)

one_gram<- readRDS('./one_gram.rds');
two_gram<- readRDS('./two_gram.rds');
three_gram<- readRDS('./three_gram.rds');
four_gram<- readRDS('./four_gram.rds');
setkey(one_gram, base)
setkey(two_gram, base)
setkey(three_gram, base)
setkey(four_gram, base)
badwords<- readRDS('./badwords.rds'); #badwords2<- readRDS('./test/badwords2.rds');



nextWord<- function(input, k=3) {
  
  input<-gsub("'", "", input)
  input<- tokens(input,
                         remove_symbols = TRUE, # remove all characters in the Unicode "Symbol" [S] class
                         remove_punct = TRUE, # remove all characters in the Unicode "Punctuation" [P] class
                         remove_numbers = TRUE, # remove tokens that consist only of numbers
                         remove_separators = TRUE, # remove separators and separator characters
                         remove_twitter = TRUE, # remove Twitter characters @ and # 
                         remove_url = TRUE) # removes URLs beginning with http(s)
  input<-tokens_select(input, pattern=c(badwords, stopwords("en")), selection="remove")
  inputLen<- ntoken(input);
  
  nxtWordFound<- FALSE;
  nxtWordPred<- as.character(NULL);
  
  # 1. First search for 4-Gram
  if (inputLen >= 3 & !nxtWordFound) {
    
    searchStr <- input[[1]][(inputLen-2):inputLen]
    searchStr <- paste0(searchStr ,collapse = "_");
    statement<-paste0("select prediction from four_gram where base = '", searchStr, "' limit ", k)
    fin<-data.table(sqldf(statement))
    (if (is.na(fin[1])==FALSE) {nxtWordFound=TRUE} else {nxtWordFound=FALSE})}
    
    if (inputLen >= 2 & !nxtWordFound) {
      searchStr <- input[[1]][(inputLen-1):inputLen]
      searchStr <- paste0(searchStr ,collapse = "_");
        statement<-paste0("select prediction from three_gram where base = '", searchStr, "' limit ", k)
        fin<-data.table(sqldf(statement))
        (if (is.na(fin[1])==FALSE) {nxtWordFound=TRUE} else {nxtWordFound=FALSE})}
  
  
        
    if (inputLen >= 1 & !nxtWordFound) {
      searchStr <- input[[1]][inputLen]
          statement<-paste0("select prediction from two_gram where base = '", searchStr, "' limit ", k)
          fin<-data.table(sqldf(statement))
          (if (is.na(fin[1])==FALSE) {nxtWordFound=TRUE} else {nxtWordFound=FALSE})}
          
  if (!nxtWordFound) {
    fin<-one_gram[,3]
  }
  
  prediction<-as.character(paste0(unlist(fin[1,1])))
  prediction[2]<-as.character(paste0(unlist(fin[2,1])))
  prediction[3]<-as.character(paste0(unlist(fin[3,1])))
  return(prediction)
  }

