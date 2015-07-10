CREATE OR REPLACE
FUNCTION F_AMT_GET_KOREANUNIT
-- function1(금액을 한글로 변경)
-- 2. Argument : amt
-- 3. Return   : name

(
	ai_position               NUMBER
) 

RETURN  VARCHAR2 Is ls_name	VARCHAR2(10);  

BEGIN
   IF ai_position = 1 THEN
      return '';
   END IF;	
	IF ai_position = 5 THEN
      return '만';
   END IF;
	IF ai_position = 9 THEN
      return '억';
   END IF;
	IF ai_position = 13 THEN
      return '조';
   END IF;
	IF ai_position = 17 THEN
      return '경';
   END IF;
	
	IF ai_position / 4 = 0 THEN
      return '천';
   END IF;	
	IF ai_position / 4 = 1 THEN
      return '';
   END IF;
	IF ai_position / 4 = 2 THEN
      return '십';
   END IF;
	IF ai_position / 4 = 3 THEN
      return '백';
   END IF;
END;
