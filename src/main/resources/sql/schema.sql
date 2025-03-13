-- -- Create auth_user table
-- CREATE TABLE auth_user (
--                            id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--                            username VARCHAR2(100) UNIQUE NOT NULL,
--                            password VARCHAR2(255) NOT NULL,
--                            role VARCHAR2(20) NOT NULL CHECK (role IN ('ADMIN', 'CUSTOMER', 'DRIVER', 'BOOKING_MANAGER', 'FINANCE_MANAGER', 'OPERATOR')),
--                            status VARCHAR2(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE')),
--                            name VARCHAR2(255),
--                            address CLOB,
--                            phone VARCHAR2(20),
--                            license_number VARCHAR2(100),
--                            vehicle_id NUMBER
-- );
-- 
-- -- Create vehicle table
-- CREATE TABLE vehicle (
--                          id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--                          model VARCHAR2(100),
--                          numberPlate VARCHAR2(50) UNIQUE,
--                          status VARCHAR2(20) CHECK (status IN ('AVAILABLE', 'BOOKED', 'MAINTENANCE')),
--                          assignedDriverId NUMBER
-- );
-- 
-- -- Create reservation table
-- CREATE TABLE reservation (
--                              id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--                              customerId NUMBER NOT NULL,
--                              vehicleId NUMBER NOT NULL,
--                              driverId NUMBER NOT NULL,
--                              startTime TIMESTAMP,
--                              endTime TIMESTAMP,
--                              pickupLocation CLOB,
--                              destinationLocation CLOB,
--                              status VARCHAR2(20) CHECK (status IN ('PENDING', 'CONFIRMED', 'CANCELLED')),
--                              FOREIGN KEY (customerId) REFERENCES auth_user(id),
--                              FOREIGN KEY (vehicleId) REFERENCES vehicle(id),
--                              FOREIGN KEY (driverId) REFERENCES auth_user(id)
-- );
-- 
-- -- Create invoice table
-- CREATE TABLE invoice (
--                          id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--                          reservationId NUMBER NOT NULL,
--                          amount DECIMAL(10,2),
--                          tax DECIMAL(10,2),
--                          discount DECIMAL(10,2),
--                          totalAmount DECIMAL(10,2),
--                          paymentStatus VARCHAR2(20) CHECK (paymentStatus IN ('PAID', 'UNPAID')),
--                          issuedAt TIMESTAMP,
--                          paidAt TIMESTAMP NULL,
--                          FOREIGN KEY (reservationId) REFERENCES reservation(id)
-- );
-- 
-- GRANT CONNECT, RESOURCE TO MEGACITYCAB;
-- GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TRIGGER TO MEGACITYCAB;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON auth_user TO MEGACITYCAB;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON vehicle TO MEGACITYCAB;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON reservation TO MEGACITYCAB;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON invoice TO MEGACITYCAB;

-- Create auth_user table
CREATE TABLE auth_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'CUSTOMER', 'DRIVER', 'BOOKING_MANAGER', 'FINANCE_MANAGER', 'OPERATOR') NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    name VARCHAR(255),
    address TEXT,
    phone VARCHAR(20),
    license_number VARCHAR(100),
    vehicle_id INT
);

-- Create vehicle table
CREATE TABLE vehicle (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(100),
    numberPlate VARCHAR(50) UNIQUE,
    status ENUM('AVAILABLE', 'BOOKED', 'MAINTENANCE'),
    assignedDriverId INT
);

-- Create reservation table
CREATE TABLE reservation (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    customerId INT NOT NULL,  
    vehicleId INT NOT NULL,   
    driverId INT NOT NULL,  
    startTime DATETIME,  
    endTime DATETIME,  
    pickupLocation VARCHAR(255), 
    destinationLocation VARCHAR(255), 
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED') DEFAULT 'PENDING',
    -- Foreign keys referencing auth_user (for customer and driver) and vehicle
    FOREIGN KEY (customerId) REFERENCES auth_user(id) ON DELETE CASCADE ON UPDATE CASCADE,  
    FOREIGN KEY (vehicleId) REFERENCES vehicle(id) ON DELETE CASCADE ON UPDATE CASCADE,  
    FOREIGN KEY (driverId) REFERENCES auth_user(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexing foreign keys for faster querying
CREATE INDEX idx_customer_id ON reservation(customerId);
CREATE INDEX idx_vehicle_id ON reservation(vehicleId);
CREATE INDEX idx_driver_id ON reservation(driverId);

);

-- Create invoice table
CREATE TABLE invoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservationId INT NOT NULL,
    amount DECIMAL(10,2),
    tax DECIMAL(10,2),
    discount DECIMAL(10,2),
    totalAmount DECIMAL(10,2),
    paymentStatus ENUM('PAID', 'UNPAID'),
    issuedAt TIMESTAMP,
    paidAt TIMESTAMP NULL,
    FOREIGN KEY (reservationId) REFERENCES reservation(id)
);

-- Grant privileges
GRANT ALL PRIVILEGES ON . TO 'root'@'localhost' IDENTIFIED BY 'z123';
FLUSH PRIVILEGES;