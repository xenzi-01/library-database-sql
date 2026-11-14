CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    genre TEXT,
    year_published INTEGER
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    joined_date DATE
);

CREATE TABLE loans (
    loan_id INTEGER PRIMARY KEY,
    book_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO books VALUES
(1, 'Learning Python', 'Mark Lutz', 'Programming', 2013),
(2, 'SQL Basics', 'Ada Okoye', 'Programming', 2019),
(3, 'World History', 'John Bello', 'History', 2010),
(4, 'Data Stories', 'Amina Yusuf', 'Data', 2021),
(5, 'Web Design 101', 'Chidi Eze', 'Design', 2018),
(6, 'Ancient Africa', 'Fatima Musa', 'History', 2015);

INSERT INTO members VALUES
(1, 'Tunde Adebayo', 'tunde@example.com', '2025-01-10'),
(2, 'Zainab Ibrahim', 'zainab@example.com', '2025-03-22'),
(3, 'Emeka Obi', 'emeka@example.com', '2025-06-05'),
(4, 'Grace Johnson', 'grace@example.com', '2025-09-18');

INSERT INTO loans VALUES
(1, 1, 1, '2026-09-01', '2026-09-12'),
(2, 2, 1, '2026-09-15', '2026-09-25'),
(3, 1, 2, '2026-10-02', '2026-10-14'),
(4, 3, 2, '2026-10-20', NULL),
(5, 4, 3, '2026-10-25', '2026-11-03'),
(6, 2, 3, '2026-11-05', NULL),
(7, 1, 1, '2026-11-08', NULL),
(8, 5, 2, '2026-11-10', '2026-11-12');
