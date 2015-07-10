CREATE OR REPLACE PROCEDURE Test_Utl_Http IS

req   UTL_HTTP.REQ;
  resp  UTL_HTTP.RESP;
  VALUE VARCHAR2(1024);
  x   UTL_HTTP.HTML_PIECES;
  len INTEGER;

BEGIN
/*htp.htmlOpen;
htp.BodyOpen;


htp.p( 
 
UTL_HTTP.REQUEST('http://192.168.1.9:7778/werp/erpw/TEST/ora_to_sql.jsp')
--UTL_HTTP.REQUEST('http://192.168.1.9:7778/werp/erpw/h_test_procedure_1h.html')
     );

htp.BodyClose;
htp.htmlClose;*/

/*  
  req := UTL_HTTP.BEGIN_REQUEST('http://192.168.1.9:7778/werp/erpw/TEST/ora_to_sql.jsp','GET');
  resp := UTL_HTTP.GET_RESPONSE(req);
  UTL_HTTP.END_RESPONSE(resp);
*/
SELECT UTL_HTTP.REQUEST('http://192.168.1.9:7778/werp/erpw/h_test_procedure.jsp')
  INTO VALUE 
  FROM dual;
  
--  x := UTL_HTTP.REQUEST_PIECES('http://192.168.1.9:7778/werp/erpw/TEST/ora_to_sql.jsp', 0);
  /*DBMS_OUTPUT.PUT_LINE(x.COUNT || ' pieces were retrieved.');
    DBMS_OUTPUT.PUT_LINE('with total length ');
    len := 0;
    FOR i IN 1..x.COUNT LOOP
      len := len + LENGTH(x(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(len);*/    
  
END;
/

