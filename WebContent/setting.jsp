<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script language="javascript">

var oTbl;
//Row 추가
function insRow() {
  oTbl = document.getElementById("addTable");
  var oRow = oTbl.insertRow();
  oRow.onmouseover=function(){oTbl.clickedRowIndex=this.rowIndex}; //clickedRowIndex - 클릭한 Row의 위치를 확인;
  var oCell = oRow.insertCell();

  //삽입될 Form Tag
  var frmTag = "<input type=text name=mail_id style=width:150px; height:20px;>";
  frmTag += "@<select name=siteAdd value=site><option value= >메일선택</option><option value=naver.com>naver.com</option><option value=gmail.com>gmail.com</option><option value=daum.net>daum.net</option></select>"
  frmTag += "<input type=button value='-' onClick='removeRow()' style='cursor:hand'>";
  oCell.innerHTML = frmTag;
}

//Row 삭제
function removeRow() {
  oTbl.deleteRow(oTbl.clickedRowIndex);
}

//텍스트 박스 비엇는지 확인하는거
function frmCheck()
{
  var frm = document.form;
  
  for( var i = 0; i <= frm.elements.length - 1; i++ ){
     if( frm.elements[i].name == "mail_id" )
     {
         if( !frm.elements[i].value ){
             alert("텍스트박스에 값을 입력하세요!");
                 frm.elements[i].focus();
	 return;
          }
      }
   }
 }

</script>
</head>
<body>
	<form name="form" method="post">
		<table width="400" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2" align="left" bgcolor="#FFFFFF">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="25">
								<table id="addTable" width="400" cellspacing="0" cellpadding="0"
									bgcolor="#FFFFFF" border="0">
									<tr>
									입력
										<!-- <td><input type="text" name="mail_id"
											style="width: 150px; height: 20px;"></td>
											<td><select name="siteAdd" value="site"> 
													<option value="">메일선택</option>
													<option value="naver.com">naver.com</option>
													<option value="gmail.com">gmail.com</option>
													<option value="daum.net">daum.net</option>
											</select>
										</td> -->
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="5" bgcolor="#FFFFFF" height="25" align="left">
								<input name="addButton" type="button" style="cursor: hand"
								onClick="insRow()" value="+">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="submit" value="등록하기">
	</form>
</body>
</html>