# Wind Down milkBABY

## Context

MilkyWay has decided to wind down the milkBABY protocol.
To return users' principal tokens, the MilkyWay team will transfer the tokens to an Osmosis liquidity pool.
For this process, please sign the transactions granting the team's address full authorization over the existing multisig accounts.
Refer to [the X post](https://x.com/milky_way_zone/status/2011770175566332325) for the details.

## Instructions

1. Register the staker controller and the rewards collector multisigs.

   > If you already have the multisigs in the keyring, you can skip to the next
   > step.

   Register the multisigs with the following command:

   ```shell
   babylond keys add staker-controller --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A3U19YGzJSTeN+avl+YYNi1GDikM6T6k7+TCEKtMEFdS"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A6ja5wwl4xJBy4cMMcrVhUCAnY6BNzTb8atKfWw2MN6u"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Aq2gBX3XyJQRYqGkowNikjBrgZKUGZ6rzpkIBICuoP5f"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A88gTPlHoVzBSCG1dFc3+lCH5+FQt0/s50V4UwnHXOuY"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Ar1b0euzsMbwHIPsupTeE8HXhwZ0rv+siQd2csfWBBBo"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A2ZIZXANZKdNo9ini8EY7rkpKjoMiU1aJsksuR1NvC9Q"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A03j8CunpLxM9mcwYCXLWAjIQmI4uZNg9AG/Ki/9LOSx"}]}'

   babylond keys add rewards-collector --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AyR/Awc+D8MWvX2m0HEKVhUl2+UvcPx1842cw6OwqUSl"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AtwjfiEHHWefiNN+bY0/8mrXSRs5SLgpsPfzglxDvbEV"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Awp+9TTdccHU+51HgLRt6WGbKHGqEwdR/+QtmDN7xTpt"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Ai9rJ5dOVTXDt9v3uMNHeASdORwsLk5um0ZZVEPyMzgu"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AnGnUdA8j5G9k4+Zqh4s+HQMxj/kISsMUR7eX7XjNrNa"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AsLnkhBShJIwAsNsKHbIah5ZIj0VX/CIgbLL6y5vWJng"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A4qrmvyYp6JT6jcLPHa9u4ugMnWfXEjEUaUpYblyDV5+"}]}'
   ```

2. Import your keys.

   > If you already have your keys imported, you can skip to the next step.

   Assuming you're using Ledger, use this command to import your operator keys
   for the multisigs:

   ```shell
   babylond keys add op-staker-controller --ledger --index <index>
   babylond keys add op-rewards-collector --ledger --index <index>
   ```

3. Sign the transactions.

   Use these commands to sign the
   [transaction for the staker](./staker_controller_unsigned_tx.json) and the
   [transaction for the rewards collector](./rewards_collector_unsigned_tx.json):

   ```shell
   babylond tx sign staker_controller_unsigned_tx.json \
     --chain-id bbn-1 \
     --from op-staker-controller \
     --multisig bbn1644m5hs8c0e6cv00n3tg3y2mv2vjykgnrdzdek \
     --node https://babylon.nodes.guru/rpc \
     --sign-mode amino-json \
     --signature-only \
     --ledger

   babylond tx sign rewards_collector_unsigned_tx.json \
     --chain-id bbn-1 \
     --from op-rewards-collector \
     --multisig bbn1d8ph9vlz5583jvsuyanls6yha0ltw2e5lv2s82 \
     --node https://babylon.nodes.guru/rpc \
     --sign-mode amino-json \
     --signature-only \
     --ledger
   ```

   > If you're not using ledger, omit `--ledger` flag.

4. Submit the signatures

   Create a file named `{YOUR_OPERATOR_NAME}.txt` inside
   [signatures](./signatures/) directory and paste your signatures there.
   The file content should look like this:

   ```
   # staker_controller_unsigned_tx.json
   {"signatures":[{"public_key":{"@type":"...","key":"..."},"data":{"single":{"mode":"SIGN_MODE_LEGACY_AMINO_JSON","signature":"..."}},"sequence":"..."}]}

   # rewards_collector_unsigned_tx.json
   {"signatures":[{"public_key":{"@type":"...","key":"..."},"data":{"single":{"mode":"SIGN_MODE_LEGACY_AMINO_JSON","signature":"..."}},"sequence":"..."}]}
   ```

   Then, create a pull request to
   [this repository](https://github.com/milkyway-labs/launch) with your signature.
