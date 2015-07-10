CREATE OR REPLACE FORCE VIEW R_PROJ_VIEW_BUSINESS_FORM
(PROJ_UNQ_KEY, STEP, BUSINESS_FORM, PROJ_NAME, PROJ_CODE)
AS 
select a.proj_unq_key,         a.step,         b.business_form,         a.proj_name,         a.proj_code     from (             select proj_unq_key,                    max(step) step,max(proj_name) proj_name,max(proj_code) proj_code                from r_proj                 group by proj_unq_key ) a, r_proj b     where a.proj_unq_key = b.proj_unq_key       and a.step = b.step;



