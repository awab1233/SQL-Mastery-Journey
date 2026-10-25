-- Data Cleanig

SELECT * FROM layoffs;

SELECT COUNT(*) FROM layoffs;
-- 1. Remove dupicates
-- 2. Standardizing the data
-- 3. Null Values
-- 4. Foramting Date columns
-- 5. Remove Any Columns
-- 6. Final table Ceanup

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
	company, location, industry, total_laid_off, percentage_laid_off, `date`, 
    stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH dupl_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
	company, location, industry, total_laid_off, percentage_laid_off, `date`, 
    stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM dupl_cte
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
	company, location, industry, total_laid_off, percentage_laid_off, `date`, 
    stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2 
WHERE row_num > 1;

SELECT * FROM layoffs_staging2
WHERE row_num > 1;

-- Standardizing Data
-- columns: company, location, industry, total_laid_off, percentage_laid_off, `date`, 
--    		stage, country, funds_raised_millions

SELECT DISTINCT(company)
FROM layoffs_staging2;

SELECT company, TRIM(company) 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);


SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1; 
-- crypto: Crypto Currency, CryptoCurrency ==> crypto

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


-- country
SELECT DISTINCT country
FROM layoffs_staging2
GROUP BY 1;
-- United States. to United States
SELECT DISTINCT country, TRIM(TRAILING '.'  FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT * FROM layoffs_staging2;

-- foramting date column
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- Musing Values: 
SELECT total_laid_off FROM layoffs_staging2
WHERE total_laid_off IS NULL;

SELECT total_laid_off, percentage_laid_off FROM layoffs_staging2
WHERE 
(total_laid_off IS NULL
OR total_laid_off = '')
AND 
(percentage_laid_off IS NULL
OR percentage_laid_off = '');

SELECT DISTINCT company FROM layoffs_staging2
WHERE company IS NULL
OR company = '';

SELECT DISTINCT location FROM layoffs_staging2
WHERE location IS NULL
OR location = '';

SELECT DISTINCT industry 
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT * FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT * FROM layoffs_staging2
WHERE company = 'Juul';

SELECT DISTINCT company, industry
FROM layoffs_staging2;

-- Assumption: We assume each company belongs to a single primary
-- industry in this dataset

SELECT t1.industry , t2.industry 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry 
WHERE (t1.industry IS NULL OR t1.industry = '')
AND NOT (t2.industry IS NULL OR t2.industry = '');



SELECT * FROM layoffs_staging2
WHERE company LIKE 'Bally%';
-- Note: Bally's Interactive remains NULL because 
-- it has no other populated rows in the dataset 
-- to join with.

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


SELECT * FROM  layoffs_staging2;
SELECT COUNT(*) FROM layoffs_staging2;