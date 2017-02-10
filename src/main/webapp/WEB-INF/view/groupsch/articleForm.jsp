<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

            <div id="schArticle" class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">제목</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="schTitle"></p>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">작성자</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="schUserName"></p>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">일정분류</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="schClassify"></p>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">종일일정</label>
                    <div class="col-sm-10">
                         <p class="form-control-static" id="schAllDay"></p>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">시작일자</label>
                    <div class="col-sm-10">
                         <p class="form-control-static" id="schStartDay"></p>
                     </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">종료일자</label>
                    <div class="col-sm-10">
                         <p class="form-control-static" id="schEndDay"></p>
                     </div>
                </div>
                
                <div class="form-group" style="min-height: 75px; border-bottom: 1px solid #ccc;">
                    <label class="col-sm-2 control-label">내용</label>
                    <div class="col-sm-10">
                         <p class="form-control-static" id="schContent" style="white-space: pre;"></p>
                    </div>
                </div>
            </div>
      
            <div style="text-align: right;" id="schFooter">
                <button type="button" class="btn btn-primary" id="btnModalUpdate"> 수정 <span class="glyphicon glyphicon-ok"></span></button>
                <button type="button" class="btn btn-danger" id="btnModalDelete"> 삭제 <span class="glyphicon glyphicon-remove"></span></button>
                <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 0px;"> 닫기 </button>
            </div>
