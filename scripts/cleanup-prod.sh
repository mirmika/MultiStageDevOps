#!/bin/bash
set -euo pipefail

# Remove all dev releases from the 'production' namespace
helm uninstall client     -n production
helm uninstall post       -n production
helm uninstall comments   -n production
helm uninstall query      -n production
helm uninstall moderation -n production
helm uninstall event-bus  -n production
helm uninstall ingress    -n production

echo "All production releases have been uninstalled."
