#!/bin/sh
set -e

#
# Staker
#

PUBKEY_STAKER_01NODE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Az2kGKb9Jta/47VaFUVLWXmSb1NsGCXwVyofGnT2z+xe"}'
PUBKEY_STAKER_ALLNODES='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A+z1b8ShNIUxR5sVssxvBOGt19hWEl5b2y5rHMW5O2vf"}'
PUBKEY_STAKER_CHORUSONE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Ai4ZY5/BKI+WVowB54zbw5kyrTbGzHDF0fizI1mT5ALQ"}'
PUBKEY_STAKER_COSMOSTATION='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AmdIUTn53SjvymnjyIAzM48ePvOz1IIrUGEjzdwD70ZG"}'
PUBKEY_STAKER_DSRV='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AroULbdtZQCjQnE2zRxCp7zO6HrHiqbRgxIeFXXCb/jp"}'
PUBKEY_STAKER_EVERSTAKE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A7Yi5eeppeM75uwpiQsie8dY+JXUWQWfO0GUJ1x/B0Rs"}'
PUBKEY_STAKER_KEPLR='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A7NH/e7j/Tek4YC2Ad5Y6KBaNsLe4PMt14V2BypaRc7f"}'

celestia-appd keys add mw-s1 --pubkey $PUBKEY_STAKER_01NODE
celestia-appd keys add mw-s2 --pubkey $PUBKEY_STAKER_ALLNODES
celestia-appd keys add mw-s3 --pubkey $PUBKEY_STAKER_CHORUSONE
celestia-appd keys add mw-s4 --pubkey $PUBKEY_STAKER_COSMOSTATION
celestia-appd keys add mw-s5 --pubkey $PUBKEY_STAKER_DSRV
celestia-appd keys add mw-s6 --pubkey $PUBKEY_STAKER_EVERSTAKE
celestia-appd keys add mw-s7 --pubkey $PUBKEY_STAKER_KEPLR

# Expected: celestia1vxzram63f7mvseufc83fs0gnt5383lvrle3qpt
celestia-appd keys add \
--multisig mw-s1,mw-s2,mw-s3,mw-s4,mw-s5,mw-s6,mw-s7 \
--multisig-threshold 5 staker

celestia-appd keys delete mw-s1 -y
celestia-appd keys delete mw-s2 -y
celestia-appd keys delete mw-s3 -y
celestia-appd keys delete mw-s4 -y
celestia-appd keys delete mw-s5 -y
celestia-appd keys delete mw-s6 -y
celestia-appd keys delete mw-s7 -y

#
# Staker Controller
#

PUBKEY_STAKER_CONTROLLER_01NODE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AvfyTXAxfXGHgs4oGFdNJYk+FZYzEgI2O9CDKZk9oiH6"}'
PUBKEY_STAKER_CONTROLLER_ALLNODES='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AsT2hJp1FGTuhNtXnQqRjJN8VU8PtWW/fyC1uesqotJE"}'
PUBKEY_STAKER_CONTROLLER_CHORUSONE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A5rIlZtyvz1YgkTgtzZeW0Znw3K1VABGYR9n9YB6ULok"}'
PUBKEY_STAKER_CONTROLLER_COSMOSTATION='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AnxLq7WAekdD7Uo+KCgmPxbwqllUIGtCXCxYQCS2GH2Y"}'
PUBKEY_STAKER_CONTROLLER_DSRV='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AjQyCsCIFl/p+UOKTREcMtwaaMoHBm5o6Sf952vE/Dj+"}'
PUBKEY_STAKER_CONTROLLER_EVERSTAKE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AunIfl+OnfdoAiT+OGFQg2Pf8bDAjxFga50aqr3cHWQS"}'
PUBKEY_STAKER_CONTROLLER_KEPLR='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A8w0vxoHFJBqFuLQrSz2jZnuQIfi4aN9Q4Bfi7vg2ihY"}'

celestia-appd keys add mw-sc1 --pubkey $PUBKEY_STAKER_CONTROLLER_01NODE
celestia-appd keys add mw-sc2 --pubkey $PUBKEY_STAKER_CONTROLLER_ALLNODES
celestia-appd keys add mw-sc3 --pubkey $PUBKEY_STAKER_CONTROLLER_CHORUSONE
celestia-appd keys add mw-sc4 --pubkey $PUBKEY_STAKER_CONTROLLER_COSMOSTATION
celestia-appd keys add mw-sc5 --pubkey $PUBKEY_STAKER_CONTROLLER_DSRV
celestia-appd keys add mw-sc6 --pubkey $PUBKEY_STAKER_CONTROLLER_EVERSTAKE
celestia-appd keys add mw-sc7 --pubkey $PUBKEY_STAKER_CONTROLLER_KEPLR

# Expected: celestia16g5l6n9kg6879z695g6qjh70qv6wzqg640z9pn
celestia-appd keys add \
--multisig mw-sc1,mw-sc2,mw-sc3,mw-sc4,mw-sc5,mw-sc6,mw-sc7 \
--multisig-threshold 5 staker-controller

celestia-appd keys delete mw-sc1 -y
celestia-appd keys delete mw-sc2 -y
celestia-appd keys delete mw-sc3 -y
celestia-appd keys delete mw-sc4 -y
celestia-appd keys delete mw-sc5 -y
celestia-appd keys delete mw-sc6 -y
celestia-appd keys delete mw-sc7 -y

#
# Rewards Collector
#

PUBKEY_REWARDS_COLLECTOR_01NODE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A5RORiziy/FSAiNZJdROcaqZWKVji/auWQQkI9LdsAYj"}'
PUBKEY_REWARDS_COLLECTOR_ALLNODES='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AzjHPG5Gp5HggpUqT2AVDatPqGY5E0MmaHXBJeWj8VsE"}'
PUBKEY_REWARDS_COLLECTOR_CHORUSONE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A4FiJus8oaRUX1vXyF9Qy040EL5wibtBYV0OwU+5mpw5"}'
PUBKEY_REWARDS_COLLECTOR_COSMOSTATION='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Awm7MwaElQ9yxgLuKu4zYOVRLQO9JMvfd/OQXSo3Aa1/"}'
PUBKEY_REWARDS_COLLECTOR_DSRV='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AyTGhI1725E2aATUMzGRlZ1oc/kV0AKugzrBGo8C9bkx"}'
PUBKEY_REWARDS_COLLECTOR_EVERSTAKE='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A6wj4MRwLAZAkJWQ82OqTKeSI/P91DxWRAN8PnFMbL+p"}'
PUBKEY_REWARDS_COLLECTOR_KEPLR='{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A/zl9DME57oiyX8ltf1dYi9+4ZswhKeys7dh6cDNtop6"}'

celestia-appd keys add mw-rc1 --pubkey $PUBKEY_REWARDS_COLLECTOR_01NODE
celestia-appd keys add mw-rc2 --pubkey $PUBKEY_REWARDS_COLLECTOR_ALLNODES
celestia-appd keys add mw-rc3 --pubkey $PUBKEY_REWARDS_COLLECTOR_CHORUSONE
celestia-appd keys add mw-rc4 --pubkey $PUBKEY_REWARDS_COLLECTOR_COSMOSTATION
celestia-appd keys add mw-rc5 --pubkey $PUBKEY_REWARDS_COLLECTOR_DSRV
celestia-appd keys add mw-rc6 --pubkey $PUBKEY_REWARDS_COLLECTOR_EVERSTAKE
celestia-appd keys add mw-rc7 --pubkey $PUBKEY_REWARDS_COLLECTOR_KEPLR

# Expected: celestia1vr00egrck8a0dax68fgglrm3n8v4yz9wjj7cj2
celestia-appd keys add \
--multisig mw-rc1,mw-rc2,mw-rc3,mw-rc4,mw-rc5,mw-rc6,mw-rc7 \
--multisig-threshold 5 rewards-collector

celestia-appd keys delete mw-rc1 -y
celestia-appd keys delete mw-rc2 -y
celestia-appd keys delete mw-rc3 -y
celestia-appd keys delete mw-rc4 -y
celestia-appd keys delete mw-rc5 -y
celestia-appd keys delete mw-rc6 -y
celestia-appd keys delete mw-rc7 -y
