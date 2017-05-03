using Database.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Database {
    public class AgentWrapper {

        static Func<IDataRecord, Agent> agsel = CodeGen.GenObjectSelector<Agent>();
        static Func<Agent, List<SqlParameter>> agparam = CodeGen.GenParameterGenerator<Agent>();

        public static List<Agent> GetAllAgents() {
            DBConnection db = new DBConnection(DB.connString);

            return db.ReadToListSP<Agent>("SelectAllInformers", agsel).ToList();
        }

        public static void SaveAgent(Agent agent) {
            DBConnection db = new DBConnection(DB.connString);
            List<SqlParameter> parameters = agparam(agent);

            if (agent.Id == -1) {
                foreach (SqlParameter s in agparam(agent)) {
                    Console.WriteLine(s.ParameterName);
                }
                var parameterArray = parameters.Where(x => x.ParameterName != "id").ToArray();
                db.ExecuteStoredProcedure("CreateAgent", parameterArray);

            } else {
                db.ExecuteStoredProcedure("UpdateAgent", parameters.ToArray());
            }
        }

    }
}
