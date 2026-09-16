# Agentic AI Test Case Generator — Design Writeup

## Problem
Generate requirement-traceable QA test suites for User Login and Apply Promo Code at Checkout, including positive, negative, boundary, and edge scenarios.

## Architecture
Requirement -> Generate -> Critique -> Improve -> Structure -> Deterministic Validate -> Coverage/Reports -> Export.

## Agent roles
- Generator: creates the draft suite.
- Critic: reviews every AC and identifies gaps/weaknesses.
- Improver: incorporates critique without inventing functionality.
- Deterministic validator: enforces repeatable QA rules after model generation.

## Tool/prompt design
The LLM prompts require AC traceability, explicit categories, priorities, risks, thresholds, timing/state checks, and no invented functionality. Python validators independently verify schema and coverage.

## What broke and fixes
The original notebook had undefined MODEL/time references, duplicate function redefinitions, inconsistent model usage, inconsistent coverage-gap labels, and an undefined project_summary. These were repaired while retaining the supplied business requirements.

## Genuine value versus manual authoring
AI reduced the effort of brainstorming a broad first-pass suite and performing a separate critique across many acceptance criteria. Manual QA judgment remains necessary for validating business intent, rejecting unsupported assumptions, and deciding which scenarios are meaningful. Deterministic checks provide the repeatability that manual review alone cannot guarantee.
