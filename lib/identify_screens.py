import json
import urllib.request
import re
import sys

# Ensure UTF-8 output
sys.stdout.reconfigure(encoding='utf-8')

# Load the screen list
with open('C:/Users/Dwayne/.gemini/antigravity/brain/89081aca-3a2d-4e23-be50-176aa420a641/.system_generated/steps/426/output.txt', 'r', encoding='utf-8') as f:
    data = json.load(f)

screens = data['screens']

print(f"Total screens: {len(screens)}")

for i, screen in enumerate(screens):
    sid = screen['name'].split('/')[-1]
    url = screen['htmlCode']['downloadUrl']
    try:
        # Fetch only the beginning of the file to find the title
        req = urllib.request.Request(url)
        with urllib.request.urlopen(req, timeout=10) as response:
            content = response.read(4096).decode('utf-8', errors='ignore')
        
        match = re.search(r'<title>(.*?)</title>', content, re.IGNORECASE | re.DOTALL)
        title = match.group(1).strip() if match else "No Title Found"
        print(f"{i+1:03d} | {sid} | {title}")
    except Exception as e:
        print(f"{i+1:03d} | {sid} | ERROR: {str(e)}")
