# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Flutter (Main App)
```bash
# Run the app
flutter run

# Run on a specific platform
flutter run -d chrome        # Web
flutter run -d android
flutter run -d ios

# Build
flutter build apk            # Android APK
flutter build web            # Web
flutter build ios

# Test
flutter test                 # All tests
flutter test test/widget_test.dart  # Single test file

# Lint / analyze
flutter analyze

# Code generation (Riverpod, Freezed, json_serializable)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs
```

### Firebase Cloud Functions
```bash
cd functions
npm install
npm run serve       # Start local emulator (functions only)
npm run deploy      # Deploy to Firebase
npm run logs        # View function logs
```

## Architecture

### Tech Stack
- **Flutter** (multi-platform: iOS, Android, Web)
- **State management:** Riverpod 2.x with `riverpod_generator`
- **Navigation:** GoRouter with role-based auth guards
- **Backend:** Firebase (Auth, Firestore, Storage, Functions, FCM)
- **Data models:** `freezed` + `json_serializable` for immutable, serializable classes
- **UI:** Material 3, Inter font (Google Fonts), Lottie animations

### User Roles & Feature Split
The app has four distinct user roles, each with its own feature module under `lib/features/`:
- **candidate/** — Job seekers (50+ screens: job feed, assessments, gigs, ForgeIQ CV builder, UpliftIQ learning, PassportIQ verification)
- **employer/** — Hiring companies (job management, MatchIQ pipeline, SignalIQ market data, WildcardIQ unbiased scoring)
- **recruiter/** — Staffing agencies (brief builder, CV vault, placement tracking, client management)
- **admin/** — System administration (user management, revenue, content moderation)
- **public/** — Unauthenticated screens (landing, auth flows, pricing, Thundafund)

### Routing (`lib/router/app_router.dart`)
Single GoRouter with 177+ routes. Auth redirect logic at the top of the router guards all authenticated routes and enforces role-based access — a candidate cannot access employer routes and vice versa. `ShellRoute` wrappers provide the bottom navigation bar for each role. This is the authoritative routing file; `lib/config/routes.dart` and `lib/routes.dart` are secondary/stub files.

### State (`lib/providers/`)
Riverpod providers per domain entity (`auth_provider.dart`, `candidate_provider.dart`, `job_provider.dart`, etc.). The project uses the generator-based approach (`@riverpod` annotations); run `build_runner` after modifying annotated providers.

### Data Models (`lib/models/`)
All models use `freezed` for immutability and `json_serializable` for Firestore serialization. Core models: `UserModel`, `CandidateModel`, `EmployerModel`, `RecruiterModel`, `JobModel`, `ApplicationModel`, `GigModel`, `BriefModel`, `PlacementModel`, `MessageModel`, `NotificationModel`.

### Services (`lib/services/`)
- `firebase/auth_service.dart` — authentication
- `firebase/firestore_service.dart` — Firestore CRUD
- `firebase/storage_service.dart` — file uploads
- `ai/` — IQ feature integrations (MatchIQ, SignalIQ, etc.)
- `payments/` — payment processing

### Shared Components (`lib/shared/`)
Reusable UI lives here, not in `lib/widgets/` (which is largely empty):
- `components/` — `CandidateCard`, `JobCard`, `EmptyState`, `SkeletonLoader`, `SmartApplyModal`, `WebLayout`
- `navigation/` — `RoleNavigationBar` (mobile), `WebNavBar`
- `footer/` — `WebFooter`

### Theme (`lib/theme/theme.dart`)
`HireIQColors` defines the design token constants. Primary palette: Navy `#1A2B4A`, Teal `#0D9488`, Background `#F8FAFC`. Always use these constants rather than raw hex values.

### Firebase Cloud Functions (`functions/index.js`)
Backend is Node.js 24. Functions are Phase 2 scaffolds (TODO stubs) for: `matchIQ`, `passportIQ`, `signalIQ`, `forgeIQ`, `wildcardIQ`, `upliftIQ`, `sendNotification`, `onApplicationCreated`, `onPlacementCreated`.

## Code Generation
After modifying any file with `@riverpod`, `@freezed`, or `@JsonSerializable` annotations, regenerate:
```bash
dart run build_runner build --delete-conflicting-outputs
```
Generated files (`*.g.dart`, `*.freezed.dart`) are checked into the repo — commit them alongside the source changes.
