CREATE TABLE clinics (
    cid VARCHAR(50),
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50),
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount FLOAT,
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
    eid VARCHAR(50),
    cid VARCHAR(50),
    amount FLOAT,
    datetime DATETIME
);

INSERT INTO clinic_sales VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat'),
('ord-00101-00101', 'bk-08df4-h7gf', 'cnc-0100002', 12500, '2021-09-24 15:10:00', 'online');

-- 4️⃣ Expenses table
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(200),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO expenses VALUES
('exp-0100-00100', 'cnc-0100001', 'First-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100002', 'Medicines', 1200, '2021-09-24 10:00:00');
