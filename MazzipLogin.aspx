<%@ Page Title="" Language="C#" MasterPageFile="~/Mazzip.master" AutoEventWireup="true" CodeFile="MazzipLogin.aspx.cs" Inherits="MazzipLogin" %>

<asp:Content ID="cntMazzip" ContentPlaceHolderID="cphMazzip" Runat="Server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <div class="auto-style10">
        <asp:Button ID="btnOut" CssClass="auto-style11" runat="server" 
            style="border:none" Text=" X " Font-Size="30" OnClick="btnOut_Click" Height="46px" Width="58px"/>
    </div>
    <div class="auto-style9" style="background-color:#fff9d4">
        <div class="container" style="background-color:#eee">
            <div class="auto-style8">
                <asp:Label ID="Label1" runat="server" Text="로그인" Font-Size="30"></asp:Label>
            </div>
            <br /><br />
            <div class="auto-style6">
                <asp:Label ID="lblLogin" runat="server" Text="로그인"></asp:Label>
                <br />
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input"></asp:TextBox>
            </div>
            <div class="auto-style6">
                <asp:Label ID="lblPassword" runat="server" Text="비밀번호"></asp:Label>
                <br />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>
            </div>
            <br />
            <div class="auto-style7">
                <asp:Button ID="btnLogin" runat="server" Text="로그인" Height="40px" Width="235px" 
                    CssClass="Button" style="border:none" OnClick="btnLogin_Click" UseSubmitBehavior="false"/>
            </div>
            <br />
            <div class="auto-style8">
                <asp:HyperLink ID="HLSignUp" runat="server" NavigateUrl="~/SignUpPage.aspx" Font-Size="8">회원가입 하기</asp:HyperLink>
                <br />
                <asp:HyperLink ID="HlNonM" runat="server" NavigateUrl="~/MainPage.aspx" Font-Size="8">비회원으로 보기</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style9 {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: right;
            margin: 0;
        }
        .auto-style10 {
            position: absolute;
            top: 0;
            right: 0;
            margin: 80px;
        }
    .auto-style11 {
        font-family: Jua, sans-serif;
        color: #fff;
        font-size: 15px;
        border-radius: 16px;
        border-style: none;
        border-color: inherit;
        border-width: medium;
        background: #f90;
    }
    </style>
</asp:Content>
