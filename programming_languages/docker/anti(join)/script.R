#!/usr/bin/env Rscript

library(dplyr)

# Метаданные образцов
sample_metadata <- data.frame(
  sample_id = paste0("Sample_", 1:6),
  cell_type = c("HEK293", "HeLa", "HEK293", "U2OS", "HeLa", "Primary"),
  treatment = c("Control", "Drug_A", "Drug_B", "Control", "Drug_A", "Drug_C"),
  replicate = c(1, 1, 1, 2, 2, 1),
  concentration_uM = c(0, 10, 50, 0, 10, 100),
  stringsAsFactors = FALSE
)

# Результаты масс-спектрометрии
mass_spec_results <- data.frame(
  sample_id = paste0("Sample_", c(1, 2, 3, 4, 7)),
  total_proteins = c(2450, 2310, 2540, 2480, 2600),
  unique_peptides = c(15200, 14800, 15600, 15400, 16200),
  contamination_level = c(0.02, 0.05, 0.03, 0.01, 0.04),
  stringsAsFactors = FALSE
)

write.csv(sample_metadata, "/data/sample_metadata.csv", row.names = FALSE)
write.csv(mass_spec_results, "/data/mass_spec_results.csv", row.names = FALSE)

cat("sample_metadata:", nrow(sample_metadata), "строк\n")
cat("mass_spec_results:", nrow(mass_spec_results), "строк\n\n")

# Anti-left join: строки из sample_metadata, которых нет в mass_spec_results
anti_left_result <- anti_join(sample_metadata, mass_spec_results, by = "sample_id")
write.csv(anti_left_result, "/data/anti_left_join.csv", row.names = FALSE)
cat("Сохранено в /data/anti_left_join.csv\n\n")

# Anti-right join: строки из mass_spec_results, которых нет в sample_metadata
anti_right_result <- anti_join(mass_spec_results, sample_metadata, by = "sample_id")
write.csv(anti_right_result, "/data/anti_right_join.csv", row.names = FALSE)
cat("Сохранено в /data/anti_right_join.csv\n\n")

# Anti-outer join (полный anti-join): строки, которые не совпадают в обеих таблицах
anti_outer_result <- bind_rows(
  anti_left_result %>% mutate(source = "only_in_metadata"),
  anti_right_result %>% mutate(source = "only_in_mass_spec")
)

write.csv(anti_outer_result, "/data/anti_outer_join.csv", row.names = FALSE)
cat("Сохранено в /data/anti_outer_join.csv\n\n")

cat("Общее количество строк в sample_metadata:", nrow(sample_metadata), "\n")
cat("Общее количество строк в mass_spec_results:", nrow(mass_spec_results), "\n")
cat("Совпадающие sample_id:", intersect(sample_metadata$sample_id, mass_spec_results$sample_id), "\n")
cat("Уникальные sample_id в sample_metadata:", setdiff(sample_metadata$sample_id, mass_spec_results$sample_id), "\n")
cat("Уникальные sample_id в mass_spec_results:", setdiff(mass_spec_results$sample_id, sample_metadata$sample_id), "\n")

