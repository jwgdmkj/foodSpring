<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> ��� ���� </title>
    
    <style type="text/css">
        #wrap {
            width: 550px;
            margin: 0 auto 0 auto;
            text-align :center;
        }
    
        #commentUpdateForm{
            text-align :center;
        }
    </style>
    
    <script type="text/javascript">
    
        var httpRequest = null;
        
        // httpRequest ��ü ����
        // HTTP Ŭ���̾�Ʈ �������̽� ����, �� ������ �����ų� �����κ��� ������ �޾ƿ�
        function getXMLHttpRequest(){
            var httpRequest = null;
        
            if(window.ActiveXObject){
                try{
                    httpRequest = new ActiveXObject("Msxml2.XMLHTTP");    
                } catch(e) {
                    try{
                        httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (e2) { httpRequest = null; }
                }
            }
            else if(window.XMLHttpRequest){
                httpRequest = new window.XMLHttpRequest();
            }
            return httpRequest;    
        }
    
    	//��Ͻ�
        function checkValue()
        {
            var form = document.forms[0];
            // ������ ���� ������ ��´�.    
            // document: �ش� html���� ��ü. �� form�� ù��°
            // ù��° form�� ���� comment_content�� value
            var comment_num = "${comment.reply_id}";
            var comment_content = form.comment_content.value
            if(!comment_content)
            {
                alert("������ �Է����ּ���");
                return false;
            }
            else{
            	//param: commentnum�� commentcontent�� ���� key�� ���ս�Ų ��
                var param="comment_num="+comment_num+"&comment_content="
                +encodeURIComponent(comment_content);
                
                httpRequest = getXMLHttpRequest();
                httpRequest.onreadystatechange = checkFunc;
                httpRequest.open("POST", "ReplyUpdateAction.co", true);    
                httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=EUC-KR'); 
                httpRequest.send(param);
            }
        }
        
        function checkFunc(){
        	//complete, request�� ������ response�� �غ�� ����(4)
            if(httpRequest.readyState == 4){
                // ������� �����´�.
                var resultText = httpRequest.responseText;
                if(resultText == 1){
                    if (opener != null) {
                        // �θ�â ���ΰ�ħ
                        window.opener.document.location.reload(); 
                        opener.updateForm = null;
                        self.close();
                    }
                }
            }
        }
        
    </script>

</head>
<body>
<div id="wrap">
    <br>
    <b><font size="5" color="gray">��ۼ���</font></b>
    <hr size="1" width="550">
    <br>
 
    <div id="commentUpdateForm">
        <form name="updateInfo" target="parentForm">        
            <textarea rows="7" cols="70" name="comment_content">${comment.reply_content }
            </textarea>
            <br><br>
		
            <input type="button" value="���" onclick="checkValue()">
            <input type="button" value="â�ݱ�" onclick="window.close()">
        </form>
    </div>
</div>    
</body>
</html>