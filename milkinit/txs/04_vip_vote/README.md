# Grant Authorization to Enable VIP Voting

## Context

We need to grant a new `/initia.move.v1.ExecuteAuthorization` to the
coordinator so that we can do Initia VIP gauge voting.

- Granter: `init1hll9rg3wprq2eyq53xnrjf3e33d6p5g8s74t5r` (the Staker multisig)
- Grantee: `init1rvd5tnt5dpegej427s8wygv85hynxvqfkyyllt` (the Grantee account)
- Module address: [`0x3a886b32a802582f2e446e74d4a24d1d7ed01adf46d2a8f65c5723887e708789`](https://docs.initia.xyz/resources/developer/deployed-contracts/initia)
- Module name: `weight_vote`
- Functions to allow: `vote`, `vote_with_amount`

## Instructions

1. Register staker multisig.

   > If you already have the staker multisig in the keyring, you can skip to the next step.

   Register the staker multisig with the following command:

   ```shell
   initiad keys add staker --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Ap7AGas283Y/mDRuKPbRNfKDYUwp54Rv+ghwXWCZK+vp"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Ap3iS1vPzuqGbI3gHazfA9daepJ1Vk+Mx7k4qOmhqgOU"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A6J+/IYQxVY/642MVp9FY195bcbEGekVP//eKxoM0zCp"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AqUp+pLK1doyrzODvqqtkkUBQADj/x1lnhLu1+jMNBW7"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Alpsypvj7nQAb9K/of05xIXdbTjk4Xs1IGnvabXKAi0Y"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A5TPk+IFF9cl6Oal04Nr4tXGFXuvIeGadXPunZqfoXbS"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Av/7+2RH4al8Q6vp70sIOt++bLh7gk3FoAnEZZ/Pr4WT"}]}'
   ```

2. Import your key.

   > If you already have your key imported, you can skip to the next step.

   Assuming you're using Ledger, use this command to import your operator key for the staker multisig:

   ```shell
   initiad keys add op-staker --ledger --index <index>
   ```

3. Sign the transaction.

   Use this command to sign the [transaction](./unsigned_tx.json):

   ```shell
   initiad tx sign unsigned_tx.json \
     --chain-id interwoven-1 \
     --from op-staker \
     --multisig init1hll9rg3wprq2eyq53xnrjf3e33d6p5g8s74t5r \
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
