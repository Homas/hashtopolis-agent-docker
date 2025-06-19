FROM nvidia/cuda:12.8.1-devel-ubuntu24.04

RUN apt update && apt install -y --no-install-recommends \
  zip \
  git \
  python3 \
  python3-psutil \
  python3-requests \
  pciutils \
  ocl-icd-libopencl1 \
  curl && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /root/agent-python && \
  mkdir -p /etc/OpenCL/vendors && \
  echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

WORKDIR /root/agent-python

RUN git clone https://github.com/hashtopolis/agent-python.git && \
  cd agent-python && \
  ./build.sh && \
  mv hashtopolis.zip /root/ && \
  cd ../ && rm -R agent-python

COPY onstart.sh /root/

# https://github.com/Milz0/hashtopolis-hashcat-vast
# https://nikita-guliaev.medium.com/clustering-hashcat-with-hashtopolis-for-distributed-cloud-computing-55f964a56804
# onstart-script
# cd /root/agent-python
# python3 hashtopolis.zip --url server_api --voucher voucher_id