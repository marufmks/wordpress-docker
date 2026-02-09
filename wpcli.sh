#!/bin/bash

# WP-CLI helper script for WordPress Docker setup
# Usage: ./wpcli.sh [wp-command]

if [ $# -eq 0 ]; then
    echo "WP-CLI helper for WordPress Docker"
    echo ""
    echo "Usage: ./wpcli.sh [wp-command]"
    echo ""
    echo "Examples:"
    echo "  ./wpcli.sh plugin list"
    echo "  ./wpcli.sh theme list"
    echo "  ./wpcli.sh core version"
    echo "  ./wpcli.sh plugin activate hello"
    echo ""
    echo "Available WP-CLI commands:"
    docker compose exec wpcli wp --help
    exit 1
fi

# Execute WP-CLI command
docker compose exec wpcli wp "$@"