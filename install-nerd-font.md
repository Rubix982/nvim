# Installing Nerd Fonts for Neovim Icons

For the Neovim file icons to work properly, you need to install a Nerd Font and configure your terminal to use it.

## Installing a Nerd Font on macOS

### Option 1: Using Homebrew (recommended)

```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install a popular Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
# Or another popular option
brew install --cask font-hack-nerd-font
# Or if you prefer Fira Code
brew install --cask font-fira-code-nerd-font
```

### Option 2: Manual Installation

1. Download a Nerd Font from [https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)
2. Unzip the downloaded file
3. Double-click the font files to install them
4. Follow the prompts to install the fonts

## Configuring Your Terminal

### For iTerm2

1. Open iTerm2 Preferences
2. Go to Profiles > Text
3. Change the font to your installed Nerd Font (such as "JetBrainsMono Nerd Font")
4. Check "Use a different font for non-ASCII text"
5. Change the Non-ASCII font to the same Nerd Font

### For macOS Terminal

1. Open Terminal Preferences
2. Go to Profiles
3. Select your profile and click the "Font" button
4. Select your installed Nerd Font
5. Click "OK" to save changes

### For VS Code integrated terminal

Add this to your VS Code settings.json:

```json
"terminal.integrated.fontFamily": "JetBrainsMono Nerd Font",
```

## Confirming Neovim Configuration

1. Make sure your init.lua has this line set to true:
   ```lua
   vim.g.have_nerd_font = true
   ```

2. Launch Neovim and press `\` to open the Neo-tree file explorer
3. You should now see icons for folders and different file types

## Troubleshooting

If icons don't appear correctly:
1. Make sure you've restarted your terminal after installing the font
2. Check that you've selected the Nerd Font variant in your terminal preferences
3. Try a different Nerd Font if one doesn't work properly

## Popular Nerd Fonts

- JetBrains Mono Nerd Font
- Hack Nerd Font
- Fira Code Nerd Font
- Source Code Pro Nerd Font
- Cascadia Code Nerd Font