# Grant Authorizations

## Overview

In this step, operators are required to sign signatures to setup the preparation for launch step in [this technical architecture](https://github.com/milkyway-labs/architecture).

### Multisig Accounts

The following multisig accounts are generated from [the previous process](../multisig/README.md).

| Name                | Address                                       |
| ------------------- | --------------------------------------------- |
| `Staker`            | `init1hll9rg3wprq2eyq53xnrjf3e33d6p5g8s74t5r` |
| `Staker Controller` | `init18ymfyqtgcg52z7te2ej7m6509fp3mhr2sm6yu0` |
| `Rewards Collector` | `init1c6u0pslgmqvd6qkt3usx6apktz4mhtylrtadkp` |
| `Grantee`           | `init1rvd5tnt5dpegej427s8wygv85hynxvqfkyyllt` |

### Signing signatures

For your convenience, the following unsigned transaction files are prepared using [scripts/create\_unsigned\_txs.sh](./scripts/create_unsigned_txs.sh).

- `staker_tx.json`
- `rewards_collector_tx.json`

#### `staker_tx.json`

The first transaction consists of the following messages from the `Staker` multisig account:

1. Allows the `Staker Controller` multisig account to execute `/cosmos.authz.v1beta1.MsgGrant` on behalf of it
2. Allows the `Staker Controller` multisig account to execute `/cosmos.feegrant.v1beta1.MsgGrantAllowance` on behalf of it
3. Allows the `Staker Controller` multisig account to execute `/cosmos.distribution.v1beta1.SetWithdrawAddress` on behalf of it
4. Allows the `Grantee` multisig account to delegate to the whitelisted validators on behalf of it
5. Allows the `Grantee` multisig account to undelegate from the whitelisted validators on behalf of it
6. Allows the `Grantee` multisig account to redelegate to the whitelisted validators on behalf of it
7. Allows the `Grantee` multisig account to withdraw staking rewards on behalf of it
8. Allows the `Grantee` multiisg account to transfer unbonded tokens to the staking contract on behalf of it
9. Allows the `Grantee` multisig account to use it as the fee granter for tx
10. Change the withdraw address of staking rewards to the `Rewards Collector` multisig account

Connect your ledger to your device and sign it.

```bash
# Import your `Staker` wallet
# Change index to the one that you have used when setting the account
initiad keys add op-staker --ledger --index 0

# We use the following public RPC endpoint to get account number.
NODE="https://..." # TODO: needs to determine
STAKER_ADDR="init1..." # TODO: needs to determine

# Sign the unsigned transaction and print the signature.
initiad tx sign staker_tx.json \
--chain-id XXX \ # TODO: needs to determine
--from op-staker \
--multisig $STAKER_ADDR \
--ledger \
--node $NODE \
--sign-mode amino-json \
--signature-only
```

#### `rewards_collector_tx.json`

The second transaction has only one message from the `Rewards Collector` multisig account which allows the `Grantee` multisig account to transfer withdrawn staking rewards to the staking contract on behalf of it.

Again, connect your ledger to your device and sign it.

```bash
# Import your Rewards Collector wallet
# Change index to the one that you have used when setting the account
initiad keys add op-rewards-collector --ledger --index 2

# We use the following public RPC endpoint to get account number.
NODE="https://..." # TODO: needs to determine
REWARDS_COLLECTOR_ADDR="init1..." # TODO: needs to determine

# Sign the unsigned transaction
initiad tx sign rewards_collector_tx.json \
--chain-id XXX \ # TODO: needs to determine
--from op-rewards-collector \
--multisig $REWARDS_COLLECTOR_ADDR \
--ledger \
--node $NODE \
--signature-only
```

### Submitting your signatures

In order to setup the pre-launch described in [this technical architecture](https://github.com/milkyway-labs/architecture#preparation-for-launch), we need to collect signatures from all operators.

1. Fork this repository.
2. Copy the `{OPERATOR_NAME}.txt` file inside `signatures` directory into the same directory
3. Input your signatures
4. Create a pull request
