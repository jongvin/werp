CREATE OR REPLACE function isdate
    ( p_string in varchar2)  
      return varchar2
    as
        l_date date;
    begin
        l_date := to_date(p_string); 
  	  return 'T';
   exception
       when others then
           return 'F';
   end;
/

