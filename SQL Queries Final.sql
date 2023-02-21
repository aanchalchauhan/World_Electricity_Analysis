USE WEA;
---Ques1--------------
SELECT Country_Name, Years, Value as Total_Elec_Access FROM TotalA T
WHERE Years > 2000
ORDER BY Years ASC;

---Ques2--------------
SELECT L.Country_Name, L.Years, AVG(L.Value) as Avg_Trans_Loss, AVG(TA.Value) as Avg_Access_Elec FROM LossesA L
JOIN TotalA TA ON L.Country_Code = TA.Country_Code
AND L.Years = TA.Years
WHERE L.Years >= 2000 
GROUP BY L.Years,L.Country_Name;

---Ques3--------------
SELECT Country_Name,Years, Value as Country_Avg, AVG(Value) OVER (PARTITION BY Years) as World_Avg FROM TotalA
ORDER BY Years;

---Ques4--------------
SELECT Years, COUNT(Country_Name) as Count_of_countries FROM RuralA as R
WHERE Value >= 75
GROUP BY Years;

---Ques5--------------
SELECT N.Years,MN.Region, MN.IncomeGroup, SUM(Value) as Sum_Nuc_Prod FROM NuclearA N JOIN Metadata_Nuclear  MN 
ON N.Country_Code = MN.Country_Code
WHERE (MN.Region is NOT NULL) AND (MN.IncomeGroup is NOT NULL) AND (Value != 0)
GROUP BY MN.Region, MN.IncomeGroup, N.Years;

---Ques6--------------
SELECT MN.Region, AVG(N.Value) as Sum_Nuc_Prod, AVG(O.Value) as Sum_Oil_Prod FROM NuclearA N 
JOIN Metadata_Nuclear MN ON N.Country_Code = MN.Country_Code 
JOIN OilA O ON N.Country_Code = O.Country_Code
WHERE (MN.Region IS NOT NULL) AND (N.Value ! = 0)
GROUP BY MN.Region;

---Ques7---------------
SELECT MR.Region, SUM(R.Value) as AVG_Renew_Prod FROM RenewableA R
JOIN Metadata_Renewable MR ON R.Country_Code=MR.Country_Code
WHERE MR.Region IS NOT Null
GROUP BY MR.Region;