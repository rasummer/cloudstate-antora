#!/usr/bin/env bash

set -e

readonly commit=$(git log -1 '--format=format:%H')

git clone https://$GITHUB_DEPLOY_TOKEN@github.com/cloudstateio/cloudstate-antora.git -b latest --depth=1 latest

mkdir -p latest/download
cp ui/build/ui-bundle.zip latest/download/ui-bundle.zip

cd latest
git add --all

if ! $(git diff --exit-code --quiet HEAD); then
  echo "Deploying UI bundle to latest branch..."
  git config user.name "Cloudstate Bot"
  git config user.email "deploy@cloudstate.io"
  git commit -m "Update UI bundle download @ $commit"
  git push --quiet origin latest
else
  echo "No changes to deploy for UI bundle"
fi
