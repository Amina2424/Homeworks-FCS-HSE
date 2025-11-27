#!/usr/bin/env python3

import pandas as pd
import numpy as np

def generate_sample_metadata():
    sample_metadata = pd.DataFrame({
        'sample_id': ['Sample_1', 'Sample_2', 'Sample_3', 'Sample_4', 'Sample_5', 'Sample_6'],
        'cell_type': ['HEK293', 'HeLa', 'HEK293', 'U2OS', 'HeLa', 'Primary'],
        'treatment': ['Control', 'Drug_A', 'Drug_B', 'Control', 'Drug_A', 'Drug_C'],
        'replicate': [1, 1, 1, 2, 2, 1],
        'concentration_uM': [0, 10, 50, 0, 10, 100]
    })
    return sample_metadata

def generate_mass_spec_results():
    mass_spec_results = pd.DataFrame({
        'sample_id': ['Sample_1', 'Sample_2', 'Sample_3', 'Sample_4', 'Sample_7'],
        'total_proteins': [2450, 2310, 2540, 2480, 2600],
        'unique_peptides': [15200, 14800, 15600, 15400, 16200],
        'contamination_level': [0.02, 0.05, 0.03, 0.01, 0.04]
    })
    return mass_spec_results

def generate_quality_metrics():
    quality_metrics = pd.DataFrame({
        'sample_id': ['Sample_2', 'Sample_3', 'Sample_4', 'Sample_5', 'Sample_8'],
        'rin_score': [8.5, 7.2, 9.1, 6.8, 8.9],
        'pcr_duplication': [0.12, 0.18, 0.09, 0.25, 0.11],
        'mapping_rate': [0.95, 0.87, 0.96, 0.82, 0.94]
    })
    return quality_metrics


sample_metadata = generate_sample_metadata()
mass_spec_results = generate_mass_spec_results()
quality_metrics = generate_quality_metrics()

sample_metadata.to_csv('input/sample_metadata.csv', index=False)
mass_spec_results.to_csv('input/mass_spec_results.csv', index=False)
quality_metrics.to_csv('input/quality_metrics.csv', index=False)

print(f"- sample_metadata.csv: {len(sample_metadata)} строк")
print(f"- mass_spec_results.csv: {len(mass_spec_results)} строк")
print(f"- quality_metrics.csv: {len(quality_metrics)} строк")
