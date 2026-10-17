FROM python:3.9-alpine3.16

LABEL "maintainer"="Stephen Arnold <nerdboy422@gmail.com>" \
      "repository"="https://github.com/sarnold/action-pypi-version" \
      "homepage"="https://github.com/sarnold/action-pypi-version" \
      "com.github.actions.name"="action-pypi-version" \
      "com.github.actions.description"="Get latest package version from pypi" \
      "com.github.actions.icon"="python" \
      "com.github.actions.color"="package"

RUN apk --no-cache add git bash

ADD entrypoint.sh /
ADD requirements.txt /

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /requirements.txt
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
