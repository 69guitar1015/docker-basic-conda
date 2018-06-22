FROM continuumio/miniconda3

RUN apt-get update && \
    apt-get install -y \
      curl wget git libgl1-mesa-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN conda config --append channels conda-forge
RUN conda update -y -n base conda && \
    conda install -y \
        cython numpy scipy scikit-learn matplotlib seaborn plotly pandas dask dask-ml \
        joblib ipython jupyter jupyter_contrib_nbextensions 

RUN jupyter contrib nbextension install --system

RUN pip instal tqdm

WORKDIR /work

EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip", "0.0.0.0"]
