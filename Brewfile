# Everything Homebrew installs on my Mac: brew bundle --file=~/dotfiles/Brewfile
# What's installed but not listed: brew bundle cleanup --file=~/dotfiles/Brewfile
# Work-only entries live in Brewfile.local (git ignores it), loaded at the end.

# ── Taps ────────────────────────────────────────────────────────────────
tap "alielsokary/tap", trusted: { casks: ["caskhub"] }
tap "hashicorp/tap", trusted: true
tap "stripe/stripe-cli"

# ── Terminal tools these dotfiles use ───────────────────────────────────
# Cross-shell prompt for astronauts
brew "starship"
# Command-line fuzzy finder written in Go
brew "fzf"
# Modern, maintained replacement for ls
brew "eza"
# Clone of cat(1) with syntax highlighting and Git integration
brew "bat"
# Shell extension to navigate your filesystem faster
brew "zoxide"
# Simple, fast and user-friendly alternative to find
brew "fd"
# Search tool like grep and The Silver Searcher
brew "ripgrep"
# Syntax-highlighting pager for git and diff output
brew "git-delta"
# Lightweight and flexible command-line JSON processor
brew "jq"
# Official tldr client written in Rust
brew "tlrc"
# Resource monitor. C++ version and continuation of bashtop and bpytop
brew "btop"
# Simple terminal UI for git commands
brew "lazygit"
# Blazing fast terminal file manager written in Rust, based on async I/O
brew "yazi"
# Render markdown on the CLI
brew "glow"
# More intuitive version of du in rust
brew "dust"
cask "font-jetbrains-mono-nerd-font"
# Terminal emulator that uses platform-native UI and GPU acceleration
cask "ghostty"

# ── For agents (agents/machine.md lists these) ──────────────────────────
# Display directories as trees (with optional color/HTML output)
brew "tree"
# Code searching, linting, rewriting
brew "ast-grep"
# GNU implementation of the famous stream editor
brew "gnu-sed"
# Process YAML, JSON, XML, CSV and properties documents from the CLI
brew "yq"
# Polyglot runtime manager (asdf rust clone)
brew "mise"
# Extremely fast Python package installer and resolver, written in Rust
brew "uv"
# GitHub command-line tool
brew "gh"
# Static analysis and lint tool, for (ba)sh scripts
brew "shellcheck"
# GNU File, Shell, and Text utilities
brew "coreutils"

# ── Databases, and headers for native gem builds ────────────────────────
# Postgres C API library
brew "libpq"
# YAML Parser
brew "libyaml"
# Open-source vector similarity search for Postgres
brew "pgvector"
# Object-relational database system
brew "postgresql@16", link: true
# Object-relational database system
brew "postgresql@17"
# Persistent key-value database, with built-in net interface
brew "redis"

# ── Other command-line tools ────────────────────────────────────────────
# Static checker for GitHub Actions workflow files
brew "actionlint"
# Automatically exclude development dependencies from Time Machine backups
brew "asimov", restart_service: :changed
# Official Amazon AWS command-line interface
brew "awscli"
# Open-source, cross-platform JavaScript runtime environment
brew "node"
# Claude Code Commands Manager
brew "claude-cmd"
# Apjanke's fork of the classic cowsay project
brew "cowsay"
# Fast and powerful Git hooks manager for any type of projects
brew "lefthook"
# Quickly generate a temporary email address
brew "mailsy"
# Mac App Store command-line interface
brew "mas"
# Package compiler and linker metadata toolkit
brew "pkgconf"
# Interpreted, interactive, object-oriented programming language
brew "python@3.14"
# Command-line interface for https://speedtest.net bandwidth tests
brew "speedtest-cli"
# Easiest, most secure way to use WireGuard and 2FA
brew "tailscale"
# Command-line interface for Vercel
brew "vercel"
# Show the current WiFi network password
brew "wifi-password"
# Terraform
brew "hashicorp/tap/terraform"
# Stripe CLI utility
brew "stripe/stripe-cli/stripe", trusted: true

# ── Apps ────────────────────────────────────────────────────────────────
# Password manager that keeps all passwords secure behind one password
cask "1password"
# Command-line helper for the 1Password password manager
cask "1password-cli@beta"
# Chromium based browser
cask "arc"
# Tool to customise input devices and automate computer systems
cask "bettertouchtool"
# Open source IDE for exploring and testing APIs
cask "bruno"
# Native GUI for Homebrew casks
cask "caskhub"
# TI-84 Plus CE and TI-83 Premium CE calculator emulator
cask "cemu"
# Anthropic's official Claude AI desktop app
cask "claude"
# Terminal-based AI coding assistant
cask "claude-code@latest"
# Write, edit, and chat about your code with AI
cask "cursor"
# App to build and share containerised applications and microservices
cask "docker-desktop"
# Emulator to play GameCube and Wii games
cask "dolphin"
# Online diagram software
cask "drawio"
# Focusrite interface controller for devices of the 4th generation and newer
cask "focusrite-control-2"
# Set of tools to manage resources and applications hosted on Google Cloud
cask "gcloud-cli"
# Desktop client for GitHub repositories
cask "github"
# Web browser
cask "google-chrome"
# AI-powered notepad for meetings
cask "granola"
# Keyboard customiser
cask "karabiner-elements"
# App to manage software development and track bugs
cask "linear"
# Discover, download, and run local LLMs
cask "lm-studio"
# Screen and video recording software
cask "loom"
# Reverse proxy, secure introspectable tunnels to localhost
cask "ngrok"
# Knowledge base that works on top of a local folder of plain text Markdown files
cask "obsidian"
# Get up and running with large language models locally
cask "ollama-app"
# Privacy-first voice-to-text dictation with AI agents
cask "openwhispr"
# Collaboration platform for API development
cask "postman"
# Window snapping tool
cask "rectangle-pro"
# GUI for streamlined Redis application development
cask "redis-insight"
# Command-line utility to interact with Sentry
cask "sentry-cli"
# Screenshot measurement and annotation tool
cask "shottr"
# Team communication and collaboration software
cask "slack"
# System monitor for the menu bar
cask "stats"
# Companion app for Stremio Web
cask "stremioservice"
# Dictation tool including LLM reformatting
cask "superwhisper"
# Control windows and applications right from your trackpad
cask "swish"
# Mesh VPN based on WireGuard
cask "tailscale-app"
# To-do list
cask "todoist-app"
# Open-source code editor
cask "visual-studio-code"
# Multimedia player
cask "vlc"
# Rust-based terminal
cask "warp"
# Voice-to-text dictation with AI-powered auto-editing
cask "wispr-flow"

# ── Mac App Store (needs an App Store sign-in) ──────────────────────────
mas "BrightIntosh", id: 6452471855
mas "ColorSlurp", id: 1287239339
mas "GarageBand", id: 682658836
mas "iMovie", id: 408981434
mas "Keynote", id: 361285480
mas "Numbers", id: 361304891
mas "Pages", id: 361309726
mas "Xcode", id: 497799835

# ── VS Code extensions ──────────────────────────────────────────────────
vscode "anthropic.claude-code"
vscode "anysphere.remote-containers"
vscode "anysphere.remote-ssh"
vscode "aykutsarac.jsoncrack-vscode"
vscode "github.vscode-github-actions"
vscode "github.vscode-pull-request-github"
vscode "growthjack.claude-code-usage"
vscode "mikestead.dotenv"
vscode "monokai.theme-monokai-pro-vscode"
vscode "pierrecomputer.pierre-vscode-icons"
vscode "pkief.material-icon-theme"
vscode "spencerwmiles.vscode-task-buttons"
vscode "wrick17.cursor-usage"
vscode "yzhang.markdown-all-in-one"

# ── Python tools (uv tool install) ──────────────────────────────────────
uv "pre-commit"

local_brewfile = File.expand_path("~/dotfiles/Brewfile.local")
instance_eval(File.read(local_brewfile)) if File.exist?(local_brewfile)
