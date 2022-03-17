# ethereum-local-development-env

Build a local ethereum development environment for test things out.

## Requirement

- Private network (with fully control, reproducible & small disk size)
- Run in docker
- Debug-able

## Prerequisite

Docker

## Genesis file

Genesis file is based on the `geth dumpgenesis`

Change `$chainId` and `$yourEthAddress` (which will get 100 Eth init balance)

```json
{
  "config": {
    "chainId": $chainId,
    "homesteadBlock": 0,
    "daoForkBlock": 0,
    "daoForkSupport": true,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0,
    "istanbulBlock": 0,
    "muirGlacierBlock": 0,
    "berlinBlock": 0,
    "londonBlock": 0,
    "arrowGlacierBlock": 0,
    "ethash": {}
  },
  "nonce": "0x0",
  "timestamp": "0x0",
  "extraData": "",
  "gasLimit": "0x1388",
  "difficulty": "0x1",
  "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": "0x0000000000000000000000000000000000000000",
	"alloc": {
    "$yourEthAddress": {
      "balance": "0x56bc75e2d63100000"
    }
  },
  "number": "0x0",
  "gasUsed": "0x0",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "baseFeePerGas": null
}
```

## Start the nodes

```bash
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

You can also pass cumstom `geth` parameters by

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

Learnt a lot from https://github.com/vertigobr/ethereum
