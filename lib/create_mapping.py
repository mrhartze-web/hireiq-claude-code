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

mapping = []

for i, screen in enumerate(screens):
    sid = screen['name'].split('/')[-1]
    url = screen['htmlCode']['downloadUrl']
    try:
        req = urllib.request.Request(url)
        with urllib.request.urlopen(req, timeout=10) as response:
            content = response.read(4096).decode('utf-8', errors='ignore')
        
        match = re.search(r'<title>(.*?)</title>', content, re.IGNORECASE | re.DOTALL)
        title = match.group(1).strip() if match else "Generated Screen"
        mapping.append({"id": sid, "title": title})
    except Exception as e:
        mapping.append({"id": sid, "title": f"ERROR: {str(e)}"})

with open('lib/screen_mapping.json', 'w', encoding='utf-8') as f:
    json.dump(mapping, f, indent=2)

print(f"Mapped {len(mapping)} screens.")
