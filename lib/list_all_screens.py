import json

with open('C:/Users/Dwayne/.gemini/antigravity/brain/89081aca-3a2d-4e23-be50-176aa420a641/.system_generated/steps/426/output.txt', 'r', encoding='utf-8') as f:
    data = json.load(f)

for screen in data['screens']:
    print(f"{screen['name'].split('/')[-1]} | {screen['title']}")
