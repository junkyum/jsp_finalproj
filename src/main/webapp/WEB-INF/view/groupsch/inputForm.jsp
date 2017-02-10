<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript" src="http://code.jquery.com/ui/1.8.8/i18n/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript">
$(function() {
    $("input[name=startDay]").datepicker();
    $("input[name=endDay]").datepicker();
});
</script>

            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">제목</label>
                    <div class="col-sm-10" id="schTitle">
                        <input class="form-control" name="title" type="text" placeholder="제목">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">작성자</label>
                    <div class="col-sm-10" id="schUserName">
                        <p class="form-control-static">${sessionScope.member.userName}</p>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">일정분류</label>
                    <div class="col-sm-10"  id="schClassify">
                        <div class="btn-group" id="classifyGroup">
                                <button type="button" class="btn btn-blue" id="btnTitle" style="background-image: none;">개인일정</button>
                                <button type="button" class="btn dropdown-toggle btn-blue" id="btnDropdown" style="border-left-color: #ccc;" data-toggle="dropdown" aria-expanded="false">
                                <span class="caret"></span>
                                <span class="sr-only"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                            <c:if test="${userId==sessionScope.member.userId}">
                                <li><a href='javascript:classifyChange("blue");'>그룹일정</a></li>
                            </c:if>
                                <li><a href='javascript:classifyChange("black");'>개인일정</a></li>
                            </ul>
                        </div>
                        <input type="hidden" name="color" value="blue">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">종일일정</label>
                    <div class="col-sm-10" id="schAllDay">
                            <p class="form-control-static">하루종일&nbsp;&nbsp;<input type="checkbox" name="allDay" value="true"></p>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">시작일자</label>
                    <div class="col-sm-10" id="schStartDay">
                        <div class="row">
                            <div class="col-sm-3" style="padding-right: 0px;">
                                <input class="form-control" name="startDay" type="text" readonly="readonly" style="background: #fff;" placeholder="시작날짜">
                            </div>
                            <div class="col-sm-3" style="padding-left: 5px;">
                                <input class="form-control" id="startTime" name="startTime" type="text" placeholder="시작시간">
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">종료일자</label>
                    <div class="col-sm-10" id="schEndDay">
                        <div class="row">
                            <div class="col-sm-3" style="padding-right: 0px;">
                                <input class="form-control" name="endDay" type="text" readonly="readonly" style="background: #fff;" placeholder="종료날짜">
                            </div>
                            <div class="col-sm-3" style="padding-left: 5px;">
                                <input class="form-control" id="endTime" name="endTime" type="text" placeholder="종료시간">
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="form-group" id="schContent"  style="min-height: 75px;">
                    <label class="col-sm-2 control-label">내용</label>
                    <div class="col-sm-10">
                        <textarea id="calcontent" name="calcontent" class="form-control" rows="3"></textarea>
                    </div>
                </div>
            </form>
      
            <div style="text-align: right;" id="schFooter">
                <button type="button" class="btn btn-primary" id="btnModalOk" onclick="insertOk();"> 확인 <span class="glyphicon glyphicon-ok"></span></button>
                <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 0px;"> 닫기 </button>
            </div>
