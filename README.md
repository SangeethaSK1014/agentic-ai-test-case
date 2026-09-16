# Agentic AI Test Case Generator

## Capstone Project --- Google Colab + Groq

This project uses an agentic AI workflow to generate
requirement-traceable QA test suites for two supplied features:

-   **Feature A --- User Login**
-   **Feature B --- Apply Promo Code at Checkout**

The notebook preserves the supplied business requirements and acceptance
criteria and generates categorized test cases covering:

-   Positive
-   Negative
-   Boundary
-   Edge

## Workflow

``` text
Requirement
    ↓
Generator Agent
    ↓
Critic Agent
    ↓
Improver Agent
    ↓
JSON Structurer / Parser
    ↓
Deterministic QA Validator
    ↓
Coverage Report
    ↓
Final Outputs
```

### Agent roles

-   **Generator agent:** creates the initial test suite from the
    supplied requirement.
-   **Critic agent:** reviews every acceptance criterion and identifies
    gaps, duplicates, weak scenarios, unsupported assumptions, and
    risk/coverage issues.
-   **Improver agent:** incorporates the critique while preserving the
    supplied business requirement.
-   **Formatter/parser:** converts the final suite into structured JSON
    and repairs malformed JSON when necessary.
-   **Deterministic QA layer:** validates schema, mandatory fields,
    duplicate IDs, categories, priorities, risks, AC format, AC
    coverage, category coverage, and minimum test count.
-   **Reporting layer:** produces feature-level CSVs, the combined
    suite, coverage reports, gap reports, summaries, Gherkin files, and
    the reflection PDF.

## Project Structure

``` text
Agentic-AI-Testing/
│
├── Agentic_AI_Testing.ipynb
├── README.md
├── DESIGN_WRITEUP.md
├── requirements.txt
├── Agentic_AI_Capstone_Reflection.pdf
│
└── outputs/
    ├── final_test_suite.csv
    ├── validation_feature_a.csv
    ├── validation_feature_b.csv
    ├── category_coverage.csv
    ├── coverage_report.csv
    ├── coverage_gaps.csv
    │
    ├── Feature_A_User_Login_Test_Cases.csv
    ├── Feature_B_Promo_Code_Test_Cases.csv
    ├── Combined_Test_Suite.csv
    ├── Coverage_Gap_Report.csv
    ├── Coverage_Summary.csv
    ├── Category_Summary.csv
    ├── Risk_Summary.csv
    ├── Priority_Summary.csv
    ├── Feature_A_Deterministic_QA_Checks.csv
    ├── Feature_B_Deterministic_QA_Checks.csv
    │
    ├── feature_a_draft.txt
    ├── feature_a_critique.txt
    ├── feature_a_final.txt
    ├── feature_a_validation.txt
    ├── feature_b_draft.txt
    ├── feature_b_critique.txt
    ├── feature_b_final.txt
    ├── feature_b_validation.txt
    ├── Feature_A_User_Login.feature
    └── Feature_B_Promo_Code.feature
```

The notebook also creates an `outputs/` directory during execution.

## Requirements

The notebook installs the following Python packages:

``` text
groq>=0.31.0
pandas
openpyxl
json-repair
reportlab
```

Install them with:

``` bash
pip install -r requirements.txt
```

The project is designed to run in **Google Colab** with Python 3.

## Groq API Configuration

A valid Groq API key is required for live generation.

In Google Colab:

1.  Open the **Secrets (🔑)** panel.
2.  Add a secret named `GROQ_API_KEY`.
3.  Enable notebook access for the secret.
4.  Run the notebook.

The notebook uses:

``` text
MODEL = "openai/gpt-oss-120b"
```

Do **not** paste the API key into a code cell or commit it to GitHub.

## Running the Notebook

Run the notebook from the beginning in order.

The main stages are:

1.  Install libraries.
2.  Import libraries and authenticate with Groq.
3.  Check the API connection.
4.  Configure reusable AI calls with retry and token-budget handling.
5.  Define Feature A and Feature B requirements.
6.  Generate the initial test suites.
7.  Run the Critic Agent.
8.  Run the Improver Agent.
9.  Structure the final suites as JSON.
10. Convert the structured results into DataFrames.
11. Run deterministic QA checks.
12. Calculate acceptance-criteria and category coverage.
13. Generate CSV and Gherkin outputs.
14. Create the design writeup and reflection PDF.
15. Review the generated project files.
16. Run the submission checklist.

## Deterministic QA Checks

The deterministic validation layer independently checks the model output
rather than relying only on the LLM.

Checks include:

-   Required columns
-   Empty required fields
-   Duplicate test case IDs
-   Valid test categories
-   Valid priorities
-   Valid risks
-   Acceptance Criteria format
-   Acceptance Criteria coverage
-   Category coverage
-   Minimum test count
-   Coverage gaps

The final coverage report is calculated directly from the test-case data
so that coverage is auditable.

## Output

The core submission artifacts are:

  --------------------------------------------------------------------------
  Artifact                               Purpose
  -------------------------------------- -----------------------------------
  `final_test_suite.csv`                 Combined final generated test suite

  `validation_feature_a.csv`             Feature A deterministic validation
                                         results

  `validation_feature_b.csv`             Feature B deterministic validation
                                         results

  `category_coverage.csv`                Test category coverage

  `coverage_report.csv`                  Acceptance criteria coverage

  `coverage_gaps.csv`                    Identified acceptance-criteria
                                         coverage gaps

  `DESIGN_WRITEUP.md`                    Project design and implementation
                                         writeup

  `Agentic_AI_Capstone_Reflection.pdf`   Short reflection on agent value and
                                         remaining manual review
  --------------------------------------------------------------------------

The notebook also produces feature-specific CSVs, Gherkin/BDD files,
intermediate draft/critique/final text files, summaries, and
deterministic QA reports in the `outputs/` directory.

## Observed Final Output

The prepared project outputs contain:

-   **21 total test cases**
-   **6 Positive**
-   **11 Negative**
-   **1 Boundary**
-   **3 Edge**
-   **0 coverage gaps**
-   **Final status: PASS**

The generated suite covers the two supplied features and their
acceptance criteria.

## Security

-   Store `GROQ_API_KEY` in Google Colab Secrets or an environment
    variable.
-   Never hardcode the API key.
-   Never commit the API key to GitHub.
-   Do not commit `.env` files or other credential files.

## Project Value

The agent adds value through broad first-pass scenario generation and
independent critique. The generator creates a structured starting point,
the critic reviews coverage and weaknesses, and the improver uses that
feedback to produce the final suite.

The agent does not replace QA judgment. Human review remains necessary
for:

-   Business-risk interpretation
-   Environment-specific data
-   Automation feasibility
-   Requirement ambiguity
-   Rejecting unsupported assumptions

Deterministic Python checks provide a repeatable quality gate around the
model-generated output.

## Submission Checklist

Before submitting the repository:

-   [ ] Both Feature A and Feature B are included.
-   [ ] Every test case has an AC ID.
-   [ ] Positive, Negative, Boundary and Edge cases are represented.
-   [ ] Critic output identifies coverage gaps.
-   [ ] Improver output addresses gaps.
-   [ ] Validator result is reviewed.
-   [ ] CSV, Gherkin and Excel outputs open correctly.
-   [ ] Reflection PDF is reviewed.
-   [ ] API key is NOT in the notebook/source files.
-   [ ] README and design writeup are complete.
-   [ ] GitHub repository is public or accessible to the evaluator.
