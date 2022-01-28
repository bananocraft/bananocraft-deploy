FROM debian:buster

ENV AKASH_KEY_NAME=akashWallet
ENV AKASH_KEYRING_BACKEND=os
ENV AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
ENV AKASH_VERSION="0.14.1"
ENV AKASH_CHAIN_ID=akashnet-2
ENV AKASH_NODE="https://rpc.akash.smartnodes.one:443"

RUN apt-get update
RUN apt-get install curl unzip vim -y

COPY .keyfile .

RUN curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v0.14.1"

EXPOSE 26656 26657 26658