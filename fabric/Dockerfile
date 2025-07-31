FROM mambaorg/micromamba:1.5.8

WORKDIR /app
COPY . .
# Add conda-forge channel and create env with python 3.11
RUN micromamba create -n fabric -c conda-forge python=3.11 -y && \
    echo 'source activate fabric' >> ~/.bashrc

# Install Azure Data Lake and authentication packages
RUN micromamba run -n fabric pip install azure-storage-file-datalake azure-identity

CMD ["micromamba", "run", "-n", "fabric", "python", "test_fabric_connection.py"]
