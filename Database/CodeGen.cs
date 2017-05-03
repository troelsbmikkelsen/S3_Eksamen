using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq.Expressions;
using System.Reflection;

namespace Database {
    public class CodeGen {
        /// <summary>
        /// Generates a method from type T that takes an IDataRecord and returns an object of type T
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static Func<IDataRecord, T> GenObjectSelector<T>() {
            // new T();
            List<Expression> expressions = new List<Expression>();

            var idrParam = Expression.Parameter(typeof(IDataRecord));
            var returnType = typeof(T);
            var returnVar = Expression.Variable(returnType);

            // Get properties for T
            var properties = returnType.GetProperties();

            // Create an array the size of the number of properties in T
            Type[] propertyTypes = new Type[properties.Length];

            // Create a type array for Expression.New
            for (int i = 0; i < properties.Length; i++) {
                propertyTypes[i] = properties[i].PropertyType;

            }

            // Create argument list for Expression.New
            Expression[] arguments = new Expression[properties.Length];
            for (int i = 0; i < properties.Length; i++) {
                // Get the property "Item" and using an index get the proper value, and use Convert to convert it to the right type
                arguments[i] = Expression.Convert(Expression.Property(idrParam, "Item", Expression.Constant(properties[i].Name.ToLower())), propertyTypes[i]);
                Console.WriteLine(arguments[i].ToString());
            }

            // Assign a new instance to the return variable
            var assignReturn = Expression.Assign(returnVar, Expression.New(returnType.GetConstructor(propertyTypes), arguments));
            expressions.Add(assignReturn);

            // The retutn variable needs to be the last expression
            expressions.Add(returnVar);

            var block = Expression.Block(new[] { returnVar }, expressions);

            var lambda = Expression.Lambda<Func<IDataRecord, T>>(block, idrParam);
            Console.WriteLine("HELLO");
            return lambda.Compile();
        }

        /// <summary>
        /// Generates a method from type T that takes an object of type T and returns a list of SqlParameter
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static Func<T, List<SqlParameter>> GenParameterGenerator<T>() {
            var properties = typeof(T).GetProperties();

            var classParam = Expression.Parameter(typeof(T));
            var parameterlist = Expression.Variable(typeof(List<SqlParameter>));
            var assignconstructor = Expression.Assign(parameterlist, Expression.New(typeof(List<SqlParameter>).GetConstructor(Type.EmptyTypes)));

            List<Expression> expressions = new List<Expression>();
            expressions.Add(assignconstructor);

            foreach (PropertyInfo pinfo in properties) {
                var getValue = Expression.Call(Expression.Constant(pinfo), typeof(PropertyInfo).GetMethod("GetValue", new[] { typeof(string) }), classParam);

                var sqlparam = Expression.New(typeof(SqlParameter).GetConstructor(new[] { typeof(string), typeof(object) }), Expression.Constant(pinfo.Name.ToLower()), Expression.Convert(getValue, typeof(object)));

                var callAdd = Expression.Call(parameterlist, typeof(List<SqlParameter>).GetMethod("Add"), sqlparam);
                expressions.Add(callAdd);
            }

            expressions.Add(parameterlist);


            var block = Expression.Block(new[] { parameterlist }, expressions);

            var lambda = Expression.Lambda<Func<T, List<SqlParameter>>>(block, classParam);

            return lambda.Compile();
        }
    }
}
