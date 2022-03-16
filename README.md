# ethereum-local-development-env

Build a local ethereum development environment for test things out.

## Requirement

- Private network (fully control, reproducible, small disk size)
- Run in docker
- Three nodes in the network: one bootstrap node, one miner, and one full node
- Debug-able

## Prerequisite

Ethereum geth & tools 1.10.16-stable

Docker 20.10.8

## Genesis file

Dump genesis file

```bash
geth dumpgenesis
```

Change `$chainId` and `$your_eth_address` (which will get 100 Eth init balance)

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
    "$your_eth_address": {
      "balance": "0x56bc75e2d63100000"
    }
  },
  "number": "0x0",
  "gasUsed": "0x0",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "baseFeePerGas": null
}
```

Reference:

[How to Create an Ethereum Genesis File](https://consensys.net/blog/quorum/hyperledger-besu-how-to-create-an-ethereum-genesis-file/)

[ethereum local development env setup - genesis file](https://github.com/ethereum/go-ethereum/issues/24525)

## Bootstrap node

Bootstrap nodes is hardcoded in [ethereum code](https://github.com/ethereum/go-ethereum/blob/master/params/bootnodes.go)

Since you want a private network so you need start a bootnode by yourself.

```json
docker pull ethereum/client-go:alltools-v1.10.16
```
