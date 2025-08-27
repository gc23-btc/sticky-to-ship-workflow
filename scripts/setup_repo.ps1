param(
    [string]$ProjectName
)

if (-not $ProjectName) {
    Write-Host "Usage: .\setup_repo.ps1 -ProjectName <project-name>"
    exit 1
}

# initialize repo
git init
git branch -M main
"# $ProjectName" | Out-File -Encoding utf8 README.md

# .gitignore
@"
node_modules
.next
.env
.env.local
.env.production
.DS_Store
"@ | Out-File -Encoding utf8 .gitignore

git add .
git commit -m "chore: init workspace"

# Create Next.js app inside website folder
npm create next-app@latest website -- --typescript --eslint --tailwind --app --src-dir --import-alias "@/*"
Set-Location website
npm install

git add .
git commit -m "feat: bootstrap Next.js + Tailwind app"

Write-Host "Now add your remote with: git remote add origin <repo-url> ; git push -u origin main"
