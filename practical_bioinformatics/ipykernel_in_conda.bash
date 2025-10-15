
#!/usr/bin/bash 

conda update -n base -c conda-forge conda
conda create -n ENV
conda activate ENV

conda install packages

conda install -c bioconda packages
conda install -c conda-forge packages
pip install ipykernel

python -m ipykernel install --user --name ENV —display-name "name_env"

```
add in  Jupyter Lab/Notebook kernel  "name_env" from kernel menu

packages - inside channels, for example pandas, numpy, scipy
ENV - name of your env 
```