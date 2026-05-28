USE tripmates;

INSERT INTO users (full_name, email, phone, password_hash, role, account_status, verification_status, email_verified_at, phone_verified_at)
VALUES
('TripMates Admin', 'admin@tripmates.local', '+910000000000', '$2y$10$P3DUfK6Q4j5Wssii6mC7wOd0mLDNMxbNHYGwA04qZ7p.ueajlhQTW', 'admin', 'active', 'approved', NOW(), NOW());

-- Admin password: Admin@12345
