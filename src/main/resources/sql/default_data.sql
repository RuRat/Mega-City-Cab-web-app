INSERT INTO auth_user (username, password, role, status, name, address, phone)
SELECT 'admin', 'admin123', 'ADMIN', 'ACTIVE', 'System Admin', '123 Admin St', '000-000-0000'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM auth_user WHERE username = 'admin');