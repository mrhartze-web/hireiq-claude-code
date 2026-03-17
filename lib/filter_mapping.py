import json

with open('lib/screen_mapping.json', 'r', encoding='utf-8') as f:
    mapping = json.load(f)

keywords = ['Inbox', 'Smart', 'Upgrade', 'Goal', 'Reference', 'Salary', 'Negotiation', 'Interview', 'Gig', 'Passport', 'Verification', 'ForgeIQ', 'Uplift', 'Skills', 'System', 'Analytics', 'Settings', 'Submission', 'Tracker', 'Forecast', 'Placement', 'Metrics', 'Error', 'Loader']

for m in mapping:
    match = False
    for kw in keywords:
        if kw.lower() in m['title'].lower():
            match = True
            break
    if match:
        print(f"{m['id']} | {m['title']}")
