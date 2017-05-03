namespace Database.Entities {
    public class Appearance {
        public Appearance(int height, string eyecolor, string haircolor, int id) {
            Height = height;
            Eyecolor = eyecolor;
            Haircolor = haircolor;
            Id = id;
        }

        public int Height
        {
            get;
            set;
        }

        public string Eyecolor
        {
            get;
            set;
        }

        public string Haircolor
        {
            get;
            set;
        }

        public int Id
        {
            get;
            set;
        }

    }
}
