<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<div id="map" style="width:100%;height:700px;background:yellow"></div>
<div>
</div>
<script>
	var lats=${lats};
	var lngs=${lngs};
	var markers = [];
	var map;
	function initMap() {
	  map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 18,
	    center: {lat: 37.498951, lng: 127.032960}
	  });
	  drop();
	}
	function drop(){
	for (var i = 0; i < lats.length; i++){
		addMarkerWithTimeout(Number(lats[i]),Number(lngs[i]),i*200);
		
	  }
	}
	function addMarkerWithTimeout(lt,lg, timeout) {
		  window.setTimeout(function() {
			var myLatlng = new google.maps.LatLng(lt,lg);
		    markers.push(new google.maps.Marker({
		      position: myLatlng,
		      map: map,
		      animation: google.maps.Animation.DROP
		    }));
		  }, timeout);
	}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD55jYBJEmD1wCJhd7c9CVk5QzaK96v--E&callback=initMap"></script>
