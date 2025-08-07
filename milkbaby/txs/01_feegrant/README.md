# Fix Fee Allowances

## Context

Currently, the staker has granted a fee allowance only for `/babylon.epoching.v1.MsgWrappedDelegate`.
But since the grantee performs various transactions using `/cosmos.authz.v1beta1.MsgExec` on behalf of the staker and the rewards collector, current fee allowance isn't working.
The staker should revoke its previous allowance and grant a new allowance with `/cosmos.authz.v1beta1.MsgExec` instead.
The staker controller will be the signer of this transaction, which has enough permissions to send messages on behalf of the staker.

## Instructions

1. Register staker controller multisig.

   > If you already have the staker controller multisig in the keyring, you can skip to the next step.

   Register the staker controller multisig with the following command:

   ```shell
   babylond keys add staker-controller --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A3U19YGzJSTeN+avl+YYNi1GDikM6T6k7+TCEKtMEFdS"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A6ja5wwl4xJBy4cMMcrVhUCAnY6BNzTb8atKfWw2MN6u"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Aq2gBX3XyJQRYqGkowNikjBrgZKUGZ6rzpkIBICuoP5f"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A88gTPlHoVzBSCG1dFc3+lCH5+FQt0/s50V4UwnHXOuY"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Ar1b0euzsMbwHIPsupTeE8HXhwZ0rv+siQd2csfWBBBo"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A2ZIZXANZKdNo9ini8EY7rkpKjoMiU1aJsksuR1NvC9Q"},{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A03j8CunpLxM9mcwYCXLWAjIQmI4uZNg9AG/Ki/9LOSx"}]}'
   ```

2. Import your key.

   > If you already have your key imported, you can skip to the next step.

   Assuming you're using Ledger, use this command to import your operator key for the staker controller multisig:

   ```shell
   babylond keys add op-staker-controller --ledger --index <index>
   ```

3. Sign the transaction.

   Use this command to sign the [transaction](./unsigned_tx.json):

   ```shell
   babylond tx sign unsigned_tx.json \
     --chain-id bbn-1 \
     --from op-staker-controller \
     --multisig bbn1644m5hs8c0e6cv00n3tg3y2mv2vjykgnrdzdek \
     --node https://babylon.nodes.guru/rpc \
     --sign-mode amino-json \
     --signature-only \
     --ledger
   ```

   > If you're not using ledger, omit `--ledger` flag.

4. Submit the signature

   Create a file named `{YOUR_OPERATOR_NAME}.txt` inside [signatures](./signatures/) directory and paste your signature there.
   The file content should look like this:

   ```
   {"signatures":[{"public_key":{"@type":"...","key":"..."},"data":{"single":{"mode":"SIGN_MODE_LEGACY_AMINO_JSON","signature":"..."}},"sequence":"..."}]}
   ```

   Then, create a pull request to [this repository](https://github.com/milkyway-labs/launch) with your signature.
