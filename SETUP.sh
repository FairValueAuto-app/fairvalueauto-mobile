#!/bin/bash
# FairValueAuto — One-Click Setup Script
# Run this on your computer: bash SETUP.sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  FairValueAuto Mobile Setup Script   ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
echo ""

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✅ Node.js found: $NODE_VERSION${NC}"
else
    echo -e "${RED}❌ Node.js not found. Please install from https://nodejs.org${NC}"
    exit 1
fi

# Check npm
if command -v npm &> /dev/null; then
    echo -e "${GREEN}✅ npm found: $(npm --version)${NC}"
else
    echo -e "${RED}❌ npm not found. Please reinstall Node.js${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}📦 Installing dependencies...${NC}"
npm install

echo -e "${YELLOW}🔧 Installing Capacitor CLI globally...${NC}"
npm install -g @capacitor/cli

echo ""
echo -e "${YELLOW}📱 Adding Android platform...${NC}"
npx cap add android || echo "Android already added"
npx cap sync android

echo ""
# iOS only on Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${YELLOW}🍎 Mac detected — Adding iOS platform...${NC}"
    npx cap add ios || echo "iOS already added"
    npx cap sync ios
    echo -e "${GREEN}✅ iOS platform ready!${NC}"
    echo ""
    echo -e "${BLUE}To open in Xcode, run:${NC}"
    echo "  npx cap open ios"
else
    echo -e "${YELLOW}⚠️  iOS requires a Mac with Xcode. Skipping iOS setup.${NC}"
fi

echo ""
echo -e "${BLUE}To open Android Studio, run:${NC}"
echo "  npx cap open android"

echo ""
echo -e "${GREEN}╔══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║         Setup Complete! 🚀           ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════╝${NC}"
echo ""
echo -e "Live app: ${BLUE}https://velox-satisfied-deal-flow.base44.app${NC}"
echo -e "Bundle ID: ${BLUE}app.fairvalueauto${NC}"
