FROM nvidia/cuda:9.0-cudnn7-devel

RUN apt-get -qq update && \ 
    apt-get -qq -y install \
      curl wget bzip2 git libgl1-mesa-dev gcc make gnupg && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cloud9
RUN git clone https://github.com/c9/core.git /cloud9 && \
    cd /cloud9 && \
    scripts/install-sdk.sh

RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -bfp /usr/local && \
    rm -rf /tmp/miniconda.sh && \
    conda install -y python=3 && \
    conda update conda && \
    apt-get -qq -y autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log && \
    conda clean --all --yes

RUN conda config --append channels conda-forge
RUN conda install -y \
      cython numpy scipy scikit-learn matplotlib seaborn plotly pandas \
      joblib ipython jupyter jupyter_contrib_nbextensions 

RUN jupyter contrib nbextension install --system

RUN pip install tqdm cupy-cuda90

WORKDIR /work

EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip", "0.0.0.0"]
