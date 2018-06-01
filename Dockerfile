FROM continuumio/miniconda3

RUN conda update -y -n base conda && \
    conda install -y -c conda-forge \
        cython numpy scipy scikit-learn matplotlib seaborn pandas \
        joblib ipython jupyter dask
    

WORKDIR /home
EXPOSE 8888
