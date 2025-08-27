#!/bin/bash
# Usage: ./setup_repo.sh <project-name>
# This script initializes a new git repository and scaffolds a Next.js project.

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

# Initialize repo
git init
git branch -M main
echo "# $PROJECT_NAME" > README.md

# Create .gitignore
cat <<EOF > .gitignore
node_modules
.next
.env
.env.local
.env.production
.DS_Store
EOF

git add .
git commit -m "chore: init workspace"

# Create Next.js app inside website folder
npm create next-app@latest website -- --typescript --eslint --tailwind --app --src-dir --import-alias "@/*"
cd website
npm install

git add .
git commit -m "feat: bootstrap Next.js + Tailwind app"

# Add remote manually after script finishes
echo "Now add your remote repository with: git remote add origin <repo-url> && git push -u origin main"
