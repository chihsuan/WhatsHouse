function initialize(){var e=new google.maps.LatLng(23.9486886,122.7529241),a=7,r={center:e,zoom:a,styles:styledMap,disableDefaultUI:!0,mapTypeId:google.maps.MapTypeId.ROADMAP};map=new google.maps.Map(document.getElementById("map_canvas"),r),infowindow=new google.maps.InfoWindow,markers=[];for(var i=gon.real_price_list,n=0;n<i.length;n++)createMarker(i[n],markers);markerCluster=new MarkerClusterer(map,markers)}function addAroundMarker(e){if("police_stations"===e.data)for(var a in aroundMarkers.police_stations)if(a.addr===e.addr)return;var r="";"stores"===e.data?r="/assets/stores-809f532ff0ae94c8a017caeb292d0411.jpg":"stations"===e.data?r="/assets/stations-9d5b047b6dc5b12f04365d8523ed9476.png":"dinings"===e.data?r="/assets/dinings-ba840dc6932c0ffd5f44957857c3edd3.png":"tainan_schools"===e.data?r="/assets/tainan_schools-7040a2104329ad7005a23fbe869761b1.png":"tainan_markets"===e.data?r="/assets/tainan_markets-11d6a9069092f7f8c680d9426619d40b.png":"hospitals"===e.data?r="/assets/hospitals-bfa08ab7f248fdeb9dc2c3649bc8a593.png":"police_stations"===e.data&&(r="/assets/police_stations-f43170ee6b5a13a52ec83eb215ec5601.png");var i={url:r,size:new google.maps.Size(30,30)},n=new google.maps.Marker({map:null,position:new google.maps.LatLng(e.lat,e.lng),id:e.id,data:e.data,lat:e.lat,lng:e.lng,icon:i});google.maps.event.addListener(n,"mouseover",function(){infowindow=new google.maps.InfoWindow;var a="";for(var r in e)"name"===r?a+="<p>\u540d\u7a31: "+e.name+"</p>":"address"===r?a+="<p>address: "+e.address+"</p>":"addr"===r?a+="<p>addr: "+e.addr+"</p>":"location"===r?a+="<p>location: "+e.location+"</p>":"breif"===r?a+="<p>brief: "+e.breif+"</p>":"tel"===r?a+="<p>tel: "+e.tel+"</p>":"time"===r&&(a+="<p>time: "+e.time+"</p>");infowindow.setContent(a),infowindow.open(map,this)}),e.data in aroundMarkers||(aroundMarkers[e.data]=[]),aroundMarkers[e.data].push(n)}function createMarker(e,a){var r=new google.maps.Marker({map:map,position:new google.maps.LatLng(e.lat,e.lng),id:e.id,data:e.data,lat:e.lat,lng:e.lng});google.maps.event.addListener(r,"click",function(){$("div.ui.inverted.red.pointing.response.menu .item").tab("change tab","Information").tab("deactivate all").tab("activate tab","Information").tab("activate navigation","Information"),window.location.hash="Information",$("#area").show(),(focusPoint.lat!==r.lat||focusPoint.lng!==r.lng)&&(focusPoint.lat=r.lat,focusPoint.lng=r.lng,deleteAround(),$(".form .fields .checkbox").checkbox("disable"),jQuery.ajax({url:"/events/show",dataType:"json",type:"GET",data:{real_price_id:r.id,data:r.data,lat:r.lat,lng:r.lng},success:function(e){for(i=0;i<e.length;++i)if("sale_houses"==e[i].data)$("#information").html('<span class="left-information"><div class="orange ui ribbon label">\u985e\u578b</div><p>'+e[i].use+'</p></span><span class="right-information"><div class="orange ui ribbon label">\u683c\u5c40</div><p>'+e[i].structure+'</p></span><span class="left-information"><div class="orange ui ribbon label">\u5730\u5740</div><p>'+e[i].address+'</p></span><span class="right-information"><div class="orange ui ribbon label">\u552e\u50f9</div><p>'+e[i].price+'</p></span><span class="left-information"><div class="orange ui ribbon label">\u806f\u7d61\u4eba</div><p>'+e[i].owner+'</p></span><span class="right-information"><div class="orange ui ribbon label">\u806f\u7d61\u96fb\u8a71</div><p>'+e[i].tel+'</p></span><span class="brief"><div class="orange ui ribbon label">\u520a\u767b\u8cc7\u8a0a</div><p>'+e[i].breif+"</p></span>");else if("rent_houses"==e[i].data){getHouse=e[i],$("#information").html('<span class=""><div class="red ui ribbon label">\u985e\u578b</div><p>'+e[i].use+'</p></span><span class=""><div class="red ui ribbon label">\u683c\u5c40 / \u4eba\u6578</div><p>'+e[i].structure+" / "+e[i].people+'</p></span><span class=""><div class="red ui ribbon label">\u5730\u5740</div><p>'+e[i].address+'</p></span><span class=""><div class="red ui ribbon label">\u79df\u91d1</div><p>'+e[i].price+'</p></span><span class=""><div class="red ui ribbon label">\u806f\u7d61\u4eba</div><p>'+e[i].owner+'</p></span><span class=""><div class="red ui ribbon label">\u806f\u7d61\u96fb\u8a71</div><p>'+e[i].tel+'</p></span><div class="" id="main_infor"><div class="red ui ribbon label">\u520a\u767b\u8cc7\u8a0a</div>\u9ede\u64ca\u7387'+e[i].browse_rate+"<p>"+e[i].breif+'</p><button class="add_to_cart ui red mini button" onclick="addToCart()">\u52a0\u5165\u6e05\u55ae</button></div>');var a=splitImgUrl(e[i].img);a&&($("#slider1_container").html('<div id = "images" u="slides">'+a+"</div>"),jssor_slider1_starter("slider1_container"))}else"real_price_deals"==e[i].data?$("#information").html('"<div class="red ui ribbon label">\u9109\u93ae\u5e02\u5340</div><p>'+e[i].area+'</p>"<div class="green ui ribbon label">\u571f\u5730\u8def\u6bb5</div><p>'+e[i].location+'</p>"<div class="blue ui ribbon label">\u7e3d\u6210\u4ea4\u50f9</div><p>'+e[i].total_price+"\u5143</p>"):(e[i].data in around||(console.log("found "+e[i].data),around[e[i].data]=[]),around[e[i].data].push(e[i]),addAroundMarker(e[i]));$("#around_services").find("input").each(function(){var e=$(this).attr("name"),a=$(this).next("label").attr("id");$(this).next("label").text(e in aroundMarkers?a+" ("+aroundMarkers[e].length+")":a+" (0)")})},error:function(e){alert("something went wrong"),console.error(e)}}),DISQUS.reset({reload:!0,config:function(){this.page.identifier=r.id,this.page.url="https://whatshouse.herokuapp.com/#!newthread"}}))}),a.push(r),id_markers[r.id]=r}function showAround(e){if("all"!==e){if(e in aroundMarkers)for(var a=0;a!=aroundMarkers[e].length;a++)aroundMarkers[e][a].setMap(map)}else for(var r in aroundMarkers)for(var a=0;a!=aroundMarkers[r].length;a++)aroundMarkers[r][a].setMap(map)}function hideAround(e){if("all"!==e){if(e in aroundMarkers)for(var a=0;a!=aroundMarkers[e].length;a++)aroundMarkers[e][a].setMap(null)}else for(var r in aroundMarkers)for(var a=0;a!=aroundMarkers[r].length;a++)aroundMarkers[r][a].setMap(null)}function deleteAround(){hideAround("all"),around={},aroundMarkers={}}function setAllMap(e){for(var a=0;a<markers.length;a++)markers[a].setMap(e)}function clearMarkers(){setAllMap(null)}function deleteMarkers(){clearMarkers(),markers=[]}function search(){$(".search_form, .menu_search_form").on("ajax:success",function(e,a){markerCluster.setMap(null),markerCluster=[],deleteMarkers(),deleteAround(),$("div.ui.inverted.red.pointing.response.menu .item").tab("change tab","Advanced_Search").tab("deactivate all").tab("activate tab","Advanced_Search").tab("activate navigation","Advanced_Search"),window.location.hash="Advanced_Search";var r=a[1];if(" "!=r&&a[0].length>0)$("div.ui.form.success").hide(),$("div#search_show").html('<span id="serach_rating">\u641c\u5c0b\u6392\u540d</span><button class="undo ui orange mini icon button" onclick="searchUndo()"><i class="undo icon"></i></button><ol id=\'search_result\'>'),appendSerachContent(a,r);else if(a[0].length>0){$("div.ui.form.success").hide(),$("div#search_show").html('<span id="serach_rating">\u641c\u5c0b\u7d50\u679c(\u986f\u793a\u524d\u4e09\u7b46)</span><button class="undo ui mini orange icon button" onclick="searchUndo()"><i class="undo icon"></i></button><ol id=\'search_result\'>'),appendSerachContent(a,r);var i=new google.maps.LatLng(a[0][0].lat,a[0][0].lng);map.setCenter(i),map.setZoom(13)}else $("div.ui.form.success").hide(),$("div#search_show").html('<span id="serach_rating">\u641c\u5c0b\u7d50\u679c(0\u7b46)</span><button class="undo ui mini orange mini icon button" onclick="searchUndo()"><i class="undo icon"></i></button>');for(var n=a[0],s=0;s<n.length;s++)createMarker(n[s],markers);markerCluster=new MarkerClusterer(map,markers),$("div#advanced_search form").hide(),$("div#search_show").show()})}function appendSerachContent(e,a){for(var r,i=0;3>i&&i<e[0].length;++i)r=" "!=a?e[0][a[a.length-i-1]]:e[0][i],$("#search_result").append("<li><a class='marker_link' href='#' id='"+r.id+"' onclick='moveToMarker(event,this.id)'>"+r.address+" "+r.price+"\u5143</a></li>");$("#search_result").append("</ol>")}function moveToMarker(e,a){e.preventDefault();var r=new google.maps.LatLng(id_markers[a].lat,id_markers[a].lng);map.setCenter(r),map.setZoom(17)}function searchUndo(){$("div#advanced_search form").show(),$("div#search_show").hide()}function initalCheckbox(){$(".form .fields .checkbox").checkbox("disable"),$(".form .fields .checkbox").checkbox(),$(".form .fields .checkbox").click(function(){$(this).children("input").is(":checked")?showAround($(this).children("input").attr("name")):hideAround($(this).children("input").attr("name"))})}function splitImgUrl(e){if(e)for(var a=e.split(","),r="",i=0;i<a.length;i++)r+='<div><img u="image" src="'+a[i]+'" /></div>';else r+='<div><img u="image" src="/assets/006-478d54e638f6433fb02bd72f727032a5.jpg" /></div>',r+='<div><img u="image" src="/assets/006-478d54e638f6433fb02bd72f727032a5.jpg" /></div>';return r}function addToCart(){var e=2,a=1;return e>=house_number&&(house_array.push(getHouse),a++,$(".cart").append('<li><i class="map marker icon"></i><div class="content"><span class="header"><a href="#" onclick="moveToMarker(event,this.id)" id="'+getHouse.id+'">'+getHouse.address+" "+getHouse.price+'$ </a></span><a href="#" onclick="javascript:removeFromCart(this)" id="house'+house_number+'" class="removeclass">x</a></div></li>'),house_number++),!1}function removeFromCart(e){return house_number>=1&&(delete house_array[e.id[4]],$(e).parents("li").remove(),house_number--),!1}var map,infowindow,services,around={},aroundMarkers={},markers=[],markerCluster,getHouse,id_markers={},focusPoint={lat:null,lng:null},styledMap=[{featureType:"water",stylers:[{visibility:"on"},{color:"#acbcc9"}]},{featureType:"landscape",stylers:[{color:"#f2e5d4"}]},{featureType:"road.highway",elementType:"geometry",stylers:[{color:"#c5c6c6"}]},{featureType:"road.arterial",elementType:"geometry",stylers:[{color:"#e4d7c6"}]},{featureType:"road.local",elementType:"geometry",stylers:[{color:"#fbfaf7"}]},{featureType:"poi.park",elementType:"geometry",stylers:[{color:"#c5dac6"}]},{featureType:"administrative",stylers:[{visibility:"on"},{lightness:33}]},{featureType:"road"},{featureType:"poi.park",elementType:"labels",stylers:[{visibility:"on"},{lightness:20}]},{},{featureType:"road",stylers:[{lightness:20}]}],house_number=$(".cart").length,house_array=[];$(document).ready(initalCheckbox),google.maps.event.addDomListener(window,"load",initialize);