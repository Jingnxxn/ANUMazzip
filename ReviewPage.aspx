<%@ Page Title="" Language="C#" MasterPageFile="~/Mazzip.master" AutoEventWireup="true" CodeFile="ReviewPage.aspx.cs" Inherits="ReviewPage" %>

<asp:Content ID="cntReview" ContentPlaceHolderID="cphMazzip" Runat="Server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <!-- Bootstrap 추가 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- 추가된 JavaScript 코드 -->
    <script type="text/javascript">
        function setRating(rating) {
            // 선택된 별점을 HiddenField에 저장
            document.getElementById('<%= hfRating.ClientID %>').value = rating;

            // 모든 별점 초기화
            var stars = document.querySelectorAll('#starRating .star');
            stars.forEach(function (star) {
                star.style.color = 'black';
            });

            // 선택된 별점까지 색상 변경
            for (var i = 0; i < rating; i++) {
                stars[i].style.color = 'gold';
            }
        }
    </script>

    <style>
        #html{
            background-color:#fff9d4;
        }
        .body {
            font-family: 'Jua', sans-serif;
            width: 100%;
            background-size: cover;
            color: #fff;
            text-align: center;
        }

        .header {
            background-color: #eee;
            color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .restaurant-name-container {
            margin: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .auto-style10 {
            background-color: #eee;
            color: black;
            text-align: center;
            padding: 20px;
            width: 608px;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            border-radius:10px;
            z-index: 1;
        }

        .review-section {
            background-color: #ffb74a;
            padding: 20px;
            margin: 20px;
            border-radius: 15px;
        }

        .container {
            margin: 20px;
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .review-input {
            margin-top: 20px;
        }

        .auto-style9 {
            padding: 8px 15px;
            background-color: #f90;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 20px;
            font-family: 'Jua', sans-serif;
        }

        /* 추가한 부분 */
        #Image1 {
            width: 100%; /* 이미지를 가득 채우도록 */
            z-index: 0;
        }
        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        .table th {
            background-color: #f90;
            color: #fff;
        }

        .word-break {
            word-wrap: break-word;
            white-space: normal !important;
        }
        .auto-style11 {
            display: block;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-clip: padding-box;
            border-radius: .25rem;
            transition: none;
            border: 1px solid #ced4da;
            background-color: #fff;
            border: none; /* 테두리 제거 */
        }
        .auto-style12 {
            margin-top: 20px;
            text-align: left;
            background-color:#eee; 
            color:black; 
            border-radius:16px;
            font-family: 'Jua', sans-serif;
            width: auto;
            height: auto;
        }
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
        }
    </style>

    <div class="body" style="background-color:#fff9d4">
        <div class="header">
            <div class="text-left">
                <asp:Button CssClass="auto-style9" ID="btnHome" runat="server" Text="메인 페이지" style="border:none" OnClick="btnHome_Click1" Height="40px" />
                <asp:DropDownList ID="ddlStores" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlStores_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>

        <div class="restaurant-name-container">
            <asp:Image ID="Image1" runat="server" Height="400px" style="z-index: 0; margin:0 50px" />
            <div class="auto-style10">
                <asp:Label ID="lblRstName" runat="server" CssClass="restaurant-name" Font-Size="20"></asp:Label>  
            </div>
        </div>
        <div class="review-section">
            <div style="background-color:#eee; color:black; border-radius:16px; font-family: 'Jua', sans-serif">
                <h2>- 가게 정보- </h2>
                <div>
                    <asp:Label ID="lblStore" runat="server"></asp:Label>
                </div>
            </div>
            <br />
            <div style="background-color:#eee; color:black; border-radius:16px; font-family: 'Jua', sans-serif">
                <h2>- 리뷰 목록 -</h2>
                <div class="row justify-content-center">         
                    <asp:GridView ID="GridViewBoards" runat="server" AutoGenerateColumns="False" DataKeyNames="Writer" CssClass="table table-striped">
                        <HeaderStyle CssClass="table-header" />                    
                        <Columns>
                            <asp:BoundField DataField="Rating" HeaderText="별점" SortExpression="Rating" />
                            <asp:BoundField DataField="Writer" HeaderText="작성자" SortExpression="Writer" />
                            <asp:BoundField DataField="Title" HeaderText="제목" SortExpression="Title" />
                            <asp:BoundField DataField="Content" HeaderText="내용" SortExpression="Content" ItemStyle-CssClass="word-break" />
                            <asp:BoundField DataField="Created_date" HeaderText="작성일" SortExpression="Created_date" />

                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <br />
            <div class="auto-style12">
                <h2>- 리뷰 작성 -</h2>
                <div id="starRating" class="star-rating" style="font-size: 30px; margin-left:10px">
                    <span class="star" data-rating="1" onclick="setRating(1)">&#9733;</span>
                    <span class="star" data-rating="2" onclick="setRating(2)">&#9733;</span>
                    <span class="star" data-rating="3" onclick="setRating(3)">&#9733;</span>
                    <span class="star" data-rating="4" onclick="setRating(4)">&#9733;</span>
                    <span class="star" data-rating="5" onclick="setRating(5)">&#9733;</span>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="TextBoxWriter" runat="server" CssClass="form-control" placeholder="당신의 이름을 써주세요." style="border: none; margin-left:10px"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="TextBoxTitle" runat="server" CssClass="form-control" placeholder="제목을 작성해주세요." style="border: none; margin-left:10px;"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="TextBoxContent" runat="server" CssClass="auto-style11 form-control" TextMode="MultiLine" placeholder="내용을 작성해주세요." Height="321px" Width="600px" style="border: none; margin-left:10px"></asp:TextBox>
                </div>
                <div style="margin-left:10px;">
                <asp:Button ID="ButtonSubmit" runat="server" Text="작성하기" CssClass="Button" OnClick="ButtonSubmit_Click" BackColor="gray" font-size="20px" />
                </div>
                <br />
            </div>          
            <!-- HiddenField 추가 -->
            <asp:HiddenField ID="hfRating" runat="server" />
        </div>
    </div>
</asp:Content>