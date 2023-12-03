#!/bin/sh

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

celestia-appd keys add s1 --pubkey $PUBKEY_STAKER_01NODE
celestia-appd keys add s2 --pubkey $PUBKEY_STAKER_ALLNODES
celestia-appd keys add s3 --pubkey $PUBKEY_STAKER_CHORUSONE
celestia-appd keys add s4 --pubkey $PUBKEY_STAKER_COSMOSTATION
celestia-appd keys add s5 --pubkey $PUBKEY_STAKER_DSRV
celestia-appd keys add s6 --pubkey $PUBKEY_STAKER_EVERSTAKE
celestia-appd keys add s7 --pubkey $PUBKEY_STAKER_KEPLR

# Expected: celestia1vxzram63f7mvseufc83fs0gnt5383lvrle3qpt
celestia-appd keys add \
--multisig s1,s2,s3,s4,s5,s6,s7 \
--multisig-threshold 5 staker

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

celestia-appd keys add sc1 --pubkey $PUBKEY_STAKER_CONTROLLER_01NODE
celestia-appd keys add sc2 --pubkey $PUBKEY_STAKER_CONTROLLER_ALLNODES
celestia-appd keys add sc3 --pubkey $PUBKEY_STAKER_CONTROLLER_CHORUSONE
celestia-appd keys add sc4 --pubkey $PUBKEY_STAKER_CONTROLLER_COSMOSTATION
celestia-appd keys add sc5 --pubkey $PUBKEY_STAKER_CONTROLLER_DSRV
celestia-appd keys add sc6 --pubkey $PUBKEY_STAKER_CONTROLLER_EVERSTAKE
celestia-appd keys add sc7 --pubkey $PUBKEY_STAKER_CONTROLLER_KEPLR

# Expected: celestia16g5l6n9kg6879z695g6qjh70qv6wzqg640z9pn
celestia-appd keys add \
--multisig sc1,sc2,sc3,sc4,sc5,sc6,sc7 \
--multisig-threshold 5 staker-controller

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

celestia-appd keys add rc1 --pubkey $PUBKEY_REWARDS_COLLECTOR_01NODE
celestia-appd keys add rc2 --pubkey $PUBKEY_REWARDS_COLLECTOR_ALLNODES
celestia-appd keys add rc3 --pubkey $PUBKEY_REWARDS_COLLECTOR_CHORUSONE
celestia-appd keys add rc4 --pubkey $PUBKEY_REWARDS_COLLECTOR_COSMOSTATION
celestia-appd keys add rc5 --pubkey $PUBKEY_REWARDS_COLLECTOR_DSRV
celestia-appd keys add rc6 --pubkey $PUBKEY_REWARDS_COLLECTOR_EVERSTAKE
celestia-appd keys add rc7 --pubkey $PUBKEY_REWARDS_COLLECTOR_KEPLR

# Expected: celestia1vr00egrck8a0dax68fgglrm3n8v4yz9wjj7cj2
celestia-appd keys add \
--multisig rc1,rc2,rc3,rc4,rc5,rc6,rc7 \
--multisig-threshold 5 rewards-collector

