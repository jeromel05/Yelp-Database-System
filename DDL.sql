/* Entity desccriptions */

CREATE TABLE Business (
    Business_id INTEGER,
 	City CHAR(30),
	Address CHAR(100),
 	Latitude REAL, 
 	Longitude REAL,
	Review_Count INTEGER,
	is_open Boolean,
	Name CHAR(30),
	Postal_Code INTEGER,
	State CHAR(2),
 	UNIQUE (Address, Postal_Code),
    PRIMARY KEY (Business_id)
)

CREATE TABLE Users (
	User_id INTEGER,
	Avg_Stars REAL, 
	Fans INTEGER, 
	Useful_Count INTEGER,
	Review_Count INTEGER,
	Yelping_Since DATETIME,
	Cool INTEGER, 
	Funny INTEGER, 
	Name CHAR (20),
	PRIMARY KEY (User_id)
)

CREATE TABLE Elite (
	User_id NOT NULL,
	Elite_year INTEGER,
    FOREIGN KEY (User_id) references Users(User_id),
	PRIMARY KEY (User_id, Elite_year)
)

/* Simply maps an nt to each of the 1000 categroy names for faster queries */
CREATE TABLE Category (
	cat_id INTEGER,
	cat_name CHAR(20),
	UNIQUE (cat_name),
	PRIMARY KEY (cat_id)
)

CREATE TABLE Opening_hours (
	hours_id INTEGER,
	days_id INTEGER,
	PRIMARY KEY (hours_id, days_id)
)

CREATE TABLE sub_attributes_map (
	attribute ENUM(BusinessParking, Music, GoodForMeal, NoiseLevel, Ambience, DietaryRestrictions),
	sub_attributes_id  INTEGER,
	sub_attributes_name char(20),
	PRIMARY KEY (attribute, sub_attributes_id),
    UNIQUE (sub_attributes_name)
) 

/* Relationships Description) */ 

CREATE TABLE Reviews (
	Review_id INTEGER,
	User_id INTEGER,
	Business_id INTEGER,
	review_text char(140),
	Cool INTEGER,
	Funny INTEGER,
	Useful INTEGER,
	posted_date DATETIME,
	PRIMARY KEY (Review_id),
	FOREIGN KEY (User_id) references User(User_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Tips (
	tip_id INTEGER, 
	User_id INTEGER,
	Business_id INTEGER,
	tip_text char(140),
	compliment_count INTEGER,
	posted_date DATETIME,
	PRIMARY KEY (tip_id),
	FOREIGN KEY (User_id) references User(User_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Has_Category (
	cat_id INTEGER,
	Business_id INTEGER,
	PRIMARY KEY (cat_id, Business_id),
    FOREIGN KEY (Business_id) references Business(Business_id),
    FOREIGN KEY (cat_id) references Category(cat_id)
)

CREATE TABLE Open_at (
	Business_id INTEGER,
	hours_id INTEGER,
	days_id INTEGER,
	PRIMARY KEY (Business_id, days_id),
    FOREIGN KEY (Business_id) references Business(Business_id),
	FOREIGN KEY (days_id) references Opening_hours(days_id),
    FOREIGN KEY (hours_id) references Opening_hours(hours_id)
)

CREATE TABLE FRIENDS ( 
	user_id_1 INTEGER,
	user_id_2 INTEGER,
	PRIMARY KEY (user_id_1, user_id_2)
	FOREIGN KEY (user_id_1) references User(User_id)
    FOREIGN KEY (user_id_2) references User(User_id))
)

CREATE TABLE Has_Attributes(
	Business_id,
	attribute ENUM ( Parking, goodForMeal,Ambiance,NOISE_LEVEL),
	sub_attribute_id INTEGER,
    PRIMARY KEY (Business_id, attribute, sub_attribute_id),
	FOREIGN KEY (Business_id references Business(Business_id))	
)














