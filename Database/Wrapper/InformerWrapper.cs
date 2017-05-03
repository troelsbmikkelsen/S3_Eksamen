using Database.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace Database {
    public class InformerWrapper {

        static Func<IDataRecord, Informer> infsel = CodeGen.GenObjectSelector<Informer>();
        static Func<Informer, List<SqlParameter>> infparam = CodeGen.GenParameterGenerator<Informer>();

        public static List<Informer> GetAllInformers() {


            DBConnection db = new DBConnection(DB.connString);

            return db.ReadToListSP<Informer>("SelectAllInformers", infsel).ToList();


        }

        public static void SaveInformer(Informer informer) {

            DBConnection db = new DBConnection(DB.connString);
            List<SqlParameter> parameters = infparam(informer);

            if (informer.Id == -1) {
                foreach (SqlParameter s in infparam(informer)) {
                    Console.WriteLine(s.ParameterName);
                }
                var parameterArray = parameters.Where(x => x.ParameterName != "id").ToArray();
                db.ExecuteStoredProcedure("CreateInformer", parameterArray);

            } else {
                db.ExecuteStoredProcedure("UpdateInformer", parameters.ToArray());
            }
        }

    }
}
