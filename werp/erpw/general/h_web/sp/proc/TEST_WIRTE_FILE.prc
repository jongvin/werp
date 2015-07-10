CREATE OR REPLACE procedure test_wirte_file (path_nm in varchar2,
                                    file_nm in varchar2,
 												lines_to_read in number default 3,
												chars_per_record in number default 999,
 												output_path in varchar2 default 'C:\temp') as
-- This procedure opens a text file in any directory, reads three lines from it
--  and writes them to C:\temp\temp.txt.
-- This is intended for large text files, to quickly get a small section of the file that can
--  be opened and browsed more easily in a text editor.
  in_file   utl_file.file_type;
  out_file  utl_file.file_type;
  text_str  varchar2(4000);
  lines     pls_integer;
  err_text  varchar2(200);
begin
  lines := 0;
  out_file := utl_file.fopen(output_path,'temp.txt','W');
  in_file := utl_file.fopen(path_nm,file_nm,'R',chars_per_record);
  while lines < lines_to_read loop
    begin
      utl_file.get_line(in_file, text_str);
      utl_file.put_line(out_file,nvl(text_str,to_char(lines)));
      lines := lines +1;
    exception
      when others then
        err_text := substr(sqlerrm,1,200);
        lines := lines +1;
        utl_file.put_line(out_file,err_text);
    end;
  end loop;
  utl_file.fclose(in_file);
  utl_file.fclose(out_file);
end;
/

