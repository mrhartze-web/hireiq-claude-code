import json

# Path to the original screens list from metadata
with open('C:/Users/Dwayne/.gemini/antigravity/brain/89081aca-3a2d-4e23-be50-176aa420a641/.system_generated/steps/426/output.txt', 'r', encoding='utf-8') as f:
    data = json.load(f)

screens = data['screens']
processed = set()
unique_screens = []

# Already exported (based on previous turns and manual tracking)
already_exported_titles = {
    "Career Roadmap", "CV Preview", "Application Status", "Edit Profile", 
    "Wildcard Score Detail", "Assessment Results", "Enterprise Dashboard", 
    "Leave Review", "Release Payment", "Open Dispute", "SignalIQ Report", 
    "Shortlist View", "Diversity Report", "Phone Verification", 
    "Email Verification", "Password Reset", "Social Auth Loading"
}

# Add screens that were explicitly mentioned as existing in the prompt
existing_files = [
    "admin_dashboard", "admin_revenue", "admin_users", 
    "assessment_results", "candidate_application_tracker", 
    "candidate_cv_upload", "candidate_job_detail", 
    "candidate_job_feed", "candidate_profile", 
    "skill_assessment", "video_pitch", 
    "employer_analytics", "employer_hiring_briefs", 
    "employer_jobs", "employer_post_job", "employer_team_management"
]
# Note: I won't re-export these.

print(f"Goal: Identify remaining high-value screens from {len(screens)} total.")

# For now, I'll just list them out with IDs so I can iterate.
for s in screens:
    title = s.get('title', 'Untitled')
    sid = s['name'].split('/')[-1]
    print(f"ID: {sid} | Title: {title}")
