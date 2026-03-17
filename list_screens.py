
import json
import os

project_path = r"C:\Users\Dwayne\Documents\Projects\hireiq"
output_file = r"C:\Users\Dwayne\.gemini\antigravity\brain\89081aca-3a2d-4e23-be50-176aa420a641\.system_generated\steps\1040\output.txt"
results_file = r"C:\Users\Dwayne\Documents\Projects\hireiq\stitch_screens_list.txt"

with open(output_file, 'r') as f:
    data = json.load(f)

screens = data['screens']

with open(results_file, 'w') as f:
    f.write(f"Total screens in Stitch: {len(screens)}\n")
    for s in screens:
        title = s.get('title', 'No Title')
        sid = s['name'].split('/')[-1]
        f.write(f"ID: {sid} | Title: {title}\n")
