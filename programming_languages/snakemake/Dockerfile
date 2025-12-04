FROM rocker/r-ver:4.3.0

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('dplyr', repos='https://cloud.r-project.org/')"

WORKDIR /app

COPY script.R /app/script.R
COPY requirements.txt /app/requirements.txt

