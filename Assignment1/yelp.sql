-- 2 (a)
select name,review_count from user group by user_id,name order by review_count desc limit 1;

-- 2(b)
select business_id, name,review_count from business group by business_id order by review_count desc limit 1;

-- 2(c)
select avg(review_count) from user;

-- 2(d)
select count(*) from (select user_id,average_stars as given_avg from user) as A inner join (select user_id,avg(stars)as computed_avg from review group by user_id) as B on B.user_id=A.user_id where A.given_avg-B.computed_avg>0.5 or B.computed_avg-A.given_avg>0.5;

-- 2(e)
select((select count(user_id) from user where review_count>10)/(select count(user_id) from user))

-- 2(f)
select (select sum(length(text)))/(select count(review_id)) from review;

