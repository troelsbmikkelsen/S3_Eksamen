using System.Data.SqlClient;

namespace Database {
    public class PersonWrapper {
        public static void DeletePerson(int id) {
            DBConnection db = new DBConnection(DB.connString);

            db.ExecuteStoredProcedure("DeletePerson", new SqlParameter("id", id));
        }
    }
}
