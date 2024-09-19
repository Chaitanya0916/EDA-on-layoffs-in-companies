-- Exploratory Data Analysis

Select * 
	from layoffs_stagging2;
    
    
    
    
Select max(total_laid_off),max(percentage_laid_off)
	from layoffs_stagging2;
    
    
    
    

Select * 
	from layoffs_stagging2
    where percentage_laid_off = 1
    order by funds_raised_millions desc;
    
    
    
    

Select company,sum(total_laid_off) 
	from layoffs_stagging2
    group by company
    order by 2 desc;
    
    
    

Select min(`date`),max(`date`) 
	from layoffs_stagging2;
    
    
    
Select industry,sum(total_laid_off) 
	from layoffs_stagging2
    group by industry
    order by 2 desc;
    


Select country,sum(total_laid_off) 
	from layoffs_stagging2
    group by country
    order by 2 desc;
    
    
Select year(`date`),sum(total_laid_off) 
	from layoffs_stagging2
    group by year(`date`)
    order by 1 desc;
    
    
select substring(`date`,1,7) as `month`,sum(total_laid_off)
from layoffs_stagging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc;



with Rolling_Total as
	(
		select substring(`date`,1,7) as `month`,sum(total_laid_off) as total_off
		from layoffs_stagging2
		where substring(`date`,1,7) is not null
		group by `month`
		order by 1 asc
	)
select `month`,total_off, 
sum(total_off) OVER(order by `month`) as rolling_total
from Rolling_Total;



Select COMPANY,year(`date`),sum(total_laid_off) 
	from layoffs_stagging2
    group by COMPANY,`date`
    order by COMPANY asc;
    
    
With company_year (company,years,total_laid_off) as 
(
	Select COMPANY,year(`date`),sum(total_laid_off) 
	from layoffs_stagging2
    group by COMPANY,year(`date`)
), Company_Year_Rank as 
(select * , 
dense_rank()over(partition by years order by total_laid_off desc) as ranking
 from company_year
 where years is not null
 )
select * from Company_Year_Rank
where ranking <=5;
    
    




    