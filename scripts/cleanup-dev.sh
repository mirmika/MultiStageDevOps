#!/bin/bash
set -euo pipefail

# Remove all dev releases from the 'development' namespace
helm uninstall client     -n development
helm uninstall posts      -n development
helm uninstall comments   -n development
helm uninstall query      -n development
helm uninstall moderation -n development
helm uninstall event-bus  -n development
helm uninstall ingress    -n development

echo "All development releases have been uninstalled."
