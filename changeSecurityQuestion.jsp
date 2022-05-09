<%@ page import="java.sql.*" %>
<%@ include file="changeDetailsHeader.jsp"%>
<%@ include file="footer.jsp"%><html>
<head>
<link rel="stylesheet" href="css/changeDetails.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Change Security Question</title>
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
<h3 class="alert">Your security Question successfully changed !</h3>
<%}
if("wrong".equals(msg)){
%>
<h3 class="alert">Your Password is wrong!</h3>
<%
}
%>
<form method = "post">
<h3>Select Your New Securtiy Question</h3>
<select class="input-style" name="securityQuestion">
        <option values='What was your First Car?'>What was your First Car?</option>
        <option values='First Pet Name?'>First Pet Name?</option>
        <option values='Born City?'>Born City?</option>
</select>
 <hr>
 <h3>Enter Your New Answer</h3>
 <input class= "input-style" type="text" name = "newAnswer" placeholder="Enter yr new Ans" required>
 
<hr>
<h3>Enter Password (For Security)</h3>
 <input class= "input-style" type="password" name = "password" placeholder="Enter Password (For Security)" required>

<hr>
 <button class ="button" name = "b1" type="submit"><i class='far fa-arrow-alt-circle-right'>Save</i></button>
</form>
</body>
<br><br><br>
</html>

<%
        if(request.getParameter("b1")!=null){
                String email1 = session.getAttribute("email").toString();
                String securityQuestion = request.getParameter("securityQuestion");
                String newAnswer = request.getParameter("newAnswer");
                String password = request.getParameter("password");
                int check = 0;
                try{
                        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
	                
	                String sql = "select * from users where email = '"+email1+"' and password = '"+password+"'";
                        Statement stmt = con.createStatement();
                        
	                ResultSet rs = stmt.executeQuery(sql);
                        while(rs.next()){
                                check = 1;
                                stmt.executeUpdate("update users set securityQuestion = '"+securityQuestion+"' ,answer = '"+newAnswer+"' where email = '"+email1+"'");
                                response.sendRedirect("changeSecurityQuestion.jsp?msg=done");


                        }
                        if(check==0){
                                response.sendRedirect("changeSecurityQuestion.jsp?msg=wrong");
                        }


                }catch(SQLException e){
                
            }



        }

%>