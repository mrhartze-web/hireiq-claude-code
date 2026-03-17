import os
import re

# We will read all dart files in the subdirectories of lib/features
features_dir = 'C:/Users/Dwayne/Documents/Projects/hireiq/lib/features'
app_router_path = 'C:/Users/Dwayne/Documents/Projects/hireiq/lib/router/app_router.dart'
mobile_screens_path = 'C:/Users/Dwayne/Documents/Projects/hireiq/lib/features/mobile_screens.dart'

# Gather all .dart files and their path + class name
all_screens = []
for role in ['candidate', 'employer', 'recruiter', 'admin']:
    role_dir = os.path.join(features_dir, role)
    if os.path.exists(role_dir):
        for file in os.listdir(role_dir):
            if file.endswith('.dart'):
                file_path = os.path.join(role_dir, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    # extract class name
                    match = re.search(r'class\s+([A-Z][a-zA-Z0-9_]+)\s+extends\s+(StatelessWidget|StatefulWidget|ConsumerWidget)', content)
                    if match:
                        class_name = match.group(1)
                        import_path = f"../features/{role}/{file}"
                        all_screens.append({
                            'role': role,
                            'file': file,
                            'class_name': class_name,
                            'import_path': import_path,
                            'route_const': class_name[:1].lower() + class_name[1:],
                            'route_path': f"/{role}/{file.replace('.dart', '').replace('_', '-')}"
                        })

# Read mobile_screens.dart
with open(mobile_screens_path, 'r', encoding='utf-8') as f:
    mobile_content = f.read()

# Add new route constants where they don't exist
added_consts = 0
for screen in all_screens:
    const_name = screen['route_const']
    if f" {const_name} = '" not in mobile_content:
        # append right before the last closing brace
        injection = f"  static const String {const_name} = '{screen['route_path']}';\n"
        mobile_content = mobile_content.rstrip().removesuffix('}') + injection + "}\n"
        added_consts += 1

with open(mobile_screens_path, 'w', encoding='utf-8') as f:
    f.write(mobile_content)


# Read app_router.dart
with open(app_router_path, 'r', encoding='utf-8') as f:
    router_content = f.read()

# Add imports for files that aren't imported
added_imports = 0
for screen in all_screens:
    import_statement = f"import '{screen['import_path']}';"
    if import_statement not in router_content:
        import_index = router_content.find('final routerProvider =')
        router_content = router_content[:import_index] + import_statement + "\n" + router_content[import_index:]
        added_imports += 1

# Now add routes to ShellRoutes
for screen in all_screens:
    route_const = f"MobileRoutes.{screen['route_const']}"
    if route_const not in router_content:
        # We need to inject the GoRoute into the correct shell
        shell_marker = f"// Shell"
        if screen['role'] == 'candidate':
            nav_to = "Shell 2: Employer"
        elif screen['role'] == 'employer':
            nav_to = "Shell 3: Recruiter"
        elif screen['role'] == 'recruiter':
            nav_to = "Shell 4: Admin"
        else: # admin
            nav_to = "];\n  });"

        insert_pos = router_content.find(nav_to)
        
        # go lines back to find the closing bracket of routes array for that shell
        if insert_pos != -1:
            code_block = f"""          GoRoute(
            path: {route_const},
            builder: (context, state) => const {screen['class_name']}(),
          ),\n"""
            if nav_to == "];\n  });":
              # For Admin, find `],` before `});`
              idx = router_content.rfind('],', 0, router_content.rfind(';'))
              insert_pos = idx

            router_content = router_content[:insert_pos] + code_block + router_content[insert_pos:]

with open(app_router_path, 'w', encoding='utf-8') as f:
    f.write(router_content)

print(f"Added {added_consts} routes to MobileRoutes")
print(f"Added {added_imports} imports and routes to AppRouter")

