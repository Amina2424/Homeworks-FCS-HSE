# Docker Homework - Pandas JOIN Operations

В данном примере продемонстрировано  выполнение различных JOIN операций в Pandas внутри Docker контейнера.

## Структура проекта
```
week_6/
├── Dockerfile
├── requirements.txt
├── data.py
├── join.py
├── README.md
├── input/ (монтируется в контейнер)
└── output/ (монтируется из контейнера)
```


### Создание структуры папок
```bash
mkdir -p input output
chmod 777 output
```
### Сборка Docker образа
``` bash
docker build -t pandas-join .
```
### Запуск Docker контейнера
```bash
docker run -v $(pwd)/input:/app/input -v $(pwd)/output:/app/output pandas-joins
```
