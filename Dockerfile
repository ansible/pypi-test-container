FROM quay.io/bedrock/alpine:3.19.1

COPY files/pip/*.txt /root/setup/
COPY files/devpi-server/devpi-server.yml /root/.config/devpi-server/devpi-server.yml

RUN apk --no-cache add python3
RUN python -m venv /root/devpi/
RUN /root/devpi/bin/pip install -r /root/setup/requirements.txt -c /root/setup/constraints.txt --disable-pip-version-check && rm -rf /root/.cache/
RUN /root/devpi/bin/devpi-init

CMD /root/devpi/bin/devpi-server
