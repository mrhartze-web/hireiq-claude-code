// HireIQ Business Constants
// Single source of truth for all platform-wide business rules and pricing.

// ── Platform economics ─────────────────────────────────────────────────────────
const double hireiqPlatformCutPercent = 0.20;

// ── Recruiter placement fee tiers ─────────────────────────────────────────────
const double placementFeeJunior = 0.10;
const double placementFeeMidLevel = 0.12;
const double placementFeeSenior = 0.15;

// ── Contact ───────────────────────────────────────────────────────────────────
const String supportEmail = 'hello@hireiq.co.za';

// ── App metadata ──────────────────────────────────────────────────────────────
const String appVersion = '1.0.0';

// ── Candidate plan limits ─────────────────────────────────────────────────────
const int candidateFreeApplicationLimit = 5;

// ── Employer plan limits ──────────────────────────────────────────────────────
const int employerStarterJobLimit = 3;
const int employerStarterTeamLimit = 3;
const int employerGrowthTeamLimit = 10;

// ── Pricing (ZAR, excl. VAT) ──────────────────────────────────────────────────
const double candidateProMonthlyPrice = 49.0;
const double employerStarterMonthlyPrice = 1999.0;
const double employerGrowthMonthlyPrice = 4999.0;
