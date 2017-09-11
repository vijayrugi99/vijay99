package com.kentropy.kmc.bean;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.SimpleDateFormat;
//import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class TimeCalculation 
{	
	private Matcher matcher;
	private Pattern pattern;
		/**
		 * This function is for getting the no of hours between two given date and time strings.
		 * @param dateStart - The start date with  dd/MM/yyyy hh:mm a format
		 * @param dateEnd  - The end date with dd/MM/yyyy hh:mm a format
		 * @param timeStart - The start time 
		 * @param timeEnd - The end time 
		 * @return diffInHours - returns difference in hrs 
		 */
		public double timeDifference(String dateStart, String dateEnd, String timeStart, String timeEnd)		
		{
			double diffInHours = 0;			
			try 
			{		   
			    String format = "dd/MM/yyyy hh:mm a";
			    SimpleDateFormat sdf = new SimpleDateFormat(format);			    
			    //get date object
			    Date dateObj1 = sdf.parse(dateStart + " " + timeStart);
			    Date dateObj2 = sdf.parse(dateEnd + " " + timeEnd);			    			    
			    //Get msec from each, and subtract
			    long millisec1 = dateObj1.getTime();			    
			    long millisec2 = dateObj2.getTime();			    
			    long diff = dateObj2.getTime() - dateObj1.getTime();			   
			    //total hours b/w two dates
			    diffInHours = diff / ((double) 1000 * 60 * 60);	
			    //System.out.println("total hrs in java="+diffInHours);
			} 
			catch (Exception e)		
			{
			    e.printStackTrace();
			}
			return diffInHours;
		}
		
		/**
		 * This function is for checking the given time lies between two time, 
		 * if the time is day to midnight calculate next date 
		 * @param date - The start date with  dd/MM/yyyy hh:mm a format		 
		 * @param startTime - The start time 
		 * @param endTime - The end time 		 
		 */		
		public double timeCalculation(String date, String startTime, String endTime)
		{
			double hrs = 0;	
			int hr =0;
			double min = 0;
			try 
			{
				/*System.out.println("passing date to java="+date);
				System.out.println("passing starttime in java="+startTime);
				System.out.println("passing endtime to java="+endTime);*/
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
			    SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
				String fromTime1 = "08:00 am";//comparison start time1
				Date from1 = sdf.parse(date + " " + fromTime1);
			    //System.out.println("From1 in java= "+from1);
			    
				String toTime1 = "11:59 pm";//comparison end time1
				Date to1 = sdf.parse(date + " " + toTime1);
			    //System.out.println("to1 in java= "+to1);
			    
				String fromTime2 = "12:00 am";//comparison start time2
				Date from2 = sdf.parse(date + " " + fromTime2);
			    //System.out.println("From2 in java= "+from2);
			    
				String toTime2 = "07:59 am";//comparison end time2
				Date to2 = sdf.parse(date + " " + toTime2);
			    //System.out.println("to2 in java= "+to2);
				
			    //get Date object of given time
			    Date starttime = sdf.parse(date + " " +startTime);
			    //System.out.println("starttime in java= "+starttime);
			    Date endtime = sdf.parse(date + " " + endTime);
			    //System.out.println("endtime in java= "+endtime);
			    
			    if(starttime.compareTo(to1)<=0) //check the starttime is lessthan end time1
			    {
			    	//System.out.println("yes start time is less than 11:59pm in java");
			    	//check the given time is equal or lies b/w start time1 and end time1
			    	if((starttime.equals(from1)||starttime.after(from1)) && starttime.before(to1) && endtime.after(from1) && 
			    			(endtime.before(to1)||endtime.equals(to1)))
			    	{
			    		//System.out.println("lies between 8am to 11:59pm");
			    		hrs = timeDifference(date, date, startTime, endTime);			    		
			    	}	
			    	//check the given time is less than= end time2 and greater than= start time1
			    	else if((starttime.before(to2)||starttime.equals(to2)) && (endtime.after(from1)||endtime.equals(from1)))
			    	{
			    		//System.out.println("lies between <7:59am to >8am");
			    		hrs = timeDifference(date, date, startTime, endTime);			    		
			    	}
			    	else
			    	{
			    		//check the given time is lies b/w start time2 and end time2
			    		if((starttime.equals(from2) || starttime.after(from2)) && starttime.before(to2) && endtime.after(from2) && 
			    				(endtime.before(to2)||endtime.equals(to2)))			    			
			    		{
			    			//System.out.println("lies between 12am to 7:59am");	
			    			hrs = timeDifference(date, date, startTime, endTime);			    			
			    		}
			    		//check the given time is less than= end time1 and less than= end time2 
			    		else if((starttime.equals(to1) || starttime.before(to1)) && (endtime.before(to2)||endtime.equals(to2)))
			    		{
			    			//System.out.println("lies between 11pm to 7:59am");
			    			Calendar c = Calendar.getInstance();
							c.setTime(sdf1.parse(date));
							c.add(Calendar.DATE, 1);  
							String nextdate = sdf1.format(c.getTime());
							//System.out.println("Next date = "+nextdate);
							hrs = timeDifference(date, nextdate, startTime, endTime);							
			    		}
			    	}
			    }
			    /*hr = (int)hrs;
			    min = (hrs - (int)hrs)*60;
			    System.out.println("Difference b/w = "+hr+"hr "+Math.round(min)+"mins");*/
			} 
			catch (Exception e)		
			{
			    e.printStackTrace();
			}
			return hrs;
		}
		
		/**
		 * This function is for convert the given time from 24hrs to 12hrs format		
		 * @param _24HourTime - The time in 24hrs format		 		 
		 */	
		public String convert24To12Format(String _24HourTime)
		{	
			String _12hrs="";
			try 
			{ 
				String regex = "([01]?[0-9]|2[0-3]):[0-5][0-9]";
				pattern = Pattern.compile(regex);		        
		        matcher = pattern.matcher(_24HourTime);
		        //System.out.println("matches ="+matcher.matches());
		        if(matcher.matches())
		        {
			        SimpleDateFormat _24HourSDF = new SimpleDateFormat("HH:mm");
			        SimpleDateFormat _12HourSDF = new SimpleDateFormat("hh:mm a");
			        Date _24HourDt = _24HourSDF.parse(_24HourTime);
			        //System.out.println("24 format date="+_24HourDt);
			        _12hrs = _12HourSDF.format(_24HourDt);
			        //System.out.println("12 hrs format date="+_12hrs);
			        return _12hrs;
		        }		       
		    } 
			catch (Exception e) 
			{
		        e.printStackTrace();
		    }
			return _24HourTime;
		}
		public static void main(String[] args) 
		{			
			TimeCalculation tc = new TimeCalculation();
			//double diffhrs = tc.timeCalculation("16/09/2016", "07:00 am",  "09:00 am");
			//double diffhrs = tc.timeCalculation("16/09/2016", "11:59 pm",  "07:59 am");
			//double diffhrs = tc.timeCalculation("16/09/2016", "01:50 am",  "3:00 am");
			//double diffhrs = tc.timeCalculation("16/09/2016", "8:30 am",  "02:00 pm");
			//String time12hrs = tc.convert24To12Format("01:46");
			//System.out.println("time12hrs= "+time12hrs);
		}		
}
