#!/bin/bash

# Create a test directory
TEST_DIR="/tmp/nvim-gitsigns-test"
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Initialize a git repository
git init

# Create a test file
echo "This is a test file to check gitsigns inline blame functionality." > test.txt
echo "Line 2 of the test file." >> test.txt
echo "Line 3 of the test file." >> test.txt

# Commit the file
git add test.txt
git config --local user.email "test@example.com"
git config --local user.name "Test User"
git commit -m "Initial commit"

# Make a change and commit again
echo "Line 4 added in the second commit." >> test.txt
git add test.txt
git commit -m "Add line 4"

# Make another change
echo "Line 5 added in the third commit." >> test.txt
git add test.txt
git commit -m "Add line 5"

# Output instructions
echo "Test repository set up at $TEST_DIR"
echo ""
echo "To test gitsigns blame functionality:"
echo "1. Run: nvim $TEST_DIR/test.txt"
echo "2. Inside nvim press <Space>tb to toggle the inline blame"
echo "3. Move your cursor to different lines to see the blame information"
echo "4. Press <Space>gb to see detailed blame for the current line"
echo ""
echo "If you don't see blame info, try these commands inside nvim:"
echo ":Gitsigns toggle_current_line_blame"
echo ":Gitsigns blame_line"
echo ""
echo "For debugging, run inside nvim:"
echo ":checkhealth gitsigns"
echo ":lua print(vim.inspect(require('gitsigns').config))"