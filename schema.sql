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