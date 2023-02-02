ALTER DATABASE newone SET COMPATIBILITY_LEVEL = 130;
declare @json  Nvarchar(max) = N'[{"filter":"yearly","values":["2021","2022"]},
{"filter":"monthly","values":["1","2"]},
{"filter":"daily","values":["17","19","27"]}]';

;with t1 as(
select il 
FROM OPENJSON (@json)
 with(filtere nvarchar(max) '$.filter',
      values1 nvarchar(max) '$.values' as json)
cross apply openjson(values1)
with(il nvarchar(max) '$'
) 
where filtere  = 'yearly' ),
t2 as(
 SELECT ay
FROM OPENJSON (@json)
 with(filtere nvarchar(max) '$.filter',
      values1 nvarchar(max) '$.values' as json)
cross apply openjson(values1)
with(ay nvarchar(max) '$'
) where filtere = 'monthly'),
t3 as(SELECT gun
FROM OPENJSON (@json)
 with(filtere nvarchar(max) '$.filter',
      values1 nvarchar(max) '$.values' as json)
cross apply openjson(values1)
with(gun nvarchar(max) '$'
) where filtere = 'daily')


select datetimefromparts(il,ay,gun,00,00,00,00) as date1    from t1,t2,t3order by t1.il     
	 
   