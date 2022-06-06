<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*"%>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
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
        String name = request.getParameter("name");
        String genre = request.getParameter("genre");
        String author = request.getParameter("author");
        String query = "select * from book where name=? or genre=? or author=?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1,name);
        pstmt.setString(2,genre);
        pstmt.setString(3, author);
        rs = pstmt.executeQuery();
        JSONArray arr = new JSONArray();
        while(rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("isbn", rs.getString("isbn"));
            obj.put("name", rs.getString("name"));
            obj.put("genre", rs.getString("genre"));
            obj.put("author", rs.getString("author"));
            obj.put("published", rs.getString("published"));
            arr.add(obj);
        }
        out.println(arr);

     }
     catch (SQLException e) {
         out.println(e.toString());
     }
%>