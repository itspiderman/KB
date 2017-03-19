This doc is for servlet Getting Started

1. create the servlet class.

This class will extend javax.servlet.http.HttpServlet

Code:
package com.demoservlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloWorldServlet
 */
public class HelloWorldServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HelloWorldServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter writer = response.getWriter();
		writer.println("Hello, World!");
		writer.close();
	}

}

2. configure this servlet in web.xml

	<servlet>
		<description>
		say hello to servlet</description>
		<display-name>HelloWorldServlet</display-name>
		<servlet-name>HelloWorldServlet</servlet-name>
		<servlet-class>com.demoservlet.HelloWorldServlet</servlet-class>
	</servlet>  
  	<servlet-mapping>
		<servlet-name>HelloWorldServlet</servlet-name>
		<url-pattern>
		/HelloWorldServlet</url-pattern>
	</servlet-mapping>
 <!-- a servlet can have multi mapping --> 
  	<servlet-mapping>
		<servlet-name>contacts</servlet-name>
		<url-pattern>
		/index.htm</url-pattern>
	</servlet-mapping>
	<servlet-mapping>
         <servlet-name>contacts</servlet-name>
         <url-pattern>*.perform</url-pattern>
     </servlet-mapping>
  
3. deploy this web to server
  
4. run this servlet
http://localhost:8158/hello/HelloWorldServlet
