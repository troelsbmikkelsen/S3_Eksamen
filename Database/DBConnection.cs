using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Database {
    public class DBConnection {
        public string ConnectionString = "";

        public DBConnection(string connectionString) {
            ConnectionString = connectionString;
        }

        public T ReadSingle<T>(string query, Func<IDataRecord, T> selector, params SqlParameter[] parameters) {
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                using (var cmd = conn.CreateCommand()) {
                    cmd.CommandText = query;
                    cmd.Parameters.AddRange(parameters);
                    cmd.Connection.Open();
                    using (var r = cmd.ExecuteReader()) {
                        return r.Cast<IDataRecord>().Select(selector).FirstOrDefault();
                    }
                }
            }
        }

        public IEnumerable<T> ReadToList<T>(string query, Func<IDataRecord, T> selector, params SqlParameter[] parameters) {
            // Create a connection
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                // Open connection
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    cmd.Parameters.AddRange(parameters);
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        // Cast internal type to IDataRecord, and run  the selector to convert to T
                        return reader.Cast<IDataRecord>().Select(selector).ToList();
                    }
                }
            }
        }

        public IEnumerable<T> ReadToListSP<T>(string query, Func<IDataRecord, T> selector, params SqlParameter[] parameters) {
            // Create a connection
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                // Open connection
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddRange(parameters);
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        // Cast internal type to IDataRecord, and run  the selector to convert to T
                        return reader.Cast<IDataRecord>().Select(selector).ToList();
                    }
                }
            }
        }

        public IEnumerable<IDataRecord> ReadToList(string query, params SqlParameter[] parameters) {
            // Create a connection
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                // Open connection
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    cmd.Parameters.AddRange(parameters);
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        return reader.Cast<IDataRecord>().ToList();
                    }
                }
            }
        }

        public IEnumerable<IDataRecord> ReadToListSP(string query, params SqlParameter[] parameters) {
            // Create a connection
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                // Open connection
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddRange(parameters);
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        return reader.Cast<IDataRecord>().ToList();
                    }
                }
            }
        }


        public void ExecuteCommand(string cmdtext, params SqlParameter[] parameters) {
            // Create a connection
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(cmdtext, conn)) {
                    // Add parameters
                    cmd.Parameters.AddRange(parameters);
                    // Execute command
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void ExecuteStoredProcedure(string proc, params SqlParameter[] parameters) {
            // Create a connection
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(proc, conn)) {
                    // Set commandtype to stored procedure
                    cmd.CommandType = CommandType.StoredProcedure;
                    // Add parameters
                    cmd.Parameters.AddRange(parameters);
                    // Execute stored procedure
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public IEnumerable<T> ReadLazy<T>(string query, Func<IDataRecord, T> selector) {
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                using (var cmd = conn.CreateCommand()) {
                    cmd.CommandText = query;
                    cmd.Connection.Open();
                    using (var r = cmd.ExecuteReader()) {
                        while (r.Read()) {
                            yield return selector(r);
                        }
                    }
                }
            }
        }
        
        public int GetLastId(string table) {
            using (SqlConnection conn = new SqlConnection(ConnectionString)) {
                using (var cmd = conn.CreateCommand()) {
                    //cmd.CommandText = "SELECT IDENT_CURRENT('" + table + "')";
                    cmd.CommandText = "SELECT TOP 1 id FROM " + table + " ORDER BY id DESC";
                    //cmd.Parameters.AddWithValue("table", table);
                    cmd.Connection.Open();
                    using (var r = cmd.ExecuteReader()) {
                        r.Read();
                        return r.GetInt32(0);
                        //return (int)r.Cast<IDataRecord>().FirstOrDefault()[0];
                    }
                }
            }
        }

        /// <summary>
        /// Does a row with id exist in table
        /// </summary>
        /// <param name="id"></param>
        /// <param name="table"></param>
        /// <returns></returns>
        public bool DoesRowExist(int id, string table) {
            try {
                var list = ReadToListSP("RowInTable", new SqlParameter("id", id), new SqlParameter("table", table));

                if (list.Count() != 0) {
                    int result = Convert.ToInt32(list.Single()["bool"]);

                    if (result == 0) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    return false;
                }
            } catch {
                return false;
            }
        }
        
    }
}
