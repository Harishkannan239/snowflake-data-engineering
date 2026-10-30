
-- Validate customer release.
-- Raise an error when the view returns no records.

EXECUTE IMMEDIATE $$
DECLARE
    v_source_count NUMBER;
    v_view_count NUMBER;

    validation_failed EXCEPTION (
        -20008,
        'RELEASE VALIDATION FAILED: row count mismatch'
    );
BEGIN
    SELECT COUNT(*)
      INTO :v_source_count
    FROM GITHUB_LAB.BRONZE.CUSTOMERS;

    SELECT COUNT(*)
      INTO :v_view_count
    FROM GITHUB_LAB.DEV.VW_CUSTOMER_RELEASE;

    IF (v_source_count = 0 OR
        v_view_count <> v_source_count) THEN
        RAISE validation_failed;
    END IF;

    RETURN 'RELEASE VALIDATION PASSED';
END;
$$;
