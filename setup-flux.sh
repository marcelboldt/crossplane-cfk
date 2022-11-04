#!/bin/sh

# GITHUB_USER and GITHUB_TOKEN must be set

flux check --pre

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=crossplane-cfk \
  --branch=flux \
  --path=./clusters/cfk-xp \
  --personal
