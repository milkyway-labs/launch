# Wind Down milkINIT

## Context

MilkyWay has decided to wind down the milkINIT protocol.
To return users' principal tokens, the MilkyWay team will transfer the tokens to an Osmosis liquidity pool.
For this process, please sign the transactions granting the team's address full authorization over the existing multisig accounts.
Refer to [the X post](https://x.com/milky_way_zone/status/2011770175566332325) for the details.

## Instructions

1. Register the staker controller and the rewards collector multisigs.

   > If you already have the multisigs in the keyring, you can skip to the next
   > step.

   Register the multisigs with the following command:

   ```shell
   initiad keys add staker-controller --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AxliJD9rSZHQP2z2+H3gOHsWAZXFZAP++18rbSzr11P1"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Av98iyLOQhaJS8Zi11c6tQQ2d0dHwZjkD9KUETXrgdKN"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A5vdfLNIhAAlSL234o6EjwAwBrUdMIKeD03JIu3u0DKa"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AsyU0pO3dqZ+58XMlid2yeaZWyt1zG/fUzVw2zS7d8Jx"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AgLmjeWoCNWF9k293PQd03LtEkmVK+jMDrs1LylKoCs8"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A/1RaxFo2Hr6DFOxTh0lekU3aGN6T9T3ybj7iS6wMHHQ"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A+kudBBUM51bSOHions37Y7Gx6+CWL8I1vVtuAFNKRTS"}]}'

   initiad keys add rewards-collector --pubkey '{"@type":"/cosmos.crypto.multisig.LegacyAminoPubKey","threshold":5,"public_keys":[{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A4hW2Gdjup3yFGs0og0DJ/yh8iYOB+Fc+usvWxrOnB3K"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A8HZJkm/NY+VxaVnHhqq8P1SKEFZc7XvQ70oRTi+0fzS"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"A/hEBDv0+d6xc3UQvkIu0gnPu8zGch9I8pgf3uO7hMxc"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"AxkGoMBs6l33/+bumcfYP9fhsuESkHaXvkTB1yCP9CAO"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Asm39oZuBCNQjN9h2sVt38YyxgZ0Q3+gWtwmii8lB/hS"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"Anp1anez4QWETxCOwjfhsea/ZgsV6nOAnCIERQAyD3HJ"},{"@type":"/initia.crypto.v1beta1.ethsecp256k1.PubKey","key":"ApyFtp335skky3VZm45TO38X5q8OtaiFHIUVag4hqKlF"}]}'
   ```

2. Import your keys.

   > If you already have your keys imported, you can skip to the next step.

   Assuming you're using Ledger, use this command to import your operator keys
   for the multisigs:

   ```shell
   initiad keys add op-staker-controller --ledger --index <index>
   initiad keys add op-rewards-collector --ledger --index <index>
   ```

3. Sign the transactions.

   Use these commands to sign the
   [transaction for the staker](./staker_controller_unsigned_tx.json) and the
   [transaction for the rewards collector](./rewards_collector_unsigned_tx.json):

   ```shell
   initiad tx sign staker_controller_unsigned_tx.json \
     --chain-id interwoven-1 \
     --from op-staker-controller \
     --multisig init18ymfyqtgcg52z7te2ej7m6509fp3mhr2sm6yu0 \
     --node https://rpc.initia.xyz \
     --sign-mode amino-json \
     --signature-only \
     --ledger

   initiad tx sign rewards_collector_unsigned_tx.json \
     --chain-id interwoven-1 \
     --from op-rewards-collector \
     --multisig init1c6u0pslgmqvd6qkt3usx6apktz4mhtylrtadkp \
     --node https://rpc.initia.xyz \
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
