<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감상문 작성</title>
</head>
<body>
	<form enctype="multipart/form-data" method="post">
		<p align="center">
		<table border="1" width="50%" height="80%" align='center'>
			<tr>
				<td colspan="3" align="center"><h2>감상문 작성</h2></td>
			</tr>
			<tr>
				<td rowspan="5" align="center">
					<p></p> <img id="img" width="100" height="100" border="1" /> <br />
					<br /> <input type='file' id="image" name="image" /><br />
				</td>
			</tr>

			<tr>
				<td bgcolor="#f5f5f5"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;제목</font></td>
				<td>&nbsp;&nbsp;&nbsp; <input type="text" name="bookname"
					id="bookname" size="30" maxlength=50 required="required" />
				</td>
			</tr>
			
			<tr>
				<td bgcolor="#f5f5f5"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;작가</font></td>
				<td>&nbsp;&nbsp;&nbsp; <input type="text" name="writer"
					id="writer" size="30" maxlength=50 required="required" />
				</td>
			</tr>
			

			<tr>
				<td bgcolor="#f5f5f5"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;내용</font></td>
				<td>&nbsp;&nbsp;&nbsp; <textarea rows="10" cols="30"
						name="writing" id="writing"></textarea>
				</td>
			</tr>

			<tr>
				<td align="center" colspan="3">
					<p></p> <input type="button" value="감상문저장" id="insertbtn" /> <input
					type="button" value="목록보기"
					onclick="javascript:window.location='../'" />
					<p></p>
				</td>
			</tr>
		</table>
	</form>
	<br />
	<br />
</body>

<!-- jQuery 링크 설정(절대경로를 써도 되고 다운로드를 받아도 된다.) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
//파일 선택 버튼에서 파일의 내용이 변경될 때 이미지 파일인 경우 이미지 파일의 내용을 img 태그에 출력하도록 해주는 스크립트
document.getElementById("image").addEventListener('change', function(){
	//선택된 파일이 있다면
	//c,javascript는 비슷 어떤 프로그래밍 언어에서는 숫자의 경우 0이아니면 true로 간주
	//참조형의 경우는 null이 아니면 true로 간주
	//이벤트가 발생한 객체 document.getElementById("image_path")
	if(this.files && this.files[0]){
		//파일 이름 찾아오기
		filename = this.files[0].name
		//확장자 찾아오기
		/*
		var idx = filename.lastIndexOf(".")
		var ext = filename.substr(
				idx+1, filename.length)
		*/
		//뒤에서 3글자 찾아오기
		var ext = filename.substr(
			filename.length-3, filename.length);
		//이미지 파일인지 여부를 저장할 변수
		var isCheck = false;
		if(ext.toLowerCase() == 'jpg' || ext.toLowerCase() == 'png' || ext.toLowerCase() == 'gif'){
			isCheck = true
		}else{
			alert("이미지 파일만 선택가능합니다.")
			//이 작업을 하지 않으면 선택한 파일의 경로가
			//남아있게 됩니다.
			document.getElementById('image').value = ""
			return
		}
		
		//파일 내용을 읽을 수 있는 객체를 생성
		var reader = new FileReader()
		//파일의 내용을 읽기를 요청 - 비동기 요청
		reader.readAsDataURL(this.files[0])
		//파일의 내용을 전부 읽으면 호출되는 콜백 처리
		reader.onload = function(e){
			document.getElementById("img").src = e.target.result;
		}
	}
});

//저장 버튼을 누르면 호출되는 콜백 처리
document.getElementById("insertbtn").addEventListener("click", function(){
	//ajax를 이용해서 폼의 데이터 전송하기 위한 객체를 생성
	var formdata = new FormData();
	//파라미터 추가
	formdata.append("bookname", document.getElementById("bookname").value);
	formdata.append("writer", document.getElementById("writer").value);
	formdata.append("writing", document.getElementById("writing").value);
	//파일 전송
	formdata.append("image", document.getElementById("image").files[0]);
	
	$.ajax({
		url:"reviewinsert",
		data:formdata,
		dataType:"json",
		type:"POST",
		processData:false,
		contentType:false,
		success:function(data){
			if(data.result == "success"){
				location.href = '../'
			}else{
				alert("데이터 저장 실패")
			}
		}
	});
		
});





</script>

</html>