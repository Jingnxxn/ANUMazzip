<%@ Page Title="" Language="C#" MasterPageFile="~/Mazzip.master" AutoEventWireup="true" CodeFile="SignUpPage.aspx.cs" Inherits="SignUpPage" %>

<asp:Content ID="cntMazzipSignUp" ContentPlaceHolderID="cphMazzip" Runat="Server">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/ea10983b3f.js" crossorigin="anonymous"></script>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <div class="full-container"  style="background-color:#fff9d4;"  >
        <div class="container" style="background-color:#eee;">
            <div style="font-size: 30px;">
            <h2>
                <i class="fa-regular fa-user" style="color: #A55D00;"></i>&nbsp;회원 정보 입력
            </h2>
            </div>
            <div class="form-group">
                <label>이름</label>
                <asp:TextBox ID="txtName" runat="server" Height="40px" ></asp:TextBox>
            </div>
            <div class="form-group">
                <div style="display: flex; justify-content: space-between;">
                    <div style="width: 48%;">
                        <label>
                        <br />
                        E - MAIL</label>
                        <asp:TextBox ID="txtEmail" runat="server" OnTextChanged="txtEmail_TextChanged" Height="40px"></asp:TextBox>
            
                    </div>
                    <div style="width: 48%;">
                        <label>
                        <br />
                        아이디</label>
                        <asp:TextBox ID="txtUsername" runat="server" Height="40px"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div style="display: flex; justify-content: space-between;">
                    <div style="width: 48%;">
                        <label>
                        <br />
                        비밀번호</label>
                        <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" Height="40px"></asp:TextBox>
            
                    </div>
                    <div style="width: 48%;">
                        <label>
                        <br />
                        비밀번호 확인</label>
                        <asp:TextBox ID="txtConfirmPassword" TextMode="Password" runat="server" Height="40px"></asp:TextBox>
                        <br />
                        <br />
                    </div>
                </div>
            </div>
            <div class="btn-container">
                <asp:Button ID="btnSignUp" Text="회원 가입" OnClick="btnSignUp_Click" runat="server" Width="84px" Height="37px" CssClass="btnSignUp" />
            </div>
        </div>
    </div>
        </html>
</asp:Content>

