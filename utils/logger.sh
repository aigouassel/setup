#!/bin/bash

# Visual logging utilities for setup script

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Log functions with visual spacing
log_header() {
    echo ""
    echo "======================================================"
    echo -e "${CYAN}$1${NC}"
    echo "======================================================"
    echo ""
}

log_section() {
    echo ""
    echo -e "${BLUE}[${1}]${NC}"
    echo ""
}

log_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

log_error() {
    echo -e "${RED}✗ $1${NC}"
}

log_info() {
    echo -e "${PURPLE}ℹ $1${NC}"
}

log_step() {
    echo -e "${CYAN}→ $1${NC}"
}

# Add blank lines for visual separation
add_spacing() {
    echo ""
    echo ""
}