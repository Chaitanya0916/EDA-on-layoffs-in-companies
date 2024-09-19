SELECT * FROM world_layoffs.layoffs;


create table layoffs_stagging like layoffs;

SELECT * FROM layoffs_stagging;

insert layoffs_stagging
select * from layoffs;

SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY COMPANY,LOCATION,INDUSTRY,TOTAL_LAID_OFF,PERCENTAGE_LAID_OFF,`DATE`,STAGE,COUNTRY,FUNDS_RAISED_MILLIONS) AS ROW_NUM
FROM layoffs_stagging;




WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY COMPANY,LOCATION,INDUSTRY,TOTAL_LAID_OFF,PERCENTAGE_LAID_OFF,`DATE`,STAGE,COUNTRY,FUNDS_RAISED_MILLIONS) AS ROW_NUM
FROM layoffs_stagging
)
select * 
from duplicate_cte
where ROW_NUM > 1;


Delete
from duplicate_cte
where ROW_NUM > 1;

ALTER TABLE `layoffs_stagging`
  ADD COLUMN `ROW_NUM` int;
  
  ALTER TABLE `layoffs_stagging`
  DROP COLUMN `ROW_NUM` INT;



DESCRIBE `layoffs_stagging`;
ALTER TABLE `layoffs_stagging`
  DROP COLUMN `ROW_NUM`;


CREATE TABLE `layoffs_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `ROW_NUM` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_stagging2;

INSERT INTO layoffs_stagging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY COMPANY,LOCATION,INDUSTRY,TOTAL_LAID_OFF,PERCENTAGE_LAID_OFF,`DATE`,STAGE,COUNTRY,FUNDS_RAISED_MILLIONS) AS ROW_NUM
FROM layoffs_stagging;



DELETE 
 FROM layoffs_stagging2
WHERE ROW_NUM>1;

SELECT * FROM layoffs_stagging2;

SET SQL_SAFE_UPDATES = 0;


-- STANDARDISING DATA


SELECT DISTINCT(company), TRIM(company) FROM layoffs_stagging2;

UPDATE layoffs_stagging2
SET company= TRIM(company);

SELECT* FROM layoffs_stagging2
WHERE INDUSTRY  like 'crypto%';


UPDATE layoffs_stagging2
SET industry= 'Crypto'
where industry like 'crypto%';

SELECT distinct(country) FROM layoffs_stagging2
order by 1;

UPDATE layoffs_stagging2
SET country= 'United States'
where country like 'United States.%';


select *
from layoffs_stagging2;


alter table layoffs_stagging2
modify column `date` date;

select *
from layoffs_stagging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_stagging2
where industry is null 
or industry ='';

select *
from layoffs_stagging2
where company like 'Bally%' 
;





select t1.industry,t2.industry from layoffs_stagging2 t1
join layoffs_stagging2 t2
on t1.company=t2.company
	and t1.location=t2.location
		where (t1.industry is null or  t1.industry ='')
        and t2.industry is not null;


update layoffs_stagging2
set industry = null
where industry ='';

update layoffs_stagging2 t1
	join layoffs_stagging2 t2
		on t1.company=t2.company
	set t1.industry = t2.industry
    where t1.industry is null 
        and t2.industry is not null;


select * from layoffs_stagging2;

select *
from layoffs_stagging2
where total_laid_off is null
and percentage_laid_off is null;


delete
from layoffs_stagging2
where total_laid_off is null
and percentage_laid_off is null;


select *
from layoffs_stagging2;

alter TABLE layoffs_stagging2
drop column ROW_NUM;

