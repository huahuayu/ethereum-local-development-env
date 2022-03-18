# ethereum-local-development-env

Build a local ethereum development environment for test things out.

## Requirement

- Private network (with fully control, reproducible & small disk size)
- Run in docker
- Debug-able

## Prerequisite

Docker

## Genesis file

[Genesis file](https://github.com/huahuayu/ethereum-local-development-env/blob/master/genesis_file/eth/genesis.json) is based on the `geth dumpgenesis`

Change `$chainId` and `$yourEthAddress` (which will get 100 Eth init balance)

## Config

Modify the [config file](https://github.com/huahuayu/ethereum-local-development-env/blob/master/config/config.conf) for example, go-ethereum version , datadir etc.

## Start the nodes

```bash
git clone https://github.com/huahuayu/ethereum-local-development-env.git
cd ethereum-local-development-env
chmod +x *.sh
./start_all.sh
```

It will start

- a bootstrap node
- a full node
- and a miner node

By default use `host` network

## Add new node

```bash
./run_node.sh node2
```

You can also pass custom `geth` parameters by

```bash
./run_node.sh node2 --maxpeers 10 --verbosity 4
```

## Attach node console

```bash
./attach.sh node1
./attach.sh miner1
```

## Check node logs

```bash
./show_log node1
./show_log miner1
```

## Cleanup

`cleanup.sh` will remove docker containers and their data dirs in host machine.

```bash
./cleanup.sh
```

## Reference

[Official Private Network Tutorial](https://geth.ethereum.org/docs/getting-started/private-net)

Learnt a lot from https://github.com/vertigobr/ethereum
