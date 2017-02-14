<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>

<div id="map" style="width:900px;height:700px;background:yellow"></div>
<div id="message"></div>
<script>
function myMap() {
  var mapCanvas = document.getElementById("map");
  var mapOptions = {
    center: new google.maps.LatLng(37.498951, 127.032960), zoom: 18
  };
  var map = new google.maps.Map(mapCanvas, mapOptions);
	  map.addListener('click', function(e) {
	  converter(e.latLng);
	  });
}
function converter(latLng){
	var str=""+latLng;
	var aa=str.split('(');
	var tt=aa[1].split(')');
	
	googleapisView(tt[0])
}
function googleapisView(ll) {
    var geocode = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+ll+"&sensor=false";
    jQuery.ajax({
        url: geocode,
        type: 'POST',
           success: function(myJSONResult){
                    if(myJSONResult.status == 'OK') {
                        var tag = "";              
                          tag += "주소 : " +myJSONResult.results[0].formatted_address;
                          
                        document.getElementById("message").innerHTML = tag;
                    } 
            }
    });
}
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD55jYBJEmD1wCJhd7c9CVk5QzaK96v--E&callback=myMap"></script>
