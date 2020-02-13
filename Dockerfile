#######################################################
# This is the Dockerfile for an app to extract physio #
# data from a CMRR DICOM file to BIDS physio          #
#######################################################

ARG DEBIAN_VERSION=buster
ARG BASE_PYTHON_VERSION=3.8
# (don't use simply PYTHON_VERSION because it's an env variable)

# Use an official Python runtime as a parent image
FROM python:${BASE_PYTHON_VERSION}-slim-${DEBIAN_VERSION}

## install:
# -curl (to get the FSL distribution)
# -libquadmath0 (needed to run many FSL commands )
#RUN apt-get update && apt-get upgrade -y && apt-get install -y \
#    curl \
#    libquadmath0 \
#  && apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y

## install required python packages:
RUN pip install pydicom==1.4.1 numpy==1.18.1


### copy module:
COPY ["./dcm2bidsphysio.py", "/usr/local/src/"]
RUN chmod o+rx /usr/local/src/dcm2bidsphysio.py

ENTRYPOINT ["/usr/local/src/dcm2bidsphysio.py"]


