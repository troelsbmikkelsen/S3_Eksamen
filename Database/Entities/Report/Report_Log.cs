using System;

namespace Database.Entities {
    public class Report_Log {
        public Report_Log(int id, DateTime time, DateTime date, string place, int observed_Id, string comment, int author_Id, string content, int report_Id) {
            Id = id;
            Time = time;
            Date = date;
            Place = place;
            Observed_Id = observed_Id;
            Comment = comment;
            Author_Id = author_Id;
            Content = content;
            Report_Id = report_Id;
        }

        public int Id
        {
            get;
            set;
        }

        public DateTime Time
        {
            get;
            set;
        }

        public DateTime Date
        {
            get;
            set;
        }

        public string Place
        {
            get;
            set;
        }

        public int Observed_Id
        {
            get;
            set;
        }

        public string Comment
        {
            get;
            set;
        }

        public int Author_Id
        {
            get;
            set;
        }

        public string Content
        {
            get;
            set;
        }

        public int Report_Id
        {
            get;
            set;
        }

    }
}
