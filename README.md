# Hyperlane

## Design Philosophy

1. Opinionated deployment design
1. Extendable to all hyperlane deployments, including the ones from the team and from the community

## Step-By-Step Setup

First, copy the sample inventory file to your own inventory file so you can customize it to suit your needs:

```bash
cp inventory.sample inventory.ini
```

The script assumes the following:

1. Each deployment will be contained in a separate folder. For example, `osmosis` is deployed into a `.osmosis` folder
1. Each deployment has an `agent-config.json` file with public info about the hyperlane deployment that does not vary per validator
1. Each deployment has an `.env` file with private info for each validator. Some assumptions are made. For example, `HYP_VALIDATOR_ID=alias/hyperlane-validator` and `HYP_CHECKPOINTSYNCER_BUCKET=hyperlane-validator-{{ validator_brand }}-{{ chain }}`. These values are related to your setup outside of this Ansible script. We assume those values because we believe they are the best practices.
1. Each deployment will use a different metrics port (based on a port prefix) so multiple hyperlane instances can reside on the same server
1. Finally, this script assumes that you do not want Ansible to handle sensitive info such as AWS credentials and signer wallet private key. As a result, you will need to manually set those in the `.env` file after the Ansible deployment.

Overall, this script is rather straightforward because much of the complexity has been assumed away.

Once you have customized the inventory file, you run one playbook to set up a hyperlane deployment, plus manual interventions to finish off the private sensitive info directly on the server.

```bash
ansible-playbook hyperlane.yml -e "target=osmosis"
```
