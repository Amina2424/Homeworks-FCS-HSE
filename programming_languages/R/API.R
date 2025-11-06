# Получите информацию о 10 белках разной длины. Постройте в R столбчатую диаграмму (barplot), отображающую длину каждого белка.

library(httr)
library(jsonlite)
library(ggplot2)

get_protein_lengths_r <- function() {
  accessions <- c("P01308", "P04637", "P00533", "P15056", "Q07812", 
                  "P0DTC2", "Q8WZ42", "P02768", "P61513", "P63165")
  
  protein_data <- data.frame(
    accession = character(),
    name = character(),
    length = numeric(),
    stringsAsFactors = FALSE
  )
  
  for (accession in accessions) {
    url <- paste0("https://www.ebi.ac.uk/proteins/api/proteins/", accession)
    response <- GET(url, accept("application/json"))
    
    if (status_code(response) == 200) {
      data <- fromJSON(content(response, "text"))
      protein_name <- data$protein$recommendedName$fullName$value
      if (is.null(protein_name)) protein_name <- data$id
      
      protein_data <- rbind(protein_data, data.frame(
        accession = accession,
        name = protein_name,
        length = data$sequence$length,
        stringsAsFactors = FALSE
      ))
    }
  }
  
  protein_data <- protein_data[order(protein_data$length), ]
  
  ggplot(protein_data, aes(x = reorder(accession, length), y = length)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    coord_flip() +
    labs(title = "Длина белков", 
         x = "Accession ID", 
         y = "Длина (аминокислоты)") +
    theme_minimal() +
    geom_text(aes(label = length), hjust = -0.2, size = 3)
}

get_protein_lengths_r()

# Сделайте запрос к Proteins API, чтобы получить данные о белке в формате FASTA. Сохраните результат в файл с расширением .fasta

get_protein_fasta_r <- function(accession) {
  url <- paste0("https://rest.uniprot.org/uniprotkb/", accession, ".fasta")
  
  response <- GET(url, accept("application/x-fasta"))
  
  if (status_code(response) == 200) {
    fasta_content <- content(response, "text")
    
    filename <- paste0(accession, ".fasta")
    writeLines(fasta_content, filename)
    
    cat(fasta_content)
    
    return(fasta_content)
  } else {
    cat("Ошибка:", status_code(response), "\n")
    return(NULL)
  }
}

fasta_data <- get_protein_fasta_r("Q8WZ42")

'''
>sp|Q8WZ42|TITIN_HUMAN Titin OS=Homo sapiens OX=9606 GN=TTN PE=1 SV=4
MTTQAPTFTQPLQSVVVLEGSTATFEAHISGFPVPEVSWFRDGQVISTSTLPGVQISFSD
GRAKLTIPAVTKANSGRYSLKATNGSGQATSTAELLVKAETAPPNFVQRLQSMTVRQGSQ
VRLQVRVTGIPTPVVKFYRDGAEIQSSLDFQISQEGDLYSLLIAEAYPEDSGTYSVNATN
SVGRATSTAELLVQGEEEVPAKKTKTIVSTAQISESRQTRIEKKIEAHFDARSIATVEMV
IDGAAGQQLPHKTPPRIPPKPKSRSPTPPSIAAKAQLARQQSPSPIRHSPSPVRHVRAPT
PSPVRSVSPAARISTSPIRSVRSPLLMRKTQASTVATGPEVPPPWKQEGYVASSSEAEMR...
'''