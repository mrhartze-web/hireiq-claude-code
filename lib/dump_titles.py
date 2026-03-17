import sys

# Ensure UTF-8 output
sys.stdout.reconfigure(encoding='utf-8')

# Try reading as UTF-16LE first
try:
    with open('lib/all_screen_titles_v2.txt', 'r', encoding='utf-16') as f:
        content = f.read()
except:
    with open('lib/all_screen_titles_v2.txt', 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

print(content)
