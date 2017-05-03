namespace Database.Entities {
    public class Address {
        public Address(string street, int areaCode, int id) {
            Street = street;
            AreaCode = areaCode;
            Id = id;
        }

        public string Street
        {
            get;
            set;
        }

        public int AreaCode
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
