---------------------------------------------------FELIPE HENRIQUE DA SILVA -----------------------------------------------------------------

--Tasks :
 /* 
 --------------------------------------------------------------------------------------------------------------------------------
1) Create query to update column transfered_to to �Invalid_destination� in Storage table if transferred_to column is equal 100.
----------------------------------------------------------------------------------------------------------------------------------
 */
UPDATE storage
SET transfered_to = 'Invalid_destination'
WHERE transfered_to = '100';

 /**
 --------------------------------------------------------------------------------------------------------------------------------
2) Create query to select all products of Dell manufacturer. 
----------------------------------------------------------------------------------------------------------------------------------
 */
SELECT * 
FROM product
WHERE maker = 'Dell';
 /* 
---------------------------------------------------------------------------------------------------------------------------------
3) Create query to delete rows from Storage table that have value �Invalid_destination� in transfered_to column.
----------------------------------------------------------------------------------------------------------------------------------
 */
DELETE FROM storage
WHERE transfered_to = 'Invalid_destination';

 /* 
---------------------------------------------------------------------------------------------------------------------------------
4) Create query to select most expensive product for every maker. Output should have maker, product model and price.
----------------------------------------------------------------------------------------------------------------------------------
 */

SELECT 	maker,
		model,
		price

FROM (

            SELECT maker,model,price,
            ROW_NUMBER() OVER(PARTITION BY maker ORDER BY price DESC ) AS rn
            
            FROM (
            
                    SELECT  a.maker,a.model, b.price
                    FROM product  a
                    INNER JOIN printer b
                    ON a.model =b.model
                    
                    union
                    
                    SELECT  a.maker,a.model, b.price
                    FROM product  a
                    INNER JOIN laptop b
                    ON a.model =b.model
                    
                    union
                    
                    SELECT  a.maker,a.model, b.price
                    FROM product  a
                    INNER JOIN pc b
                    ON a.model =b.model
            )
            
            
            ORDER BY price DESC
)

WHERE RN = 1;

 /* 
---------------------------------------------------------------------------------------------------------------------------------
5) Create query to select overall amount of laptops that Hitachi manufactures.
----------------------------------------------------------------------------------------------------------------------------------
 */
SELECT count(*) as laptop_hitachi_amount
FROM PRODUCT
WHERE  type = 'laptop'
and maker = 'Hitachi';

 /* 
---------------------------------------------------------------------------------------------------------------------------------
6) Create query to select all devices ordered from most expensive ones to cheapest. Output should have serial number, maker, price, type.
----------------------------------------------------------------------------------------------------------------------------------
 */

SELECT b.serial_number,
	   a.maker,
	   b.price as price,
       a.type
FROM product a 
INNER JOIN printer b
ON a.model = b.model

union

SELECT b.serial_number,
       a.maker,
       b.price as price,
       a.type
FROM product a 
INNER JOIN laptop b
ON a.model = b.model

union

SELECT b.serial_number,
       a.maker,
       b.price as price,
       a.type
FROM product a 
INNER JOIN pc b
ON a.model = b.model

ORDER BY price DESC;
 /* 
---------------------------------------------------------------------------------------------------------------------------------
7) Create query to select makers that make more printers than pc\laptops.

---------------------------------------------------------------------------------------------------------------------------------
 */ 
 SELECT DISTINCT (maker) FROM 
 ( 
								  SELECT  maker,
										 CASE maker 
																   WHEN 'Hitachi' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'Hitachi'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					   )
																   
																	WHEN 'Dell' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'Dell'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					   )           
																   
																	WHEN 'Dell' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'Dell'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					  )
																	WHEN 'HP' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'HP'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					) 
																	WHEN 'HP' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'HP'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					) 
																	WHEN 'Lenovo' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'Lenovo'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					) 
																	WHEN 'IBM' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'IBM'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					) 
																	WHEN 'Kyocera' THEN (
																   
																						   select type from (
																											   select  type,count(*)
																											   from product
																											   where maker = 'Kyocera'
																											   --and ROWNUM = 1
																											   group by type
																											)
																							where ROWNUM = 1    
																					) 
															   
																   ELSE 'error-maker' END AS highest_amount_type
								  FROM product 
  )
  WHERE highest_amount_type ='printer';

/* 
---------------------------------------------------------------------------------------------------------------------------------
8) Create query to select most expensive PC without CD drive for makers who manufacture only PCs. Output should have serial_number, maker, price.
----------------------------------------------------------------------------------------------------------------------------------
 */
SELECT serial_number, 
       maker, 
       price


FROM ( SELECT 	b.serial_number AS serial_number, 
				a.maker AS maker, 
				b.price AS price,
				b.cd AS CD
        FROM product a
        INNER JOIN pc b
        ON  a.model = b.model
        
        WHERE
				 a.maker   not in (select maker from product where type <>'pc')
				 and b.cd is null
				 and PRICE = (SELECT MAX (PRICE) FROM (
														SELECT b.price AS price
														FROM product a
														INNER JOIN pc b
														ON  a.model = b.model
														WHERE
														a.maker   not in (select maker from product where type <>'pc')
														and b.cd is null
													))
      
      );
      
      
      
 /* -------------------------------------------------------------------------------------------------------------------------------------------
 9) Write an SQL function that returns the cheapest computer (PC or laptop) based on three
characteristics: speed, ram and hd. The function will accept as input parameters: speed, ram,
hd. The function will return: type, maker, serial_number, speed, ram, hd and price.
In case there are two computers with the same price, the function can return any one with no
specific priority.
 -----------------------------------------------------------------------------------------------------------------------------------------------
 */
 
 
 
    
    

SELECT  * FROM (

					SELECT 
							a.type AS TYPE,
							a.maker AS MAKER ,
							b.serial_number AS SERIAL_NUMBER,
							b.speed AS SPEED,
							b.ram AS RAM, 
							b.hd AS HD,
							b.price AS PRICE
					FROM product a
					INNER JOIN pc b
					ON a.MODEL = b.MODEL
					WHERE   b.speed= (SELECT MAX(speed)  FROM pc)
							AND b.ram = (SELECT MAX(ram) FROM pc )
							AND b.hd = (SELECT MIN(hd) FROM pc)


					union all

					SELECT 
							c.type AS TYPE,
							c.maker AS MAKER ,
							d.serial_number AS SERIAL_NUMBER,
							d.speed AS SPEED,
							d.ram AS RAM, 
							d.hd AS HD,
							d.price AS PRICE
					FROM product c
					INNER JOIN laptop d
					ON c.MODEL = d.MODEL
					WHERE 	d.speed= (SELECT MAX(speed) FROM laptop)
							AND d.ram = (SELECT MAX(ram) FROM laptop )
							AND d.hd = (SELECT MIN(hd) FROM laptop)

)
ORDER BY price;
----------------------------------------------------------------------------------------------------------------------------------------------------