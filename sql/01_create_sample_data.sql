DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    account_status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email, account_status) VALUES
('user1', 'user1@example.com', 'active'),
('user2', 'user2@example.com', 'active'),
('user3', 'user3@example.com', 'inactive'),
('user4', 'user4@example.com', 'active');

-- Improves CDC messages for updates/deletes in this demo.
ALTER TABLE users REPLICA IDENTITY FULL;
