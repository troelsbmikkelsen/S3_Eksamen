using Database.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace Database {
    public class ReportWrapper {

        static Func<IDataRecord, Report> repsel = CodeGen.GenObjectSelector<Report>();
        static Func<Report, List<SqlParameter>> repparam = CodeGen.GenParameterGenerator<Report>();

        static Func<IDataRecord, Report_Log> logsel = CodeGen.GenObjectSelector<Report_Log>();

        public static List<Report> GetReports(int person_id) {
            DBConnection db = new DBConnection(DB.connString);
            Console.WriteLine(person_id);
            return db.ReadToListSP<Report>("SelectReports", repsel, new SqlParameter("id", person_id)).ToList();
        }

        public static void SaveReport(Report report) {
            DBConnection db = new DBConnection(DB.connString);
            List<SqlParameter> parameters = repparam(report);

            if (report.Id == -1) {
                foreach (SqlParameter s in repparam(report)) {
                    Console.WriteLine(s.ParameterName);
                }
                var parameterArray = parameters.Where(x => x.ParameterName != "id").ToArray();
                db.ExecuteStoredProcedure("CreateReport", parameterArray);

            } else {
                db.ExecuteStoredProcedure("UpdateReport", parameters.ToArray());
            }
        }

        public static List<Report_Log> GetReportLogs(int id) {
            DBConnection db = new DBConnection(DB.connString);

            return db.ReadToListSP<Report_Log>("SelectReportLogs", logsel, new SqlParameter("id", id)).ToList();
        }
    }
}
