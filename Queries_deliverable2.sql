------------------------Queries for DELIVERABLE 2 ------------------------

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
select sum(friendsCnt)  as fullcount, userId  from userFriends group by userId order by fullcount desc FETCH FIRST 10 ROWS ONLY;

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
