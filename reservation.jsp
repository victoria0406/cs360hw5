<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%

%>
<script>
    $(document).ready(function(){
        $('#bottom_2').hide();
        $('#bottom_1').show();
        $("#bottom_1 input").change(function(){
            $.ajax({
                type:'POST',
                url:'/find_register.jsp',
                dataType:'json',
                data: {'name': $('#name').val(), "genre": $('#genre').val(), "author": $('#author').val()},
                success: function (data){
                    $('table').html("<tr><th>ISBN</th><th>Name</th><th>Genre</th><th>Author</th><th>Published</th></tr>");
                     data.map((ele)=>{ 
                         const html =  
                            "<tr>"+
                                "<td class = 'isbn' id = "+ele["isbn"]+">"+ele["isbn"]+"</td>"+
                                "<td>"+ele["name"]+"</td>"+
                                "<td>"+ele["genre"]+"</td>"+
                                "<td>"+ele["author"]+"</td>"+
                                "<td>"+ele["published"]+"</td>"+
                            "<tr>";
                         $('table').append(html);
                    });  
                }
            });
        });
        $(document).on('click','.isbn',function(event){
            console.log($(event.target).attr('id'));
            $('#bottom_1').hide();
            $('#bottom_2').show();
            const html = "Reserve "+ $(event.target).attr('id');
            $('#bottom_2>h1').text(html);
            $('#bottom_2 form').append('<input type= hidden name = "ISBN" class = "isbn_hidden"  value = '+$(event.target).attr('id')+ ' />');
        });

        $(document).on('click','#cancel',function(){
            $('#bottom_2').hide();
            $('#bottom_1').show();
        })
        
    });
</script>


        <h1>Searched Books</h1>
        <table border=1>
            <tr>
                <th>ISBN</th>
                <th>Name</th>
                <th>Genre</th>
                <th>Author</th>
                <th>Published</th>
            </tr>
        </table>
    



<div Class="bottom">
    <div id = "bottom_1">
        <h1>Find Books</h1>
        Name: <input type = text id="name"/> <br>
        Genre: <input type = text id ="genre"/> <br>
        Author: <input type  = test id = "author"/> <br>
    </div>
    <div id = "bottom_2">
        <h1></h1>
        <form action="insert_reservation.jsp" method = "post">
            User name: <input type = text name='username'/> <br>
            Start Date: <input type = date name='start_date'/> <br>
            End Date: <input type = date name='end_date'/> <br>
            Password: <input type = password name='password'/> <br>
            Retype Password <input type = password name='password_retype'/> <br>
            <button type="button" id = "cancel">reset</button>
            <button id = "submit">submit</button>
        </form>
        
    </div>
</div>
