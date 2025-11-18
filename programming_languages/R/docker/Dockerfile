# Используем официальный образ R
FROM r-base:4.3.2

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libudunits2-dev \
    libgdal-dev \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем необходимые R-пакеты
RUN R -e "install.packages('readxl', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('ggplot2', repos='https://cloud.r-project.org/')"

# Создаем рабочую директорию
WORKDIR /app

# Копируем R-скрипт и данные из текущей директории
COPY analyze.R .
COPY Пациенты.xlsx .

# Создаем папку для результатов

# Запускаем скрипт
CMD ["Rscript", "analyze.R"]
