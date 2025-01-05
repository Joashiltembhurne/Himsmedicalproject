-- For each department in a hospital display the number of staff members and physicians.
SELECT
  	H.HOSPITAL_NAME,D.DEPARTMENT_NAME
  	,COUNT(S.DEPARTMENT_ID) AS STAFF_COUNT
  	,COUNT(P.DEPARTMENT_ID) AS PHYSICIAN_COUNT
FROM HOSPITALS H
JOIN DEPARTMENTS D ON D.HOSPITAL_ID = H.HOSPITAL_ID
LEFT JOIN STAFF S ON S.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN PHYSICIAN P ON P.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY H.HOSPITAL_NAME,D.DEPARTMENT_NAME
ORDER BY H.HOSPITAL_NAME,D.DEPARTMENT_NAME

-- Display the number of admissions in each hospital by month and year.
SELECT
  	H.HOSPITAL_NAME
  	,EXTRACT(YEAR FROM A.ADMISSION_DATE) AS YEAR
  	,EXTRACT(MONTH FROM A.ADMISSION_DATE) AS MONTH
  	,COUNT(A.ADMISSION_ID) AS NUM_OF_ADMISSIONS
FROM HOSPITALS H
JOIN DEPARTMENTS D ON D.HOSPITAL_ID = H.HOSPITAL_ID
JOIN ADMISSIONS A ON A.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY
  	H.HOSPITAL_NAME
  	,EXTRACT(YEAR FROM A.ADMISSION_DATE)
  	,EXTRACT(MONTH FROM A.ADMISSION_DATE)

-- Display the number of appointments for each physician.
SELECT
  	P.PHYSICIAN_NAME
  	,D.DEPARTMENT_NAME
  	,H.HOSPITAL_NAME
  	,COUNT(A.PHYSICIAN_ID) AS NUM_OF_APPOINTMENTS
FROM PHYSICIAN P
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = P.DEPARTMENT_ID
JOIN HOSPITALS  H ON H.HOSPITAL_ID = D.HOSPITAL_ID
JOIN APPOINTMENT A ON A.PHYSICIAN_ID = P.PHYSICIAN_ID
GROUP BY
  	P.PHYSICIAN_NAME,D.DEPARTMENT_NAME,H.HOSPITAL_NAME
ORDER BY P.PHYSICIAN_NAME

-- Display all payments for a single patient by their ID.
SELECT 
	P.PATIENT_NAME,
	PT.PAYMENT_DATE,
	PT.PAYMENT_AMOUNT,
	PT.PAYMENT_DETAILS,
	PT.PAYMENT_TYPE
FROM PAYMENTS PT 
JOIN PATIENT P ON P.PATIENT_ID = PT.PATIENT_ID 
WHERE P.PATIENT_ID = 1005
ORDER BY PT.PAYMENT_DATE DESC

-- Display all medications and the number of patients to whom that medication was prescribed and average dose.
SELECT
  	M.MEDICATION_NAME,
  	COUNT(PM.MEDICATION_ID) AS NUM_OF_PRESCRIBED_PATIENTS
  	,CONCAT(AVG(REGEXP_REPLACE(PM.DOES, '[^0-9]', '')),' Tablets') AS AVERAGE_DOSE
FROM MEDICATION M
LEFT JOIN PATIENT_MEDICATION PM ON PM.MEDICATION_ID = M.MEDICATION_ID
GROUP BY M.MEDICATION_NAME
ORDER BY M.MEDICATION_NAME

-- For each patient, display the number of times the patient got admitted to a hospital. 
SELECT
  	P.PATIENT_NAME,H.HOSPITAL_NAME
  	,COUNT(A.PATIENT_ID) AS NUM_OF_ADMISSIONS
FROM PATIENT P
LEFT JOIN ADMISSIONS A ON A.PATIENT_ID = P.PATIENT_ID
LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = A.DEPARTMENT_ID
LEFT JOIN HOSPITALS H ON H.HOSPITAL_ID = D.HOSPITAL_ID
GROUP BY P.PATIENT_NAME,H.HOSPITAL_NAME
ORDER BY P.PATIENT_NAME,H.HOSPITAL_NAME

-- Display the total payments made by all patients by Month and Year.
SELECT
  	H.HOSPITAL_NAME,
  	EXTRACT(YEAR FROM PAYMENT_DATE) AS YEAR,
  	EXTRACT(MONTH FROM PAYMENT_DATE) AS MONTH,
  	SUM(PAYMENT_AMOUNT) AS PAYMENT_AMOUNT
FROM PAYMENTS PT
JOIN PATIENT P ON P.PATIENT_ID = PT.PATIENT_ID
JOIN ADMISSIONS A ON A.PATIENT_ID = P.PATIENT_ID
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = A.DEPARTMENT_ID
JOIN HOSPITALS H ON H.HOSPITAL_ID = D.HOSPITAL_ID
GROUP BY
  	H.HOSPITAL_NAME,
  	EXTRACT(YEAR FROM PAYMENT_DATE),
  	EXTRACT(MONTH FROM PAYMENT_DATE)
ORDER BY
  	H.HOSPITAL_NAME,
  	EXTRACT(YEAR FROM PAYMENT_DATE),
  	EXTRACT(MONTH FROM PAYMENT_DATE)

-- Display all test types from labs and calculate the number of times that test was conducted on patients. 
SELECT TEST_TYPE,COUNT(PATIENT_ID) AS NUM_OF_PATIENTS FROM LAB_WORK
GROUP BY TEST_TYPE
ORDER BY TEST_TYPE


