FROM ubuntu:16.04

WORKDIR /code

RUN apt-get update && \
    apt-get install software-properties-common -yq && \
    apt-get install python3 python -yq && \
    apt-add-repository ppa:ansible/ansible -y && \
    apt-get update -yq && \
    apt-get install ansible -yq && \
    apt-get install python-pip -yq && \
    pip install --upgrade pip && \
    apt-get install python-netaddr -yq

RUN git clone https://github.com/kubernetes-incubator/kubespray.git && \
    cd kubespray && \
    wget -c https://github.com/kubernetes-incubator/kubespray/blob/master/contrib/inventory_builder/inventory.py
