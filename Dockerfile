FROM continuumio/miniconda3

RUN conda config --append channels conda-forge
RUN conda update -y -n base conda && \
    conda install -y \
        cython numpy scipy scikit-learn matplotlib seaborn pandas dask dask-ml \
        joblib ipython jupyter jupyter_contrib_nbextensions 

RUN jupyter contrib nbextension install --system
 
WORKDIR /work

EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip", "0.0.0.0"]
