#!/usr/bin/env bash

gst-launch-1.0 udpsrc port=46000 buffer-size=65536 ! \
    application/x-rtp,media=audio,payload=127,clock-rate=48000,encoding-name=L16,channels=5 ! \
    rtpjitterbuffer latency=200 ! \
    rtpL16depay ! \
    audioconvert ! \
    pulsesink device="combine_sink_4.1"
