-- Run these in the source database to test CDC replication.

INSERT INTO users (username, email, account_status)
VALUES ('user5', 'user5@example.com', 'active');

UPDATE users
SET email = 'user1.updated@example.com'
WHERE username = 'user1';

ALTER TABLE users ADD COLUMN user_segment TEXT NOT NULL DEFAULT 'standard';

UPDATE users
SET user_segment = 'premium'
WHERE username = 'user2';
