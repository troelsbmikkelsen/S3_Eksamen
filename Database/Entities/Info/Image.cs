using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Database.Entities {
    public class Image {
        public Image(byte[] data, int id) {
            Data = data;
            Id = id;
        }

        public byte[] Data
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
