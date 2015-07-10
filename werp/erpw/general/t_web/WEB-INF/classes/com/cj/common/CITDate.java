package com.cj.common;

import java.text.*;
import java.util.*;

public class CITDate
{
	public static void main(String[] args) throws Exception
	{
		/*
		java.sql.Date date = java.sql.Date.valueOf("2001-12-31");
		System.out.println(CITDate.toString((java.util.Date)date, "yyyy-MM-dd"));
		*/
	}
	
	// 오늘날짜 yyyy-MM-dd 포맷의 문자열로 변환
	public static String getNow() throws Exception
	{
		return getNow("yyyy-MM-dd");
	}
	
	// 오늘날짜를 해당 포맷의 문자열로 변환
	public static String getNow(String asFormat) throws Exception
	{
    	return toString(getDate(), asFormat);
	}
	
	// 오늘날짜를 Date 타입으로 변환
	public static Date getDate() throws Exception
	{
		try
		{
			return Calendar.getInstance().getTime();
		}
		catch (Exception ex)
		{
			throw new Exception ("CITDate getDate Error : " + ex.getMessage());
		}
	}
	
	// 특정 날짜 스트링을 Date 타입으로 변환
	public static Calendar getDateCalendar(String asDate) throws Exception
	{
		Calendar calendar = Calendar.getInstance();
		String lsDate;
		int liYear;
		int liMonth;
		int liDay;
		int liHour;
		int liMinute;
		int liSecond;
		
		if (asDate == null || asDate.trim().equals("")) return null;
		
		lsDate = asDate.trim().replaceAll("-", "").replaceAll("\\.", "").replaceAll("/", "").replaceAll(":", "").replaceAll(" ","");
		
		try
		{
			if (lsDate.length() == 4)
			{
				liYear = Integer.parseInt(lsDate.substring(0, 4));
				liMonth = 0;
				liDay = 1;
				liHour = 0;
				liMinute = 0;
				liSecond = 0;
			}
			else if (lsDate.length() == 6)
			{
				liYear = Integer.parseInt(lsDate.substring(0, 4));
				liMonth = Integer.parseInt(lsDate.substring(4, 6)) - 1;
				liDay = 1;
				liHour = 0;
				liMinute = 0;
				liSecond = 0;
			}
			else if (lsDate.length() == 8)
			{
				liYear = Integer.parseInt(lsDate.substring(0, 4));
				liMonth = Integer.parseInt(lsDate.substring(4, 6)) - 1;
				liDay = Integer.parseInt(lsDate.substring(6, 8));
				liHour = 0;
				liMinute = 0;
				liSecond = 0;
			}
			else if (lsDate.length() >= 14)
			{
				liYear = Integer.parseInt(lsDate.substring(0, 4));
				liMonth = Integer.parseInt(lsDate.substring(4, 6)) - 1;
				liDay = Integer.parseInt(lsDate.substring(6, 8));
				liHour = Integer.parseInt(lsDate.substring(8, 10));
				liMinute = Integer.parseInt(lsDate.substring(10, 12));
				liSecond = Integer.parseInt(lsDate.substring(12,14));
			}
			else
			{
				throw new Exception (asDate + "-올바르지 못한 형태의 날짜값 입니다.(년월일시분초:20010101120000 또는 년월일:20010101)");
			}
			
			calendar.set(liYear, liMonth, liDay, liHour, liMinute, liSecond);
			
			return calendar;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITDate getDate Error : " + ex.getMessage());
		}
	}
	public static Date getDate(String asDate) throws Exception
	{
		Calendar calendar = getDateCalendar(asDate);
			
		return calendar.getTime();
	}
	
	// 특정 날짜 값을 Date 타입으로 변환
	public static Date getDate(long alDate) throws Exception
	{
		Calendar calendar = Calendar.getInstance();
		
		try
		{
			calendar.setTimeInMillis(alDate);
			return calendar.getTime();
		}
		catch (Exception ex)
		{
			throw new Exception ("CITDate getDate Error : " + ex.getMessage());
		}
	}
	
	// 특정 날짜를 해당 기본포맷의 문자열로 변환
	public static String toString(Date aDate)
	{
		return toString(aDate, "yyyy-MM-dd");
	}
	
	// 특정 날짜를 해당 포맷의 문자열로 변환
	public static String toString(Date aDate, String asFormat)
	{
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat(asFormat);
	    	return sdf.format(aDate);
	    }
	    catch (Exception ex)
		{
			return "";
		}
	}
	
	// 특정 날짜를 해당 기본포맷의 문자열로 변환
	public static String toString(Object aoDate)
	{
		return toString(aoDate, "yyyy-MM-dd");
	}
	
	// 특정 날짜를 해당 포맷의 문자열로 변환
	public static String toString(Object aoDate, String asFormat)
	{
		try
		{
			return CITDate.toString((java.util.Date)aoDate, asFormat);
		}
		catch (Exception ex)
		{
			return "";
		}
	}
	
	// 특정 날짜스트링을 해당 기본포맷의 문자열로 변환
	public static String toString(String asDate) throws Exception
	{
    	return toString(asDate, "yyyy-MM-dd");
	}
	
	// 특정 날짜스트링을 해당 포맷의 문자열로 변환
	public static String toString(String asDate, String asFormat) throws Exception
	{
    	return toString(getDate(asDate), asFormat);
	}
	
	// 특정 날짜 값을 해당 기본포맷의 문자열로 변환
	public static String toString(long alDate) throws Exception
	{
    	return toString(alDate, "yyyy-MM-dd");
	}
	
	// 특정 날짜 값을 해당 포맷의 문자열로 변환
	public static String toString(long alDate, String asFormat) throws Exception
	{
    	return toString(getDate(alDate), asFormat);
	}
}