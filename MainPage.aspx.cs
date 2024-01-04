using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected List<string> markerInfoList = new List<string>();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) //페이지 처음 로드될 때
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "KakaoMapScript", GetKakaoMapScript(), true);
            LoadMarkers();
        }
    }
    private void LoadMarkers()
    {
        LoadMarkersWithCategory("bars");
        LoadMarkersWithCategory("restaurants");
        LoadMarkersWithCategory("cafes");
    }
    private string GetKakaoMapScript()
    {
        // 카카오 맵 API 스크립트를 생성하는 메서드
        return @"var mapContainer = document.getElementById('mapPanel'), mapOption = {
                center: new kakao.maps.LatLng(36.54326, 128.79626),
                level: 2,
                mapTypeId: kakao.maps.MapTypeId.ROADMAP
            };
        var map = new kakao.maps.Map(mapContainer, mapOption);";
    }


    protected void loginBtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("MazzipLogin.aspx");
    }

    private void LoadMarkersWithCategory(string category)
    {

        //이전마커정보 리스트 초기화
        markerInfoList.Clear();
        // SQL Server 연결 문자열
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True";

        // SQL 쿼리
        string query = string.Format("SELECT Name, Latitude, Longitude, Description FROM {0}", category);

        // 데이터베이스 연결 생성
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            // SQL Command 생성
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // 연결 열기
                connection.Open();

                // 데이터 가져오기
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string name = reader["Name"].ToString();
                        double latitude = Convert.ToDouble(reader["Latitude"]);
                        double longitude = Convert.ToDouble(reader["Longitude"]);
                        string description = reader["Description"].ToString();

                        // 각 음식점의 정보를 이용하여 마커를 생성하고 지도에 표시
                        // AddMarkerToMap(name, latitude, longitude, description); 

                        // addMarker 함수 호출
                        string markerScript = string.Format("addMarker('{0}', {1}, {2}, '{3}');", name, latitude, longitude, description);
                        ScriptManager.RegisterStartupScript(this, GetType(), "MarkerScript" + name, markerScript, true);

                        //마커 정보 리스트에추가
                        markerInfoList.Add(string.Format("{0}<br>{1}", name, description));

                    }

                }
                UpdateCategoryList(category, markerInfoList);

                // 연결 닫기
                connection.Close();
            }
        }
    }


    private void AddMarkerToMap(string name, double latitude, double longitude, string description)
    {
        // Font Awesome 아이콘의 이미지 URL
        string iconImageUrl = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png";

        // 기존의 맵 스크립트를 변경하지 않고, 해당 함수로 마커를 추가
        string markerScript = string.Format(@"
    var markerPosition = new kakao.maps.LatLng({0}, {1});
    var markerImage = new kakao.maps.MarkerImage('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', new kakao.maps.Size(24, 24), {{
        offset: new kakao.maps.Point(12, 12)
    }});
    var marker = new kakao.maps.Marker({{
        position: markerPosition,
        map: map,
        title: '{2}',
        image: markerImage
    }});
    var infowindow = new kakao.maps.InfoWindow({{
        content: '{2}<br>{3}'
    }});
    kakao.maps.event.addListener(marker, 'click', function() {{
        infowindow.open(map, marker);
    }});
    ", latitude, longitude, name, description, iconImageUrl);

        ScriptManager.RegisterStartupScript(this, GetType(), "MarkerScript" + name, markerScript, true);
    }

    private void UpdateCategoryList(string category, List<string> markerInfoList)
    {

        // 카테고리에 해당하는 목록 업데이트
        string listHtml = string.Format("<h2>{0}</h2><ul>{1}</ul>", category, string.Join("", markerInfoList.Select(info => "<li>" + info + "</li>").ToArray()));


        // ScriptManager를 통해 클라이언트 측으로 목록 업데이트 코드 전달
        ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCategoryList", "$('#category-list').html('" + listHtml + "');", true);
    }



    protected void cafeBtn_Click(object sender, EventArgs e)
    {
        LoadMarkersWithCategory("cafes");
    }

    protected void restauratnBtn_Click(object sender, EventArgs e)
    {
        LoadMarkersWithCategory("restaurants");

    }

    protected void barBtn_Click(object sender, EventArgs e)
    {
        LoadMarkersWithCategory("bars");
    }

    private void SearchInAllCategories(string searchTerm)
    {
        // 이전 마커 정보 리스트 초기화
        markerInfoList.Clear();

        // 각 카테고리에 대해 검색을 수행하고 결과를 누적
        SearchInCategory("restaurants", searchTerm);
        SearchInCategory("cafes", searchTerm);
        SearchInCategory("bars", searchTerm);

        // 업데이트된 마커 정보로 카테고리 목록 업데이트
        UpdateCategoryList("restaurants", markerInfoList);
        UpdateCategoryList("cafes", markerInfoList);
        UpdateCategoryList("bars", markerInfoList);
    }
    protected void searchBtn_Click(object sender, EventArgs e)
    {
        // 검색어를 가져오기
        string searchTerm = searchInput.Text.Trim();

        if (!string.IsNullOrEmpty(searchTerm))
        {
            // 이전 마커 정보 리스트 초기화
            markerInfoList.Clear();

            // 각 카테고리에 대해 검색을 수행하고 결과를 누적
            List<string> restaurantsMarkerList = new List<string>();
            List<string> cafesMarkerList = new List<string>();
            List<string> barsMarkerList = new List<string>();
            // 각 카테고리에 대해 검색을 수행하고 결과를 누적
            SearchInCategory("restaurants", searchTerm);
            SearchInCategory("cafes", searchTerm);
            SearchInCategory("bars", searchTerm);

            // 업데이트된 마커 정보로 카테고리 목록 업데이트
            UpdateCategoryList("restaurants", markerInfoList);
            UpdateCategoryList("cafes", markerInfoList);
            UpdateCategoryList("bars", markerInfoList);
        }
   

}
    private void SearchInCategory(string category, string searchTerm)
    {
        // SQL Server 연결 문자열
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True";

        // SQL 쿼리 - 검색어를 사용하여 필터링
        string query = string.Format("SELECT Name, Latitude, Longitude, Description FROM {0} WHERE Name LIKE '%{1}%'", category, searchTerm);



        // 데이터베이스 연결 생성
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            // SQL Command 생성
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // 연결 열기
                connection.Open();

                // 데이터 가져오기
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string name = reader["Name"].ToString();
                        double latitude = Convert.ToDouble(reader["Latitude"]);
                        double longitude = Convert.ToDouble(reader["Longitude"]);
                        string description = reader["Description"].ToString();

                        // 검색어가 해당 음식점의 이름에 포함되어 있는 경우에만 추가
                        if (name.Contains(searchTerm))
                        {
                            // 각 음식점의 정보를 이용하여 마커를 생성하고 지도에 표시
                            // addMarker 함수 호출
                            string markerScript = string.Format("addMarker('{0}', {1}, {2}, '{3}');", name, latitude, longitude, description);
                            ScriptManager.RegisterStartupScript(this, GetType(), "MarkerScript" + name, markerScript, true);

                            // 마커 정보 리스트에 추가
                            markerInfoList.Add(string.Format("{0}<br>{1}", name, description));
                        }
                    }

                    // 연결 닫기
                    connection.Close();
                }
            }

            // 업데이트된 마커 정보로 카테고리 목록 업데이트
            UpdateCategoryList(category, markerInfoList);
        }
    }
}

