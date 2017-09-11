package com.kentropy.mongodb;


import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.kentropy.mongodb.MongoDAO;
import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;

	/**
	 * Mongo config listener class use to establish database connection
	 *
	 */
	public class MongoConfigListener implements ServletContextListener 
	{
		public void contextDestroyed(ServletContextEvent sce) 
		{
			MongoClient mongoClient = (MongoClient) sce.getServletContext().getAttribute("MONGO_CLIENT");
			MongoDAO.mongo=null;
			mongoClient.close();
			System.out.println("MongoClient closed successfully");
		}
		public void contextInitialized(ServletContextEvent sce) 
		{
			ServletContext ctx = sce.getServletContext();
			String username=ctx.getInitParameter("MONGODB_USER");
			String password=ctx.getInitParameter("MONGODB_PASS");
			String authDB=ctx.getInitParameter("MONGODB_AUTHDB");
			String host=ctx.getInitParameter("MONGODB_HOST");
			MongoCredential credential = MongoCredential.createCredential(username,
	                authDB,
	             password.toCharArray());
			List<MongoCredential> list= new ArrayList<MongoCredential>();
			
			ServerAddress sa = new ServerAddress(host);
			System.out.println("server address = "+sa);
			list.add(credential);
			MongoClient mc= new MongoClient(sa,list);
			//MongoClient mongoClient = new MongoClient(ctx.getInitParameter("MONGODB_HOST"), 
				//	Integer.parseInt(ctx.getInitParameter("MONGODB_PORT")));
			//MongoClient 
			MongoDAO.mongo=mc;			
			System.out.println("MongoClient initialized successfully");
			sce.getServletContext().setAttribute("MONGO_CLIENT", mc);
		}
	}

