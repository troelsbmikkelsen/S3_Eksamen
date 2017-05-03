using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Database.Entities {
    public class Observed : Person {
        public Observed(string tags, int id, string cpr, string nationality, string name) : base(id, cpr, nationality, name) {
            Tags = tags;
        }

        public Observed() {

        }

        public string Tags
        {
            get;
            set;
        }

    }
}
