CREATE OR REPLACE function selnum
    ( p_string in varchar2 )
      return number
    deterministic
    as
       l_num number;
    begin
       l_num := p_string;
      return l_num;
   exception
      when others then
         return null;
   end;
/

