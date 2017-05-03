using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using Database.Entities;

namespace Database {
    public class InfoWrapper {
        static Func<IDataRecord, Image> imgsel = CodeGen.GenObjectSelector<Image>();
        static Func<Image, List<SqlParameter>> imgparam = CodeGen.GenParameterGenerator<Image>();

        static Func<IDataRecord, Address> addsel = CodeGen.GenObjectSelector<Address>();
        static Func<Address, List<SqlParameter>> addparam = CodeGen.GenParameterGenerator<Address>();

        static Func<IDataRecord, Appearance> appsel = CodeGen.GenObjectSelector<Appearance>();
        static Func<Appearance, List<SqlParameter>> appparam = CodeGen.GenParameterGenerator<Appearance>();

        public static Image GetImage(int id) {
            DBConnection db = new DBConnection(DB.connString);
            var list = db.ReadToListSP<Image>("SelectImage", imgsel, new SqlParameter("id", id)).ToList();

            if (list.Count != 0) {
                return list[0];
            }

            return new Image(new byte[] { 0x00 }, -1);
        }

        public static Address GetAddress(int id) {
            DBConnection db = new DBConnection(DB.connString);
            var list = db.ReadToListSP<Address>("SelectAddress", addsel, new SqlParameter("id", id)).ToList();

            if (list.Count != 0) {
                return list[0];
            }

            return new Address("", 0, -1);
        }

        public static Appearance GetAppearance(int id) {
            DBConnection db = new DBConnection(DB.connString);
            var list = db.ReadToListSP<Appearance>("SelectAppearance", appsel, new SqlParameter("id", id)).ToList();

            if (list.Count != 0) {
                return list[0];
            }

            return new Appearance(0, "", "", -1);
        }

        public static void SaveAddress(Address address) {
            DBConnection db = new DBConnection(DB.connString);
            List<SqlParameter> parameters = addparam(address);

            if (db.DoesRowExist(address.Id, "address")) {
                db.ExecuteStoredProcedure("UpdateAddress", parameters.ToArray());
            } else {
                db.ExecuteStoredProcedure("CreateAddress", parameters.ToArray());

            }
        }

        public static void SaveImage(Image image) {
            DBConnection db = new DBConnection(DB.connString);
            List<SqlParameter> parameters = imgparam(image);

            if (db.DoesRowExist(image.Id, "image")) {
                db.ExecuteStoredProcedure("UpdateImage", parameters.ToArray());
            } else {
                db.ExecuteStoredProcedure("CreateImage", parameters.ToArray());

            }
        }

        public static void SaveAppearence(Appearance appearance) {
            DBConnection db = new DBConnection(DB.connString);
            List<SqlParameter> parameters = appparam(appearance);

            if (db.DoesRowExist(appearance.Id, "appearance")) {
                db.ExecuteStoredProcedure("UpdateAppearance", parameters.ToArray());
            } else {
                db.ExecuteStoredProcedure("CreateAppearance", parameters.ToArray());

            }
        }

        public static int GetLastPersonId() {
            DBConnection db = new DBConnection(DB.connString);
            return db.GetLastId("person");
        }
    }
}
