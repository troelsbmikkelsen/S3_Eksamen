using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Database.Entities {
    
    public class Person {
        public Person(int id, string cPR, string nationality, string name) {
            Id = id;
            CPR = cPR;
            Nationality = nationality;
            Name = name;
        }

        public Person() {

        }

        public int Id
        {
            get;
            set;
        }

        public string CPR
        {
            get;
            set;
        }

        public string Nationality
        {
            get;
            set;
        }

        public string Name
        {
            get;
            set;
        }

        public override string ToString() {
            return $"{Name}";
        }

    }
}
