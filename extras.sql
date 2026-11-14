-- Run this AFTER schema.sql

-- 1. New table: fines for late or unreturned books
CREATE TABLE fines (
    fine_id INTEGER PRIMARY KEY,
    loan_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    paid INTEGER DEFAULT 0,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

INSERT INTO fines VALUES
(1, 4, 500.00, 0),
(2, 6, 300.00, 0),
(3, 3, 150.00, 1);

-- 2. Indexes to speed up common lookups
CREATE INDEX idx_loans_book ON loans(book_id);
CREATE INDEX idx_loans_member ON loans(member_id);

-- 3. View: books currently on loan
CREATE VIEW current_loans AS
SELECT l.loan_id, b.title, m.name AS member, l.loan_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

-- 4. View: unpaid fines per member
CREATE VIEW unpaid_fines AS
SELECT m.name, SUM(f.amount) AS total_owed
FROM fines f
JOIN loans l ON f.loan_id = l.loan_id
JOIN members m ON l.member_id = m.member_id
WHERE f.paid = 0
GROUP BY m.name;

-- 5. Use the views
SELECT * FROM current_loans;
SELECT * FROM unpaid_fines;

-- 6. Rank members by number of loans (window function)
SELECT name, total_loans,
       RANK() OVER (ORDER BY total_loans DESC) AS loan_rank
FROM (
    SELECT m.name, COUNT(l.loan_id) AS total_loans
    FROM members m
    LEFT JOIN loans l ON m.member_id = l.member_id
    GROUP BY m.name
);

-- 7. Mark a fine as paid
UPDATE fines SET paid = 1 WHERE fine_id = 1;

-- 8. Check the result
SELECT * FROM fines;
