﻿<%@ Page Title="" Language="C#" MasterPageFile="~/quiz.Master" AutoEventWireup="true" CodeBehind="question1.aspx.cs" Inherits="Assignment1_Quiz.question1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentBlock" runat="server">

    <div class="progress col-xs-12">
        <div class="progress-bar progress-bar-info progress-bar-striped" style="width: 0%"></div>
    </div>

    <strong><asp:Label ID="lblQuestion" CssClass="col-xs-12 text-center" runat="server" /></strong>

    <div class="ansSpacer col-xs-12">
        <asp:RadioButtonList  ID="lstAnswers" runat="server" />
    </div>

    <div class="spacer col-xs-12">
        <asp:Button ID="btnNextQuestion" Text="Next Question" CssClass="btn spacer col-xs-6 btn-default pull-right" OnClick="btnNextQuestion_Click" runat="server" />
    </div>
</asp:Content>
