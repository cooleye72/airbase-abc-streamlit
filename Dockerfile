FROM gdssingapore/airbase:python-3.13
ENV PYTHONUNBUFFERED=TRUE
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-dev python3.11-venv python3.11-distutils python3-pip && \
    apt-get clean

# ENV PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# RUN /bin/sh -c set -eux;
# ENV GPG_KEY=A035C8C19219BA821ECEA86B64E628F8D684696D
# ENV PYTHON_VERSION=3.11.9
# ENV PYTHON_SHA256=1f6e417b1d8718a5195a9c0a25f6c1c3b9a1b8b5b5e5e5e5e5e5e5e5e5e5e5e5
# RUN /bin/sh -c set -eux;
# RUN /bin/sh -c set -eux;

#Create and activate a Python 3.11 virtual environment
RUN python3.11 -m venv /opt/venv311
ENV PATH="/opt/venv311/bin:$PATH"

RUN python --version
RUN pip --version
COPY --chown=app:app requirements.txt ./
#RUN python3.11 -m pip install -r requirements.txt
RUN pip install -r requirements.txt
COPY --chown=app:app . ./
USER app
CMD ["bash", "-c", "streamlit run main.py --server.port=$PORT"]

##############################################
# Ubuntu Custom Build 3.11 Image
##############################################
# FROM ubuntu:jammy

# # Install Python and basic shell utilities first
# RUN apt-get update && \
#     apt-get install -y python3.11 python3.11-dev python3.11-venv python3.11-distutils python3-pip && \
#     apt-get clean

# #Verify Python version
# RUN python3 --version && \
#     python3.11 --version && \
#     python3 -m pip --version

# ENV PYTHONUNBUFFERED=TRUE
# COPY --chown=app:app requirements.txt ./
# RUN pip install -r requirements.txt
# COPY --chown=app:app . ./
# USER app
# CMD ["bash", "-c", "streamlit run main.py --server.port=$PORT"]

##############################################
# GDS Build Image
##############################################


#new

##############################################
# Modify GDS Build Image to use Python 3.11
##############################################
# FROM gdssingapore/airbase:python-3.13
# # 1. Install Python 3.11 alongside existing Python
# RUN apt-get update && \
#     apt-get install -y python3.11 python3.11-dev python3.11-venv python3.11-distutils python3-pip && \
#     apt-get clean

# # 2. Set Python 3.11 as default
# RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
#     update-alternatives --install /usr/bin/python python /usr/bin/python3.11 2 && \
#     update-alternatives --set python3 /usr/bin/python3.11 && \
#     update-alternatives --set python /usr/bin/python3.11

# RUN python3.11 -m pip --version

# # 3. Verify Python version
# # RUN python3 --version && \
# #     python3.11 --version && \
# #     python3 -m pip --version

# # 2. Create and activate a Python 3.11 virtual environment
# # RUN python3.11 -m venv /opt/venv311
# # ENV PATH="/opt/venv311/bin:$PATH"

# # 4. Set environment variables
# ENV PYTHONUNBUFFERED=TRUE
# ENV PIP_BREAK_SYSTEM_PACKAGES=1

# # 5. Install requirements
# COPY --chown=app:app requirements.txt ./
# RUN python3.11 -m pip install -r requirements.txt

# # 6. Copy application code
# COPY --chown=app:app . ./

# # 7. Switch to non-root user
# USER app

# # 8. Run Streamlit
# CMD ["bash", "-c", "python3.11 -m streamlit run app.py --server.port=$PORT"]