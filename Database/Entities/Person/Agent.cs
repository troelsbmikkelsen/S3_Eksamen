namespace Database.Entities {
    public class Agent : Person {
        public Agent(int id, string cpr, string nationality, string name) : base(id, cpr, nationality, name) {
            
        }

        public Agent() {

        }

        public Person GetPerson() {
            return new Person(Id, CPR, Nationality, Name);
        }
    }
}
