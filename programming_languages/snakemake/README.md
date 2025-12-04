# Snakemake Pipeline для обработки данных масс-спектрометрии

Этот pipeline автоматизирует загрузку и анти-объединение (anti-join) данных масс-спектрометрии.

## Структура проекта

```
├── Dockerfile
├── Snakefile
├── script.R
├── README.md
```
## Для докер изображения
```docker build -t pipeline:latest . ```

## Для запуска пайплайна и визуалзации графов
```
snakemake --cores 1
snakemake --cores 1 --rulegraph | dot -Tpng > rulegraph.png
snakemake --cores 1 --filegraph | dot -Tpng > filegraph.png
```
После выполнения pipeline в папке output будут созданы три файла:
`anti_left_join.csv`, `anti_right_join.csv`, `anti_outer_join.csv`
