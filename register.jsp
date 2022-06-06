<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<body>
    <%
    Connection con = null;
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
    %>
    <h1>Registered Book List</h1>
    <table border="1">
        <tr>
            <th>ISBN</th>
            <th>Name</th>
            <th>Genre</th>
            <th>Author</th>
            <th>Published</th>
        </tr>
        <%
        try {
            stmt = con.createStatement();
            String query = "SELECT * FROM book";
            rs = stmt.executeQuery(query);
            while(rs.next()) {
                String isbn = rs.getString(1);
            %>
            <tr>
                <td><%=isbn%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=rs.getString(5)%></td>
            <tr>
            <%
            }
        } 
        catch (SQLException e) {
            out.println(e.toString());
        }
        %>
        
    </table>
    <h1>Find Books</h1>
    <form action = "insert_register.jsp" method = "post">
        ISBN: <input type = text name="ISBN"/> <br>
        Name: <input type = text name = "name"/> <br>
        Genre: <input type = text name = "genre"/> <br>
        Author: <input id = "author" type = text name = "author"/> <br>
        Published: <input type = text name = "published"/> <br>
        <input type =submit value="제출">
    </form>
    <script>
        $('#author').autocomplete({
            source: function (req, res) {
                $.ajax({
                    type:'POST',
                    url:'/search_author.jsp',
                    dataType:'json',
                    data:{"string":$('#author').val()},
                    success: function (data) {
                        res($.map(data, function (item){
                            return {
                                label: item["author"],
                                value: item["author"]
                            }
                        }))
                    }
                })
            },
            minLength:1,
            select: function(event, ui){
            }
        })
    </script>
</body>