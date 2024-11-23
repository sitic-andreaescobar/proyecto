using DAO;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilities
{
    public class ParameterSanitizer
    {
        private DAO.DAOClass Dao { get; set; }

        public ParameterSanitizer(DAOClass dao)
        {
            Dao = dao;
        }

        public void CleanParameterCollection(ref SqlParameterCollection parameters, string procedure)
        {
            (string schema, string name) = global::Utilities.SqlCommandParser.ParseProcedureName(procedure);

            List<string> lstParameters = GetProcedureParameters(schema, name);

            List<SqlParameter> parametersToRemove = new();

            foreach (SqlParameter param in parameters)
            {
                if (!lstParameters.Contains(param.ParameterName))
                    parametersToRemove.Add(param);
            }

            foreach (var param in parametersToRemove)
                parameters.Remove(param);
        }

        private List<string> GetProcedureParameters(string schema, string name)
        {
            List<string> lstParameters = null;
            using (SqlCommand sqlCommand = new())
            {
                DataTable dt = Dao.ExecuteQuery($"EXEC {Schemas.dbo}.{Procedures.GetProcedureParameters} " +
                    $"@Schema = '{schema}', @Procedure = '{name}'");

                if (dt?.Rows?.Count > 0)
                {
                    lstParameters = new();
                    foreach (DataRow dr in dt.Rows)
                        lstParameters.Add(Utilities.GetValueOrDefault<string>(dr, "Parameter"));
                }
            }
            return lstParameters;
        }
    }

    public static class Utilities
    {
        public static T GetValueOrDefault<T>(this DataRow dr, string columnName)
        {
            if (dr == null || !dr.Table.Columns.Contains(columnName))
                return default(T);

            object value = dr[columnName];

            if (value == DBNull.Value)
                return default(T);

            return (T)Convert.ChangeType(value, typeof(T));
        }
    }

    public static class SqlCommandParser
    {
        public static (string schema, string name) ParseProcedureName(string procedureName)
        {
            string schema = null;
            string name = procedureName;
            int dotIndex = 0;

            procedureName = procedureName.Trim('[', ']');

            dotIndex = procedureName.IndexOf('.');

            if (dotIndex >= 0)
            {
                schema = procedureName.Substring(0, dotIndex);
                name = procedureName.Substring(dotIndex + 1);
            }

            return (schema, name);
        }
    }

   

}
