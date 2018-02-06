DROP TABLE IF EXISTS jingdu_yt_inp_diagnosis_bymonth;

CREATE TABLE IF NOT EXISTS jingdu_yt_inp_diagnosis_bymonth (
	diagnosis_date DATETIME COMMENT '诊断日期',
	diagnosis_name STRING COMMENT '诊断名称',
	h_amount BIGINT COMMENT '人次',
	avg_income DECIMAL COMMENT '次均收入'
)
COMMENT '住院前十疾病人次，次均收入，按月'
LIFECYCLE 100000;

INSERT OVERWRITE TABLE jingdu_yt_inp_diagnosis_bymonth
SELECT datetrunc(diagnosis_date, 'MM'), diagnosis_name
	, SUM(h_amount)
	, h_amount * avg_income / SUM(h_amount)
FROM jingdu_yt_inp_diagnosis
GROUP BY datetrunc(diagnosis_date, 'MM'), 
	diagnosis_name,
	h_amount ,
	avg_income 