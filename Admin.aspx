<%@ Page Title="" Language="C#" MasterPageFile="~/Mazzip.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="cntAdminPage" ContentPlaceHolderID="cphMazzip" Runat="Server">
    <style>
        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #fff; /* 표의 배경색을 흰색으로 지정 */
        }

        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        .table th {
            background-color: gray; /* 표의 헤더 배경색을 회색으로 지정 */
            color: #fff;
        }

        .table-header {
            background-color: gray; /* 표의 헤더 배경색을 회색으로 지정 */
            color: #fff;
            align-items:center;
        }
    .auto-style9 {
        text-align: left;
    }
    </style>
    <div class="full-container" runat="server">
        <div class="container" style="height:auto; width:auto">
            <h2 class="auto-style9">유저 정보</h2>
            <div class="row justify-content-center">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                    DataKeyNames="UserName" 
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating"
                    OnRowDeleting="GridView1_RowDeleting" AllowPaging="False" CssClass="mx-auto table">
                    <HeaderStyle CssClass="table-header" />
                    <Columns>
                        <asp:BoundField DataField="UserName" HeaderText="유저 아이디" SortExpression="UserName" />
                        <asp:BoundField DataField="Name" HeaderText="유저 이름" SortExpression="Name" />
                        <asp:BoundField DataField="Email" HeaderText="유저 메일" SortExpression="Email" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>

                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString= "Data Source=DESKTOP-6TVR91V;Initial Catalog=users;Integrated Security=True"
                    SelectCommand="SELECT UserName, Name, Email FROM Users"
                    UpdateCommand="UPDATE Users SET Name = @Name, Email = @Email WHERE UserName = @UserName"
                    DeleteCommand="DELETE FROM Users WHERE UserName = @UserName">
                    <UpdateParameters>
                        <asp:Parameter Name="UserName" Type="String" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="Name" Type="String" />
                    </UpdateParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="UserName" Type="String" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </div>
            <h2 class="auto-style9">리뷰 정보</h2>
            <div>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="mx-auto table" 
                    DataKeyNames="Writer"
                    OnRowCancelingEdit="GridView2_RowCancelingEdit"
                    OnRowDeleting="GridView2_RowDeleting" OnRowUpdating="GridView2_RowUpdating" AllowPaging="false">
                    <HeaderStyle CssClass="table-header" />
                    <Columns>
                        <asp:BoundField DataField="Writer" HeaderText="작성자" SortExpression="Writer" />
                        <asp:BoundField DataField="Title" HeaderText="제목" SortExpression="Title" />
                        <asp:BoundField DataField="Content" HeaderText="내용" SortExpression="Content" />
                        <asp:BoundField DataField="Created_date" HeaderText="작성일" SortExpression="Created_date" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSourceReviews" runat="server"
                ConnectionString= "Data Source=DESKTOP-6TVR91V;Initial Catalog=category;Integrated Security=True"
                SelectCommand="SELECT Writer, Title, Content, Created_date FROM Board"
                DeleteCommand="DELETE FROM Board WHERE Writer = @Writer">
                <UpdateParameters>
                    <asp:Parameter Name="Writer" Type="String" />
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Content" Type="String" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Writer" Type="String" />
                </DeleteParameters>
            </asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>