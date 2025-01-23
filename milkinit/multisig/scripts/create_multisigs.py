#!/usr/bin/env python3

import os
from pathlib import Path
import subprocess

import yaml # pip install pyyaml


class colors:
    RED = "\033[91m"
    GREEN = "\033[92m"
    END = "\033[0m"


def print_err(msg):
    print(f"{colors.RED}error{colors.END}: {msg}")


BINARY = os.getenv("BINARY", "initiad")
MULTISIG_THRESHOLD = os.getenv("MULTISIG_THRESHOLD", 5)
MULTISIG_NAMES = ("staker", "staker-controller", "rewards-collector")
all_pubkeys = []

print(f"{colors.GREEN}Multisig threshold:{colors.END} {MULTISIG_THRESHOLD}")

for p in Path("./pubkeys").glob("*.txt"):
    # ignore template file
    if p.name == "{OPERATOR_NAME}.txt":
        continue

    with p.open() as f:
        data = yaml.load(f, Loader=yaml.Loader)
        pubkeys = {item["name"]: item["pubkey"] for item in data}
        for name in MULTISIG_NAMES:
            if name not in pubkeys:
                print_err(f"file '{p}' doesn't have the following key: {name}")
                exit(1)
        all_pubkeys.append(pubkeys)

if not all_pubkeys:
    print_err("no pubkeys collected")
    exit(1)

print(f"{colors.GREEN}Number of operators:{colors.END} {len(all_pubkeys)}")
print(f"{colors.GREEN}Commands:{colors.END}")

commands = []

for name in MULTISIG_NAMES:
    print(f"\n# Create {name} multisig address")

    key_names = []
    for i, pubkeys in enumerate(all_pubkeys):
        pubkey = pubkeys[name]
        key_name = f"{name}-{i+1}"
        key_names.append(key_name)
        command = f"yes | {BINARY} keys add {key_name} --pubkey '{pubkey}'"
        commands.append(command)
        print(command)

    command = f"yes | {BINARY} keys add {name} --multisig {','.join(key_names)} --multisig-threshold {MULTISIG_THRESHOLD}"
    commands.append(command)
    print(command)

    for i, key_name in enumerate(key_names):
        command = f"{BINARY} keys delete {key_name} -y"
        commands.append(command)
        print(command)

if input(f"\n{colors.GREEN}Do you want to execute the commands [y/N]?{colors.END} ").strip().lower() == "y":
    for command in commands:
        retcode = subprocess.call(f"{command} >/dev/null 2>&1", shell=True)
        if retcode != 0:
            print_err(f"'{command}' failed with exit code {retcode}")
            exit(retcode)
        print(".", end="", flush=True)
    print(f"\n{colors.GREEN}Successfully executed commands{colors.END}")

    print(f"\n{colors.GREEN}Created multisig addresses:{colors.END}")
    for name in MULTISIG_NAMES:
        addr = subprocess.check_output(f"{BINARY} keys show -a {name}", shell=True).decode().strip()
        print(f"{colors.GREEN}{name}:{colors.END} {addr}")