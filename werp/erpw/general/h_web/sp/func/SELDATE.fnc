CREATE OR REPLACE function seldate
    ( p_string in varchar2)  
      return date
    as
        l_date date;
    begin
        l_date := to_date(p_string); 
  	  return l_date;
   exception
       when others then
           return null;
   end;
/

