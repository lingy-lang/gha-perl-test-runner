ARG DOCKER_BASE_IMAGE_FQIN

FROM $DOCKER_BASE_IMAGE_FQIN

RUN cpanm -n Zilla::Dist
RUN cpanm -n Test2::Harness
RUN cpanm -n Term::ReadLine::Gnu
RUN cpanm -n Lingy

RUN apt update \
 && apt install -y \
        pandoc \
 && true

COPY bin/ /bin/

# Dev and debugging:
RUN apt update \
 && apt install -y \
        bash-completion \
        less \
        tig \
        tmate \
        vim \
 && ( \
        echo 'source /etc/bash_completion'; \
    ) >> ~/.bashrc \
 && true
