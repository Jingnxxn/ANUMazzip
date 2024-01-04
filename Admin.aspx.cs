using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDataFromDatabase();
            LoadReviewDataFromDatabase();
        }
    }

    private void LoadDataFromDatabase()
    {
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=users;Integrated Security=True";

        // SQL 쿼리문
        string query = "SELECT UserName, Name, Email FROM Users";

        // 데이터베이스 연결 및 데이터 가져오기
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                // GridView에 데이터 바인딩
                GridView1.DataSource = reader;
                GridView1.DataBind();
            }
        }
    }
    private void LoadReviewDataFromDatabase()
    {
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True";

        // SQL 쿼리문
        string query = "SELECT Writer, Title, Content, Created_date FROM Board";

        // 데이터베이스 연결 및 데이터 가져오기
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                // GridView에 데이터 바인딩
                GridView2.DataSource = reader;
                GridView2.DataBind();
            }
        }
    }

    protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
    {
        // GridView의 편집 모드를 취소하고 원래의 데이터로 돌아감
        GridView1.EditIndex = -1;
        LoadDataFromDatabase();
    }

    protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=users;Integrated Security=True";

        // GridView에서 편집한 데이터를 데이터베이스에 업데이트
        string primaryKeyValue = GridView1.DataKeys[e.RowIndex].Values["UserName"].ToString();
        string updatedValue1 = e.NewValues["Name"].ToString();
        string updatedValue2 = e.NewValues["Email"].ToString();

        // 데이터베이스 연결 및 업데이트 쿼리 실행
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string updateQuery = "UPDATE Users SET Name = @Name, Email = @Email WHERE UserName = @UserName";

            using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
            {
                updateCommand.Parameters.AddWithValue("@Name", updatedValue1);
                updateCommand.Parameters.AddWithValue("@Email", updatedValue2);
                updateCommand.Parameters.AddWithValue("@UserName", primaryKeyValue);

                connection.Open();
                updateCommand.ExecuteNonQuery();
            }
        }

        GridView1.EditIndex = -1;
        LoadDataFromDatabase();
    }

    protected void GridView1_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=users;Integrated Security=True";

        // GridView에서 선택한 행을 데이터베이스에서 삭제
        string primaryKeyValue = GridView1.DataKeys[e.RowIndex].Values["UserName"].ToString();

        // 데이터베이스 연결 및 삭제 쿼리 실행
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string deleteQuery = "DELETE FROM Users WHERE UserName = @UserName";

            using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
            {
                deleteCommand.Parameters.AddWithValue("@UserName", primaryKeyValue);

                connection.Open();
                deleteCommand.ExecuteNonQuery();
            }
        }

        LoadDataFromDatabase();
    }

    protected void GridView1_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        // 서버 측 데이터 페이징 대신 클라이언트 측 데이터 페이징을 수행
        GridView1.PageIndex = e.NewPageIndex;
        LoadDataFromDatabase();
    }

    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True";

        // GridView에서 선택한 행을 데이터베이스에서 삭제
        string primaryKeyValue = GridView2.DataKeys[e.RowIndex].Values["Writer"].ToString();

        // 데이터베이스 연결 및 삭제 쿼리 실행
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string deleteQuery = "DELETE FROM Board WHERE Id = @Writer";

            using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
            {
                deleteCommand.Parameters.AddWithValue("@Writer", primaryKeyValue);

                connection.Open();
                deleteCommand.ExecuteNonQuery();
            }
        }

        LoadReviewDataFromDatabase();
    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True";

        // GridView에서 선택한 행을 데이터베이스에서 삭제
        string primaryKeyValue = GridView2.DataKeys[e.RowIndex].Values["Writer"].ToString();

        // 데이터베이스 연결 및 삭제 쿼리 실행
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string deleteQuery = "DELETE FROM Board WHERE Writer = @Writer";

            using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
            {
                deleteCommand.Parameters.AddWithValue("@Writer", primaryKeyValue);

                connection.Open();
                deleteCommand.ExecuteNonQuery();
            }
        }

        LoadReviewDataFromDatabase();
    }

    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True";

        string primaryKeyValue = GridView2.DataKeys[e.RowIndex].Values["Writer"].ToString();
        string updatedValue2 = e.NewValues["Title"].ToString();
        string updatedValue3 = e.NewValues["Content"].ToString();

        // 데이터베이스 연결 및 업데이트 쿼리 실행
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string updateQuery = "UPDATE Board SET Title = @Title, Content = @Content WHERE Writer = @Writer";

            using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
            {
                updateCommand.Parameters.AddWithValue("@Title", updatedValue2);
                updateCommand.Parameters.AddWithValue("@Content", updatedValue3);
                updateCommand.Parameters.AddWithValue("@Id", primaryKeyValue);

                connection.Open();
                updateCommand.ExecuteNonQuery();
            }
        }

        GridView2.EditIndex = -1;
        LoadReviewDataFromDatabase();
    }
}