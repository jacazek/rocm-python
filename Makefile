ROCM_VERSION=6.2
ROCM_PATCH_VERSION=${ROCM_VERSION}.4
ROCM_DOCKER_IMAGE=rocm/dev-ubuntu-24.04:${ROCM_PATCH_VERSION}-complete
ROCM_PYTORCH_INDEX_URL=https://download.pytorch.org/whl/nightly/rocm${ROCM_VERSION}
INSTALL_LOCATION=/mnt/data4/usr/local/bin
SIF_FILE_NAME=rocm${ROCM_PATCH_VERSION}_python.sif
PYTHON_SHELL=${INSTALL_LOCATION}/rocm${ROCM_PATCH_VERSION}-python
INSTALLED_SIF=${INSTALL_LOCATION}/${SIF_FILE_NAME}
BIN_DIRECTORY=./bin

.PHONY: prepare build clean rebuild

prepare:
	mkdir -p ${BIN_DIRECTORY}

build: prepare apptainer_build
	
# docker_build: Dockerfile
# 	docker build --build-arg ROCM_DOCKER_IMAGE=${ROCM_DOCKER_IMAGE} -t jacazek/rocm${ROCM_VERSION}_python .

apptainer_build: rocm_python.def
	apptainer build --build-arg ROCM_DOCKER_IMAGE=${ROCM_DOCKER_IMAGE} ${BIN_DIRECTORY}/${SIF_FILE_NAME} rocm_python.def

clean:
	rm -f ${BIN_DIRECTORY}/${SIF_FILE_NAME}

rebuild: clean build

install:
	echo "#!/usr/bin/env bash" > ${PYTHON_SHELL}
	echo 'apptainer run --rocm ${INSTALLED_SIF} $$@' >> ${PYTHON_SHELL}
	chmod a+x ${PYTHON_SHELL}
	rm -f ${INSTALL_LOCATION}/rocm-python
	rm -f ${INSTALLED_SIF}
	mv ${BIN_DIRECTORY}/${SIF_FILE_NAME} ${INSTALLED_SIF}
	ln -s ${PYTHON_SHELL} ${INSTALL_LOCATION}/rocm-python
	rm -f ${INSTALL_LOCATION}/create-python-dev-venv
	cp create-python-dev-venv ${INSTALL_LOCATION}/create-python-dev-venv

uninstall:
	rm -f ${INSTALL_LOCATION}/create-python-dev-venv
	rm -f ${INSTALL_LOCATION}/rocm-python
	rm -f ${INSTALLED_SIF}
	rm -f ${PYTHON_SHELL}



