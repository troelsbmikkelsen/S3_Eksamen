namespace Database.Entities {
    public class Informer : Person {

        public Informer(string currency, string paymentType, string tags, int id, string cpr, string nationality, string name) : base(id, cpr, nationality, name) {
            Currency = currency;
            PaymentType = paymentType;
            Tags = tags;
        }

        public Informer() {

        }

        public string Currency
        {
            get;
            set;
        }

        public string PaymentType
        {
            get;
            set;
        }

        public string Tags
        {
            get;
            set;
        }

        public Person GetPerson() {
            return new Person(Id, CPR, Nationality, Name);
        }
    }
}
