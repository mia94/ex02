<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
	table {
		border-collapse: collapse;
	}
	td{
		border: 1px solid #ccc;
		padding: 5px;
	}
	#modDiv{
		width:400px;
		height: 200px;
		background-color: gray;
		position: absolute;
		left: 40%;
		top: 20%;
		padding: 10px;
		z-index: 1000;
		display: none;
		padding: 10px;
	}
	#modDiv label{
		width:100px;
		padding-left: 20px;
		padding-right: 20px;
	}
</style>
<title>Insert title here</title>
</head>
<body>

<div class="container">

    <div class="form-group">
      <label class="control-label col-sm-2" for="id">아이디</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="userid" name="userid">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="name">이름</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="username" name="username">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd">비밀번호</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="userpw" name="userpw">
      </div>
    </div>
     <div class="form-group">
      <label class="control-label col-sm-2" for="email">이메일</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="email" name="email">
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="button" class="btn btn-default btnAdd">추가</button>
        <button type="button" class="btn btn-default btnList">리스트 가져오기</button>
      </div>
    </div>
  	<!-- 수정 창 -->
  	<div id="modDiv">
		<p>
			<label>아이디</label>
			<input type="text" id="useridMod" size="30" readonly="readonly">
		</p>
		<p>
			<label>이름</label>
			<input type="text" id="usernameMod" size="30">
		</p>
		<p>
			<label>비밀번호</label>
			<input type="text" id="passwdMod" size="30">
		</p>
		<p>
			<label>이메일</label>
			<input type="text" id="emailMod" size="30">
		</p>
		<div>
			<button id="btnMod">수정</button>
			<button id="btnCancel">취소</button>
		</div>
	</div>
  
  <!-- 리스트 -->
  <div id="memberlist">
  	
  </div>
  <script>

  
	  function getPageList(){
		  $.ajax({
				url:"${pageContext.request.contextPath}/member/list",
				type:"get",
				dataType:"json",
				success:function(json){
					console.log(json);
					$("#memberlist").empty();//안에만 비우기
				
				var source = $("#template1").html();
				var f = Handlebars.compile(source);
				var result = f(json);
				$("#memberlist").append(result);
				/* 	$(json).each(function(i,obj){
					var divTag = $("<p>").text(obj.username);
					$("#memberlist").append(divTag);
				})  */
				}
			})
	  }
	  
	  
	  $(function(){
		  getPageList();
		  
		  $(".btnList").click(function(){
			  getPageList();
		  })
		  
		  $(".btnAdd").click(function(){
				//값 넘겨주기
				var userid = $("#userid").val();
				var username = $("#username").val();
				var userpw = $("#userpw").val();
				var email = $("#email").val();
				//@RequestBody를 사용했기때문에
				var jsonBody = {userid:userid, username:username, userpw:userpw, email:email};
				//@RequestBody를 사용했으면headers, JSON.stringify를 반드시 사용해야함
				$.ajax({
					url:"member/",
					type:"post",
					headers:{
						"Content-Type":"application/json",
						"X-HTTP-Method-Override":"POST"
					},
					data:JSON.stringify(jsonBody),/*JSON.stringify는 {bno:bno, replyer:replyer, replytext:replytext}이런 스트링으로 변환*/
					dataType:"text",/*String으로 반환되면 객체가 아니기때문에 json이 아닌 text로 받아야함*/
					success:function(json){
						console.log(json);
						if(json=="success"){
							alert("등록하였습니다.");
							getPageList(1);
						}
					}
				})
			})
			
		//삭제
		$(document).on("click","#btndelete",function(){
			var userid = $(this).parents("tr").children(".userid").text();
			$.ajax({
				url:"${pageContext.request.contextPath}/member/"+userid,
				type:"delete",
				dataType:"text",
				success:function(json){
					console.log(json);
					if(json == "success"){
						alert(userid+"가 삭제되었습니다.");
					}
					getPageList(1);
				}
			})
		})
		//수정
		$(document).on("click","#btnModify",function(){
			var userid = $(this).parents("tr").children(".userid").text();
			var username = $(this).parents("tr").children(".username").text();
			var userpw = $(this).parents("tr").children(".userpw").text();
			var email = $(this).parents("tr").children(".email").text();
			
			$("#useridMod").val(userid);
			$("#usernameMod").val(username);
			$("#passwdMod").val(userpw);
			$("#emailMod").val(email);
			
			$("#modDiv").show();
		})
		
		$("#btnCancel").click(function(){
			$("#modDiv").hide();
		})
		
		$("#btnMod").click(function(){
			var userid = $("#useridMod").val();
			var username = $("#usernameMod").val();
			var userpw = $("#passwdMod").val();
			var email = $("#emailMod").val();
			var jsonBody = {userid:userid, username:username, userpw:userpw, email:email};
			$.ajax({
				url:"${pageContext.request.contextPath}/member/"+userid,
				type:"put",
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"PUT"
				},
				data:JSON.stringify(jsonBody),
				dataType:"text",
				success:function(json){
					console.log(json);
					if(json == "success"){
						alert(userid+"가 수정되었습니다.");
					}
					//수정완료되면 창 닫기
					$("#modDiv").hide();
					getPageList(1);
				}
			})
		})
	  })
  </script>
  <script id="template1" type="text/x-handlebars-template"> 
 	<table class="item">
	{{#each.}}
		<tr>
			<td class="userid">{{userid}}</td>
			<td class="username">{{username}}</td>
			<td class="userpw">{{userpw}}</td>
			<td class="email">{{email}}</td>
			<td>
				<button type="button" class="btn btn-default" id="btnModify">수정</button>
        		<button type="button" class="btn btn-default" id="btndelete">삭제</button>
			</td>
		</tr>
	{{/each}}
	</table>
  </script>
</div>
</body>
</html>