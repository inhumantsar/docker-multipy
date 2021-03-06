FROM alpine
MAINTAINER Shaun Martin <shaun@samsite.ca>

ENV PYENV_ROOT /root/.pyenv
ENV PATH "$PYENV_ROOT/bin:$PATH"
ENV LIBRARY_PATH=/lib:/usr/lib

VOLUME /workspace
ENV WORKSPACE /workspace
WORKDIR /workspace

RUN apk add --no-cache \
      bash \
      git \
      python \
      py-pip \
      python-dev \
      build-base \
      zlib-dev \
      linux-headers \
      readline-dev \
      bzip2-dev \
      openssl-dev \
      sqlite-dev \
      libffi-dev \
    && pip install tox tox-pyenv \
    && git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
    && echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> /root/.bashrc

ONBUILD ADD . /workspace/
ONBUILD RUN /bin/bash -c '([ -f pythons.txt ] && xargs -n 1 pyenv install < pythons.txt) || (echo "No pythons.txt file found. Cannot continue." && exit 1)'

CMD /bin/bash -c 'pyenv local $(pyenv versions --bare) && tox'
