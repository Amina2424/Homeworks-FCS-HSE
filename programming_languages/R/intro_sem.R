# 3адание 1

# Создайте символьный вектор bases со значениями: "A", "T", "G", "C", "A".
bases <- c("A", "T", "G", "C", "A")

# Попробуйте создать вектор mixed с элементами TRUE, 5, "G". Какой тип данных будет у результирующего вектора? Проверьте с помощью typeof().
mixed <-  c(TRUE, 5, "G")
#typeof(mixed)
#[1] "character"

# Используйте функцию table() на векторе bases, чтобы посчитать частоту каждого нуклеотида.
#table(bases)
#A C G T 
#2 1 1 1 

# Задание 2

# Создайте матрицу data размером 5x4, заполненную числами от 1 до 20, заполняя данные по строкам (byrow = TRUE).
data <- matrix(c(1:20),nrow=5, ncol=4, byrow = TRUE)

'''
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    5    6    7    8
[3,]    9   10   11   12
[4,]   13   14   15   16
[5,]   17   18   19   20
'''

# Выведите на экран второй столбец матрицы
data[,2]
# [1]  2  6 10 14 18

# Выведите на экран третью строку матрицы

data[3,]
# [1]  9 10 11 12

# Извлеките элемент, находящийся на пересечении 4-й строки и 3-го столбца.
data[4,3]
# [1] 15

# Задание 3
# Преобразовать в верхний регистр

seq <- "atgcctga"
toupper(seq)
# [1] "ATGCCTGA"

# Задание 4

# Создайте матрицу из вектора чисел 1–9 с тремя строками, используя matrix()

# Матрица должна иметь 3 строки и 3 столбца. Выведите результат

nine_shape <- matrix(c(1:9), nrow = 3, ncol = 3)
ч 
'''
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
'''

# Задание 5
# Примените функцию sum к каждому столбцу с помощью apply(..., 2, sum) и выведите полученные суммы столбцов
m <- matrix(1:9, nrow=3)
apply(m,2,sum)

# [1]  6 15 24

# Задание 6
# Таблица частот 

col <- c("A", "C", "A", "G", "A", "C")
table(col)
'''
A C G 
3 2 1 
'''

# Задание 7
'''
example(barplot, package = "graphics") was run in the console.

To view output in the browser, the knitr package must be installed.
'''

op <- par(mfrow = 2:1, mgp = c(3,1,0)/2, mar = .1+c(3,3:1))
summary(d.Titanic <- as.data.frame(Titanic))
barplot(Freq ~ Class + Survived, data = d.Titanic,
        subset = Age == "Adult" & Sex == "Male",
        main = "barplot(Freq ~ Class + Survived, *)", ylab = "# {passengers}", legend.text = TRUE)
# Corresponding table :
(xt <- xtabs(Freq ~ Survived + Class + Sex, d.Titanic, subset = Age=="Adult"))
# Alternatively, a mosaic plot :
mosaicplot(xt[,,"Male"], main = "mosaicplot(Freq ~ Class + Survived, *)", color=TRUE)
par(op)

# Задание 8
# Количество элементов в векторе

col <- c("A", "T", "G", "C", "A", "A")
length(col)
# [1] 6

# Задание 9
# Сумма

nums <- c(5, 10, 15, 20)
sum(nums)
# [1] 50

# Задание 10
#Преобразуйте вектор в фактор и выведите уровни фактора

nucleotides <- c("A", "T", "G", "A", "C", "T", "G")
as.factor(nucleotides)

# [1] A T G A C T G
# Levels: A C G T

# Задание 11
# Найдите индекс элемента с максимальным значением

scores <- c(10, 25, 18, 30, 22)
ind <- which.max(scores)
# [1] 4

# Задание 12
# Объедините соответствующие элементы в одну строку

a <- c("A", "B", "C")
a <- result <- paste(a, collapse = ", ")
# [1] "A, B, C"


