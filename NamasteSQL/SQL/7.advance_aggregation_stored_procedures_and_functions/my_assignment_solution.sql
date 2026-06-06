-- 1. write a sql to find top 3 products in each category by highest rolling 3 months total sales for Jan 2020.

-- We get category wise for each product monthly total sales 
WITH monthlyProductSales AS
(
    SELECT
        category,
        product_id,
        DATEPART(YEAR, order_date) AS order_year,
        DATEPART(MONTH, order_date) AS order_month,
        SUM(sales) as total_sales
    FROM orders
    GROUP BY category, product_id, DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)
),

-- We compute rolling sales, category wise for each product order by monthly
rollingThreeMonthProductSales AS 
(
    SELECT
        *,
        SUM(total_sales) OVER(
            PARTITION BY 
                category,
                product_id 
            ORDER BY 
                order_year,
                order_month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            ) AS rollingSum
    FROM  monthlyProductSales
),

-- We rank products grouped by category for year 2024 and month January
rollingThreeMonthProductSalesRanked AS 
(
    SELECT
        *,
        DENSE_RANK() OVER(
            PARTITION BY 
                category
            ORDER BY 
                rollingSum DESC
            ) as rnk
    FROM rollingThreeMonthProductSales
    WHERE order_year = 2020 AND order_month = 1
)

-- We select the top 3 products in each category
SELECT
    *
FROM rollingThreeMonthProductSalesRanked
WHERE rnk <= 3;

-- 2. write a query to find products for which month over month sales has never declined.

-- we compute product wise monthly total sales
WITH productMonthlySales AS 
(
    SELECT
        product_id,
        DATEPART(YEAR, order_date) AS order_year,
        DATEPART(MONTH, order_date) AS order_month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY product_id, DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)
),

-- we compute previous month sales for each product 
previousMonthSales AS 
(
    SELECT
        *,
        LAG(total_sales, 1, 0) OVER(
            PARTITION BY
                product_id
            ORDER BY
                order_year,
                order_month
        ) AS previous_month_sales
    FROM productMonthlySales
)

-- we select products which have never seen any decline
SELECT
    DISTINCT product_id
FROM previousMonthSales
WHERE product_id NOT IN 
(
    -- we get products which have seen a decline at least onces
    SELECT
        DISTINCT product_id
    FROM previousMonthSales
    WHERE total_sales < previous_month_sales
    GROUP BY product_id
);

-- 3. write a query to find month wise sales for each category for months where sales is more than the combined sales of previous 2 months for that category.

-- we compute category wise monthly sales
WITH categoryMonthlySales AS 
(
    SELECT
        category,
        DATEPART(YEAR, order_date) AS order_year,
        DATEPART(MONTH, order_date) AS order_month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY
        category,
        DATEPART(YEAR, order_date),
        DATEPART(MONTH, order_date)
),

-- we compute category wise previous two month sales
categoryPreviousTwoMonthSales AS 
(
    SELECT
        *,
        SUM(total_sales) OVER(
            PARTITION BY
                category
            ORDER BY
                order_year,
                order_month
            ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING 
        ) AS previous_two_month_sales
    FROM categoryMonthlySales
)

-- we select those category wise monthly sales, where sales is more than the combined sales of previous 2 months for that category. 
SELECT
    *
FROM categoryPreviousTwoMonthSales
WHERE total_sales > previous_two_month_sales;

-- 4. write a user defined functions  which takes 2 input parameters of DATE data type. 
-- The function should return no of business days between the 2 dates.
-- note -> if any of the 2 input dates are falling on saturday or sunday then function should use immediate Monday 
-- date for calculation
-- example if we pass dates as 2024-11-30 and 2024-12-05..then it should calculate business days 
-- between 2024-12-02 and 2024-12-05

CREATE FUNCTION dbo.fn_business_days
(
    @start_date DATE, 
    @end_date DATE
)
RETURNS INT
AS
BEGIN
    -- Adjust start_date if it falls on weekend
    SET @start_date = CASE
        WHEN DATEPART(WEEKDAY, @start_date) = 7 THEN DATEADD(DAY, 2, @start_date) -- If day is Saturday
        WHEN DATEPART(WEEKDAY, @start_date) = 1 THEN DATEADD(DAY, 1, @start_date) -- IF day is Sunday
        ELSE @start_date
    END;

    -- Adjust end_date if it falls on weekend
    SET @start_date = CASE
        WHEN DATEPART(WEEKDAY, @end_date) = 7 THEN DATEADD(DAY, 2, @end_date) -- If day is Saturday
        WHEN DATEPART(WEEKDAY, @end_date) = 1 THEN DATEADD(DAY, 1, @end_date) -- IF day is Sunday
        ELSE @end_date
    END;
    
    RETURN 
        (
            SELECT 
                DATEDIFF(DAY, @start_date, @end_date) - (2 * DATEDIFF(DAY, @start_date, @end_date))
        )
END;

SELECT 
    dbo.fn_business_days(order_date,ship_date) as business_days,
    *
FROM orders; 

-- 5. This is in continuation to the stored procedure for namastesql LMS. We created a stored procedure sp_manage_students to manage students.
-- Now create a courses table manually which will have course_id , course_name and insert some records. Eample -
-- 100, SQL
-- 200, Python
-- 300, Tableau
-- on namaste sql you have option to buy combos as well which gives you access to multiple courses. 
-- create a table called combos which will have 2 columns combo_id , course_id and insert some data, Example -
-- combo_id , course_id
-- 1,100
-- 1,200
-- 2,100
-- 2,200
-- 2,300
-- Next create a stored procedure to manage enrollments  : sp_manage_enrollments
-- for this first create a table student_courses which will have 2 columns student_id, course_id
-- student_id will refer to the students table created in the lecture.
-- sp_manage_enrollments should take 3 arguments : @student_id, @course_combo_id , @iscombo_flag
-- based on these arguments the procedure should enroll the students by making entry in student_courses table.

-- we create TABLE courses and INSERT values
CREATE TABLE courses
(
    course_id INT,
    course_name VARCHAR(20)
);

INSERT INTO courses (course_id, course_name) 
VALUES 
    (100, 'SQL'),
    (200, 'Python'),
    (300, 'Tableau');

-- we create TABLE combo and INSERT values
CREATE TABLE combo
(
    combo_id INT,
    course_id INT,
    PRIMARY KEY (combo_id, course_id)
);

INSERT INTO combo (combo_id, course_id) 
VALUES
    (1, 100),
    (1, 200),
    (2, 100),
    (2, 200),
    (2, 300);

-- we create TABLE student_courses

-- First we create the parent Students table
CREATE TABLE students (
    student_id INT IDENTITY (1,1) PRIMARY KEY, -- Made PRIMARY KEY to allow referencing
    email_id VARCHAR(20),
    name VARCHAR(20),
    country VARCHAR(20)
);

-- now, we create TABLE student_courses
CREATE TABLE student_courses
(
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT FK_student_courses_students FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE PROCEDURE sp_manage_enrollments
    @student_id INT,
    @course_combo_id INT,
    @iscombo_flag CHAR(1)
AS
BEGIN
    -- SET NOCOUNT ON Stops SQL Server from sending the "rows affected" message back to the client after each statement. It prevents extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- CASE 1: Enrolling in a Single Course
    IF @iscombo_flag = 'N'
    BEGIN
        -- Check if the student is already enrolled to prevent primary key violation
        IF NOT EXISTS (SELECT 1 FROM student_courses WHERE student_id = @student_id AND course_id = @course_combo_id)
        BEGIN
            INSERT INTO student_courses (student_id, course_id)
            VALUES (@student_id, @course_combo_id);
            
            PRINT 'Student successfully enrolled in course ' + CAST(@course_combo_id AS VARCHAR);
        END
        ELSE
        BEGIN
            PRINT 'Student is already enrolled in this course.';
        END
    END

    -- CASE 2: Enrolling in a Combo Pack
    ELSE IF @iscombo_flag = 'Y'
    BEGIN
        -- Insert all courses belonging to the combo, ignoring duplicates
        INSERT INTO student_courses (student_id, course_id)
        SELECT @student_id, course_id
        FROM combo
        WHERE combo_id = @course_combo_id
          -- Subquery to ensure we only insert courses the student doesn't already have
          AND course_id NOT IN (
              SELECT course_id FROM student_courses WHERE student_id = @student_id
          );

        PRINT 'Student successfully enrolled in Combo Pack ' + CAST(@course_combo_id AS VARCHAR);
    END
    
    ELSE
    BEGIN
        PRINT 'Invalid Flag! Please use Y for Combo or N for Single Course.';
    END
END;


-- Step 1: Insert a new student (SQL generates the ID automatically)
INSERT INTO students (email_id, [name], country) VALUES ('alex@email.com', 'Alex', 'India');
INSERT INTO students (email_id, [name], country) VALUES ('kira@email.com', 'Kira', 'UK');
INSERT INTO students (email_id, [name], country) VALUES ('Tony.com', 'Tony', 'US');



-- Call your stored procedure to enroll Alex into Combo Pack 1
EXEC sp_manage_enrollments 
    @student_id = 1, 
    @course_combo_id = 1, 
    @iscombo_flag = 'Y';

-- Call your stored procedure to enroll Kira into Combo Pack 2
EXEC sp_manage_enrollments 
    @student_id = 2, 
    @course_combo_id = 2, 
    @iscombo_flag = 'Y';

-- Call your stored procedure to enroll Tony into Combo Pack 1
EXEC sp_manage_enrollments 
    @student_id = 3, 
    @course_combo_id = 1, 
    @iscombo_flag = 'Y';

-- Call your stored procedure to enroll Tony into Single Course - Tableau
EXEC sp_manage_enrollments 
    @student_id = 3, 
    @course_combo_id = 300, 
    @iscombo_flag = 'N';
