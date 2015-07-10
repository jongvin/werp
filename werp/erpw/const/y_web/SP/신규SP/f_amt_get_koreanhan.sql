CREATE OR REPLACE
FUNCTION F_AMT_GET_KOREANHAN
-- function1(±Ý¾×À» ÇÑ±Û·Î º¯°æ)
-- 2. Argument : amt
-- 3. Return   : name

(
	ai_number               NUMBER
) 

RETURN  VARCHAR2 Is ls_name	VARCHAR2(10);  

BEGIN
   IF ai_number = 0 THEN
      return '';
   END IF;	
	IF ai_number = 1 THEN
      return 'ÀÏ';
   END IF;	
	IF ai_number = 2 THEN
      return 'ÀÌ';
   END IF;
	IF ai_number = 3 THEN
      return '»ï';
   END IF;
	IF ai_number = 4 THEN
      return '»ç';
   END IF;
	IF ai_number = 5 THEN
      return '¿À';
   END IF;
	IF ai_number = 6 THEN
      return 'À°';
   END IF;	
	IF ai_number = 7 THEN
      return 'Ä¥';
   END IF;
	IF ai_number = 8 THEN
      return 'ÆÈ';
   END IF;
	IF ai_number = 9 THEN
      return '±¸';
   END IF;	
END;
