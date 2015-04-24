﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Assignment1_Quiz
{
    /// <summary>
    /// Group:
    /// 
    /// Brian Geraghty
    /// s00077881
    /// -------------
    /// Fergal Gaffney
    /// s00147036
    /// -------------
    /// 
    /// Assignment 1 - Web Programming
    /// 
    /// Asp.net
    /// Bootstrap
    /// jQuery
    /// 
    /// GitHub : 
    /// </summary>


    public partial class quizSelection : System.Web.UI.Page
    {
        //Main link to database
        ProjectDataDataContext db = new ProjectDataDataContext();


        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /***************************************
         * Populate category dropdown on select 
         * quiz based on user selection
         * ************************************/

        protected void btnCat_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;

            try
            {
                var catQuizes = from q in db.Quizes
                                where q.Category == btn.AlternateText
                                select new Quiz(Convert.ToString(q.Id) ,q.Name, q.Category);

                lstQuizSelect.Items.Clear();

                foreach (var cat in catQuizes)
                {
                    lstQuizSelect.Items.Add(new ListItem(cat._quizName, Convert.ToString(cat._quizID)));
                }
            }
            catch(Exception)
            {
                //Need to populate error mesage
            }
        }


        /**************************************
         * On click loads the questions for the
         * selected quiz and stores them in the
         * session. Redirects to question1.aspx
         **************************************/

        protected void startQuiz_Click(object sender, EventArgs e)
        {
            List<QuizQuestions> answerStore = null;
            List<int> questionIds = null;

            try
            {
                answerStore = (from q in db.Quizes
                               where q.Id == Convert.ToInt32(lstQuizSelect.SelectedValue)
                               from qq in db.QuizQuestions
                               where qq.QuizId == q.Id
                               from a in db.QuizAnswers
                               where a.QuestionId == qq.QuestionId
                               select new QuizQuestions(
                                   qq.QuestionId,
                                   qq.Question,
                                   qq.QuizId,
                                   new QuizAnswers(a.QuestionId, a.Answer, a.Value))).ToList();

                //Question ids for random generator
                questionIds = (from id in answerStore
                           select id._questionId).Distinct().ToList();



                //Store questions, Answers and there right/wrong value in session
                Session.Add("questions", answerStore);
                Session.Add("quesAnswered", RandomArray(questionIds));
            }
            catch (Exception)
            {
                //Need to populate error message
            }

            Session.Add("QuizID", Convert.ToInt32(lstQuizSelect.SelectedValue));
            Session.Add("QuestionCurIndex", 0);
            Session.Add("timeStart", DateTime.Now);  
            Response.Redirect("questions.aspx");
        }


        /******************************************
         * Creates an aray to display the questions
         * in a random order
         * ****************************************/

        protected List<int> RandomArray(List<int> questionIds)
        {
            List<int> quesAnswered = new List<int>();
            Random rnd = new Random();
            int num;

            while (quesAnswered.Count < questionIds.Count())
            {
                num = rnd.Next(0, questionIds.Count());

                if (!quesAnswered.Contains(questionIds.ElementAt(num)))
                    quesAnswered.Add(questionIds.ElementAt(num));

            }

            return quesAnswered;
        }
    }
}