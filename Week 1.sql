

--Week 1 Sql Assignment Chris Fenton


--1.

SELECT COUNT(*) FROM FLIGHTS;

--Answer 336,776

--2.

SELECT carrier,
count(*) AS "Total Flights"
FROM flights
GROUP BY carrier
ORDER BY "Total Flights" DESC;

/*Answer

"UA";58665
"B6";54635
"EV";54173
"DL";48110
"AA";32729
"MQ";26397
"US";20536
"9E";18460
"WN";12275
"VX";5162
"FL";3260
"AS";714
"F9";685
"YV";601
"HA";342
"OO";32
*/

--3.

SELECT carrier,
count(*) AS "Total Flights"
FROM flights
GROUP BY carrier
ORDER BY "Total Flights" DESC;

/*Answer

"UA";58665
"B6";54635
"EV";54173
"DL";48110
"AA";32729
"MQ";26397
"US";20536
"9E";18460
"WN";12275
"VX";5162
"FL";3260
"AS";714
"F9";685
"YV";601
"HA";342
"OO";32
*/

--4.

SELECT carrier,
count(*) AS "Total Flights"
FROM flights
GROUP BY carrier
ORDER BY "Total Flights" DESC
LIMIT 5;

/*Answer

"UA";58665
"B6";54635
"EV";54173
"DL";48110
"AA";32729

*/

--5.

SELECT carrier,
count(*) AS "Total Flights"
FROM flights
WHERE distance > 1000
GROUP BY carrier
ORDER BY "Total Flights" DESC
LIMIT 5;

/*Answer

"UA";41135
"B6";30022
"DL";28096
"AA";23583
"EV";6248

*/

--6. Question: What are the 6 most popular destinations?

SELECT dest,
count(*) AS "Total Flights"
FROM flights
GROUP BY dest
ORDER BY "Total Flights" DESC
LIMIT 6;


/* Answer

"ORD";17283
"ATL";17215
"LAX";16174
"BOS";15508
"MCO";14082
"CLT";14064

*/



