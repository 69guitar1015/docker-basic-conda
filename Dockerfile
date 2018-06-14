FROM nvidia/cuda

RUN apt update && \
    apt install -y 

RUN apt-get -qq update && \ 
      apt-get -qq -y install curl bzip2


RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
      bash /tmp/miniconda.sh -bfp /usr/local && \
      rm -rf /tmp/miniconda.sh && \
      conda install -y python=3 && \
      conda update conda && \
      apt-get -qq -y remove curl bzip2 && \
      apt-get -qq -y autoremove && \
      apt-get autoclean && \
      rm -rf /var/lib/apt/lists/* /var/log/dpkg.log && \
      conda clean --all --yes

RUN conda config --append channels conda-forge
RUN conda install -y \
        cython numpy scipy scikit-learn matplotlib seaborn plotly pandas dask dask-ml \
        joblib ipython jupyter jupyter_contrib_nbextensions 

RUN jupyter contrib nbextension install --system
 
WORKDIR /work

EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip", "0.0.0.0"]
