FROM gdssingapore/airbase:python-3.13-builder AS build-stage0

RUN apt-get update
RUN apt-get -y install build-essential procps curl file git sudo
# Install Homebrew
# RUN useradd -m -s /bin/bash linuxbrew && \
#         mkdir -p /home/linuxbrew/.linuxbrew && \
#         chown -R linuxbrew: /home/linuxbrew/.linuxbrew
# USER linuxbrew

# Create a non-root user and switch to it
RUN useradd -m dockeruser
#RUN usermod -aG sudo dockeruser


# Create a sudoers file for your user with NOPASSWD to avoid password prompts
RUN echo "dockeruser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dockeruser && \
    chmod 0440 /etc/sudoers.d/dockeruser

USER dockeruser
#RUN sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

# Install Homebrew and set the PATH in a single chained command
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install python@3.11

# USER root
# RUN echo >> /root/.bashrc
# RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc
# RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# RUN brew install python@3.11
#RUN echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> /home/dockeruser/.profile

RUN echo >> /home/dockeruser/.profile \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/dockeruser/.profile 
    # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    # brew install python@3.11

# RUN echo >> /home/dockeruser/.profile
# RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/dockeruser/.profile
# RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#RUN brew install python@3.11

RUN export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"

RUN python3 --version
RUN pip3 --version
WORKDIR /app
COPY --chown=dockeruser:dockeruser requirements.txt ./
# RUN pip3 install -r requirements.txt

FROM gdssingapore/airbase:python-3.13-builder
RUN useradd -m dockeruser
USER dockeruser
COPY --from=build-stage0 /home/linuxbrew/.linuxbrew/bin/* /home/linuxbrew/.linuxbrew/bin/
RUN export PATH="/home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin:$PATH"
WORKDIR /app
COPY --from=build-stage0 /app/requirements.txt ./
COPY --chown=dockeruser:dockeruser . ./
# CMD ["bash", "-c", "python3 streamlit run main.py --server.port=$PORT"]
# FROM gdssingapore/airbase:python-3.13
# ENV PYTHONUNBUFFERED=TRUE
# RUN apt-get update && \
#     apt-get install -y python3.11 python3.11-dev python3.11-venv python3.11-distutils python3-pip && \
#     apt-get clean

# #Create and activate a Python 3.11 virtual environment
# RUN python3.11 -m venv /opt/venv311
# ENV PATH="/opt/venv311/bin:$PATH"

# RUN python --version
# RUN pip --version
# COPY --chown=app:app requirements.txt ./
# RUN pip install -r requirements.txt