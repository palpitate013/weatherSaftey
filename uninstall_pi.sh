#!/bin/bash
set -e

echo "Removing Raspberry Pi environment..."

rm -rf env
echo "Removed virtual environment 'env'."

echo "Uninstall complete. You may remove wakeonlan with:"
echo "  sudo apt remove wakeonlan"

echo "Remember to delete config.json manually if desired."
