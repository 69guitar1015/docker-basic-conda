FROM continuumio/miniconda3

RUN apt-get update && \
    apt-get install -y \
      curl wget git libgl1-mesa-dev gcc make gnupg && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cloud9
RUN git clone https://github.com/c9/core.git /cloud9 && \
    cd /cloud9 && \
    scripts/install-sdk.sh

RUN conda config --append channels conda-forge
RUN conda update -y -n base conda && \
    conda install -y \
        cython numpy scipy scikit-learn matplotlib seaborn plotly pandas dask dask-ml \
        joblib ipython jupyter jupyter_contrib_nbextensions 

RUN jupyter contrib nbextension install --system

RUN pip install tqdm

WORKDIR /work

EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip", "0.0.0.0"]
