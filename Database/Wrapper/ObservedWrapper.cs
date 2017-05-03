using System;
using System.Collections.Generic;
using System.Linq;
using Database.Entities;
using System.Data;
using System.Data.SqlClient;

namespace Database {
    public class ObservedWrapper {

        static Func<IDataRecord, Observed> obssel = CodeGen.GenObjectSelector<Observed>();
        static Func<Observed, List<SqlParameter>> obsparam = CodeGen.GenParameterGenerator<Observed>();

        public static List<Observed> GetAllObserved() {
            DBConnection db = new DBConnection(DB.connString);

            return db.ReadToListSP<Observed>("SelectAllObserved", obssel).ToList();

        }

        public static void SaveObserved(Observed observed) {
            DBConnection db = new DBConnection(DB.connString);
            List<SqlParameter> parameters = obsparam(observed);

            if (observed.Id == -1) {
                foreach (SqlParameter s in obsparam(observed)) {
                    Console.WriteLine(s.ParameterName);
                }
                var parameterArray = parameters.Where(x => x.ParameterName != "id").ToArray();
                db.ExecuteStoredProcedure("CreateObserved", parameterArray);

            } else {
                db.ExecuteStoredProcedure("UpdateObserved", parameters.ToArray());
            }
        }

    }
}
