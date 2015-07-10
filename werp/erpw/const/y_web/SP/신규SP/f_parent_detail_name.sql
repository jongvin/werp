CREATE OR REPLACE
FUNCTION F_PARENT_DETAIL_NAME
-- function1(상위집계명칭구함)
-- 2. Argument : dept_code,parent_code,level 
-- 3. Return   : name

(
	as_dept_code			VARCHAR2, 
	ai_spec_unq_num      NUMBER
) 

RETURN  VARCHAR2 Is ls_name	VARCHAR2(1000);  
    li_cnt		   			INTEGER;
    li_level					INTEGER;
    li_key   					INTEGER;
	 as_parent_sum_code     VARCHAR2(20);
    ls_temp_name        	VARCHAR2(50);
    ls_detail_name        	VARCHAR2(50);
    ls_sum_code         	VARCHAR2(20);
    ls_temp_code        	VARCHAR2(20);
    ls_code 		       	VARCHAR2(20);
    lb_yn					BOOLEAN;

BEGIN
   lb_yn          := FALSE;

	SELECT spec_no_seq,name
	  INTO li_key,ls_detail_name
     FROM y_budget_detail
	 WHERE dept_code = as_dept_code
		AND spec_unq_num = ai_spec_unq_num;

	SELECT sum_code,llevel + 1
	  INTO as_parent_sum_code,li_level
	  FROM y_budget_parent
    WHERE dept_code = as_dept_code
		AND spec_no_seq = li_key;

   ls_sum_code    := as_parent_sum_code;
   IF li_level = 9 THEN
      ls_sum_code := substr(ls_sum_code, 1, 16);
   END IF;
   IF li_level = 8 THEN
      ls_sum_code := substr(ls_sum_code, 1, 14);
   END IF;
   IF li_level = 7 THEN
      ls_sum_code := substr(ls_sum_code, 1, 12);
   END IF;
   IF li_level = 6 THEN
      ls_sum_code := substr(ls_sum_code, 1, 10);
   END IF;
   IF li_level = 5 THEN
      ls_sum_code := substr(ls_sum_code, 1, 8);
   END IF;
   IF li_level = 4 THEN
      ls_sum_code := substr(ls_sum_code, 1, 6);
   END IF;
   IF li_level = 3 THEN
      ls_sum_code := substr(ls_sum_code, 1, 4);
   END IF;
   IF li_level = 2 THEN
      ls_sum_code := substr(ls_sum_code, 1, 2);
   END IF;

   ls_code := ls_sum_code;
   LOOP
      SELECT COUNT(*)
        INTO li_cnt
        FROM Y_BUDGET_PARENT
       WHERE dept_code  = as_dept_code  AND
				 chg_no_seq = 0 AND
             sum_code   = ls_sum_code;

	  if length(ls_sum_code) = 2 then
	     exit ;
	  end if;
	  	     
	  IF li_cnt > 0 THEN
         SELECT llevel,
                NVL(name,''),
                NVL(parent_sum_code,'')
           INTO li_cnt,
                ls_temp_name,
                ls_temp_code
           FROM Y_BUDGET_PARENT
          WHERE dept_code  = as_dept_code  AND
                chg_no_seq = 0     AND
                sum_code        = ls_sum_code;
          ls_sum_code := ls_temp_code;
          IF lb_yn = TRUE THEN
             ls_name := ltrim(rtrim(ls_temp_name)) || '/' || ltrim(rtrim(ls_name));
          ELSIF lb_yn = FALSE THEN
             ls_name := rtrim(ls_temp_name);
             lb_yn   := TRUE;
          END IF;
      ELSE
          EXIT;
      END IF;
      IF li_cnt = 0 THEN
         EXIT;
      END IF;

   END LOOP;
   IF ls_code = '' OR ls_code IS NULL THEN
      ls_name := '';
   ELSE
      IF li_level > 1 THEN
         ls_name := ls_name || '/' || ltrim(ls_detail_name);
      ELSE
         ls_name := '';
      END IF;
   END IF;
   
   RETURN ls_name;
END;
