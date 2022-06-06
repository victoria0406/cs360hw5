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
        rs = con.getMetaData().getTables(null, "hw5", null, new String[]{"TABLE"});
        while(rs.next()) {
            String table = rs.getString("TABLE_NAME");
            out.println("Table Name : " + table);
        }
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
        stmt = con.createStatement();
        String query = "create table book ("
        +"ISBN char(17) primary key, "
        +"name varchar(20), "
        +"genre varchar(20)," 
        +"author varchar(20),"
        +"published numeric(4,0))";
        stmt.executeUpdate(query);
    }catch (SQLException e) {
        out.println(e.toString());
    }
    try {
        stmt = con.createStatement();
        String query = "create table reserve ("
        +"id int primary key auto_increment, "
        +"username varchar(20),"
        +"ISBN char(17), "
        +"start_date date, "
        +"end_date date, "
        +"password varchar(20),"
        +"foreign key (ISBN) references book(ISBN))";
        stmt.executeUpdate(query);
    }catch (SQLException e) {
        out.println(e.toString());
    }
    try {
        stmt = con.createStatement();
        String query = "insert into book "
        + "values "
        + "('1-1', 'Harry Potter', 'Fantasy', 'J.K. Rowling', 2001), "
        + "('1-2', 'Harry Petrey', 'Fantasy', 'J.K. Rowling', 2002), "
        + "('1-3', 'Harry Battery', 'Fantasy', 'J.K. Rowling', 2003), "
        + "('1-4', 'Parry Potter', 'SF', 'Peter parker', 2001), "
        + "('1-5', 'Haray Pitter', 'SF', 'Peter parker', 2001), "
        + "('1-11', 'Harry Potter2', 'Fantasy', 'J.K. Rowling', 2001), "
        + "('1-12', 'Harry Petrey2', 'Fantasy', 'J.K. Rowling', 2002), "
        + "('1-13', 'Harry Battery2', 'Fantasy', 'J.K. Rowling', 2003), "
        + "('1-14', 'Parry Potter2', 'SF', 'Peter parker', 2001), "
        + "('1-15', 'Haray Pitter2', 'SF', 'Peter parker', 2001) ";
        stmt.executeUpdate(query);
    }catch (SQLException e) {
        out.println("insert book:" + e.toString());
    }
    try {
        stmt = con.createStatement();
        String query = "insert into reserve (username, ISBN, start_date, end_date, password)"
        +"values "
        +"('Minjae Park', '1-1', '2022-04-21', '2022-05-21', '1q2w3e4r!'), "
        +"('Doyun Park', '1-11', '2022-06-21', '2022-07-21', '1111'), "
        +"('Minjae Park', '1-2', '2022-04-21', '2022-05-21', '1q2w3e4r!'), "
        +"('Doyun Park', '1-12', '2022-06-21', '2022-07-21', '1111'), "    
        +"('Minjae Park', '1-3', '2022-04-21', '2022-05-21', '1q2w3e4r!'), "
        +"('Doyun Park', '1-13', '2022-06-21', '2022-07-21', '1111'), "    
        +"('Minjae Park', '1-4', '2022-04-21', '2022-05-21', '1q2w3e4r!'), "
        +"('Doyun Park', '1-14', '2022-06-21', '2022-07-21', '1111'), "    
        +"('Minjae Park', '1-5', '2022-04-21', '2022-05-21', '1q2w3e4r!'), "
        +"('Doyun Park', '1-15', '2022-06-21', '2022-07-21', '1111') " ;   
            

        stmt.executeUpdate(query);
    }catch (SQLException e) {
        out.println("insert reserve:" + e.toString());
    }
%>