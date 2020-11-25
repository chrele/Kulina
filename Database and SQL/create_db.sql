CREATE TABLE ku_user_location_type (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ku_user_location_status (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ku_user_status (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ku_order_status (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ku_product_status (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
)

CREATE TABLE ku_category(
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ku_order_detail_status(
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ku_user(
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    password_hash VARCHAR(15) NOT NULL,
    salt VARCHAR(15) NOT NULL,
    photo VARCHAR(50) NOT NULL,
    `status` INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`status`)
    REFERENCES ku_user_status(id)
);

CREATE TABLE ku_user_location(
    id INT PRIMARY KEY auto_increment,
    `type` INT NOT NULL,
    `status` INT NOT NULL,
    `user_id` INT NOT NULL,
    location GEOMETRY NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`type`)
    REFERENCES ku_user_location_type(id),
    FOREIGN KEY (`status`)
    REFERENCES ku_user_location_status(id),
    FOREIGN KEY (`user_id`)
    REFERENCES ku_user(id)
);

CREATE TABLE ku_order(
    id INT PRIMARY KEY auto_increment,
    `user_id` INT NOT NULL,
    `status` INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`)
    REFERENCES ku_user(id),
    FOREIGN KEY (`status`)
    REFERENCES ku_order_status(id)
);

CREATE TABLE ku_product(
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(100) NOT NULL,
    effective_date DATE NOT NULL,
    effective_until DATE NOT NULL,
    photo VARCHAR(100) NOT NULL,
    price DECIMAL(7,1) NOT NULL,
    `status` INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`status`)
    REFERENCES ku_product_status(id)
);

CREATE TABLE ku_product_category(
    id INT PRIMARY KEY auto_increment,
    `product_id` INT NOT NULL,
    `category_id` INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`product_id`)
    REFERENCES ku_product(id),
    FOREIGN KEY (`category_id`)
    REFERENCES ku_category(id)
);

CREATE TABLE ku_order_detail(
    id INT PRIMARY KEY auto_increment,
    `user_location_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    quantity INT NOT NULL,
    delivery_date DATE NOT NULL,
    `status` INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_location_id`)
    REFERENCES ku_user_location(id),
    FOREIGN KEY (`order_id`)
    REFERENCES ku_order(id),
    FOREIGN KEY (`product_id`)
    REFERENCES ku_product(id),
    FOREIGN KEY (`status`)
    REFERENCES ku_order_detail_status(id)
);