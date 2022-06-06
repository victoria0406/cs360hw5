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
    String user_name = request.getParameter("username");
    String isbn = request.getParameter("ISBN");
    Date startdate = Date.valueOf(request.getParameter("start_date"));
    Date enddate = Date.valueOf(request.getParameter("end_date"));
    String pw = request.getParameter("password");
    String password_retype =request.getParameter("password_retype");
    out.println(user_name+isbn+startdate+enddate+pw+password_retype);

    if(pw.equals(password_retype) && startdate.before(enddate)){
        try{
            String query = "select exists (select * from book where ISBN = ? "
            +"and ISBN not in (select ISBN from reserve where ISBN=? and end_date>=?))"; 
            pstmt = con.prepareStatement(query);
            pstmt.setString(1,isbn);
            pstmt.setString(2,isbn);
            pstmt.setDate(3,startdate);
            rs = pstmt.executeQuery();
            rs.next();
            if(rs.getBoolean(1)){
                query = "insert into reserve(username, ISBN, start_date, end_date, password) "
                + "values(?,?,?,?,?)";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1,user_name);
                pstmt.setString(2,isbn);
                pstmt.setDate(3,startdate);
                pstmt.setDate(4,enddate);
                pstmt.setString(5,pw);
                pstmt.executeUpdate();
                out.println("success");
                response.sendRedirect("reservation.jsp");
            }else{
                out.println("case1");
                response.sendRedirect("reservation.jsp");
            }

        }catch(SQLException e){
            out.println(e.toString());
        }
    }
    else{
        out.println("case2");
         response.sendRedirect("reservation.jsp");
    }

%>