using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class ReviewPage : System.Web.UI.Page
{
    string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStores();
            LoadReviews();
        }
    }

    private void LoadStores()
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            string queryString = "SELECT Id, Name FROM Stores";
            DataTable dt = new DataTable();

            using (SqlCommand cmd = new SqlCommand(queryString, connection))
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                dt.Load(reader);
            }

            ddlStores.DataSource = dt;
            ddlStores.DataTextField = "Name";
            ddlStores.DataValueField = "Id";
            ddlStores.DataBind();

            LoadReviews();
        }
    }

    private void LoadReviews()
    {
        if (ddlStores.SelectedIndex > 0)
        {
            int storeId = int.Parse(ddlStores.SelectedValue);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // 수정된 쿼리문: Board와 Stores 테이블을 조인하여 이미지와 리뷰를 함께 가져오도록 변경
                string queryString = "SELECT B.Rating, B.Writer, B.Title, B.Content, B.Created_date, S.ImagePath " +
                                     "FROM Board B " +
                                     "JOIN Stores S ON B.StoreId = S.Id " +
                                     "WHERE B.StoreId = @StoreId";

                DataTable dt = new DataTable();

                using (SqlCommand cmd = new SqlCommand(queryString, connection))
                {
                    cmd.Parameters.AddWithValue("@StoreId", storeId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
                }

                GridViewBoards.DataSource = dt;
                GridViewBoards.DataBind();

                // LoadRestaurantInfo 호출
                LoadRestaurantInfo();
            }
        }
    }

    private void LoadRestaurantInfo()
    {
        if (ddlStores.SelectedIndex > 0)
        {
            int storeId = int.Parse(ddlStores.SelectedValue);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string queryString = "SELECT Name, Description, ImagePath FROM Stores WHERE Id = @StoreId";
                DataTable dt = new DataTable();

                using (SqlCommand cmd = new SqlCommand(queryString, connection))
                {
                    cmd.Parameters.AddWithValue("@StoreId", storeId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
                }

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    lblRstName.Text = row["Name"].ToString();
                    lblStore.Text = row["Description"].ToString();

                    // 이미지 경로를 가져와 이미지 컨트롤에 설정
                    string imagePath = row["ImagePath"].ToString();

                    // 이미지 컨트롤의 ImageUrl 속성에 경로 설정
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        // 이미지를 표시할 Image 컨트롤의 ID를 확인하고 해당 ID로 설정
                        Image1.ImageUrl = imagePath;
                    }
                    else
                    {
                        // 이미지가 없을 경우 기본 이미지 경로를 설정하거나 숨김 처리
                        Image1.ImageUrl = "기본이미지경로.jpg";
                    }
                }
            }
        }
    }




    protected void btnHome_Click1(object sender, EventArgs e)
    {
        Response.Redirect("~/ZinMainPage.aspx");
    }

    protected void ButtonSubmit_Click(object sender, EventArgs e)
    {
        if (ddlStores.SelectedIndex > 0)
        {
            string writer = TextBoxWriter.Text;
            string title = TextBoxTitle.Text;
            string content = TextBoxContent.Text;
            int storeId = int.Parse(ddlStores.SelectedValue);
            int rating = int.Parse(hfRating.Value);

            string queryString = "INSERT INTO Board (Writer, Title, Content, Created_date, StoreId, Rating) VALUES (@Writer, @Title, @Content, GETDATE(), @StoreId, @Rating)";

            if (!string.IsNullOrEmpty(writer) && !string.IsNullOrEmpty(title) && !string.IsNullOrEmpty(content))
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand cmd = new SqlCommand(queryString, connection))
                    {
                        cmd.Parameters.AddWithValue("@Writer", writer);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Content", content);
                        cmd.Parameters.AddWithValue("@StoreId", storeId);
                        cmd.Parameters.AddWithValue("@Rating", rating);

                        cmd.ExecuteNonQuery();
                    }
                }

                LoadReviews();

                TextBoxWriter.Text = "";
                TextBoxTitle.Text = "";
                TextBoxContent.Text = "";
            }
            else
            {
                Response.Write("<script>alert('모든 필드를 입력하세요.');</script>");
            }
        }
        else
        {
            Response.Write("<script>alert('가게를 선택하세요.');</script>");
        }
    }

    protected void ddlStores_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadReviews();
    }
}