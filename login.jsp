<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<%-- <link rel="stylesheet" href="css/signup-style.css"> --%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="./css/login_style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>  
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'> 
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">

<title>Login</title>

<script>

function verifyPassword() {  
  var pw = document.getElementById("pwd").value;  
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
    function show(){
      var password = document.getElementById("pwd");
      var icon = document.querySelector(".fas")

      // ========== Checking type of password ===========
      if(password.type === "password"){
        password.type = "text";
      }
      else {
        password.type = "password";
      }
    };
  </script>
</head>
<body class='body'>
<div class="login-page">
  <div class="form">

    <form onsubmit ="return verifyPassword()" method="post" >
      <lottie-player src="https://assets4.lottiefiles.com/datafiles/XRVoUu3IX4sGWtiC3MPpFnJvZNq7lVWDCa8LSqgS/profile.json"  background="transparent"  speed="1"  style="justify-content: center;" loop  autoplay></lottie-player>
      <input type="email" name="email" placeholder="&#xf007;  username" autocomplete="off" required/>
      <input type="password" name="password" id="pwd" placeholder="&#xf023;  password" required/>
      <i class="fas fa-eye" onclick="show()"></i> 
      <br>
      <br>
      <button name="b1"  >LOGIN</button>
      <p class="message"></p>
    </form>

    <form class="login-form">
      <button type="button"  onclick="window.location.href='signup.jsp'">SIGN UP</button>
    </form>

    <div class='whysignLogin'>
    <%-- <h1>Hello</h1> --%>
    <%
      String msg = request.getParameter("msg");
      if("notexist".equals(msg))
      { 
  
    %>
    <h1>Incorrect Username or Password</h1>
      <% }
      %>
    <% if("invalid".equals(msg)) {   %>
    <h1>Some thing Went Wrong! Try Again !</h1>
    <%  } %>

  </div>

  </div>
  


</div>

<%
  if(request.getParameter("b1")!=null){
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    if("admin@gmail.com".equals(email) && "admin@ayush".equals(password)){

      session.setAttribute("email",email);
      response.sendRedirect("admin/adminHome.jsp");
    }
    else{
      int z = 0;
      try{
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

                String sql = "select * from users where email='"+email+"' and password ='"+password+"'";

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                while(rs.next()){
                  z=1;
                  session.setAttribute("email",email);
                  response.sendRedirect("home.jsp");
                }
                if(z==0)
                  response.sendRedirect("login.jsp?msg=notexist");

    }catch(Exception e){
                out.println(e);
                
                  response.sendRedirect("login.jsp?msg=invalid");
              }

  }
  }
%>





  
</div>

</body>
</html>