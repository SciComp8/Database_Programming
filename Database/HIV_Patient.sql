CREATE SCHEMA hiv;

USE hiv;

#Tables

#Recreate a lookup table
CREATE TABLE arv_type (
	PRIMARY KEY (arv_id),
    arv_id TINYINT(2) UNSIGNED AUTO_INCREMENT,
    arv_name VARCHAR(255)
);

#Recreate a baseline table with index
CREATE TABLE baseline_info (
	PRIMARY KEY (study_id),
    study_id SMALLINT(4) UNSIGNED AUTO_INCREMENT,
    age_year TINYINT(3) UNSIGNED,
    race TINYINT(1) UNSIGNED,
    baseline_arv_drug TINYINT(2) UNSIGNED,
    baseline_dna_ratio FLOAT(5, 2) UNSIGNED,
    baseline_cd4 SMALLINT(4) UNSIGNED,
    bmi FLOAT(5, 2) UNSIGNED,
    hbv TINYINT(1) UNSIGNED,
    hcv TINYINT(1) UNSIGNED,
	FOREIGN KEY (baseline_arv_drug) REFERENCES arv_type(arv_id) 
		ON UPDATE CASCADE
);
CREATE INDEX baseline_dna_index
	ON baseline_info(baseline_dna_ratio);    
CREATE INDEX baseline_arv_index
	ON baseline_info(baseline_arv_drug);
CREATE INDEX baseline_cd4_index
	ON baseline_info(baseline_cd4);

#Recreate a visit table with index
CREATE TABLE visit_info (
	PRIMARY KEY (visit_id),
    visit_id MEDIUMINT(5) UNSIGNED AUTO_INCREMENT, 
    study_id SMALLINT(4) UNSIGNED,
	visit_time TINYINT(1) UNSIGNED,
    follow_arv_drug TINYINT(2) UNSIGNED,
    follow_dna_ratio FLOAT(5, 2) UNSIGNED,
    follow_cd4 SMALLINT(4) UNSIGNED,
	FOREIGN KEY (study_id) REFERENCES baseline_info(study_id) 
		ON UPDATE CASCADE,
    FOREIGN KEY (follow_arv_drug) REFERENCES arv_type(arv_id) 
		ON UPDATE CASCADE
);
CREATE UNIQUE INDEX unique_index
	ON visit_info(study_id, visit_time);
CREATE INDEX follow_dna_index
	ON visit_info(follow_dna_ratio);
CREATE INDEX follow_arv_index
	ON visit_info(follow_arv_drug);
CREATE INDEX follow_cd4_index
	ON visit_info(follow_cd4);
    
#Trigger for baseline table
DELIMITER //

CREATE TRIGGER trigger_baseline
	BEFORE INSERT ON baseline_info
    FOR EACH ROW
BEGIN
    /*Limit age_year to values between 0 and 130*/
	IF NEW.age_year < 0 OR NEW.age_year > 130 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'Age in years should be between 0 and 130 years. Please check the value and try again.';
	END IF;
    
	/*Limit race to one of the following values: 1, 2, 3, 4, 5, 6*/
	IF NEW.race <> 1 AND NEW.race <> 2 AND NEW.race <> 3 AND NEW.race <> 4 AND NEW.race <> 5 AND NEW.race <> 6 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'The value for race can only take one of the following values: 1, 2, 3, 4, 5, 6.';
	END IF;
    
    /*Limit baseline_cd4 to integers between 0 and 1500.*/
	IF NEW.baseline_cd4 < 0 OR NEW.baseline_cd4 > 1500 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'Please enter the integer value of CD4+T cell level between 0 and 1500.';
	END IF;
    
    /*Limit bmi to positive values less than or equal to 300.*/
	IF NEW.bmi <= 0 OR NEW.bmi > 300 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'You have entered an invalid body mass index. Please enter a positive value less than or equal to 300.00 kg/m2.';
	END IF;
    
	/*Limit hbv to values of 1 or 2*/
	IF NEW.hbv <> 1 AND NEW.hbv <> 2 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'The value for hbv can only take values of 1 or 2.';
	END IF;
    
	/*Limit hcv to values of 1 or 2*/
	IF NEW.hcv <> 1 AND NEW.hcv <> 2 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'The value for hcv can only take values of 1 or 2.';
	END IF;
	
END//

#Trigger for visit table
DELIMITER //

CREATE TRIGGER trigger_visit
	BEFORE INSERT ON visit_info
    FOR EACH ROW
BEGIN
	/*Limit visit_time to one of the following values: 1, 2, 3, 4*/
	IF NEW.visit_time <> 1 AND NEW.visit_time <> 2 AND NEW.visit_time <> 3 AND NEW.visit_time <> 4 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'The value for visit_time can only take one of the following values: 1, 2, 3, 4.';
	END IF;
    
    /*Limit follow_cd4 to integers between 0 and 1500.*/
	IF NEW.follow_cd4 < 0 OR NEW.follow_cd4 > 1500 THEN 
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'Please enter the integer value of CD4+T cell level between 0 and 1500.';
	END IF;
	
END//

#Enter data into lookup table
INSERT INTO arv_type (arv_name)
	VALUES
    ('efavirenz'),
    ('lamivudine'),
    ('zidovudine'),
    ('stavudine'),
    ('tenofovir'),
    ('nevirapine'),
    ('lopinavir/ritonavir'),
    ('abacavir'),
    ('emtricitabine'),
    ('doravirine'),
    ('etravirine'),
    ('rilpivirine'),
    ('atazanavir'),
    ('darunavir'),
    ('fosamprenavir'),
    ('saquinavir'),
    ('tipranavir'),
    ('enfuvirtide'),
    ('maraviroc'),
    ('cabotegravir'),
    ('ibalizumab-uiy'),
    ('cobicistat');
    
#Enter data into baseline table
INSERT INTO baseline_info (age_year, race, baseline_arv_drug, baseline_dna_ratio, baseline_cd4, bmi, hbv, hcv)
	VALUES
    (22, 1, 3, 2.56, 367, 23.23, 2, 2),
    (47, 3, 9, 5.78, 678, 25.00, 2, 2),
    (77, 5, 5, 1.09, 233, 16.78, 1, 1);
    
#Enter data into visit table
INSERT INTO visit_info (study_id, visit_time, follow_arv_drug, follow_dna_ratio, follow_cd4)
	VALUES
    (1, 1, 3, 2.43, 455),
    (1, 2, 5, 1.7, 455),
    (2, 1, 9, 9.78, 788);    

#Queries

#Create a view and incorporate a self join
CREATE VIEW cd4_dynamic AS
	SELECT a.study_id, a.follow_cd4 AS month_6_cd4, b.follow_cd4 AS month_12_cd4, b.follow_cd4 - a.follow_cd4 AS cd4_change
	FROM visit_info AS a
	INNER JOIN visit_info AS b
		USING (study_id)
	WHERE a.study_id = 1 AND a.visit_time = 1 AND b.visit_time = 2;

#Create a temporary table
CREATE TEMPORARY TABLE dna_dynamic AS
(
	SELECT study_id,
		CASE
			WHEN visit_time = 1 THEN 'Month 6'
			WHEN visit_time = 2 THEN 'Month 12'
			WHEN visit_time = 8 THEN 'Month 18'
			ELSE 'Month 24'
		END AS visit_type, 
		follow_dna_ratio, 
		(follow_dna_ratio - LAG(follow_dna_ratio, 1) OVER(PARTITION BY study_id ORDER BY visit_time)) AS dna_change
    FROM visit_info
);

SELECT *
FROM dna_dynamic
WHERE study_id = 1;

#Create a Common Table Expression (CTE)
WITH dna_cd4_status AS 
(
	SELECT study_id, 
		CASE
			WHEN visit_time = 1 THEN 'Month 6'
			WHEN visit_time = 2 THEN 'Month 12'
			WHEN visit_time = 8 THEN 'Month 18'
			ELSE 'Month 24'
		END AS visit_type, 
		follow_dna_ratio, 
		follow_cd4,
		CASE 
			WHEN follow_dna_ratio - LAG(follow_dna_ratio, 1) OVER(PARTITION BY study_id) IS NULL THEN 'Not Applicable'
			WHEN follow_dna_ratio - LAG(follow_dna_ratio, 1) OVER(PARTITION BY study_id) > 0 THEN 'MtDNA Increase'
            		WHEN follow_dna_ratio - LAG(follow_dna_ratio, 1) OVER(PARTITION BY study_id) = 0 THEN 'MtDNA Stable'
			ELSE 'MtDNA Decrease'
		END AS dna_status,
        	CASE
			WHEN follow_cd4 - LAG(follow_cd4, 1) OVER(PARTITION BY study_id) IS NULL THEN 'Not Applicable'
            		WHEN follow_cd4 - LAG(follow_cd4, 1) OVER(PARTITION BY study_id) > 0 THEN 'CD4 Increase'
            		WHEN follow_cd4 - LAG(follow_cd4, 1) OVER(PARTITION BY study_id) = 0 THEN 'CD4 Stable'
            		ELSE 'CD4 Decrease'
		END AS cd4_status
	FROM visit_info
)

SELECT *
FROM dna_cd4_status
WHERE study_id = 1;
