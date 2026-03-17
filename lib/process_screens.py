import json

# Get screens from the file saved in step 1457
with open('C:/Users/Dwayne/.gemini/antigravity/brain/89081aca-3a2d-4e23-be50-176aa420a641/.system_generated/steps/1457/output.txt', 'r', encoding='utf-8') as f:
    data = json.load(f)

screens = data['screens']
results = []

for s in screens:
    sid = s['name'].split('/')[-1]
    title = s.get('title', 'Generated Screen')
    results.append({
        'id': sid,
        'title': title
    })

with open('screen_titles.json', 'w', encoding='utf-8') as f:
    json.dump(results, f, indent=2)
