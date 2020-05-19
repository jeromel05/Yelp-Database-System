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

--Query 1: What is the average review count over all the users ? 
Select 
	AVG(Review_Count)
FROM
	Users

--Query 2: How many businesses are in the provinces of Québec and Alberta?
SELECT 
    count(*)
FROM 
    Business B, Postal_code P
WHERE   
    P.postal_code_id = B.postal_code_id AND (P.state = 'AB' OR P.state = 'QC');


--Query 3: What is the maximum number of categories assigned to a business? Show the business name and the
--        previously described count.
-- select first for improved version
select count(cat_id) as cat_count,business_id from category group by business_id order by cat_count desc fetch first 1 rows only;

-- another way
-- with catcnt(businessId, catCnt) as
-- (
-- select count(cat_id) as cat_count,business_id from category_map group by business_id 
-- )
-- select businessID, catCnt from catcnt where catCnt = (select max(catCnt) from catCnt)

--Query 4: How many businesses are labelled as "Dry Cleaners" or “Dry Cleaning”?
Select 
 	Count(Business_id) 
From 
	Category_map mapi , CATEGORY cat
Where 
mapi.cat_id = cat.cat_id and mapi.cat_name = 'dry cleaning' or mapi.cat_name = 'dry cleaners'

--Query 5: Find the overall number of reviews for all the businesses that have more than 150 reviews and least any 2 dietary restriction categories
-- indexing to speed up
SELECT
	SUM(Review_Count)
FROM 
	Business B,
	Attr_DietaryRestrictions A
where
	B.Review_Count > 150 AND B.Business_id IN ( Select business_id from Attr_DietaryRestrictions 
    group by business_id having count(business_id)>1)

---Query 6
with userFriends(friendsCnt, userId) as
(
(select count(*) as countV, user_id1 as user_id from friends group by (user_id1))
UNION
(select count(*) as countV, user_id2 as user_id from friends group by (user_id2)) 
)
select friendsCnt, userId from userFriends order by friendsCnt desc FETCH FIRST 10 ROWS ONLY;

--Query 7: Show the business name, number of stars, and the business review count of the top-5 businesses based
--         on their review count that are currently open in the city of San Diego.
--issue with the null values in the Postal_code table 

Select
	Name, Stars, Review_Count
FROM  
	Business B, Postal_code P
where
    B.is_open = 1 AND P.city= 'San diego' AND B.postal_code_id = P.postal_code_id order by Review_Count DESC fetch first 5 rows only
 

--Query 8: Show the state name and the number of businesses for the state with the highest number of businesses.

SELECT
    State,
    COUNT(Business_id) as compte
FROM
    Postal_code P, Business B
Where B.postal_code_id = P.postal_code_id
GROUP BY P.State order by compte DESC fetch first 1 rows only 

--Query 9: Find the total average of “average star” of elite users, grouped by the year in which they started to be
--         elite users. Display the required averages next to the appropriate years.
select Star_table.elite_year, avg(Star_table.stars) as avg_stars_for_the_year 
from (select A.e_year as elite_year, U.avg_stars as stars 
    from (select user_id, min(elite_year) as e_year from elite group by (user_id)
        )A
    join users U on U.user_id=A.user_id
)Star_table group by (Star_table.elite_year)

--Query 10: List the names of the top-10 businesses based on the median “star” rating, that are currently open in the
--          city of New York.

Select name 
from Business B
Where B.is_open = 1 and Business_id IN (
Select 
	Business_id
From 
	Reviews 
Group by 
	Business_id
Order by 
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY stars DESC) fetch first 10 rows only )								

--Query 11: Find and show the minimum, maximum, mean, and median number of categories per business.
--			Show the final statistic (4 numbers respectively, aggregated over all the businesses)  

SELECT
AVG(COUNT(cat_id)) AS averages,
MAX(COUNT(cat_id)) AS maxi,
MIN(COUNT(cat_id)) AS mini ,
PERCENTILE_CONT(0.5)WITHIN GROUP(ORDER BY COUNT(cat_id) DESC) as medianito
FROM
Category cat
group by cat.business_id


--Query 12: Find the businesses (show 'name', 'stars', 'review count') in the city of Las Vegas possessing 'valet' parking
--          and open between '19:00' and '23:00' hours on a Friday.

SELECT name,stars, review_count 
FROM business b 
JOIN postal_code p 
ON (b.postal_code_id = p.postal_code_id) 
JOIN attr_businessparking a 
ON (a.business_id = b.business_id)
JOIN open_at o
ON (o.business_id = b.business_id)
where p.city = 'Las Vegas' 
AND a.sub_attr_id = 1 
AND o.day_id=5 
AND o.hours_id <= 19*60000 
AND MOD(o.hours_id , 10000) >= 23*60;


--------------------------------- DELIVERABLE 3 ------------------------
-- Query 1: . What is the total number of businesses in the province of Ontario that have at least 6 reviews and a
--            rating above 4.2?

Select 
    count(Business_id) as total 
from 
    Business B,
    Postal_Code P
Where 
    B.Postal_Code_id = P.postal_code_id and P.State= 'ON' and review_count > 5 and stars > 4.2

--Query 2: What is the average difference in review scores for businesses that are considered "good for dinner" that have noise levels "loud" or "very loud", ---        compared to ones with noise levels "average" or "quiet"?
SELECT BB2.avg_star - BB1.avg_star
FROM
    (SELECT  AVG(B1.stars) as avg_star
        FROM business B1 JOIN attr_goodformeal G1 ON b1.business_id=g1.business_id JOIN attr_noiselevel N1 ON b1.business_id=n1.business_id  
        where g1.sub_attr_id IN (SELECT sub_attr_id FROM attr_goodformeal_map WHERE sub_attr_name like 'dinner') 
        AND n1.sub_attr_id IN (SELECT sub_attr_id FROM attr_noiselevel_map WHERE sub_attr_name like '%loud')
    )BB1,
    (SELECT  AVG(B1.stars) as avg_star
     FROM business B1 JOIN attr_goodformeal G1 ON b1.business_id=g1.business_id JOIN attr_noiselevel N1 ON b1.business_id=n1.business_id  
     where g1.sub_attr_id IN (SELECT sub_attr_id FROM attr_goodformeal_map WHERE sub_attr_name like 'dinner') 
     AND (n1.sub_attr_id IN (SELECT sub_attr_id FROM attr_noiselevel_map WHERE sub_attr_name like 'average') 
     OR n1.sub_attr_id IN (SELECT sub_attr_id FROM attr_noiselevel_map WHERE sub_attr_name like 'quiet')  
    ))BB2;
    


--Query 3: List the “name”, “star” rating, and “review_count” of the businesses that are tagged as “Irish Pub” and offer “live” music.

SELECT name,stars,review_count FROM business b JOIN attr_music m ON b.business_id = m.business_id 
JOIN category c ON b.business_id = c.business_id 
WHERE m.sub_attr_id IN (SELECT sub_attr_id FROM attr_music_map WHERE sub_attr_name like 'live') 
AND c.cat_id IN (SELECT cat_id FROM category_map WHERE cat_name like 'irish pub');

--Query 4 : Find the average number of attribute “useful” of the users whose average rating falls in the following 2
-           ranges: [2-4), [4-5]. Display separately these results for elite users vs. regular users (4 values total).

-- should iimplement a different query for elite and regular users
Select  avg(review_count) as avgEL24_avgEL45_avgreg24_avgreg45
From 
    Users U , Elite E 
where 
U.user_id = E.user_id and U.avg_stars >= 2 and U.avg_stars <4  union
Select  avg(review_count)  
From 
    Users U , Elite E 
where 
U.user_id = E.user_id and  U.avg_stars>=4 and U.avg_Stars <= 5 union
Select  avg(review_count) 
From 
    Users U left join Elite E on U.user_id = E.user_id 
where 
E.user_id is null and U.avg_stars >= 2 and U.avg_stars <4  union
Select  avg(review_count) 
From 
    Users U left join Elite E on U.user_id = E.user_id
where 
 E.user_id is null and U.avg_stars>=4 and U.avg_stars <= 5



--Query 5: Find the average rating and number of reviews for all businesses which have at least two categories and more than (or equal to) one parking type.

SELECT
    AVG(B.stars) as average_rating, AVG(B.review_count) as average_review_count
FROM
    Business B
WHERE
    B.Business_id IN(SELECT business_id FROM attr_businessparking
        group by business_id having count(business_id)>=1)
    AND B.Business_id IN(SELECT business_id FROM Category
        group by business_id having count(business_id)>1)
        

--Query 6: What is the fraction of businesses (of the total number of businesses) that are considered "good for late night meals"?

SELECT A.late_meal_count/B.total_count, A.late_meal_count,B.total_count FROM
(SELECT DISTINCT COUNT(*) AS late_meal_count  
FROM business b JOIN attr_goodformeal a ON b.business_id = a.business_id  
WHERE a.sub_attr_id IN ( SELECT sub_attr_id FROM attr_goodformeal_map where sub_attr_name like 'latenight%' )
)A
JOIN
(SELECT count(*) as total_count from business)B ON 1=1;

--Query 7 : Find the names of the cities where all businesses are closed on Sundays 

Select q2.city
from 
(Select 
    city, Count(B.business_id) as closed 
from
   Business B Inner Join Open_at O on O.business_id=B.Business_id  Inner join Postal_code P on P.postal_code_id
   =B.postal_code_id 
Where  
    O.Day_id!=0
group by 
    city ) q1
inner join (Select 
    city, Count(B.business_id) as total 
from
   Business B Inner Join Open_at O on O.business_id=B.Business_id  Inner join Postal_code P on P.postal_code_id
   =B.postal_code_id 
group by 
    city )q2  on (q1.closed = q2.total and q1.city=q2.city)


--Query 8: Find the ids of the businesses that have been reviewed by more than 1030 unique users.

SELECT
    R.Business_id
FROM
    Reviews R
    GROUP BY Business_id having COUNT(DISTINCT(user_id))> 1030;
    

--Query 9: Find the top-10 (by the number of stars) businesses (business name, number of stars) in the state of California.
                     
SELECT * FROM business WHERE business.postal_code_id IN (SELECT postal_code_id FROM POSTAL_CODE WHERE state='CA') 
ORDER BY business.stars desc FETCH FIRST 10 ROWS ONLY;
                     

--Query 10 : Find the top-10 (by number of stars) ids of businesses per state. Show the results per state, in a
-            descending order of number of stars

   WITH TOPTEN AS (
   SELECT Business_id, state, ROW_NUMBER() 
    over (
        PARTITION BY state
        order by stars
    ) AS rank
    from Business B left join Postal_code P on B.postal_code_id= P.postal_code_id
)
SELECT * from TOPTEN WHERE rank <= 10

SELECT Business_id, city, ROW_NUMBER() 
    over (
        PARTITION BY city
        order by review_count   
    ) as rank
    from Business B inner join Postal_code P on B.postal_code_id= P.postal_code_id
    where rank <=100


--Query 11: Find and display all the cities that satisfy the following: each business in the city has at least two reviews.

SELECT
    Distinct(p.city)
FROM
    Business B
    LEFT JOIN Postal_code P ON (b.postal_code_id = p.postal_code_id)
WHERE
    b.business_id IN(SELECT business_id FROM Reviews
        group by business_id having count(business_id)>1);


--Query 12: Find the number of businesses for which every user that gave the business a positive tip (containing 'awesome') has also given some business a positive tip within the previous day.
                     
SELECT COUNT(*) FROM
(SELECT A.business_id as bid, count(*) as positive_count  FROM
(SELECT CAST(posted_date AS DATE) as first_date, business_id ,user_id, tip_id FROM tips where UPPER(tip_text) like '%AWESOME%')A 
INNER JOIN (SELECT posted_date-1 AS prv_date ,user_id, tip_id FROM tips where UPPER(tip_text) like '%AWESOME%')  B 
ON A.first_date=B.prv_date AND A.user_id=B.user_id group by A.business_id)C 
INNER JOIN (SELECT count(*) as full_count,business_id FROM tips where UPPER(tip_text) like '%AWESOME%' group by business_id) D on D.business_id=C.bid AND D.full_count=C.positive_count
;

--- 13. Find the maximum number of different businesses any user has ever reviewed
Select 
    count( Distinct Business_id) as reviewed
from
    Reviews R
group by 
    User_id
order by reviewed DESC fetch first 1 rows only 
                    
--Query 14: What is the difference between the average useful rating of reviews given by elite and non-elite users?
#Takes a long time

# by wenuka
--15 - List the name of the businesses that are currently 'open', possess a median star rating of 4.5 or above, considered good for 'brunch', and open on weekends.
SELECT DISTINCT name 
FROM business b 
JOIN attr_goodformeal a ON b.business_id = a.business_id  
JOIN open_at o ON (o.business_id = b.business_id)
where b.stars >= 4.5
AND b.is_open > 0
AND a.sub_attr_id IN ( SELECT sub_attr_id FROM attr_goodformeal_map where sub_attr_name like 'brunch%' )
AND (o.day_id=6 OR o.day_id=0)

--Query 15: List the name of the businesses that are currently 'open', possess a median star rating of 4.5 or above, considered good for 'brunch', and open on weekends.

SELECT
    Distinct(b.name)
FROM
    Business B, attr_goodformeal G, attr_goodformeal_map GM, Open_at O
WHERE
    b.is_open = 1
    AND b.stars >= 4.5
    AND b.business_id = g.business_id
    AND g.sub_attr_id = gm.sub_attr_id
    AND gm.sub_attr_name = 'brunch'
    AND b.business_id = O.business_id
    AND o.day_id IN (0,6);

    --16    List the 'name', 'star' rating, and 'review_count' of the top-5 businesses in the city of 'los angeles' based
--      on the average 'star' rating that serve both 'vegetarian' and 'vegan' food and open between '14:00' and
--      '16:00' hours. Note: The average star rating should be computed by taking the mean of 'star' ratings
--      provided in each review of this business.


--Query 17: Compute the difference between the average 'star' ratings (use the reviews for each business to compute its average star rating) of businesses considered 'good for dinner' with a (1) "divey" and (2) an "upscale" ambience.

SELECT AVG(rd.stars) - AVG(ru.stars)

FROM Reviews RD, Reviews RU, attr_ambience A1, attr_ambience A2, attr_goodformeal G1, attr_goodformeal G2

WHERE
    g1.business_id = rd.business_id
    AND g2.business_id = ru.business_id
    AND a1.business_id = rd.business_id
    AND a2.business_id = ru.business_id
    AND g1.sub_attr_id IN ( SELECT sub_attr_id FROM attr_goodformeal_map where sub_attr_name like 'dinner%')
    AND g2.sub_attr_id IN ( SELECT sub_attr_id FROM attr_goodformeal_map where sub_attr_name like 'dinner%')
    AND a1.sub_attr_id IN ( SELECT sub_attr_id FROM attr_ambience_map where sub_attr_name like 'divey%')
    AND a2.sub_attr_id IN ( SELECT sub_attr_id FROM attr_ambience_map where sub_attr_name like 'upscale%');
    

--18- Find the number of cities that satisfy the following: the city has at least five businesses and each of the top-5 (in terms of number of reviews) businesses in the city has a minimum of 100 reviews.
SELECT count(*) from 
(SELECT count(*) from 
(SELECT business_id,review_count,postal_code_id from business where review_count >=100)A
join postal_code p on (p.postal_code_id = A.postal_code_id) group by p.city having count(*)>=5)B
;


--19    Find the names of the cities that satisfy the following: the combined number of reviews for the top-100
--      (by reviews) businesses in the city is at least double the combined number of reviews for the rest of the
--      businesses in the city.

with top100 as ( select city,sum(review_count) as sumtop from
   (SELECT Business_id,review_count, city, ROW_NUMBER() 
    over (
        PARTITION BY city
        order by review_count   
    ) as rank
    from Business B inner join Postal_code P on B.postal_code_id= P.postal_code_id)
    where rank <=100 group by city
),
bottom as ( select city,sum(review_count) as sumrest from
   (SELECT Business_id,review_count, city, ROW_NUMBER() 
    over (
        PARTITION BY city
        order by review_count   
    ) AS rank
    from Business B inner join Postal_code P on B.postal_code_id= P.postal_code_id  
    ) where rank>100 group by city) 
    
select * from top100 topo inner join bottom botto on topo.city=botto.city and topo.sumtop>=botto.sumrest*2

    

--Query 20: For each of the top-10 (by the number of reviews) businesses, find the top-3 reviewers by activity among those who reviewed the business. Reviewers by activity are defined and ordered as the users that have the highest numbers of total reviews across all the businesses (the users that review the most).
#incomplete 

SELECT U.user_id, U.review_count
FROM Business B, Reviews R
LEFT JOIN Users U ON(U.user_id = R.user_id)

WHERE
    R.business_id = B.business_id
    AND B.business_id IN (  SELECT business_id 
                        FROM (SELECT b1.business_id FROM Business B1 ORDER BY b1.review_count DESC)
                        WHERE ROWNUM < 11)
    AND U.user_id IN(   SELECT user_id 
                        FROM (SELECT u3.user_id FROM Users U3 ORDER BY u3.review_count DESC)
                        WHERE ROWNUM < 4);

-- Query 20 by Wenuka
SELECT DISTINCT R.user_id, u.review_count 
from reviews R 
JOIN users U on R.user_id = U.user_id 
where business_id IN (SELECT b1.business_id FROM Business B1 ORDER BY b1.review_count DESC FETCH FIRST 10 ROWS ONLY) 
ORDER BY u.review_count DESC FETCH FIRST 3 ROWS ONLY
;
    
    
    




