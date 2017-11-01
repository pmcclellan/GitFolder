
SELECT    CDWCustomerID
        , b.year_month
        , SUM(CASE WHEN eventID = 50010 THEN Quantity ELSE 0 END) as Targets
        , SUM(CASE WHEN eventID = 60010 THEN Quantity ELSE 0 END) as Serves
        , SUM(CASE WHEN eventID = 70010 THEN Quantity ELSE 0 END) as Activations
        , SUM(CASE WHEN eventID = 80000 THEN Quantity ELSE 0 END) as Redemptions
FROM    cdw.vFT_CustomerOfferEvent a
join 
        (
        select calendardate, year_month 
        from cdw.vDM_date b 
        where b.year_month = Year(ADD_MONTHS(current_date, -1))*100 + Month(ADD_MONTHS(current_date, -1))
        ) b
on a.eventdate = b.calendardate
WHERE   1=1
        AND InstitutionID = 7086
GROUP BY CDWCustomerID, year_month;
