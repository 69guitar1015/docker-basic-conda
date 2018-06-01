FROM continuumio/miniconda3

RUN conda config --append channels conda-forge
RUN conda update -y -n base conda && \
    conda install -y \
        cython numpy scipy scikit-learn matplotlib seaborn pandas \
        joblib ipython jupyter dask
   
RUN mkdir /work 
WORKDIR /work

EXPOSE 8888
CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0"]
