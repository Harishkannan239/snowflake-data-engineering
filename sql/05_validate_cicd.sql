
-- CI/CD deployment validation

SELECT
    COUNT(*) AS TOTAL_RECORDS
FROM GITHUB_LAB.DEV.VW_CUSTOMER_CICD;

-- Fail the deployment if the view is missing
-- or returns zero customer records.

EXECUTE IMMEDIATE $$
DECLARE
    v_count NUMBER;
    validation_failed EXCEPTION (
        -20001,
        'CI/CD validation failed'
    );
BEGIN
    SELECT COUNT(*)
    INTO :v_count
    FROM GITHUB_LAB.DEV.VW_CUSTOMER_CICD;

    IF (v_count = 0) THEN
        RAISE validation_failed;
    END IF;

    RETURN 'CI/CD validation passed';
END;
$$;
