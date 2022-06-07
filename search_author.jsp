<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*"%>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String jdbcUrl ="jdbc:mysql://localhost:3306/HW5?characterEncoding=UTF-8&serverTimezone=UTC";
    String dbUser = "root";
    String dbPass = "root1234";
 
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch(ClassNotFoundException e) { 
        out.println("mysql driver loading error!");
        out.println(e.toString());
        out.println("mysql driver loading error!");
        return;
    }
 
    try {
        con = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
    } catch(SQLException e) {
        con = null;
        out.println("mysql connection error!");
        out.println(e.toString());
        return;
    }
    request.setCharacterEncoding("UTF-8");
%>
<%
     try {
        String input = request.getParameter("string");
        String query = "select author from book where author like '%"+input+"%' order by length(author) ";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);
        JSONArray arr = new JSONArray();
        while(rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("author", rs.getString("author"));
            arr.add(obj);
        }
        out.println(arr);

     }
     catch (SQLException e) {
         out.println(e.toString());
     }
%>