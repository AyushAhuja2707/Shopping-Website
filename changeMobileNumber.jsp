<%@ page import="java.sql.*" %>
<%@ include file="changeDetailsHeader.jsp"%>
<%@ include file="footer.jsp"%>
<html>
<head>
<link rel="stylesheet" href="css/changeDetails.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Change Mobile Number</title>
<style>
body{
  background-image: url('https://ordinaryfaith.net/wp-content/uploads/2016/03/Gray-plain-website-background.jpg');
  background-repeat: no-repeat;
  background-size: cover;

}
</style>
</head>
<body>


<%
String msg = request.getParameter("msg");
if("done".equals(msg)){

%>

<h3 class="alert">Your Mobile Number successfully changed!</h3>
<%
}
if("wrong".equals(msg)){
%>
<h3 class="alert">Your Password is wrong!</h3>
<%
}
%>

<form method= "post">
 <h3>Enter Your New Mobile Number</h3>
 <input class = "input-style" type="number" name="mobileNumber" placeholder="Enter Yr New Mobile Number"  minlength="10" pattern="[0-9]{10}" required>
 <hr>
<h3>Enter Password (For Security)</h3>
<input class = "input-style" type="password" name="password" placeholder="Enter Password (For Security)" required>
 
<hr>
 <button class = "button" type="submit" name = "b1"><i class='far fa-arrow-alt-circle-right'>SAVE</i></button>
</form>
</body>
<br><br><br>
</html>
<%
        if(request.getParameter("b1")!=null){
                String email1 = session.getAttribute("email").toString();
                String mobileNumber = request.getParameter("mobileNumber");
                String password = request.getParameter("password");
                int check = 0;
                try{
                        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
	                
	                String sql = "select * from users where email = '"+email+"' and password = '"+password+"'";
                        Statement stmt = con.createStatement();
                        
	                ResultSet rs = stmt.executeQuery(sql);
                    while(rs.next()){
                        check = 1;
                        stmt.executeUpdate("update users set mobileNumber = '"+mobileNumber+"' where email = '"+email+"'");
                        response.sendRedirect("changeMobileNumber.jsp?msg=done");

                    }
                    if(check == 0){
                        response.sendRedirect("changeMobileNumber.jsp?msg=wrong");
                    }

                }catch(Exception e){

                }
        }

%>