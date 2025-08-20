
#!/bin/bash

# ULTRA-FAST DEPLOYMENT STARTUP - ZERO PYTHON DEPENDENCIES
echo "🚀 STARTING ULTRA-FAST DEPLOYMENT MODE"

# Force deployment environment variables
export NODE_ENV=production
export PORT=${PORT:-8080}
export HOST=0.0.0.0
export DISABLE_PYTHON_SERVICES=true
export REPLIT_DEPLOYMENT_ID=${REPLIT_DEPLOYMENT_ID:-"forced"}

# Log environment for debugging
echo "Environment variables:"
echo "NODE_ENV=$NODE_ENV"
echo "PORT=$PORT"
echo "HOST=$HOST"
echo "DISABLE_PYTHON_SERVICES=$DISABLE_PYTHON_SERVICES"

# Check if build exists
if [ ! -f "dist/index.js" ]; then
    echo "❌ Build not found! Running build..."
    npm run build
    if [ $? -ne 0 ]; then
        echo "❌ Build failed!"
        exit 1
    fi
fi

# Ensure theme.json is available
mkdir -p dist/public
if [ -f "theme.json" ]; then
    cp theme.json dist/public/
    echo "✅ Theme file copied"
fi

# Skip all Python services completely
echo "⚡ SKIPPING ALL PYTHON SERVICES FOR INSTANT STARTUP"
echo "⚡ NODE.JS-ONLY MODE: ACTIVE"
echo "⚡ RECIPE GENERATION: OpenAI Direct (No Python)"
echo "⚡ STARTUP TARGET: <10 seconds"

# Start Node.js server immediately
echo "🚀 STARTING NODE.JS SERVER ON PORT $PORT"
exec node dist/index.js
