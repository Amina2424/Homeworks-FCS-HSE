#!/usr/bin/env Rscript

library(dplyr)

sample_metadata <- read.csv("/data/input/sample_metadata.csv", stringsAsFactors = FALSE)
mass_spec_results <- read.csv("/data/input/mass_spec_results.csv", stringsAsFactors = FALSE)


anti_left_result <- anti_join(sample_metadata, mass_spec_results, by = "sample_id")
write.csv(anti_left_result, "/data/output/anti_left_join.csv", row.names = FALSE)
cat("Сохранено в /data/output/anti_left_join.csv\n\n")

anti_right_result <- anti_join(mass_spec_results, sample_metadata, by = "sample_id")
write.csv(anti_right_result, "/data/output/anti_right_join.csv", row.names = FALSE)
cat("Сохранено в /data/output/anti_right_join.csv\n\n")

anti_outer_result <- bind_rows(
  anti_left_result %>% mutate(source = "only_in_metadata"),
  anti_right_result %>% mutate(source = "only_in_mass_spec")
)
write.csv(anti_outer_result, "/data/output/anti_outer_join.csv", row.names = FALSE)
cat("Сохранено в /data/output/anti_outer_join.csv\n\n")

cat("Совпадающие sample_id:", intersect(sample_metadata$sample_id, mass_spec_results$sample_id), "\n")
cat("Уникальные sample_id в sample_metadata:", setdiff(sample_metadata$sample_id, mass_spec_results$sample_id), "\n")
cat("Уникальные sample_id в mass_spec_results:", setdiff(mass_spec_results$sample_id, sample_metadata$sample_id), "\n")