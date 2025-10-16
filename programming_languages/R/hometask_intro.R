motifs2 <- matrix(c(
  "a", "C", "g", "G", "T", "A", "A", "t", "t", "C", "a", "G",
  "t", "G", "G", "G", "C", "A", "A", "T", "t", "C", "C", "a",
  "A", "C", "G", "t", "t", "A", "A", "t", "t", "C", "G", "G",
  "T", "G", "C", "G", "G", "G", "A", "t", "t", "C", "C", "C",
  "t", "C", "G", "a", "A", "A", "A", "t", "t", "C", "a", "G",
  "A", "C", "G", "G", "C", "G", "A", "a", "t", "T", "C", "C",
  "T", "C", "G", "t", "G", "A", "A", "t", "t", "a", "C", "G",
  "t", "C", "G", "G", "G", "A", "A", "t", "t", "C", "a", "C",
  "A", "G", "G", "G", "T", "A", "A", "t", "t", "C", "C", "G",
  "t", "C", "G", "G", "A", "A", "A", "a", "t", "C", "a", "C"
), nrow = 10, byrow = TRUE)

# верхний регистр
motifs2 <- toupper(motifs2)

# COUNT-матрица
count_matrix <- apply(motifs2, 2, function(col) table(factor(col, levels = c("A", "C", "G", "T"))))

'''
[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
A    4    0    0    1    2    8   10    2    0
C    0    7    1    0    2    0    0    0    0
G    0    3    9    7    3    2    0    0    0
T    6    0    0    2    3    0    0    8   10
  [,10] [,11] [,12]
A     1     4     1
C     8     5     4
G     0     1     5
T     1     0     0
'''

# Создаем PROFILE-матрицу
profile_matrix <-apply(motifs2, 2, function(x) {
  counts <- table(factor(x, levels = c("A", "C", "G", "T")))
  counts / sum(counts)
})

'''
  [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
A  0.4  0.0  0.0  0.1  0.2  0.8    1  0.2    0
C  0.0  0.7  0.1  0.0  0.2  0.0    0  0.0    0
G  0.0  0.3  0.9  0.7  0.3  0.2    0  0.0    0
T  0.6  0.0  0.0  0.2  0.3  0.0    0  0.8    1
  [,10] [,11] [,12]
A   0.1   0.4   0.1
C   0.8   0.5   0.4
G   0.0   0.1   0.5
T   0.1   0.0   0.0

'''

# scoreMotifs
scoreMotifs <- function(motifs) {
  count_matrix <- apply(motifs, 2, function(x) {
    table(factor(x, levels = c("A", "C", "G", "T")))
  })
  
  total_score <- 0
  for (j in 1:ncol(motifs)) {
    max_count <- max(count_matrix[, j])
    total_score <- total_score + (nrow(motifs) - max_count)
  }
  
  return(total_score)
}

# Вычисляем score для motifs2
motif_score <- scoreMotifs(motifs2)
# [1] 34

consensus <- apply(profile_matrix, 2, function(col) {
  nucleotides <- c("A", "C", "G", "T")
  nucleotides[which.max(col)]
})
consensus_string <- paste(consensus, collapse = "")
# [1] "TCGGGAATTCCG"

barplot(profile_matrix[, 5], 
       col = c("green", 'red', 'blue','orange'),
       main = "Частоты нуклеотидов в 1-м столбце",
       xlab = "Нуклеотиды",
       ylab = "Частота",
       ylim = c(0, 1))
# взяла пятый он самый гетерогенный :))