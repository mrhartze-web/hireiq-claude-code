import os

root = 'lib/features'
files = []
for r, d, f in os.walk(root):
    for file in f:
        if file.endswith('.dart'):
            files.append(os.path.join(r, file))

with open('implemented_files.txt', 'w') as f:
    for file in files:
        f.write(file + '\n')
