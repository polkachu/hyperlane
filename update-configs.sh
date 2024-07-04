#!/bin/bash

HYPERLANE_MONOREPO_DIR="/path/to/hyperlane-monorepo"

# Loop through ${chain}.json files
for filepath in roles/hyperlane/files/*
do
    filename=$(basename -- "$filepath")
    extension="${filename##*.}"
    chain="${filename%.*}"

    if [[ $extension != "json" ]]
    then
        continue
    fi

    # Update only the specific .chains.$chain key in the chain configuration
    jq ".chains.$chain = input.chains.$chain" \
        "roles/hyperlane/files/$chain.json" \
        "$HYPERLANE_MONOREPO_DIR/rust/config/mainnet_config.json" > tmp.json \
        && mv tmp.json "roles/hyperlane/files/$chain.json"

    echo "Configuration for chain $chain has been updated successfully."
done
