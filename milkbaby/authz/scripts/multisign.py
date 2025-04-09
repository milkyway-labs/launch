#!/usr/bin/env python3

import os
from pathlib import Path
import subprocess


class colors:
    RED = "\033[91m"
    GREEN = "\033[92m"
    END = "\033[0m"


def print_err(msg):
    print(f"{colors.RED}error{colors.END}: {msg}")


BINARY = os.getenv("BINARY", "babylond")


try:
    sig1_files = []
    sig2_files = []

    for p in Path("./signatures").glob("*.txt"):
        # ignore template file
        if p.name == "{OPERATOR_NAME}.txt":
            continue

        with p.open() as f:
            lines = list(filter(None, (x.strip() for x in f.readlines())))
            if len(lines) != 4:
                print_err(f"file '{p}' has invalid format")
                exit(1)

        sig1 = lines[1]
        sig2 = lines[3]

        with p.with_name(f"{p.stem}_sig1.json").open("w") as f:
            f.write(sig1)
            sig1_files.append(f.name)

        with p.with_name(f"{p.stem}_sig2.json").open("w") as f:
            f.write(sig2)
            sig2_files.append(f.name)

    print(f"{colors.GREEN}Commands:{colors.END}")

    commands = []
    output_files = []

    for tx_file, multisig_name, sig_files in (
        ("./scripts/staker_tx.json", "staker", sig1_files),
        ("./scripts/rewards_collector_tx.json", "rewards-collector", sig2_files),
    ):
        output_file = Path(".") / (Path(tx_file).stem + "_signed.json")
        output_files.append(str(output_file))
        command = f"{BINARY} tx multisign {tx_file} {multisig_name} {' '.join(sig_files)} | jq > {output_file}"
        commands.append(command)
        print(command)

    if input(f"\n{colors.GREEN}Do you want to execute the commands [y/N]?{colors.END} ").strip().lower() != "y":
        exit(0)

    for command in commands:
        retcode = subprocess.call(command, shell=True)
        if retcode != 0:
            print_err(f"'{command}' failed with exit code {retcode}")
            exit(retcode)
        print(".", end="", flush=True)
    print(f"\n{colors.GREEN}Successfully executed commands{colors.END}")

    print(f"\n{colors.GREEN}Created signed transaction files:{colors.END} {','.join(output_files)}")

finally:
    for p in Path("./signatures").glob("*_sig*.json"):
        p.unlink()