Feature: Apply Promo Code at Checkout

  Scenario: Apply a valid percentage promo code (SAVE10) to a qualifying subtotal.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,000; no promo code applied.
    And the test data is Promo code: SAVE10
    When 1. Verify item‑subtotal displayed as ₹1,000.
    When 2. Enter SAVE10 into the promo code field.
    When 3. Click the Apply button.
    When 4. Observe the discount and total.
    Then A 10% discount of ₹100 is applied; item‑subtotal becomes ₹900; order total updates accordingly.

  Scenario: Apply a valid fixed‑amount promo code (FLAT200) when subtotal meets the minimum requirement.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,500; no promo code applied.
    And the test data is Promo code: FLAT200
    When 1. Verify item‑subtotal displayed as ₹1,500.
    When 2. Enter FLAT200 into the promo code field.
    When 3. Click Apply.
    When 4. Observe the discount and total.
    Then ₹200 is deducted; item‑subtotal becomes ₹1,300; order total reflects the discounted amount.

  Scenario: Attempt to apply a fixed‑amount promo code (FLAT200) when subtotal is below the required minimum.
    Given User is on the Checkout page; cart item‑subtotal = ₹800; no promo code applied.
    And the test data is Promo code: FLAT200
    When 1. Verify item‑subtotal displayed as ₹800.
    When 2. Enter FLAT200 into the promo code field.
    When 3. Click Apply.
    When 4. Observe the response.
    Then Error message displayed: "This code requires a minimum order of ₹1,000."; no discount applied; total remains unchanged.

  Scenario: Apply an expired promo code.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,200; no promo code applied.
    And the test data is Promo code: EXPIRED2022
    When 1. Verify item‑subtotal displayed as ₹1,200.
    When 2. Enter EXPIRED2022 into the promo code field.
    When 3. Click Apply.
    When 4. Observe the response.
    Then Error message displayed: "This code has expired."; no discount applied; total remains unchanged.

  Scenario: Apply a non‑existent promo code.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,200; no promo code applied.
    And the test data is Promo code: NOTACODE
    When 1. Verify item‑subtotal displayed as ₹1,200.
    When 2. Enter NOTACODE into the promo code field.
    When 3. Click Apply.
    When 4. Observe the response.
    Then Error message displayed: "Invalid promo code."; no discount applied; total remains unchanged.

  Scenario: Validate case‑insensitivity of promo codes.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,000; no promo code applied.
    And the test data is Promo code: save10
    When 1. Verify item‑subtotal displayed as ₹1,000.
    When 2. Enter save10 (lowercase) into the promo code field.
    When 3. Click Apply.
    When 4. Observe the discount and total.
    Then Same result as SAVE10: ₹100 discount applied; subtotal becomes ₹900; order total updates.

  Scenario: Reapply a single‑use promo code that has already been redeemed by the same customer.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,200; promo code SAVE10 has been previously used and marked as single‑use for this account.
    And the test data is Promo code: SAVE10
    When 1. Verify item‑subtotal displayed as ₹1,200.
    When 2. Enter SAVE10 into the promo code field.
    When 3. Click Apply.
    When 4. Observe the response.
    Then Error message displayed: "This code has already been used."; no additional discount applied; total remains unchanged.

  Scenario: Apply a fixed‑amount promo code that would otherwise reduce subtotal below zero.
    Given User is on the Checkout page; cart item‑subtotal = ₹150; no promo code applied.
    And the test data is Promo code: FLAT200
    When 1. Verify item‑subtotal displayed as ₹150.
    When 2. Enter FLAT200 into the promo code field.
    When 3. Click Apply.
    When 4. Observe the discount and total.
    Then Discount capped at ₹150; resulting subtotal is ₹0 (never negative); order total reflects ₹0 for items.

  Scenario: Replace an already applied promo code with a new one after user confirmation.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,000; promo code SAVE10 already applied (₹100 discount).
    And the test data is New promo code: FLAT200
    When 1. Verify existing discount of ₹100 from SAVE10.
    When 2. Enter FLAT200 into the promo code field.
    When 3. Click Apply.
    When 4. System prompts: "A promo code is already applied. Replace it?".
    When 5. Confirm replacement.
    When 6. Observe the new discount and total.
    Then SAVE10 discount removed; FLAT200 discount of ₹200 applied; item‑subtotal becomes ₹800; order total updates accordingly.

  Scenario: Attempt to apply a promo code with an empty input field.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,200; promo code field is empty.
    And the test data is Promo code: (none)
    When 1. Ensure promo code field is blank.
    When 2. Click the Apply button.
    When 3. Observe the response.
    Then Error message displayed: "Enter a promo code."; no discount applied; total remains unchanged.

  Scenario: Validate that leading and trailing whitespace in the promo code is trimmed before validation.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,000; no promo code applied.
    And the test data is Promo code: "  SAVE10  " (with spaces)
    When 1. Verify item‑subtotal displayed as ₹1,000.
    When 2. Enter "  SAVE10  " into the promo code field.
    When 3. Click Apply.
    When 4. Observe the discount and total.
    Then Whitespace is trimmed; code recognized as SAVE10; ₹100 discount applied; subtotal becomes ₹900; total updates.

  Scenario: Re‑validate discount when cart subtotal changes after a promo code has been applied.
    Given User is on the Checkout page; cart item‑subtotal = ₹1,200; promo code FLAT200 (requires ₹1,000 minimum) already applied.
    And the test data is Cart change: remove an item reducing subtotal to ₹900.
    When 1. Verify FLAT200 discount of ₹200 applied; subtotal displayed as ₹1,000.
    When 2. Remove an item causing subtotal to drop to ₹900.
    When 3. System automatically re‑validates the applied promo code.
    When 4. Observe the outcome.
    Then FLAT200 is removed because the new subtotal is below the minimum; discount cleared; item‑subtotal returns to ₹900; total updates accordingly.
