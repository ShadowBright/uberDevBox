#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_python() {

    export CONDA_DIR=/opt/conda
    export PATH=$CONDA_DIR/bin:$PATH

    echo 'export PATH=/opt/conda/bin:$PATH' | sudo tee -a /etc/profile.d/conda.sh

    wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh

    /bin/bash Miniconda-latest-Linux-x86_64.sh -b -p /opt/conda

    rm Miniconda-latest-Linux-x86_64.sh

    /opt/conda/bin/conda install --yes conda==latest

    conda install -q -y \
                terminado \
                && conda clean -yt

    pip install user-agents GeoIP

    # Install Python 3 packages
    conda install -q -y \
            'pandas=0.17*' \
            'matplotlib=1.4*' \
            'scipy=0.16*' \
            'seaborn=0.6*' \
            'scikit-learn=0.16*' \
            'scikit-image=0.11*' \
            'sympy=0.7*' \
            'cython=0.22*' \
            'patsy=0.4*' \
            'statsmodels=0.6*' \
            'cloudpickle=0.1*' \
            'dill=0.2*' \
            'numba=0.22*' \
            'bokeh=0.10*' \
            && conda clean -yt


    # Install Python 2 packages
    conda create -q -p $CONDA_DIR/envs/python2 python=2.7 \
            'pandas=0.17*' \
            'matplotlib=1.4*' \
            'scipy=0.16*' \
            'seaborn=0.6*' \
            'scikit-learn=0.16*' \
            'scikit-image=0.11*' \
            'sympy=0.7*' \
            'cython=0.22*' \
            'patsy=0.4*' \
            'statsmodels=0.6*' \
            'cloudpickle=0.1*' \
            'dill=0.2*' \
            'numba=0.22*' \
            'bokeh=0.10*' \
            pyzmq \
            && conda clean -yt

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_python
fi
