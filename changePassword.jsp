<%@ page import="java.sql.*" %>
<%@ include file="changeDetailsHeader.jsp"%>
<%@ include file="footer.jsp"%>
<html>
<head>
<link rel="stylesheet" href="css/changeDetails.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script>
function verifyPassword() {  
  var pw = document.getElementById("pwd1").value;  
  //check empty password field  

   
 //minimum password length validation  
  if(pw.length < 6) {  
     alert("**Password length must be atleast 6 characters");  
     return false;  
  }  
  
//maximum length of password validation  
  if(pw.length > 15) {  
     alert("**Password length must not exceed 15 characters");  
     return false;  
  } 
}  
</script>
<title>Message Us</title>
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
if("notMatch".equals(msg)){
%>
<h3 class="alert">New password and Confirm password does not match!</h3>
<%
}
%>
<%
if("wrong".equals(msg)){
%>
<h3 class="alert">Your old Password is wrong!</h3>
<%
}
%>
<%
if("done".equals(msg)){
%>
<h3 class="alert">Password change successfully!</h3>
<%
}
%>
<%
if("invalid".equals(msg)){
%>
<h3 class="alert">Some thing went wrong! Try again!</h3>
<%
}
%>
<form onsubmit ="return verifyPassword()">
<h3>Enter Old Password</h3>
 <input class="input-style"type="password" name="oldPassword" placeholder="Enter Old Password" minlength="6" required>
  <hr>
 <h3>Enter New Password</h3>
 <input class="input-style"type="password" id="pwd1" name="newPassword" placeholder="Enter New Password" minlength="6" required>
 
 <hr>
<h3>Enter Confirm Password</h3>
 <input class="input-style"type="password" name="confirmPassword" placeholder="Enter Confirm Password" minlength="6" required>

<hr>
 <button class="button" type="submit" name="b1">Save<i class='far fa-arrow-alt-circle-right'></i></button>
</form>
</body>
<br><br><br>
</html>

<%
    
if(request.getParameter("b1")!=null){
  String email1 = session.getAttribute("email").toString();
  System.out.println(email1);
  String oldPassword = request.getParameter("oldPassword");
  String newPassword = request.getParameter("newPassword");
  String confirmPassword = request.getParameter("confirmPassword");
  if(!confirmPassword.equals(newPassword))
    response.sendRedirect("changePassword.jsp?msg=notMatch");

  else{
    int check = 0;
    try{
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from users where email = '"+email1+"' and password = '"+oldPassword+"'");
        while(rs.next()){
          check = 1;
          stmt.executeUpdate("update users set password = '"+newPassword+"' where email ='"+email1+"'");
          response.sendRedirect("changePassword.jsp?msg=done");
          rs.close();
        }
        if(check==0){
          response.sendRedirect("changePassword.jsp?msg=wrong");

        }


  }catch(Exception e){
     System.out.println(e);
  }
  }
}
                

%>