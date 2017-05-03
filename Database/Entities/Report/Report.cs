using System;

namespace Database.Entities {
    public class Report {
        public Report(int id, DateTime createdate, DateTime changedate, string place, int observed_id, string comment, int author_id, string content) {
            Id = id;
            Create_Date = createdate;
            Change_Date = changedate;
            Place = place;
            Observed_Id = observed_id;
            Comment = comment;
            Author_Id = author_id;
            Content = content;
        }

        public int Id
        {
            get;
            set;
        }

        public DateTime Create_Date
        {
            get;
            set;
        }

        public DateTime Change_Date
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

        public override string ToString() {
            return $"{Create_Date.ToShortDateString()} - {Place}";
        }

    }


}
