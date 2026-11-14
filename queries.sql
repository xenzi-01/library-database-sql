-- 1. All books by genre
SELECT genre, COUNT(*) AS total_books
FROM books
GROUP BY genre;

-- 2. Books currently on loan
SELECT b.title, m.name, l.loan_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

-- 3. Number of loans per member
SELECT m.name, COUNT(l.loan_id) AS total_loans
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.name
ORDER BY total_loans DESC;

-- 4. Most borrowed books
SELECT b.title, COUNT(*) AS times_borrowed
FROM loans l
JOIN books b ON l.book_id = b.book_id
GROUP BY b.title
ORDER BY times_borrowed DESC;

-- 5. Books never borrowed
SELECT b.title
FROM books b
LEFT JOIN loans l ON b.book_id = l.book_id
WHERE l.loan_id IS NULL;

-- 6. Members who have never borrowed
SELECT m.name
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
WHERE l.loan_id IS NULL;

-- 7. Unreturned loans older than 14 days (as of 2026-11-14)
SELECT b.title, m.name, l.loan_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL
AND l.loan_date < '2026-10-31';

-- 8. Books published after 2015
SELECT title, author, year_published
FROM books
WHERE year_published > 2015
ORDER BY year_published;

-- 9. Members who joined in 2025, newest first
SELECT name, joined_date
FROM members
WHERE joined_date >= '2025-01-01'
ORDER BY joined_date DESC;

-- 10. Average loan length in days (SQLite)
SELECT AVG(julianday(return_date) - julianday(loan_date)) AS avg_days
FROM loans
WHERE return_date IS NOT NULL;
