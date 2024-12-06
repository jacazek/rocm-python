ARG ROCM_DOCKER_IMAGE

FROM ${ROCM_DOCKER_IMAGE}
ENV ROCM_PATH=/opt/rocm
ENV LD_LIBRARY_PATH="/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

RUN apt -y update \
    && apt -y upgrade \
    && apt -y install git wget ffmpeg python3-venv python3-dev cmake ninja-build build-essential unzip liblapack-dev liblapack3 gfortran libgfortran5 libblas3 libblas-dev zstd \
    # && python3 -m pip install matplotlib transformers datasets jupyterlab reactivex biopython torchmetrics lightning \
    && python3 -m pip install --upgrade --pre torch torchvision torchaudio --index-url ${ROCM_PYTORCH_INDEX_URL} \
    && python3 -m pip cache purge \
    && apt clean

CMD python3