<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="ZinMainPage.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!DOCTYPE html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <script src="path/to/mapScript.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef39a15ef3a2a912411a013e27d1d499"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/ea10983b3f.js" crossorigin="anonymous"></script>

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>맛집 검색</title>
    <style>
        #login-btn,
        #search-btn,
        #categories button {
            font-family: 'Jua', sans-serif;
            margin: 0;
            padding: 0;
            border: none;
        }

        html {
            background-color: #fff9d4; 
        }

        body {
            font-family: 'Jua', sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #search-box {
            display: flex;
            align-items: center;
            border-radius: 5px;
        }

        #searchInput {
            padding: 5px;
            border: none;
            border-radius: 5px 0 0 5px;
        }

        #reviewBtn,
        #loginBtn {
            padding: 8px 15px;
            background-color: #f90;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 20px;
            font-family: 'Jua', sans-serif;
        }

        #loginBtn:hover {
            background-color: #ffb74a;
        }

        #searchBtn,
        #search-btn{
            padding: 8px 13px;
            background-color: #f90;
            color: #fff;
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }

        #searchBtn:hover {
            background-color: #ffb74a;
        }

        #categories {
            display: flex;
            justify-content: space-around;
            background-color: #eee;
            padding: 10px;
        }

        .category-btn {
            font-family: 'Jua', sans-serif;
            margin: 0;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #fff;
            color: #333;
            font-size: 20px;
        }

        .category-btn:hover {
            background-color: #f90;
            color: #fff;
        }
        .category-item {
        border:none; /* 테두리 스타일 및 색상 설정 */
        margin-bottom: 10px; /* 각 항목 사이의 간격 설정 */
        padding: 10px; /* 테두리 내부의 여백 설정 */
        border-radius:5px;
        background-color:white;
    }

    .category-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 5px;
        text-align: left;
    }

    .category-item img {
        max-width: 100%; /* 이미지가 너무 큰 경우에 대비한 스타일 */
        height: auto;
    }

    .category-item div {
        margin-bottom: 5px; /* 항목 내부의 각 요소 간 간격 설정 */
        
    }
        #map-container{
            display: flex;
            
        }
        #map {
            font-family: 'Jua', sans-serif;
            margin: 20px;
        }

        #category-list {
            width: 30%;
            height: 550px;
            overflow-y: auto;
            padding: 10px;
            box-sizing: border-box;
            font-family: 'Jua', sans-serif;
           float: right;
           border: none;
           background-color:#eee;
           margin:20px;
           border-radius:5px;
           text-align: center;
        }

        footer {
            background-color: #808080;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        .auto-style4 {
            height: 65px;
        }
        .auto-style5 {
            margin-top: 0px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <header>
            <div id="search-box" class="auto-style4">
                <asp:TextBox ID="searchInput" runat="server" placeholder="검색하기" CssClass="auto-style5" Height="35px"></asp:TextBox>
&nbsp;<asp:Button ID="searchBtn" runat="server" class="auto-style4" Height="45px" Text="🔍︎" Font-Size="20px" OnClick="searchBtn_Click"/>
               
            </div>
            <div id="login-btn">
                <asp:Button ID="reviewBtn" runat="server" OnClick="reviewBtn_Click" Text="리뷰" />
                <asp:Button ID="loginBtn" runat="server" OnClick="loginBtn_Click" Text="로그아웃" />
            </div>
        </header>

        <div id="categories">
            <asp:Button ID="cafeBtn" runat="server" onclick="cafeBtn_Click" CssClass="category-btn" Text="카페" />
            <asp:Button ID="restauratnBtn" runat="server" onclick="restauratnBtn_Click" CssClass="category-btn"
                Text="밥집" />
            <asp:Button ID="barBtn" runat="server" onclick="barBtn_Click" CssClass="category-btn" Text="술집" />
        </div>

        <!-- 원하는 위치에 지도를 표시할 div 추가 -->
        <div id="map-container">
        <div id="map" style="width: 1000px; height: 550px;"></div>
            <div id="category-list"></div>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c750ad03f2dc7fc806c095dd4bfae59d"></script>
        <script>
            var container = document.getElementById('map');
            var options = {
                // 기본 위치는 안동대학교로 설정
                center: new kakao.maps.LatLng(36.54326, 128.79626),
                level: 3
            };

            var map = new kakao.maps.Map(container, options);

            // HTML5 Geolocation API를 사용하여 현재 위치 가져오기
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    // 성공적으로 위치를 가져왔을 때
                    var userLatLng = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);

                    // 사용자의 현재 위치로 지도 중심 이동
                    map.setCenter(userLatLng);

                    // 사용자의 현재 위치에 마커 추가
                    var marker = new kakao.maps.Marker({
                        position: userLatLng,
                        map: map,
                        title: '현재 위치'
                    });

                    // 마커 클릭 이벤트 리스너 등록
                    kakao.maps.event.addListener(marker, 'click', function () {
                        var infowindow = new kakao.maps.InfoWindow({
                            content: '현재 위치'
                        });
                        infowindow.open(map, marker);
                    });

                }, function (error) {
                    // 위치 정보를 가져오지 못했을 때의 처리
                    console.error('위치 정보를 가져오는데 실패했습니다.', error);
                });
            } else {
                // Geolocation을 지원하지 않는 경우의 처리
                console.error('Geolocation을 지원하지 않습니다.');
            }

            // 데이터베이스에서 가져온 마커들에 대해 이벤트 리스너 등록

            // 데이터베이스에서 가져온 마커들에 대해 이벤트 리스너 등록
            var markers = [];
            var infowindows = [];
            var currentInfowindow = null; // 현재 열려있는 인포윈도우를 저장할 변수

            function addMarker(name, latitude, longitude, description) {
                var markerPosition = new kakao.maps.LatLng(latitude, longitude);
                var markerImage = new kakao.maps.MarkerImage(
                    'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                    new kakao.maps.Size(24, 24),
                    {
                        offset: new kakao.maps.Point(12, 12)
                    }
                );
                var marker = new kakao.maps.Marker({
                    position: markerPosition,
                    map: map,
                    title: name,
                    image: markerImage
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="padding:5px;font-size:14px;">' +
                        name + '<br>' + description + '</div>',
                    position: markerPosition
                });

                // 마커 클릭 이벤트 리스너 등록
                kakao.maps.event.addListener(marker, 'click', function () {
                    if (currentInfowindow) {
                        currentInfowindow.close();
                    }
                    infowindow.open(map, marker);
                    currentInfowindow = infowindow;
                });

                markers.push(marker); // 이 부분을 수정하여 markers 배열에 마커를 추가하도록 변경
                infowindows.push(infowindow); // infowindows 배열에 인포윈도우를 추가
            }



// addMarker 함수를 호출하여 마커 추가
<% for (int i = 0; i < markerInfoList.Count; i++) { %>
            var markerInfo = '<%= markerInfoList[i] %>'.split('<br>');
            addMarker(markerInfo[0], markerInfo[1], markerInfo[2], markerInfo[3]);
<% } %>





            // 여기에 목록을 생성하고 표시하는 코드 추가
            var categoryListContainer = document.getElementById('category-list');

            // 데이터베이스에서 가져온 목록 정보를 이용하여 목록을 생성하고 표시
            function addCategoryToList(name, description) {
                // 새로운 div 엘리먼트를 생성합니다.
                var listItem = document.createElement('div');

                // category-title 클래스를 가진 div를 추가합니다.
                var titleDiv = document.createElement('div');
                titleDiv.className = 'category-title';
                titleDiv.innerHTML = name;

                // category-item 클래스를 가진 div를 추가합니다.
                var itemDiv = document.createElement('div');
                itemDiv.className = 'category-item';
                itemDiv.innerHTML = description;

                // listItem에 titleDiv와 itemDiv를 추가합니다.
                listItem.appendChild(titleDiv);
                listItem.appendChild(itemDiv);

                // categoryListContainer에 새로 생성한 listItem을 추가합니다.
                categoryListContainer.appendChild(listItem);


            }

            // 카테고리 선택 전에는 안내문구를 추가합니다.
            function addGuidanceMessage() {
                // 새로운 div 엘리먼트를 생성합니다.
                var guidanceDiv = document.createElement('div');

                // 안내문구를 추가합니다.
                guidanceDiv.innerHTML = '<p>카테고리를 선택해주세요.</p>';

                // categoryListContainer에 안내문구를 추가합니다.
                categoryListContainer.appendChild(guidanceDiv);
            }

    // 데이터베이스에서 가져온 목록에 대해 함수 호출
    <% if (markerInfoList.Count > 0) { %>
        <% foreach (var markerInfo in markerInfoList) { %>
            var markerInfo = '<%= markerInfo %>'.split('<br>');
            addCategoryToList(markerInfo[0], markerInfo[1]);
        <% } %>
    <% } else { %>
        // 카테고리 목록이 없는 경우 안내문구를 추가합니다.
        addGuidanceMessage();
    <% } %>

            function updateMarkersOnMap() {
                // 기존 마커 삭제
                removeAllMarkers();

    // 새로운 마커 추가
    <% foreach (var markerInfo in markerInfoList) { %>
        var markerInfo = '<%= markerInfo %>'.split('<br>');
        addMarker(markerInfo[0], markerInfo[1], markerInfo[2], markerInfo[3]);
    <% } %>
            }

            function removeAllMarkers() {
                // 기존 마커를 모두 제거하는 코드 작성
                map.removeOverlay(marker);
            }


        </script>

        
    </div>
        
    </form>
</body>

</html>
</html>