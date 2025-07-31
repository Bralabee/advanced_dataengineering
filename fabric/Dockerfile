FROM mambaorg/micromamba:1.5.8

WORKDIR /app
COPY . .
# Add conda-forge channel and create env with python 3.11
RUN micromamba create -n fabric -c conda-forge python=3.11 -y && \
    echo 'source activate fabric' >> ~/.bashrc
# Install azure-storage-file-datalake with pip using micromamba run
RUN micromamba run -n fabric pip install azure-storage-file-datalake

CMD ["micromamba", "run", "-n", "fabric", "python", "-c", "import azure.storage.filedatalake; print('Fabric container ready')"]
