FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y git build-essential cmake curl \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y zlib1g-dev libx11-dev libcurl4-openssl-dev xvfb \
    && git clone https://github.com/mapbox/mapbox-gl-native.git \
    && cd mapbox-gl-native \
    && curl -o ca-bundle.crt https://curl.haxx.se/ca/cacert-2017-01-18.pem \
    && make offline

LABEL io.whalebrew.name mbgl-offline 
LABEL io.whalebrew.config.volumes '["~/:/root/"]'
WORKDIR /mapbox-gl-native
ENTRYPOINT ["./build/linux-x86_64/Debug/mbgl-offline"]
