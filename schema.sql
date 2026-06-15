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