/***********************************************************
/*  화일 업로드 파라메터 골라내기, 업로드하기 
/*  1998/02/10 제작자 : 김용대 
/*  copyright(c) JavaLand(http://javaland.cgiserver.net)
/*  사용시 출처를 밝혀주기 바랍니다.
/***********************************************************/
import java.io.*;

public class FileUpload{
  private String fname;
  private String boundary;

  String param;
  DataInputStream in;

  public FileUpload(InputStream instream)
  {
this.in=new DataInputStream(instream);
try{
          boundary=in.readLine();
}catch(IOException e){
  System.out.println(e.getMessage());
  in=null;
}
  }

 // 델리미터를 넘긴다.
  public String getDelimeter()
  {
return boundary;
  }

  public String getDelimeter(InputStream instream)
  {
this.in=new DataInputStream(instream);
try{
  boundary=in.readLine();
}catch(IOException e){
  System.out.println(e.getMessage());
  in=null;
}

return boundary;
  }

  // 변수에 대한 값을 읽어낸다.
  public String getParameter(String in_name) throws IOException
  {
String str;
while((str=in.readLine())!=null){
  if(str.indexOf("name=") != -1)
  {
int nS=str.indexOf("name=");
int nE=str.indexOf("\"",nS+6);
param=str.substring(nS+6,nE);

if(param.equals(in_name)) 
{
str=in.readLine();
str=in.readLine();
return str;
}
   }
       }
return null;
  }

  public boolean getParameter(OutputStream out,String in_name)
  throws IOException
  {
String str;
while((str=in.readLine())!=null){
  if(str.indexOf("name=") != -1)
  {
int nS=str.indexOf("name=");
int nE=str.indexOf("\"",nS+6);
param=str.substring(nS+6,nE);
if(param.equals(in_name)) 
{
  str=in.readLine();
  if(readParameter(out))
return true;
  }
}
}
return false;
  }

  public String getFileName() throws IOException
  {
String str;
int nS;
int nE;
while((str=in.readLine())!=null){
  if(str.indexOf("filename=\"\"") != -1)
  {
str=in.readLine();
return null;
  }
  if(str.indexOf("filename=") != -1)
  {
nS=str.indexOf("filename=");
nE=str.indexOf("\"",nS+10);
fname=str.substring(nS+10,nE);
if(fname.lastIndexOf("\\") != -1){
fname=fname.substring(fname. lastIndexOf("\\")+1);
return fname;
}
  }
}
return null;
  }
  
  public boolean UpFile(OutputStream Out) throws IOException
  {
String str;
while((str=in.readLine())!=null)
{
  if(str.indexOf("Content-Type") != -1)
  {
str=in.readLine();
if(readParameter(Out))
return true;
  }
}
return false;
  }

  public boolean readParameter( OutputStream Out )
  {
byte[] buffer=new byte[1024];
byte[] tbuffer=new byte[boundary.length()+1];
byte tm;
int x=0;

try{
  for(;;)
  {
buffer[x++]=tm=in.readByte();
if(x==boundary.length()+1)
{
  int y=0;
  String temp=new String(buffer,0,x);
  if((y=temp.indexOf(boundary))!= -1)
  {
x=y;
if(x!=0)
  Out.write(buffer,0,x-1);
return true;
   }
}
else{
  if((x==1023) || (tm =='\n')){
Out.write(buffer,0,x);
x=0;
  }
}  //end of if/else
  } //end of for

}catch(Exception e){
  System.out.println("Error : "+e.toString());
}
return false;
  }
}
