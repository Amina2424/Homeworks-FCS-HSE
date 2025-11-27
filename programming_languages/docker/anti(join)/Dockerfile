# Используем официальный образ R
FROM r-base:4.3.2

WORKDIR /app

COPY script.R .

RUN R -e "install.packages('dplyr', repos='https://cloud.r-project.org/')"

RUN mkdir -p /data

VOLUME ["/data"]

CMD ["Rscript", "script.R"]
