-- ???????? ??????? queue
CREATE TABLE queue (
    id             NUMBER PRIMARY KEY,
    owner_email    VARCHAR2(255) NOT NULL,
    owner_name     VARCHAR2(255) NOT NULL,
    owner_phone    VARCHAR2(20) NOT NULL,
    vehicle_number VARCHAR2(20) NOT NULL,
    service_type   NUMBER NOT NULL,
    in_time        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    out_time       TIMESTAMP,
    status_type    NUMBER DEFAULT '1' NOT NULL,
    last_update    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ??????? ??? ?????????? last_update ? ??????? queue
CREATE OR REPLACE TRIGGER queue_update_trigger
BEFORE UPDATE ON queue
FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_TIMESTAMP;
END;
/

-- ???????? ??????? notifications
CREATE TABLE notifications (
    id           NUMBER NOT NULL,
    notification VARCHAR2(100) NOT NULL,
    timestamp    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ???????? ??????? service_type
CREATE TABLE service_type (
    id          NUMBER NOT NULL,
    type        VARCHAR2(200) NOT NULL,
    description VARCHAR2(500) NOT NULL
);

-- ??????? ?????? ? service_type
-- ??????? ?????? ? service_type
INSERT INTO service_type (id, type, description) VALUES (1, 'Car wash only', 'Only car wash');
INSERT INTO service_type (id, type, description) VALUES (2, 'Car wash and paint correction', 'Car wash and paint correction as an additional service');
INSERT INTO service_type (id, type, description) VALUES (3, 'Car wash only and Ceramic coating', 'Car wash only and Ceramic coating as an additional service');
INSERT INTO service_type (id, type, description) VALUES (4, 'Car wash and full detailing', 'Car wash and full detailing as an additional service');
INSERT INTO service_type (id, type, description) VALUES (5, 'Car wash and car wrapping', 'Car wash and car wrapping as an additional service');
INSERT INTO service_type (id, type, description) VALUES (6, 'Car wash and all above', 'Car wash and all services');


-- ???????? ??????? status_type
CREATE TABLE status_type (
    id   NUMBER NOT NULL,
    name VARCHAR2(30) NOT NULL
);

INSERT INTO status_type (id, name)
SELECT 1, 'Initialized' FROM DUAL UNION ALL
SELECT 2, 'In Progress' FROM DUAL UNION ALL
SELECT 3, 'Completed' FROM DUAL UNION ALL
SELECT 4, 'Dispatched' FROM DUAL UNION ALL
SELECT 0, 'On Hold' FROM DUAL;

-- ???????? ??????? status_updates
CREATE TABLE status_updates (
    queue_id     NUMBER NOT NULL,
    status_id    NUMBER NOT NULL,
    time         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description VARCHAR2(500) NOT NULL
);

-- ???????? ??????? users
CREATE TABLE users (
    id       NUMBER NOT NULL,
    name     VARCHAR2(200) NOT NULL,
    username VARCHAR2(200) NOT NULL,
    email    VARCHAR2(200) NOT NULL,
    password VARCHAR2(200) NOT NULL
);

-- ??????? ??? ??????? notifications
CREATE UNIQUE INDEX idx_notifications_id ON notifications (id);
CREATE INDEX idx_notifications_notification ON notifications (notification);

-- ??????? ??? ??????? queue
CREATE UNIQUE INDEX idx_queue_id ON queue (id);
CREATE UNIQUE INDEX idx_queue_vehicle_status ON queue (vehicle_number, status_type);
CREATE INDEX idx_queue_vehicle_number ON queue (vehicle_number);

-- ??????? ??? ??????? service_type
CREATE UNIQUE INDEX idx_service_type_id ON service_type (id);

-- ??????? ??? ??????? status_type
CREATE UNIQUE INDEX idx_status_type_id ON status_type (id);

-- ??????? ??? ??????? status_updates
CREATE INDEX idx_status_updates_queue_status ON status_updates (queue_id, status_id);

-- ??????? ??? ??????? users
CREATE UNIQUE INDEX idx_users_id ON users (id);

-- ??????? ?????? ? ??????? queue
/* FUNGUJE INSERT
INSERT INTO queue (id, owner_email, owner_name, owner_phone, vehicle_number, service_type, in_time, out_time, status_type)
VALUES (1, 'example@email.com', 'John Doe', '123456789', 'ABC123', 1, TO_TIMESTAMP('2023-12-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
*/

select * from queue;


