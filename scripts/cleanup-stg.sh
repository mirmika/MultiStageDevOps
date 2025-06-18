#!/bin/bash
set -euo pipefail

# Remove all dev releases from the 'staging' namespace
helm uninstall client     -n staging
helm uninstall post       -n staging
helm uninstall comments   -n staging
helm uninstall query      -n staging    
helm uninstall moderation -n staging
helm uninstall event-bus  -n staging
helm uninstall ingress    -n staging

echo "All staging releases have been uninstalled."
