using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SignUpPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        // 사용자가 입력한 회원가입 정보
        string name = txtName.Text;
        string email = txtEmail.Text;
        string username = txtUsername.Text;
        string password = txtPassword.Text;

        // 입력 유효성 검사
        if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            Response.Write("<script>alert('모든 필드를 입력해주세요.');</script>");
            return;
        }

        // 데이터베이스 연결 문자열
        string connectionString = "Data Source=DESKTOP-6TVR91V;Initial Catalog=users;Integrated Security=True";

        // SQL 쿼리문
        string query = "INSERT INTO Users (UserName, Password, Name, Email) VALUES (@UserName, @Password, @Name, @Email)";

        try
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // 파라미터 추가
                    command.Parameters.AddWithValue("@UserName", username);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@Password", password);

                    // 데이터베이스 연결 열기
                    connection.Open();

                    // 쿼리 실행
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // 회원가입 성공
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('회원가입이 완료되었습니다.'); window.location.href='MazzipLogin.aspx';", true);
                    }
                    else
                    {
                        // 회원가입 실패
                        Response.Write("<script>alert('회원가입에 실패하였습니다.');</script>");
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

    protected void txtEmail_TextChanged(object sender, EventArgs e)
    {

    }
}