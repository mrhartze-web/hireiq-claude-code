import json

with open('C:/Users/Dwayne/.gemini/antigravity/brain/89081aca-3a2d-4e23-be50-176aa420a641/.system_generated/steps/426/output.txt', 'r', encoding='utf-8') as f:
    data = json.load(f)

keywords = ['Messaging', 'Inbox', 'Apply', 'Subscription', 'Goals', 'Reference', 'Salary', 'Negotiation', 'Interview', 'Gig', 'Passport', 'Verification', 'ForgeIQ', 'Uplift', 'Skills']

found = []
for screen in data['screens']:
    title = screen['title'].lower()
    for kw in keywords:
        if kw.lower() in title:
            found.append(f"ID: {screen['name'].split('/')[-1]} | Title: {screen['title']}")
            break

for f in found:
    print(f)
