<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감상문</title>
</head>
<body>
<input type="button" value="삽입" id="insertbtn"/>
<div id="detaildisplay"></div>
<div id="listdisplay"></div>
</body>
<!-- jquery 링크 추가 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
document.getElementById("insertbtn").addEventListener("click", function(){
	location.href = "review/reviewinsert"
})
<!--파라미터는 없으니까 생략-->
//ajax로 review/reviewlist 요청을 수행해주는 함수
function reviewlist(){
	$.ajax({
		url:'review/reviewlist',
		dataType:'json',
		success: function(reviewlist){
			//listdisplay라는 id를 가진 DOM객체를 찾아오는 것
			//value 속성 입력한 값을 가져오는 속성
			//innerHTML은 태그 사이의 내용을 가져오거나 설정하는 속성
			var listdisplay = document.getElementById("listdisplay")
			//제목 출력
			listdisplay.innerHTML = "<h3 align='center'>감상문 목록</h3>"
			//데이터 개수 출력
			listdisplay.innerHTML += "<p>감상문 개수:" + reviewlist.reviewcount +"<p>"
			//테이블 생성 태그
			var display = "<table border ='1'>"
			//테이블의 제목 셀 만들기
			display += "<tr><th>감상문 번호</th><th>책 제목</th><th>작성일</th></tr>"
			
			//데이터배열 찾아오기 reviews가 배열
			var ar = reviewlist.reviews;
			//자바스크립트는 배열순회하면 다른 언어처럼 데이터가 대입되지 않고 인덱스가 대입된다.
			for(i in ar){
				record = ar[i]
				display += "<tr><td>" + record.reviewid +"</td>";
				//상세보기를 구현하려면 기본키 값을 넘겨주는 방법을 고민해야 합니다.
				display += "<td><a href='#' onclick='detail(" + record.reviewid +")'>"+ record.bookname +"</a></td>";
				display += "<td>" + record.regdate +"</td></tr>";
			}

			display += "</table>"
			
			listdisplay.innerHTML += display
			}
	})
	}
	
	//상세보기를 위한 함수
	function detail(reviewid){
		$.ajax({
		url:"review/reviewdetail",
		data:{"reviewid":reviewid},
		dataType:"json",
		success:function(review){
			//Dom(document Object Model): html 문서내에 있는 객체
			var detaildisplay = document.getElementById("detaildisplay");
			detaildisplay.innerHTML = "<h3>감상문 작성 시간:" + review.redgate + "</h3>"
			detaildisplay.innerHTML += "<p><b>책 제목:" + review.bookname + "</b></p>"
			detaildisplay.innerHTML += "<p><b>작가:" + review.writer + "</b></p>"
			detaildisplay.innerHTML += "<p>감상문 내용:" + review.writing + "</p>"
			//image는 테이블의 이미지속성이름
			alert(review.image)
			if(review.image != " "){
				detaildisplay.innerHTML += "<img src='http://localhost:8080/bookdiary/reviewimage/" +review.image + "'/><br/>"
			}
			detaildisplay.innerHTML += "<input type='button' value='삭제' onclick='del(" +review.reviewid + ")' />"
			
			}
		});
		}
	
	//데이터를 삭제하는 메소드
	function del(reviewid){
		$.ajax({
			url:'review/reviewdelete',
			data:{"reviewid":reviewid},
			dataType:'json',
			type:'POST',
			success:function(map){
				if(map.result == 'success'){
					//데이터 다시 출력
					reviewlist()
					document.getElementById("detaildisplay").innerHTML = ""					
				}else{
					alert("삭제 실패")
				}
			}
		});
	}
	
	
	//jquery에서 문서가 시작되자마자 수행
	$(function(){
		reviewlist()
	})
</script>
</html>