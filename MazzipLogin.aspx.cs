using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class MazzipLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 페이지 로드 시 실행되는 코드
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // 사용자가 입력한 아이디와 패스워드
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        // 데이터베이스 연결 문자열
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=users;Integrated Security=True";

        // SQL 쿼리문
        string query = "SELECT COUNT(*) FROM Users WHERE UserName = @UserName AND Password = @Password";

        try
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // 파라미터 추가
                    command.Parameters.AddWithValue("@UserName", username);
                    command.Parameters.AddWithValue("@Password", password);

                    // 데이터베이스 연결 열기
                    connection.Open();

                    // 쿼리 실행 후 결과 가져오기
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // 로그인 성공
                        // 여기서 어드민 여부를 확인하고, 어드민이면 AdminPage로 리다이렉션
                        if ( IsAdmin(username))
                        {
                            Response.Redirect("~/Admin.aspx");
                        }
                        else
                        {
                            Response.Redirect("~/ZinMainPage.aspx");  // 일반 사용자는 MainPage로 리다이렉션
                        }
                    }
                    else
                    {
                        // 로그인 실패
                        // 실패 메시지를 표시하거나 다른 처리를 수행할 수 있음
                        Response.Write("<script>alert('아이디 또는 패스워드가 잘못되었습니다.');</script>");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // 오류 처리
            Response.Write("오류 발생: " + ex.Message);
        }
    }

    // 어드민 여부를 확인하는 메서드
    private bool IsAdmin(string username)
    {
        // 여기에서 어드민 여부를 확인하는 로직을 추가
        // 예를 들어, 어드민 테이블을 만들어서 해당 아이디가 어드민인지 확인할 수 있음
        // 이 예시에서는 임의로 "admin" 아이디가 어드민으로 간주되도록 함
        return username.ToLower() == "admin";
    }

    protected void btnOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/MainPage.aspx");
    }
}