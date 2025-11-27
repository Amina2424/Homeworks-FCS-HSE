# Anti-Join Operations with Docker

Этот проект демонстрирует выполнение anti-join операций с использованием пакета `dplyr` в R, запущенного в Docker контейнере.

## Описание

Контейнер выполняет следующие операции:
1. Генерирует тестовые данные (метаданные образцов и результаты масс-спектрометрии)
2. Выполняет три типа anti-join операций:
   - Anti-left join
   - Anti-right join  
   - Anti-outer join
3. Сохраняет результаты в CSV файлы


Для запуска

`docker build -t anti-join .`
`mkdir -p data` - для монтирования
`docker run -v $(pwd)/data:/data anti-join-app`

### Выходные данные 

- sample_metadata.csv - исходные метаданные образцов
- mass_spec_results.csv - исходные результаты масс-спектрометрии
- anti_left_join.csv - результат anti-left join
- anti_right_join.csv - результат anti-right join
- anti_outer_join.csv - результат anti-outer join
