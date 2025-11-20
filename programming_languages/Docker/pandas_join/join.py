#!/usr/bin/env python3

import pandas as pd
import os
import sys

def perform_joins():
    try:
        sample_metadata = pd.read_csv('input/sample_metadata.csv')
        mass_spec_results = pd.read_csv('input/mass_spec_results.csv')
        quality_metrics = pd.read_csv('input/quality_metrics.csv')
        
        print(f"Прочитано:")
        print(f"- sample_metadata: {len(sample_metadata)} samples")
        print(f"- mass_spec_results: {len(mass_spec_results)} samples") 
        print(f"- quality_metrics: {len(quality_metrics)} samples")
        print()
        
    except FileNotFoundError as e:
        print(f"Ошибка: Файл не найден - {e}")
        sys.exit(1)
    
    inner_join = pd.merge(sample_metadata, mass_spec_results, 
                         on='sample_id', how='inner')
    print(f"Было: {len(sample_metadata)} + {len(mass_spec_results)} samples")
    print(f"Стало: {len(inner_join)} samples")
    print(f"Общие образцы: {list(inner_join['sample_id'])}")
    inner_join.to_csv('output/inner_join.csv', index=False)
    print("Результат сохранен в output/inner_join.csv")
    print()
    
    left_join = pd.merge(sample_metadata, mass_spec_results, 
                        on='sample_id', how='left')
    print(f"Было: {len(sample_metadata)} samples в левой таблице")
    print(f"Стало: {len(left_join)} samples")
    
    # Образцы без mass-spec данных
    missing_ms = left_join[left_join['total_proteins'].isna()]
    if len(missing_ms) > 0:
        print(f"Образцы без mass-spec данных: {list(missing_ms['sample_id'])}")
        print("В полях правой таблицы установлены NaN значения")
    else:
        print("Все образцы имеют mass-spec данные")
    
    left_join.to_csv('output/left_join.csv', index=False)
    print("Результат сохранен в output/left_join.csv")
    print()
    
    right_join = pd.merge(sample_metadata, quality_metrics, 
                         on='sample_id', how='right')
    print(f"Было: {len(quality_metrics)} samples в правой таблице")
    print(f"Стало: {len(right_join)} samples")
    
    only_in_quality = right_join[right_join['cell_type'].isna()]
    if len(only_in_quality) > 0:
        print(f"Образцы только в quality_metrics: {list(only_in_quality['sample_id'])}")
        print("В полях левой таблицы установлены NaN значения")
    else:
        print("Все образцы quality_metrics имеют метаданные")
    
    right_join.to_csv('output/right_join.csv', index=False)
    print("Результат сохранен в output/right_join.csv")
    print()
    
    outer_join = pd.merge(sample_metadata, mass_spec_results, 
                         on='sample_id', how='outer')
    print(f"Было: {len(sample_metadata)} + {len(mass_spec_results)} samples")
    print(f"Стало: {len(outer_join)} samples")
    
    outer_join['has_metadata'] = ~outer_join['cell_type'].isna()
    outer_join['has_mass_spec'] = ~outer_join['total_proteins'].isna()
    
    status_counts = outer_join[['has_metadata', 'has_mass_spec']].value_counts()
    print("Статус наличия данных:")
    for status, count in status_counts.items():
        has_meta, has_ms = status
        meta_status = "есть метаданные" if has_meta else "нет метаданных"
        ms_status = "есть mass-spec" if has_ms else "нет mass-spec"
        print(f"- {meta_status}, {ms_status}: {count} samples")
    
    outer_join.to_csv('output/outer_join.csv', index=False)
    print("Результат сохранен в output/outer_join.csv")
    print()
    
    print("Результаты сохранены в папке output:")

perform_joins()
