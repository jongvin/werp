CREATE OR REPLACE
FUNCTION F_AMT_GET_KOREANUNIT
-- function1(�ݾ��� �ѱ۷� ����)
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
      return '��';
   END IF;
	IF ai_position = 9 THEN
      return '��';
   END IF;
	IF ai_position = 13 THEN
      return '��';
   END IF;
	IF ai_position = 17 THEN
      return '��';
   END IF;
	
	IF ai_position / 4 = 0 THEN
      return 'õ';
   END IF;	
	IF ai_position / 4 = 1 THEN
      return '';
   END IF;
	IF ai_position / 4 = 2 THEN
      return '��';
   END IF;
	IF ai_position / 4 = 3 THEN
      return '��';
   END IF;
END;
