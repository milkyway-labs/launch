# Grant Authorization to Enable VIP Voting

## Context

We need to grant a new `/initia.move.v1.ExecuteAuthorization` to the
coordinator so that we can do Initia VIP gauge voting.

- Granter: `init1hll9rg3wprq2eyq53xnrjf3e33d6p5g8s74t5r` (the Staker multisig)
- Grantee: `init1rvd5tnt5dpegej427s8wygv85hynxvqfkyyllt` (the Grantee account)
- Module address: [`0x3a886b32a802582f2e446e74d4a24d1d7ed01adf46d2a8f65c5723887e708789`](https://docs.initia.xyz/resources/developer/deployed-contracts/initia)
- Functions to allow: `vote`, `vote_with_amount`

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
