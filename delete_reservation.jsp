<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    }
    catch(ClassNotFoundException e) { 
        out.println("mysql driver loading error!");
        out.println(e.toString());
        out.println("mysql driver loading error!");
        return;
    }

    try {
        con = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
    } 
    catch(SQLException e) {
        con = null;
        out.println("mysql connection error!");
        out.println(e.toString());
        return;
    }
    Integer id = Integer.parseInt(request.getParameter("id"));
    String password = request.getParameter("password");

     try{
        String query = "delete from reserve where id=? and password = ?"; 
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1,id);
        pstmt.setString(2,password);
        pstmt.executeUpdate();

     }catch(SQLException e){
         out.println(e.toString());
     }
     %>
        <form name = "return" action = "reservation_list.jsp" method = "get">
        </form>
        <script>
            document.return.submit();
        </script>
    <%
%>