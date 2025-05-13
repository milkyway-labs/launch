# Add CryptoCrew to milkINIT Validator Set

## Context

We add CryptoCrew to the milkINIT validator set.
The address to add is [`initvaloper15a07mcvjzrgtlf8mpp05r3avy9jvvgu2gucxxf`](https://scan.initia.xyz/interwoven-1/validators/initvaloper15a07mcvjzrgtlf8mpp05r3avy9jvvgu2gucxxf).

## Instructions

1. Register staker controller multisig.

   > If you already have the staker controller multisig in the keyring, you can skip to the next step.

   Register the staker controller multisig with the following command:

   ```shell
   initiad keys add staker-controller --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AxliJD9rSZHQP2z2+H3gOHsWAZXFZAP++18rbSzr11P1"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Av98iyLOQhaJS8Zi11c6tQQ2d0dHwZjkD9KUETXrgdKN"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A5vdfLNIhAAlSL234o6EjwAwBrUdMIKeD03JIu3u0DKa"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AsyU0pO3dqZ+58XMlid2yeaZWyt1zG/fUzVw2zS7d8Jx"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AgLmjeWoCNWF9k293PQd03LtEkmVK+jMDrs1LylKoCs8"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A/1RaxFo2Hr6DFOxTh0lekU3aGN6T9T3ybj7iS6wMHHQ"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A+kudBBUM51bSOHions37Y7Gx6+CWL8I1vVtuAFNKRTS"}]}'
   ```

2. Import your key.

   > If you already have your key imported, you can skip to the next step.

   Assuming you're using Ledger, use this command to import your operator key for the staker controller multisig:

   ```shell
   initiad keys add op-staker-controller --ledger --index <index>
   ```

3. Sign the transaction.

   Use this command to sign the [transaction](./unsigned_tx.json):

   ```shell
   initiad tx sign unsigned_tx.json \
     --chain-id interwoven-1 \
     --from op-staker-controller \
     --multisig init18ymfyqtgcg52z7te2ej7m6509fp3mhr2sm6yu0 \
     --node https://rpc.initia.xyz \
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
