-- Create auth_user table
CREATE TABLE auth_user (
                           id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                           username VARCHAR2(100) UNIQUE NOT NULL,
                           password VARCHAR2(255) NOT NULL,
                           role VARCHAR2(20) NOT NULL CHECK (role IN ('ADMIN', 'CUSTOMER', 'DRIVER', 'BOOKING_MANAGER', 'FINANCE_MANAGER', 'OPERATOR')),
                           status VARCHAR2(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE')),
                           name VARCHAR2(255),
                           address CLOB,
                           phone VARCHAR2(20),
                           license_number VARCHAR2(100),
                           vehicle_id NUMBER
);

-- Create vehicle table
CREATE TABLE vehicle (
                         id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                         model VARCHAR2(100),
                         numberPlate VARCHAR2(50) UNIQUE,
                         status VARCHAR2(20) CHECK (status IN ('AVAILABLE', 'BOOKED', 'MAINTENANCE')),
                         assignedDriverId NUMBER
);

-- Create reservation table
CREATE TABLE reservation (
                             id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                             customerId NUMBER NOT NULL,
                             vehicleId NUMBER NOT NULL,
                             driverId NUMBER NOT NULL,
                             startTime TIMESTAMP,
                             endTime TIMESTAMP,
                             pickupLocation CLOB,
                             destinationLocation CLOB,
                             status VARCHAR2(20) CHECK (status IN ('PENDING', 'CONFIRMED', 'CANCELLED')),
                             FOREIGN KEY (customerId) REFERENCES auth_user(id),
                             FOREIGN KEY (vehicleId) REFERENCES vehicle(id),
                             FOREIGN KEY (driverId) REFERENCES auth_user(id)
);

-- Create invoice table
CREATE TABLE invoice (
                         id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                         reservationId NUMBER NOT NULL,
                         amount DECIMAL(10,2),
                         tax DECIMAL(10,2),
                         discount DECIMAL(10,2),
                         totalAmount DECIMAL(10,2),
                         paymentStatus VARCHAR2(20) CHECK (paymentStatus IN ('PAID', 'UNPAID')),
                         issuedAt TIMESTAMP,
                         paidAt TIMESTAMP NULL,
                         FOREIGN KEY (reservationId) REFERENCES reservation(id)
);

GRANT CONNECT, RESOURCE TO MEGACITYCAB;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TRIGGER TO MEGACITYCAB;
GRANT SELECT, INSERT, UPDATE, DELETE ON auth_user TO MEGACITYCAB;
GRANT SELECT, INSERT, UPDATE, DELETE ON vehicle TO MEGACITYCAB;
GRANT SELECT, INSERT, UPDATE, DELETE ON reservation TO MEGACITYCAB;
GRANT SELECT, INSERT, UPDATE, DELETE ON invoice TO MEGACITYCAB;