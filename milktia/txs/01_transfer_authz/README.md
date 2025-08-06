# Fix Transfer Authorization

## Context

Since Celestia has upgraded their ibc-go dependency recently, the previous
transfer authorizations no longer work.
We grant new transfer authorizations with `"allowed_packet_data": ["*"]`.

In order to fix the authorizations correctly, the milkTIA operators need to sign
two transactions: one for the staker(via the staker controller) and another for
the rewards collector.

## Instructions

1. Register the staker controller and the rewards collector multisigs.

   > If you already have the multisigs in the keyring, you can skip to the next
   > step.

   Register the multisigs with the following command:

   ```shell
   celestia-appd keys add staker-controller --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A8w0vxoHFJBqFuLQrSz2jZnuQIfi4aN9Q4Bfi7vg2ihY"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AvfyTXAxfXGHgs4oGFdNJYk+FZYzEgI2O9CDKZk9oiH6"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AunIfl+OnfdoAiT+OGFQg2Pf8bDAjxFga50aqr3cHWQS"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AsT2hJp1FGTuhNtXnQqRjJN8VU8PtWW/fyC1uesqotJE"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AjQyCsCIFl/p+UOKTREcMtwaaMoHBm5o6Sf952vE/Dj+"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AnxLq7WAekdD7Uo+KCgmPxbwqllUIGtCXCxYQCS2GH2Y"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A5rIlZtyvz1YgkTgtzZeW0Znw3K1VABGYR9n9YB6ULok"}]}'

   celestia-appd keys add rewards-collector --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Awm7MwaElQ9yxgLuKu4zYOVRLQO9JMvfd/OQXSo3Aa1/"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A5RORiziy/FSAiNZJdROcaqZWKVji/auWQQkI9LdsAYj"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A6wj4MRwLAZAkJWQ82OqTKeSI/P91DxWRAN8PnFMbL+p"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AzjHPG5Gp5HggpUqT2AVDatPqGY5E0MmaHXBJeWj8VsE"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A/zl9DME57oiyX8ltf1dYi9+4ZswhKeys7dh6cDNtop6"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AyTGhI1725E2aATUMzGRlZ1oc/kV0AKugzrBGo8C9bkx"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A4FiJus8oaRUX1vXyF9Qy040EL5wibtBYV0OwU+5mpw5"}]}'
   ```

2. Import your keys.

   > If you already have your keys imported, you can skip to the next step.

   Assuming you're using Ledger, use this command to import your operator keys
   for the multisigs:

   ```shell
   celestia-appd keys add op-staker-controller --ledger --index <index>
   celestia-appd keys add op-rewards-collector --ledger --index <index>
   ```

3. Sign the transactions.

   Use these commands to sign the
   [transaction for the staker](./staker_controller_unsigned_tx.json) and the
   [tranbsaction for the rewards collector](./rewards_collector_unsigned_tx.json):

   ```shell
   celestia-appd tx sign staker_controller_unsigned_tx.json \
     --chain-id celestia \
     --from op-staker-controller \
     --multisig celestia16g5l6n9kg6879z695g6qjh70qv6wzqg640z9pn \
     --node https://celestia-mocha-rpc.publicnode.com:443 \
     --sign-mode amino-json \
     --signature-only \
     --ledger

   celestia-appd tx sign rewards_collector_unsigned_tx.json \
     --chain-id celestia \
     --from op-rewards-collector \
     --multisig celestia1vr00egrck8a0dax68fgglrm3n8v4yz9wjj7cj2 \
     --node https://celestia-mocha-rpc.publicnode.com:443 \
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
