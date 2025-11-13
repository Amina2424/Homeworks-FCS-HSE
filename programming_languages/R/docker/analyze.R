# Загрузка необходимых библиотек
library(readxl)
library(ggplot2)

# Чтение данных
df <- read_excel('Пациенты.xlsx')

# Проверка структуры данных
cat("Структура данных:\n")
str(df$Пол)
str(df$Возраст)

# Преобразование пола в фактор
df$Пол <- factor(df$Пол, levels = c("м", "ж"))
cat("\nУровни фактора Пол:\n")
print(levels(df$Пол))

# Создание возрастных групп
df$возраст_группа_2 <- ifelse(df$Возраст <= 60, "Молодые", "Старшие")

# Пациенты старше 75 лет
cat("\nПациенты старше 75 лет:\n")
print(df$Возраст[df$Возраст > 75])

# Описательная статистика
cat("\nОписательная статистика (первые 6 строк):\n")
print(head(df[, c("лейкоциты", "глюкоза")]))

cat("\nСводная статистика:\n")
print(summary(df[, c("лейкоциты", "глюкоза")]))

# Средний уровень глюкозы по полу
cat("\nСредний уровень глюкозы по полу:\n")
glucose_by_sex <- aggregate(глюкоза ~ Пол, data = df, mean)
print(glucose_by_sex)

cat("\nСредние лейкоциты по полу и возрастной группе:\n")
leukocytes_by_group <- aggregate(лейкоциты ~ Пол + возраст_группа_2, data = df, FUN = mean)
print(leukocytes_by_group)

cat("\nРасширенная статистика по глюкозе:\n")
glucose_stats <- do.call(data.frame, 
        aggregate(глюкоза ~ Пол, data = df, 
                  FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x))))
print(glucose_stats)

# Статистика по гемоглобину
cat("\nСтатистика по гемоглобину по возрастным группам:\n")
final_results <- do.call(data.frame, 
        aggregate(гемоглобин ~ возраст_группа_2, data = df, 
                  FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x))))

colnames(final_results) <- c("Возрастная_группа", "Средний_гемоглобин", "Стандартное_отклонение", "Количество_наблюдений")

write.csv(final_results, "/app/results/анализ_гемоглобина.csv", row.names = FALSE, fileEncoding = "UTF-8")

cat("\nФайл 'анализ_гемоглобина.csv' успешно сохранен в папку /app/results/\n")

cat("\nСодержимое папки /app/results/:\n")
print(list.files("/app/results/"))

cat("\nСодержимое сохраненного файла:\n")
saved_data <- read.csv("/app/results/анализ_гемоглобина.csv")
print(saved_data)
