FROM debian:latest

ARG RECEIVER_VERSION = "rtp-receiver-4.1.sh"

RUN apt-get update && \
    apt-get install -y pulseaudio gstreamer1.0-tools gstreamer1.0-plugins-good gstreamer1.0-pulseaudio && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV HOME="/home/receiver"
ENV PULSE_SERVER="tcp:host.containers.internal:4713"
RUN groupadd --gid 1000 receiver \
  && useradd --uid 1000 --gid 1000 --create-home --home-dir "$HOME" receiver \
  && usermod -aG audio,pulse,pulse-access receiver \
  && chown -R receiver:receiver "$HOME"

WORKDIR "$HOME"
COPY --chmod=755 --chown=1000:1000 ./services/${RECEIVER_VERSION} ./start.sh

USER receiver
ENTRYPOINT ["./start.sh"]
