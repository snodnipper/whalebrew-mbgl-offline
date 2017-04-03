FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y git build-essential cmake curl \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y zlib1g-dev libx11-dev libcurl4-openssl-dev xvfb \
    && git clone https://github.com/mapbox/mapbox-gl-native.git \
    && cd mapbox-gl-native \
    && sed -ie 's/handleError(curl_easy_setopt(handle, CURLOPT_CAINFO, "ca-bundle.crt"));/\/\/handleError(curl_easy_setopt(handle, CURLOPT_CAINFO, "ca-bundle.crt"));/g' /mapbox-gl-native/platform/default/http_file_source.cpp \
    && make offline
    
LABEL io.whalebrew.name mbgl-offline

ENTRYPOINT ["/mapbox-gl-native/build/linux-x86_64/Debug/mbgl-offline"]
