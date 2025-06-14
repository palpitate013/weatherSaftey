#!/bin/bash
set -e

echo "Removing PC environment..."

rm -rf env
echo "Removed virtual environment 'env'."

echo "Uninstall complete. Remember to delete config.json manually if desired."
