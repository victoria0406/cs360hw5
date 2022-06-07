<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
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
    request.setCharacterEncoding("UTF-8");
    if(request.getParameter("ISBN")==null ){
        out.println("Nothing!");
    }
    else{
        String ISBN = request.getParameter("ISBN"); //데이터 형태 구분 해야함.
        String test_isbn = ISBN.replaceAll("-","").replaceAll(" ","");
        if((ISBN.indexOf("-")>-1) && (test_isbn.length()>0)){
            try{
                Double testt = Double.parseDouble(test_isbn); //숫자가 아닌 문제가 들어가면 예외처리됨 -> 저장 안됨
                String name = request.getParameter("name");
                String genre = request.getParameter("genre");
                String author = request.getParameter("author");
                Integer published = Integer.parseInt(request.getParameter("published"));
                String query = "insert into book(ISBN, name, genre, author, published) "
                + "values(?,?,?,?,?)";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1,ISBN);
                pstmt.setString(2,name);
                pstmt.setString(3,genre);
                pstmt.setString(4,author);
                pstmt.setInt(5,published);
                pstmt.executeUpdate();

            }catch (Exception e) {
                out.println(e.toString());
            }
        }
        
    }
    
    %>
        <form name = "return" action = "register.jsp" method = "get">
        </form>
        <script>
            document.return.submit();
        </script>
    <%

    
%>