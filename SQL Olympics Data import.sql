-- Importing large data more than lakhs of rows

-- 1. Create the table athletes
create table athletes(
	Id int,
    Name varchar(200),
    Sex char(1),
    Age int,
    Height float,
    Weight float,
    Team varchar(200),
    NOC char(3),
    Games varchar(200),
    Year int,
    Season varchar(200),
    City varchar(200),
    Sport varchar(200),
    Event varchar(200),
    Medal Varchar(50));

-- View the blank Athletes table
select * from athletes;

-- Location to add the csv
SHOW VARIABLES LIKE "secure_file_priv";

-- Load the data from csv file after saving to above location
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv'
into table athletes
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- View the table
select * from athletes;

-- Check number of rows in the table
select count(*) from athletes;

-- Q1. Show how many medal counts present for entire data.
select Medal,count(Medal) as medalcount
from athletes
group by Medal;

-- Q2. Show count of unique Sports are present in olympics.
select distinct Sport,count(Sport) as sportcount
from athletes
group by Sport;

-- Q3. Show how many different medals won by Team India in data.
select *
from athletes
where Team='India' and Medal<>'NoMedal';

-- Q4. Show event wise medals won by india show from highest to lowest medals won in order.
select Event,Team,Medal
from athletes
where Team='India' and Medal<>'NoMedal'
order by Medal desc;

-- Q5. Show event and yearwise medals won by india in order of year.
select Team,event,year,medal
from athletes
where team='india'  and Medal<>'NoMedal'
order by Year;


-- Q6. Show the country with maximum medals won gold, silver, bronze
select noc,team,medal,event
from athletes
where Medal<>'nomedal'
order by medal desc;

-- Q7. Show the top 10 countries with respect to gold medals
select team,noc,medal
from athletes
where medal='Gold'
limit 10;

-- Q8. Show in which year did United States won most medals
select team,year, count(medal) as countmedal
from athletes
where team='united states' and medal<>'nomedal'
group by team,year
order by countmedal desc
limit 1;

-- Q9. In which sports United States has most medals
select team,sport,count(medal) as countmedal
from athletes
where team='united states' and medal<>'nomedal'
group by team,Sport
order by countmedal desc
limit 5;


-- Q10. Find top 3 players who have won most medals along with their sports and country.
select name,sport,medal,team ,count(medal) as countmedal
from athletes
where medal<>'Nomedal'
group by name,sport,medal,team
order by countmedal desc
limit 3;


-- Q11. Find player with most gold medals in cycling along with his country.
select Name,sport,team,medal,count(medal) as countmedal
from athletes
where sport='Cycling' and medal<>'nomedal'
group by name,sport,team,medal
order by countmedal desc
limit 1;

-- Q12. Find player with most medals (Gold + Silver + Bronze) in Basketball also show his country.
