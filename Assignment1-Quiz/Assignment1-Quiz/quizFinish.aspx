﻿<%@ Page Title="" Language="C#" MasterPageFile="~/quiz.Master" AutoEventWireup="true" CodeBehind="quizFinish.aspx.cs" Inherits="Assignment1_Quiz.quizFinish" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentBlock" runat="server">

    <div class="progress"><!--Contains progress bar-->
        <div class="progress-bar progress-bar-success progress-bar-striped" style="width: 100%"></div>
    </div>

    <div id="divLeftColumn" class="col-xs-12 col-md-6" runat="server"><!--Left Column-->
    </div><!--End Left Column-->

        <div class="col-xs-12 col-md-6"><!--Right Column-->
        <div class="col-xs-12 center-block spacer formHolder" style="font-size:18px">
            <strong><asp:Label ID="lblTimeTaken" runat="server" /></strong>
        </div>

        <div class="col-xs-12 formHolder spacer">
            <asp:Label ID="lblScore" runat="server" />
        </div>
        
        <div class="col-sm-12 formHolder spacer">
            <div class="col-xs-12 col-md-6 formHolder">
                <asp:Label ID="lblTotalPeople" runat="server" />
            </div>
            <div class="col-xs-12 col-md-6 formHolder">
                <asp:Label ID="lblAverageScore" runat="server" />
            </div>
        </div>

        <div class="col-xs-12 formHolder">
            <div id="chartContainer" class="ansSpacer" style="height: 300px; width: 100%;"></div>
        </div>

        <div class="col-md-12 ansSpacer formHolder">
            <asp:Button ID="btnNewQuiz" Text="Select New Quiz" CssClass="btn btn-default col-xs-12 col-md-6 spacer " OnClick="btnNewQuiz_Click" runat="server" />
            <asp:Button ID="btnRestartQuiz" Text="Restart Quiz" CssClass="btn btn-default col-xs-12 col-md-6 spacer " OnClick="btnRestartQuiz_Click" runat="server" />
        </div>
    </div><!--End Right Column-->

    <script type="text/javascript">

        //Dispalys the the users score and average in a bar chart
        //http://canvasjs.com/editor/?id=http://canvasjs.com/example/gallery/column/oil_reserves/

        window.onload = function () {
            var chart = new CanvasJS.Chart("chartContainer",
            {
            title:{
                text: "Score Comparison"
            },
            animationEnabled: true,
            theme: "theme1",
            data: [
                {        
                    type: "column",  
                    dataPoints: [      
                        {y: <%=score%>, label: "Your Score"},      
                        {y: Math.round(<%=average%> * 100) / 100, label: "Average Score" }
                    ]
                }   
            ]
            });

            chart.render();
        }
    </script>
    <script type="text/javascript" src="/js/canvasjs.min.js"></script>
</asp:Content>
