-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;
-- ================================================================================
-- tables creation
-- ================================================================================
-- 1. Create Users table start
-- ================================================================================
CREATE TABLE Users (
    user_id SERIAL,
    full_name varchar(100) NOT NULL,
    email varchar(200) NOT NULL,
    role varchar(20) NOT NULL,
    phone_number varchar(20),
    CONSTRAINT pk_users PRIMARY KEY (user_id),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT chk_users_role CHECK (role IN ('Ticket Manager', 'Football Fan'))
);
-- ================================================================================
-- 1. Create Users table end
-- ================================================================================
-- ================================================================================
-- 2. Create Matches table start
-- ================================================================================
CREATE TABLE Matches (
    match_id SERIAL,
    fixture varchar(150) NOT NULL,
    tournament_category varchar(100) NOT NULL,
    base_ticket_price numeric(10, 2) NOT NULL,
    match_status varchar(20) NOT NULL,
    CONSTRAINT pk_matches PRIMARY KEY (match_id),
    CONSTRAINT chk_base_ticket_price_is_positive CHECK (base_ticket_price >= 0),
    CONSTRAINT chk_match_status CHECK (
        match_status IN (
            'Available',
            'Selling Fast',
            'Sold Out',
            'Postponed'
        )
    )
);
-- ================================================================================
-- 2. Create Matches table end
-- ================================================================================
-- ================================================================================
-- 3. Create Bookings table start
-- ================================================================================
CREATE TABLE Bookings (
    booking_id serial,
    user_id int NOT NULL,
    match_id int NOT NULL,
    seat_number varchar(20),
    payment_status varchar(20),
    total_cost numeric(10, 2) NOT NULL,
    CONSTRAINT pk_bookings PRIMARY KEY (booking_id),
    CONSTRAINT fk_bookings_user FOREIGN key (user_id) REFERENCES Users (user_id),
    CONSTRAINT fk_bookings_match FOREIGN key (match_id) REFERENCES Matches (match_id),
    CONSTRAINT uq_match_seat UNIQUE (match_id, seat_number),
    CONSTRAINT chk_total_cost_is_positive CHECK (total_cost >= 0),
    CONSTRAINT chk_payment_status CHECK (
        payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
    )
);
-- ================================================================================
-- 3. Create Bookings table end
-- ================================================================================
-- ================================================================================
-- values insertion
-- ================================================================================
-- 1. Values into Users table
-- ================================================================================
INSERT INTO Users (user_id, full_name, email, role, phone_number)
VALUES (
        1,
        'Tanvir Rahman',
        'tanvir@mail.com',
        'Football Fan',
        '+8801711111111'
    ),
    (
        2,
        'Asif Haque',
        'asif@mail.com',
        'Football Fan',
        '+8801722222222'
    ),
    (
        3,
        'Sajjad Rahman',
        'sajjad@mail.com',
        'Ticket Manager',
        '+8801733333333'
    ),
    (
        4,
        'Jannat Ara',
        'jannat@mail.com',
        'Football Fan',
        NULL
    );
-- ================================================================================
-- 2. Values into Matches table
-- ================================================================================
INSERT INTO Matches (
        match_id,
        fixture,
        tournament_category,
        base_ticket_price,
        match_status
    )
VALUES (
        101,
        'Real Madrid vs Barcelona',
        'Champions League',
        150.00,
        'Available'
    ),
    (
        102,
        'Man City vs Liverpool',
        'Premier League',
        120.00,
        'Selling Fast'
    ),
    (
        103,
        'Bayern Munich vs PSG',
        'Champions League',
        130.00,
        'Available'
    ),
    (
        104,
        'AC Milan vs Inter Milan',
        'Serie A',
        90.00,
        'Sold Out'
    ),
    (
        105,
        'Juventus vs Roma',
        'Serie A',
        80.00,
        'Available'
    );
-- ================================================================================
-- 3. Values into Bookings table
-- ================================================================================
INSERT INTO Bookings (
        booking_id,
        user_id,
        match_id,
        seat_number,
        payment_status,
        total_cost
    )
VALUES (501, 1, 101, 'A-12', 'Confirmed', 150.00),
    (502, 1, 102, 'B-04', 'Confirmed', 120.00),
    (503, 2, 101, 'A-13', 'Confirmed', 150.00),
    (504, 2, 101, NULL, NULL, 150.00),
    (505, 3, 102, 'C-20', 'Pending', 120.00);
-- ================================================================================