CREATE OR REPLACE
FUNCTION f_amt_tohangle
-- function1(상위집계명칭구함)
-- 2. Argument : dept_code,parent_code,level 
-- 3. Return   : name

(
	ai_number               NUMBER
) 

RETURN  VARCHAR2 Is ls_name	VARCHAR2(1000);  
    i				         	INTEGER;
    i_number					INTEGER;
    s_my				        	VARCHAR2(100);
    
BEGIN
	i_number := ai_number.length;
	
	for (i = 1;i<=i_number;i++){
	    s_my(i) :=ai_number.substr((i_number - i),1);
	}
	    
	for (i = 1;i<=i_number;i++){
		if s_my(i) = '0' then
			if (i / 4) = 1 then
				s_my(i) = f_amt_get_koreanunit(i);
				if i <= (i_number - 3) and s_my[i + 1] = '0' and s_my[i + 2] = '0' and s_my[i + 3] = '0' then
					s_my(i) := '';
				end if;
			else 
				s_my(i) := '';
			end if;
		end if;
		elseif s_my(i) = '-' then
				s_my(i) = f_amt_get_koreanhan(s_my(i));
		elseif s_my(i) <> '1' or (i / 4) = 1 or i = i_number then
			s_my(i) := f_amt_get_koreanhan(s_my(i)) + f_amt_get_koreanunit(i);
		else
			s_my(i) := f_amt_get_koreanunit(i);
		end if;
	}
	
	ls_name := '';
	    
	for (i=arg_number.length;i>=1; i--){
		ls_name := ls_name + s_my(i);
	}
	
   RETURN ls_name;
END;
