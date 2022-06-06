<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $(document).ready(function(){
        $(document).on('click', ".id", function(){
            $(".id").css("color", "black");
            $(event.target).css("color", "red");
            $('input[name="id"]').val($(event.target).attr('id'));
            $('input[name="id"]').prop('readonly', true);
        })
    })
</script>

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
<h1>Book reservation list</h1>
<table border="1">
    <tr>
        <th>User Name</th>
        <th>ISBN</th>
        <th>Book name</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>Delete</th>
    </tr>
    <%
    try {
        stmt = con.createStatement();
        String query = "SELECT id, username, ISBN, name, start_date, end_date FROM reserve join book using(ISBN) order by id";
        rs = stmt.executeQuery(query);
        while(rs.next()) {
        %>
        <tr>
            <form>
                <td class ="id" id =<%=rs.getString(1)%> ><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=rs.getString(5)%></td>
                <td><%=rs.getString(6)%></td>
            </form>
        </tr>
        <%
        }
    } 
    catch (SQLException e) {
        out.println(e.toString());
    }
    %>
</table>
<h1>Delete information</h1>
<form action = "delete_reservation.jsp" action ="post">
    Borrow ID: <input type=text name = "id" value /><br>
    Password: <input type = password name = "password" /><br>
    <input type=submit value ="제출"/>
</form>