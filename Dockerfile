FROM nvidia/cuda:12.6.3-runtime-ubuntu24.04
#FROM nvidia/cuda:12.9.1-cudnn-runtime-ubuntu24.04

RUN apt update && apt install -y --no-install-recommends \
  zip \
  git \
  python3 \
  python3-psutil \
  python3-requests \
  pciutils \
  curl && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /root/agent-python

WORKDIR /root/agent-python

RUN git clone https://github.com/hashtopolis/agent-python.git && \
  cd agent-python && \
  ./build.sh && \
  mv hashtopolis.zip ../ && \
  cd ../ && rm -R agent-python

# https://github.com/Milz0/hashtopolis-hashcat-vast
# https://nikita-guliaev.medium.com/clustering-hashcat-with-hashtopolis-for-distributed-cloud-computing-55f964a56804
# onstart-script
# cd /root/agent-python
# python3 hashtopolis.zip --url server_api --voucher voucher_id