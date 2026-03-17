import re

with open('lib/all_screen_titles_v2.txt', 'r', encoding='utf-16') as f:
    titles = f.readlines()

keywords = ['Inbox', 'Apply', 'Confirmation', 'Upgrade', 'Goals', 'Goal', 'Reference', 'Salary', 'Negotiation', 'Interview', 'Gig', 'Passport', 'Verification', 'ForgeIQ', 'Uplift', 'Skills', 'System', 'Analytics', 'Settings', 'Submission', 'Tracker', 'Forecast', 'Placement', 'Metrics']

found = []
for line in titles:
    if '|' not in line: continue
    for kw in keywords:
        if kw.lower() in line.lower():
            found.append(line.strip())
            break

for f in found:
    print(f)
