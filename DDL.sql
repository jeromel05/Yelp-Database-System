/* Entity desccriptions */

CREATE TABLE Attr_Ambience (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Attr_BusinessParking (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Attr_DietaryRestrictions (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Attr_GoodForMeal (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Attr_Music (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Attr_NoiseLevel (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Attr_Ambience_map (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_BusinessParking_map (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_DietaryRestrictions_map (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_GoodForMeal_map (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_Music_map (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_NoiseLevel_map (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Business (
    Business_id CHAR(22),
	Address VARCHAR(200),
 	Latitude REAL, 
 	Longitude REAL,
	Review_Count INTEGER,
	is_open Boolean,
	Name VARCHAR(80),
	Postal_Code_id INTEGER,
	Stars REAL, 
 	UNIQUE (Address, Postal_Code_id),
    PRIMARY KEY (Business_id),
    FOREIGN KEY (Postal_Code_id) references Postal_Code(Postal_Code_id)
)

CREATE TABLE Category_map (
    Category_id INTEGER,
 	Category_name VARCHAR(200),
    UNIQUE (Category_name),
    PRIMARY KEY (Category_id)
)

CREATE TABLE Category (
    Category_id INTEGER,
 	Business_id CHAR(22),
    PRIMARY KEY (Business_id, Category_id),
    FOREIGN KEY (Category_id) references Category(Category_id)
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Elite (
    User_id CHAR(22),
 	Elite_year INTEGER,
    PRIMARY KEY (User_id, Elite_year),
    FOREIGN KEY (User_id) references Users(User_id)
)

CREATE TABLE FRIENDS ( 
	user_id_1 CHAR(22),
	user_id_2 CHAR(22),
	PRIMARY KEY (user_id_1, user_id_2),
	FOREIGN KEY (user_id_1) references Users(User_id),
    FOREIGN KEY (user_id_2) references Users(User_id)
)

CREATE TABLE Hours (
    Opening_time VARCHAR(8), 
	Closing_time VARCHAR(8), 
	Hours_id INTEGER,
	PRIMARY KEY (Hours_id)
)

CREATE TABLE Open_at (
	Business_id CHAR(22),
    Opening_hours_id INTEGER,
	Day_id INTEGER,
	PRIMARY KEY (Business_id, Opening_hours_id),
    FOREIGN KEY (Business_id) references Business(Business_id),
	FOREIGN KEY (Opening_hours_id) references Hours(Hours_id),
)

CREATE TABLE Postal_code (
	Postal_code_id INTEGER,
    Postal_code VARCHAR(10),
    City VARCHAR(50),
    State VARCHAR(3),
	UNIQUE (Postal_code, City, State),
	PRIMARY KEY (Postal_code_id)
)

CREATE TABLE Users (
	User_id CHAR(22),
	Avg_Stars REAL, 
	Fans INTEGER, 
	Useful_Count INTEGER,
	Review_Count INTEGER,
	Yelping_Since DATETIME,
	Cool INTEGER, 
	Funny INTEGER, 
	Name CHAR (40),
    Compliment_cool INTEGER,
    Compliment_cute INTEGER,
    Compliment_funny INTEGER,
    Compliment_hot INTEGER,
    Compliment_list INTEGER,
    Compliment_more INTEGER,
    Compliment_note INTEGER,
    Compliment_photos INTEGER,
    Compliment_plain INTEGER,
    Compliment_profile INTEGER,
    Compliment_writer INTEGER,
	PRIMARY KEY (User_id)
)

/* Relationships Description) */ 

CREATE TABLE Reviews (
	Review_id CHAR(22),
	User_id CHAR(22),
	Business_id CHAR(22),
	review_text CLOB,
	stars INTEGER,
	Cool INTEGER,
	Funny INTEGER,
	Useful INTEGER,
	posted_date TIMESTAMP,
	PRIMARY KEY (Review_id),
	FOREIGN KEY (User_id) references Users(User_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)

CREATE TABLE Tips (
	Tip_id INTEGER, 
	User_id CHAR(22),
	Business_id CHAR(22),
	Tip_text CLOB,
	compliment_count INTEGER,
	posted_date TIMESTAMP,
	PRIMARY KEY (Tip_id),
	FOREIGN KEY (User_id) references Users(User_id),
    FOREIGN KEY (Business_id) references Business(Business_id)
)
