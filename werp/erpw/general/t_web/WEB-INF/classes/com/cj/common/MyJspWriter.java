package com.cj.common;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public	class	MyJspWriter extends JspWriter
{
	public	MyJspWriter(javax.servlet.jsp.JspWriter orgwriter) 
	{
		writer_ = orgwriter;
	}
    public  void newLine() throws java.io.IOException
	{
		writer_.newLine();
	}
	public  void print(boolean b) throws java.io.IOException
	{
		writer_.print(b);
	}
	public  void print(char c) throws java.io.IOException
	{
		writer_.print(c);
	}
	public  void print(int i)throws java.io.IOException
	{
		writer_.print(i);
	}
	public  void print(long l) throws java.io.IOException
	{
		writer_.print(l);
	}
	public  void print(float f) throws java.io.IOException
	{
		writer_.print(f);
	}
	public  void print(double d) throws java.io.IOException
	{
		writer_.print(d);
	}
	public  void print(char[] s) throws java.io.IOException
	{
		writer_.print(s);
	}
	public  void print(java.lang.String s) throws java.io.IOException
	{
		writer_.print(s);
	}
	public  void print(java.lang.Object obj) throws java.io.IOException
	{
		writer_.print(obj);
	}
	public  void println() throws java.io.IOException
	{
		writer_.println();
	}
	public  void println(boolean x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(char x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(int x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(long x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(float x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(double x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(char[] x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(java.lang.String x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void println(java.lang.Object x) throws java.io.IOException
	{
		writer_.println(x);
	}
	public  void clear() throws java.io.IOException
	{
		writer_.clear();
	}
	public void clearBuffer() throws java.io.IOException
    {
    	writer_.clearBuffer();
    }
    public  void flush() throws java.io.IOException
    {
    	writer_.flush();
    }
    public  void close() throws java.io.IOException
    {
    	writer_.close();
    }
    public int getBufferSize()
    {
    	return writer_.getBufferSize();
    }
    public  int getRemaining()
    {
    	return writer_.getRemaining();
    }
    public boolean isAutoFlush()
    {
    	return writer_.isAutoFlush();
    }
    public	void	write(char[] bf,int i ,int j) throws java.io.IOException
    {
    	writer_.write(bf,i,j);
    }
	private	JspWriter	writer_ = null;
}
