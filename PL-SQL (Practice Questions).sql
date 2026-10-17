-- PL/SQL Practice Questions :

CREATE TABLE employees2 (
    emp_id     INT,
    emp_name   VARCHAR2(20),
    department VARCHAR2(10),
    salary     INT
);

INSERT INTO employees2 VALUES ( 101,
                                'Amit',
                                'IT',
                                45000 ), ( 102,
                                           'Neha',
                                           'HR',
                                           38000 ), ( 103,
                                                      'Ravi',
                                                      'IT',
                                                      52000 ), ( 104,
                                                                 'Sara',
                                                                 'Sales',
                                                                 41000 );

SELECT
    *
FROM
    employees2;

-- 1. Write a PL/SQL block to print your name.

DECLARE
    v_name VARCHAR2(20) := 'Shouvik';
BEGIN
    dbms_output.put_line('My name is: ' || v_name);
END;
/

-- 2. Create a procedure that displays an employee's name and salary by employee ID.

select * from employees2;
CREATE OR REPLACE PROCEDURE getemployeedata (
    v_id IN NUMBER
) IS
    v_name   employees2.emp_name%TYPE;
    v_salary employees2.salary%TYPE;
BEGIN
    SELECT
        emp_name,
        salary
    INTO
        v_name,
        v_salary
    FROM
        employees2
    WHERE
        emp_id = v_id;

    dbms_output.put_line('Employee name is:' || v_name);
    dbms_output.put_line('Employee salary is:' || v_salary);
END;
/

EXECUTE GETEMPLOYEEDATA(104);

--DROP PROCEDURE GETEMPLOYEEDATA;

-- 3. Write a function that returns annual salary.

CREATE OR REPLACE FUNCTION annual_salary (
    m_salary IN NUMBER
) RETURN NUMBER IS
BEGIN
    RETURN m_salary * 12;
END;
/

-- DROP FUNCTION Annual_Salary;

BEGIN
    dbms_output.put_line(annual_salary(10000));
END;
/

-- 4. Use a FOR LOOP to print numbers from 1 to 10.

BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/

-- 5. Use IF-ELSIF-ELSE to classify marks.

DECLARE
    v_marks NUMBER := 65;
BEGIN
    IF v_marks >= 75 THEN
        dbms_output.put_line('Excellent');
    ELSIF v_marks >= 60 THEN
        dbms_output.put_line('First Class');
    ELSIF v_marks >= 40 THEN
        dbms_output.put_line('Pass');
    ELSE
        dbms_output.put_line('Fail');
    END IF;
END;
/

-- 6. Use a cursor FOR LOOP to display all IT employees.


BEGIN
    FOR c_emp IN (
        SELECT
            *
        FROM
            employees2
        WHERE
            department = 'IT'
    ) LOOP
        dbms_output.put_line('Employee ID : '
                             || c_emp.emp_id
                             || ', Employee Name : '
                             || c_emp.emp_name
                             || ', Department : '
                             || c_emp.department
                             || ', Salary : '
                             || c_emp.salary);
    END LOOP;
END;
/

-- 7. Handle NO_DATA_FOUND when an employee ID does not exist.

select * from employees2;

DECLARE
    v_id         PLS_INTEGER := 106;
    v_name       employees2.emp_name%TYPE;
    v_department employees2.department%TYPE;
    v_salary     employees2.salary%TYPE;
BEGIN
    SELECT
        emp_name,
        department,
        salary
    INTO
        v_name,
        v_department,
        v_salary
    FROM
        employees2
    WHERE
        emp_id = v_id;

    dbms_output.put_line('ID: ' || v_id);
    dbms_output.put_line('Name: ' || v_name);
    dbms_output.put_line('Department: ' || v_department);
    dbms_output.put_line('Salary: ' || v_salary);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Employee does not exist');
END;
/

-- 8. Create a view showing only IT employees.

CREATE VIEW getemployees AS
    SELECT
        *
    FROM
        employees2
    WHERE
        department = 'IT';

SELECT
    *
FROM
    getemployees;

-- 9. Create a sequence and display NEXTVAL.

CREATE SEQUENCE s_employees START WITH 110 INCREMENT BY 2 MINVALUE 110 MAXVALUE 130 CYCLE NOCACHE;

SELECT
    s_employees.NEXTVAL
FROM
    dual;

-- 10. Create a trigger that assigns a default salary when salary is NULL.

CREATE OR REPLACE TRIGGER t2 BEFORE
    INSERT ON employees2
    FOR EACH ROW
BEGIN
    IF :new.salary IS NULL THEN
        :new.salary := 30000;
    END IF;
END;
/

SELECT
    *
FROM
    employees2;

INSERT INTO employees2 VALUES ( 111,
                                'Saurabh',
                                'IT',
                                NULL );

SELECT
    *
FROM
    employees2;
    

-- 11. Write a block to check whether a number is even or odd. 
    
DECLARE
    v_number NUMBER := 12;
BEGIN
    IF MOD(v_number, 2) = 0 THEN
        dbms_output.put_line('Even');
    ELSE
        dbms_output.put_line('Odd');
    END IF;
END;
/

-- 12. Write a block to calculate factorial using a FOR loop. 

DECLARE 

v_fact NUMBER := 1;

BEGIN
FOR i IN 1..5 LOOP
    v_fact := v_fact * i;
END LOOP;

dbms_output.put_line(v_fact);

end;
/

-- 13. Use SELECT INTO to fetch an employee salary and handle NO_DATA_FOUND. 

select * from employees2;

DECLARE
    v_id         employees2.emp_id%TYPE;
    v_name       employees2.emp_name%TYPE;
    v_department employees2.department%TYPE;
    v_salary     employees2.salary%TYPE;
BEGIN
    SELECT
        emp_id,
        emp_name,
        department,
        salary
    INTO
        v_id,
        v_name,
        v_department,
        v_salary
    FROM
        employees2
    WHERE
        emp_id = 999;

    dbms_output.put_line('ID: '
                         || v_id
                         || ', Name: '
                         || v_name
                         || ', Department: '
                         || v_department
                         || ', Salary: '
                         || v_salary);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Employee does not exist');
END;
/

-- 14. Write a cursor FOR loop to display employees earning above a chosen salary. 
--
-- select * from employees2;

BEGIN
    FOR c_emp IN (
        SELECT
            *
        FROM
            employees2
        WHERE
            salary >= 45000
    ) LOOP
        dbms_output.put_line('ID: '
                             || c_emp.emp_id
                             || ', Name: '
                             || c_emp.emp_name
                             || ', Department: '
                             || c_emp.department
                             || ', SALARY: '
                             || c_emp.salary);
    END LOOP;
END;
/

-- 15. Write an exception handler for division by zero. 

DECLARE
    v1_number NUMBER := 10;
    v2_number NUMBER := 0;
BEGIN
    dbms_output.put_line('The division is: ' ||(v1_number / v2_number));
EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line('Zero Division Error');
END;
/

-- 9. Create a trigger that rejects negative salary values. 

CREATE OR REPLACE TRIGGER t3
BEFORE INSERT ON EMPLOYEES2
FOR EACH ROW
BEGIN
IF :new.salary < 0 THEN 
RAISE_APPLICATION_ERROR(-20001,'Salary cannot be negative');
END IF;
END;
/

-- drop trigger t3;

select * from employees2;

INSERT INTO EMPLOYEES2 VALUES(121,'Rohan','HR', 100000);

select * from employees2;

-- 10. Explain how you would update a salary and roll back the transaction if validation fails. 

SAVEPOINT before_updated_salary;

UPDATE EMPLOYEES2
SET Salary = Salary + 5000
WHERE EMP_ID = 121;

select * from employees2;

-- If validation fails:
ROLLBACK TO before_updated_salary;

-- If validation succeds.
COMMIT;