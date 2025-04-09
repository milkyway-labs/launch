# Create Multisig Accounts

## Overview

### What is Multisig account?

Before we start, if you are not familiar with what a multisig account is, a multisig account is a special key that requires more than one signature to sign transactions. This can be useful for increasing the security of the account or for requiring the consent of multiple parties to make transactions.

To sign with a multisig account, the transaction must be signed individually by the different keys specified for the account. Then the signatures from each individual will be combined into a multisignature which can be used to sign the transaction. If fewer than the threshold number of signatures needed are present, the resultant multisignature is considered invalid.

### MilkyWay Multisig accounts

The multisig setup is a critical aspect of MilkyWay protocol. Our multisig accounts on Babylon are a 5-of-7 configuration, meaning transactions need approval from at least 5 operators. This setup is crucial for ensuring a high-security standard. Prior to a launch, every operator needs to generate accounts and share their public keys. This repository will collect public keys and create multisig accounts that will be used within the MilkyWay protocol. However, it is important to note that **keys are NOT utilized in day-to-day operations**. They come into play only when the MilkyWay protocol undergoes changes, such as modifications to the operator set, and in the event of slashing incidents.

MilkyWay protocol necessitates the use of three multisig accounts on Babylon:

1. `Staker`

   - This account is configured as a 5-of-7 multisig, utilizing the public keys of the operators. It serves its purpose of holding funds and grant full authorization to the `Staker Controller` multisig account. The full authorization means to grant privileges to grant to the `Staker Controller` multisig account on behalf of the `Staker`. It is suggested to be kept safe in cold storage.

2. `Staker Controller`

   - This account is configured as a 5-of-7 multisig, utilizing the public keys of the operators. It receives a full authorization from the `Staker` multisig account and performs actions on behalf of the `Staker` multisig account. This account will be used to grant a limited authorization to the `Grantee` account.

3. `Rewards Collector`
   - This account is configured as a 5-of-7 multisig, utilizing the public keys of the operators. It is primarily responsible for receiving staking rewards on behalf of the `Staker` multisig account and is instrumental in enhancing accounting management.

If you're not familiar with the need for multisig accounts or the meaning of full and limited authorization, delve into our [technical architecture](https://github.com/milkyway-labs/architecture). It provides a comprehensive overview, shedding light on the design and structure of MilkyWay.

## Instruction

### Generating accounts

We suggest using a hardware wallet, Ledger device to store your keys because it greatly improves the security and it is supported in `babylond` binary. If you plan to use other hardware devices or a software wallet, we assume that you are already familiar with the best practices for the management and security, ensuring they are neither lost nor compromised. Please exercise caution in securely managing the keys and feel free to engage in discussions with other operators for additional insights.

In this guide, we will generate accounts using a Ledger device.
First, you need to build `babylond` either from the source by following their [documentation](https://docs.babylonlabs.io/operators/babylon_node/installation_guide/) or download from the [releases](https://github.com/babylonlabs-io/babylon/releases) page.
Usually the binary's version doesn't affect how keys are generated, so feel free to pick up any version.
At the time of writing, [v1.0.0-rc.8](https://github.com/babylonlabs-io/babylon/releases/tag/v1.0.0-rc.8) is the latest version.

```bash
#
# Staker
#

# Add your Ledger key for `Staker`
babylond keys add staker --ledger --index 0

# Confirm your address
babylond keys show staker -d

# Example
- address: bbn1...
  name: staker
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"{YOUR_PUBLIC_KEY}"}'
  type: ledger

#
# Staker Controller
#

# Add your Ledger key for `Staker Controller`
babylond keys add staker-controller --ledger --index 1

# Confirm your address
babylond keys show staker-controller -d

# Example
- address: bbn1...
  name: staker-controller
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"{YOUR_PUBLIC_KEY}"}'
  type: ledger

#
# Rewards Collector
#

# Add your Ledger key for `Rewards Collector`
babylond keys add rewards-collector --ledger --index 2

# Confirm your address
babylond keys show rewards-collector -d

# Example
- address: bbn1...
  name: rewards-collector
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"{YOUR_PUBLIC_KEY}"}'
  type: ledger
```

### Submitting your public keys

1. Fork this repository
2. Copy the `{OPERATOR_NAME}.txt` file inside `pubkeys` directory into the same directory
3. Input your public keys after changing the text file name to match your operator name
4. Create a pull request

### Creating multisig accounts

After collecting public keys from all operators, the MilkyWay team will handle creating the multisig accounts by running the [scripts/create_multisigs.py](./scripts/create_multisigs.py) script.

## Remark

As a core contributor to MilkyWay protocol, we extend our warmest welcome to you on the remarkable journey of the MilkyWay protocol. Your committment to being an operator is invaluable. We eagerly anticipate the collaborative efforts that lie ahead and are grateful for your participation in shaping the future of our protocol.

Thank you for joining us, and we look forward to the journey ahead!
