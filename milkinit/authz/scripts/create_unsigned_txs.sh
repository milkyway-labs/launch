#!/bin/sh

# Ensure we have all the environment variables set

set -eu -o pipefail
echo "\033[92mStaker:\033[0m $STAKER"
echo "\033[92mStaker controller:\033[0m $STAKER_CONTROLLER"
echo "\033[92mRewards collector:\033[0m $REWARDS_COLLECTOR"
echo "\033[92mGrantee:\033[0m $GRANTEE"
echo "\033[92mWhitelisted validators:\033[0m $VALIDATORS"
echo "\033[92mStaking Contract:\033[0m $CONTRACT"
echo "\033[92mSource Channel:\033[0m $SOURCE_CHANNEL"

# Create staker_tx.json

echo
echo "\033[92mCreating staker_tx.json\033[0m"

initiad tx authz grant $STAKER_CONTROLLER generic --msg-type "/cosmos.authz.v1beta1.MsgGrant" --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_01.json
printf "."

initiad tx authz grant $STAKER_CONTROLLER generic --msg-type "/cosmos.authz.v1beta1.MsgRevoke" --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_02.json
printf "."

initiad tx authz grant $STAKER_CONTROLLER generic --msg-type "/cosmos.feegrant.v1beta1.MsgGrantAllowance" --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_03.json
printf "."

initiad tx authz grant $STAKER_CONTROLLER generic --msg-type "/cosmos.feegrant.v1beta1.MsgRevokeAllowance" --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_04.json
printf "."

initiad tx authz grant $STAKER_CONTROLLER generic --msg-type "/cosmos.distribution.v1beta1.MsgSetWithdrawAddress" --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_05.json
printf "."

initiad tx authz grant $GRANTEE delegate --allowed-validators $VALIDATORS --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_06.json
printf "."

initiad tx authz grant $GRANTEE unbond --allowed-validators $VALIDATORS --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_07.json
printf "."

initiad tx authz grant $GRANTEE redelegate --allowed-validators $VALIDATORS --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_08.json
printf "."

initiad tx authz grant $GRANTEE generic --msg-type "/cosmos.distribution.v1beta1.MsgWithdrawDelegatorReward" --expiration 0 \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_09.json
printf "."

GRANTER=$STAKER GRANTEE=$GRANTEE SOURCE_CHANNEL=$SOURCE_CHANNEL RECEIVER=$CONTRACT \
  envsubst < transfer_authz_template.json > staker_tx_10.json
printf "."

initiad tx feegrant grant $STAKER $GRANTEE --allowed-messages "/cosmos.staking.v1beta1.MsgDelegate" \
  --generate-only --offline -a 0 -s 0 > staker_tx_11.json
printf "."

initiad tx distribution set-withdraw-addr $REWARDS_COLLECTOR \
  --from $STAKER --generate-only --offline -a 0 -s 0 > staker_tx_12.json
printf "."

jq -s '{
  "body": {
    "messages": (map(.body.messages) | add)
  },
  "auth_info": {
    "signer_infos": [],
    "fee": {
      "amount": [
        {
          "denom": "uinit",
          "amount": "15000"
        }
      ],
      "gas_limit": 1000000,
      "payer": "",
      "granter": ""
    },
    "tip": null
  },
  "signatures": []
}' staker_tx_*.json > staker_tx.json
printf "."

rm staker_tx_*.json
printf "."

echo
echo "\033[92mSuccessfully created staker_tx.json!\033[0m"

# Create rewards_collector_tx.json

echo
echo "\033[92mCreating rewards_collector_tx.json\033[0m"

GRANTER=$REWARDS_COLLECTOR GRANTEE=$GRANTEE SOURCE_CHANNEL=$SOURCE_CHANNEL RECEIVER=$CONTRACT \
  envsubst < transfer_authz_template.json > rewards_collector_tx.json
printf "."

echo
echo "\033[92mSuccessfully created rewards_collector_tx.json!\033[0m"
