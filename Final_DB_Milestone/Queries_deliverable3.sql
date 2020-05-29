------------------------Queries for DELIVERABLE 3 ------------------------

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
AND c.cat_id IN (SELECT cat_id FROM category_map WHERE UPPER(cat_name) like 'IRISH PUB');

--Query 4 : Find the average number of attribute “useful” of the users whose average rating falls in the following 2
--           ranges: [2-4), [4-5]. Display separately these results for elite users vs. regular users (4 values total).

-- should implement a different query for elite and regular users
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
                     
SELECT name,stars FROM business WHERE business.postal_code_id IN (SELECT postal_code_id FROM POSTAL_CODE WHERE state='CA') 
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
SELECT U1.avg_useful_el - U2.avg_useful_el
FROM
(SELECT AVG(re.useful) as avg_useful_el FROM Reviews RE INNER JOIN Elite E ON (re.user_id = e.user_id))U1,
(SELECT AVG(re.useful) as avg_useful_el FROM Reviews RE LEFT JOIN Elite E ON (re.user_id = e.user_id) WHERE e.user_id IS NULL)U2
;
                     
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

#by Jerome                     
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
-       on the average 'star' rating that serve both 'vegetarian' and 'vegan' food and open between '14:00' and
-       '16:00' hours. Note: The average star rating should be computed by taking the mean of 'star' ratings
-       provided in each review of this business.


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
                     
SELECT count(*) 
from (SELECT count(*) 
     from (SELECT business_id,review_count,postal_code_id from business where review_count >=100)A
      join postal_code p on (p.postal_code_id = A.postal_code_id) group by p.city having count(*)>=5)B
;


--19    Find the names of the cities that satisfy the following: the combined number of reviews for the top-100
-       (by reviews) businesses in the city is at least double the combined number of reviews for the rest of the
-       businesses in the city.

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
    