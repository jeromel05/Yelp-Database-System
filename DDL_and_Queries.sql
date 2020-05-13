/* Entity desccriptions */

CREATE TABLE Attr_Ambience_map (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (User_id) references Users(User_id)
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id)
)

CREATE TABLE Attr_BusinessParking_map (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (User_id) references Users(User_id)
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id)
)

CREATE TABLE Attr_DietaryRestrictions_map (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (User_id) references Users(User_id)
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id)
)

CREATE TABLE Attr_GoodForMeal_map (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (User_id) references Users(User_id)
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id)
)

CREATE TABLE Attr_Music_map (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (User_id) references Users(User_id)
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id)
)

CREATE TABLE Attr_NoiseLevel_map (
    Business_id CHAR(22),
 	Sub_Attr_id INTEGER,
    PRIMARY KEY (Business_id, Sub_Attr_id),
    FOREIGN KEY (User_id) references Users(User_id)
    FOREIGN KEY (Sub_Attr_id) references Attr_Ambience(Sub_Attr_id)
)

CREATE TABLE Attr_Ambience (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_BusinessParking (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_DietaryRestrictions (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_GoodForMeal (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_Music (
    Sub_Attr_id INTEGER,
 	Sub_Attr_name VARCHAR(50),
    UNIQUE (Sub_Attr_name),
    PRIMARY KEY (Sub_Attr_id)
)

CREATE TABLE Attr_NoiseLevel (
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

CREATE TABLE Category (
    Category_id INTEGER,
 	Category_name VARCHAR(200),
    UNIQUE (Category_name),
    PRIMARY KEY (Category_id)
)

CREATE TABLE Category_map (
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
	Hours VARCHAR(8),
	Hours_id INTEGER,
	PRIMARY KEY (Hours_id)
)

CREATE TABLE Open_at (
	Business_id CHAR(22),
    Opening_hour_id INTEGER,
	Day_id INTEGER,
    Closing_hours_id INTEGER,
	PRIMARY KEY (Business_id, Opening_hour_id),
    FOREIGN KEY (Business_id) references Business(Business_id),
	FOREIGN KEY (Opening_hour_id) references Opening_hours(Hours_id),
    FOREIGN KEY (Closing_hours_id) references Opening_hours(Hours_id)
)

CREATE TABLE Postal_code (
	Postal_code_id INTEGER,
    Postal_code VARCHAR(10),
    City VARCHAR(10),
    State VARCHAR(2),
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

--Query 1: What is the average review count over all the users ? 
Select 
	AVG(Review_Count)
FROM
	Users

--Query 2: How many businesses are in the provinces of Québec and Alberta?
Select 
	Count(*)
From 
	Business B 
Where 	
	Postal_code.postal_code_id = B.postal_code_id AND Postal_Code_id.state = "AB" or Postal_code.Postal_Code_id = "QC"

--Query 3: What is the maximum number of categories assigned to a business? Show the business name and the
--        previously described count.
select count(cat_id) as cat_count,business_id from category_map group by business_id order by cat_count desc fetch first 1 rows only;

-- another way
with catcnt(businessId, catCnt) as
(
select count(cat_id) as cat_count,business_id from category_map group by business_id 
)
select businessID, catCnt from catcnt where catCnt = (select max(catCnt) from catCnt)

--Query 4: How many businesses are labelled as "Dry Cleaners" or “Dry Cleaning”?
Select 
 	Count(Distinct)
From 
	Has_Category
Group By 
	Business_id
Where cat_id = ( Select cat_id from categories cat where cat.cat_name = "Dry cleaners" OR cat.cat_name = "Dry cleaning")

--Query 5: Find the overall number of reviews for all the businesses that have more than 150 reviews and least any 2 dietary restriction categories
SELECT
	SUM (Review_Count)
FROM 
	Business B
	Attr_DietaryRestrictions A
having 
	B.Review_Count > 150 AND  B.Business_id = A.Business_id AND COUNT(A.Business_id) > 2

---Query 6
with userFriends(userId, friendsCnt) as
(
(select count(*) as countV, user_id1 as user_id from friends group by (user_id1))
UNION
(select count(*) as countV, user_id2 as user_id from friends group by (user_id2)) 
)
select count(*) as friendsCnt, userId from userFriends group by userId order by friendsCnt desc FETCH FIRST 10 ROWS ONLY;

--Query 7: Show the business name, number of stars, and the business review count of the top-5 businesses based
--         on their review count that are currently open in the city of San Diego.
Select
	Name, Stars, Review_Count
FROM  
	Business 
	has_city
Where 
	B.is_open = TRUE AND has_city.business_id = Business.business_id AND has_city.city= San Diego
Order By limit 5 
	Review_Count DESC  

--Query 8: Show the state name and the number of businesses for the state with the highest number of businesses.
-- using indexes to speed up the lookup 
SELECT
	State,
	COUNT()
FROM
	Business
GROUP BY
	State

ORDER BY LIMIT 1 
	COUNT() DESC

--Query 9: Find the total average of “average star” of elite users, grouped by the year in which they started to be
--         elite users. Display the required averages next to the appropriate years.
with eliteAvg(eliteYear, eliteCnt) as
(
select elite_year ,count(*)from elite group by (elite_year)
)
select eliteYear, avg(eliteCnt) from eliteAvg group by (eliteYear);

--Query 10: List the names of the top-10 businesses based on the median “star” rating, that are currently open in the
--          city of New York.

Select name 

from Business 

Where is_open = TRUE and Business_id IN (

Select 
	Business_id
From 
	Reviews 
Group by 
	Business_id
Order by Limit 10 
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY stars DESC)
)									

--Query 11: Find and show the minimum, maximum, mean, and median number of categories per business.
--			Show the final statistic (4 numbers respectively, aggregated over all the businesses)  
SELECT
AVG(COUNT()) AS average
MAX(COUNT()) AS maximum
MIN(COUNT()) AS minimum 
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY COUNT() DESC) 

FROM
SELECT
	Count()
FROM
	Has_Category
GROUP BY
	Business_id)
--Query 12: Find the businesses (show 'name', 'stars', 'review count') in the city of Las Vegas possessing 'valet' parking
--and open between '19:00' and '23:00' hours on a Friday.
and open between '19:00' and '23:00' hours on a Friday.
SELECT name,stars, review_count 
FROM business b 
LEFT JOIN postal_code p 
ON (b.postal_code_id = p.postal_code_id) 
LEFT JOIN attr_businessparking a 
ON (a.business_id = b.business_id)
LEFT JOIN opens_at o
ON (o.business_id = b.business_id)
where p.city = 'Las Vegas' 
AND a.sub_attr_id = 1 
AND o.day_id=5 
AND o.opening_hour_id <= 19*60 
AND o.closing_hour_id >= 23*60












