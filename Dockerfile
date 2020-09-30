FROM ubuntu:18.04

# System packages
ARG PYTHON_VERSION=3.7

# Python packages
ARG FIGLET_VERSION=0.8.post1
ARG POSIX_IPC=1.0.4
ARG WATCHDOG=0.10.3
ARG DOCOP_VERSION=0.6.2

RUN apt-get update

# Install all the python3 nesessary libs
RUN apt-get -y install --no-install-recommends apt-transport-https ca-certificates gcc build-essential
RUN apt-get -y install --no-install-recommends git wget python${PYTHON_VERSION} python${PYTHON_VERSION}-distutils python${PYTHON_VERSION}-dev

# Cleanup a bit
RUN apt-get autoremove
RUN apt-get autoclean

# Create non root user
RUN useradd -ms /bin/bash stalker

# Create the directories where our code will be mounted and do proper permissions stuff
RUN mkdir /var/mq-stalker
RUN chown -R stalker:stalker /var/mq-stalker

USER stalker
WORKDIR /home/stalker
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python${PYTHON_VERSION} get-pip.py --user

# Switch back to root to create a symbolic link for python
USER root
RUN ln -s /usr/bin/python3 /usr/bin/python & \
    ln -s /usr/bin/pip3 /usr/bin/pip

# Step down again and perform a basic cleanup to save some space ;)
USER stalker
RUN rm get-pip.py

# Set python3 as the python version that we are going to use
ENV PATH "/home/stalker/.local/bin:$PATH"
RUN echo "PATH=$PATH:/home/stalker/.local/bin" >> ~/.bashrc
RUN echo "alias python=\"python${PYTHON_VERSION}\"" >> ~/.bashrc

# Install python deps ( will be replaced with pip install requirement.txt so we don't need to touch dockerfile)
RUN pip install pyfiglet==$FIGLET_VERSION --user
RUN pip install posix_ipc==$POSIX_IPC --user
RUN pip install watchdog==$WATCHDOG --user
RUN pip install docopt==$DOCOP_VERSION --user

WORKDIR /var/mq-stalker
CMD [ "python", "/var/mq-stalker/stalk.py" ]