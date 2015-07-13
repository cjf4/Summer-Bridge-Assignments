--1.
--"Delays" for the purposes of this question were considered to be anything over 30 minutes.
--Only Newark provided sufficient hour data, so this data mostly reflects Newark.
--However, this can be extrapolated to the other 2 NY area airports.

--This query gets the average weather figures of delayed flights:

select  AVG(temp) as "Temp",
    AVG(dewp) as "Dew Pt",
    AVG(humid) as "humidity",
    AVG(wind_dir) as "wind direction",
    AVG(wind_speed) as "wind speed",
    AVG(wind_gust) as "wind gust",
    AVG(precip) as "precipitation",
    AVG(pressure) as "pressure",
    AVG(visib) as "visibility"
from flights
inner join weather
on flights.year = weather.year AND flights.month = weather.month
AND flights.day = weather.day AND flights.hour = weather.hour
where dep_delay > 30 AND ;

--This query gets the average weather figures of non delayed flights:

select  AVG(temp) as "Temp",
    AVG(dewp) as "Dew Pt",
    AVG(humid) as "humidity",
    AVG(wind_dir) as "wind direction",
    AVG(wind_speed) as "wind speed",
    AVG(wind_gust) as "wind gust",
    AVG(precip) as "precipitation",
    AVG(pressure) as "pressure",
    AVG(visib) as "visibility"
from flights
inner join weather
on flights.year = weather.year AND flights.month = weather.month
AND flights.day = weather.day AND flights.hour = weather.hour
where dep_delay <= 30 AND ;

--These are the average figures for delayed and non delayed flights.
--              temp    dp   humidity  wind d  wind spd  wind gust   precipitation   pressure    visibility
--Delayed      60.09   46.04   63.34   190.71  10.45        12.03       0.01        1015.95         8.67
--Non Delayed  55.27   41.19   62.05   192.19   9.35        10.76       0.00        1018.18         9.33
--Difference    4.82    4.85    1.29    -1.48   1.10        1.26        0.00        -2.23           -0.66

--Higher temperatures, a higher dew point, higher wind speeds, higher wind gusts, and lower visibility seem
--to be the weather conditions associated with NYC departure delays.

--2.
--Same assumptions as above.


select avg(planes.year) as "Average Year"
from flights
inner join planes
on flights.tailnum = planes.tailnum
where dep_delay > 30;

--The above query, looking at flights that are delayed, returns an averaga plane year of 2001.73

select avg(planes.year) as "Average Year"
from flights
inner join planes
on flights.tailnum = planes.tailnum
where dep_delay <= 30;

--The above query, looking at flights that are not delayed, returns an averaga plane year of 2001.34

--These numbers are very similar, so older planes are not more likely to be delayed.
--In fact, older planes are slightly less likely to be delayed.

--3.
--Question: What manufacturer had the highest number of delays?

select manufacturer, count(manufacturer) as "Delays"
from planes
inner join flights
on flights.tailnum = planes.tailnum
where dep_delay > 30
group by manufacturer
order by "Delays" DESC;


--Returns Embraer with 12754
