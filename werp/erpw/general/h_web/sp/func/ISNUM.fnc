CREATE OR REPLACE function isnum
    ( p_string in varchar2 )
      return varchar2
    deterministic
    as
       l_num number;
    begin
       l_num := p_string;
      return 'T';
   exception
      when others then
         return 'F';
   end;
/

