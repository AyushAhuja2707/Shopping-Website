
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>ForgotPassword</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
  <form method="post">
  <input type="email" name="email" placeholder="Enter Email:" required>
      <input type="number" name="mobileNumber" placeholder="Enter Password:" required>
      <select name="securityQuestion">
      <option values='What was your First Car?'>What was your First Car?</option>
          <option values='First Pet Name?'>First Pet Name?</option>
          <option values='Born City?'>Born City?</option>


      </select>

        <input type="text" name = "answer" placeholder="Enter Ans:" required>
        <input type="password" name = "newPassword" placeholder="Enter New Password:" required>
        
        <input type="submit" value="Save" name="b1">



  </form>

     
      <h2><a href="login.jsp">Login</a></h2>
  </div>
  <%
    if(request.getParameter("b1")!=null){
      String email = request.getParameter("email");
      String mobileNumber = request.getParameter("mobileNumber");
      String securityQuestion = request.getParameter("securityQuestion");
      String answer = request.getParameter("answer");
      String newPassword = request.getParameter("newPassword");

      int check =0;
      try{
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

                String sql = "select * from users where email= '"+email+"' and mobileNumber ='"+mobileNumber+"' and securityQuestion= '"+securityQuestion+"' and answer = '"+answer+"'";
                
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                while(rs.next()){
                  check = 1;
                  stmt.executeUpdate("update users set password='"+newPassword+"' where email='"+email+"'");
                  response.sendRedirect("forgotPassword.jsp?msg=done");
                }
                if(check==0){
                  response.sendRedirect("forgotPassword.jsp?msg=invalid");
                }

      }catch(Exception e){
            out.println(e);
      } 




  }
  
  
  %>


  <div class='whyforgotPassword'>

  <%
    String msg = request.getParameter("msg");
    if("done".equals(msg)){
  
  %>
   
<h1>Password Changed Successfully!</h1>
<%}%>

<%
if("invalid".equals(msg)){
%>

<h1>Some thing Went Wrong! Try Again !</h1>
<%}%>

    <h2>Online Shopping</h2>
    <p>The Online Shopping System is the application that allows the users to shop online without going to the shops to buy them.</p>
  </div>
</div>
</body>
</html>