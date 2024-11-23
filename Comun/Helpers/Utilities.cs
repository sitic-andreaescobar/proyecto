using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using VO;

namespace Utilities
{
    public static class CommonUtils
    {
        public static List<T> ConvertDataTableToList<T>(DataTable dt) where T : new()
        {
            List<T> list;
            T obj;

            list = new();
            if (dt?.Rows?.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    obj = new();

                    foreach (var prop in typeof(T).GetProperties())
                    {
                        if (dt.Columns.Contains(prop.Name) && row[prop.Name] != DBNull.Value)
                        {
                            // Verificar si la propiedad es un Enum
                            if (prop.PropertyType.IsEnum)
                            {
                                // Convertir el valor al tipo subyacente (int) si es un enum
                                object enumValue = Enum.ToObject(prop.PropertyType, row[prop.Name]);
                                prop.SetValue(obj, enumValue);
                            }
                            else
                            {
                                // Si no es un Enum, hacemos la conversión normal
                                prop.SetValue(obj, Convert.ChangeType(row[prop.Name], prop.PropertyType), null);
                            }
                        }
                    }

                    list.Add(obj);
                }
            }
            return list;
        }

        public static SqlParameterCollection AddParametersFromObject<T>(T obj)
        {
            // Obtenemos todas las propiedades del objeto
            SqlParameterCollection parameters;

            PropertyInfo[] properties;
            string parameterName;
            SqlDbType sqlDbType;

            parameters = new SqlCommand().Parameters;
            properties = typeof(T).GetProperties();

            foreach (var property in properties)
            {
                var value = property.GetValue(obj);

                if (value == null) continue;

                parameterName = $"@{property.Name}";


                try
                {
                    // Determinamos el tipo de dato para asignar el SqlDbType adecuado
                    sqlDbType = Type.GetTypeCode(property.PropertyType) switch
                    {
                        TypeCode.Int32 => SqlDbType.Int,
                        TypeCode.Int64 => SqlDbType.BigInt,
                        (TypeCode.Double or TypeCode.Single) => SqlDbType.Float,
                        TypeCode.Decimal => SqlDbType.Money,
                        TypeCode.Boolean => SqlDbType.Bit,
                        TypeCode.DateTime => SqlDbType.DateTime,
                        TypeCode.String => SqlDbType.NVarChar,
                        _ => throw new NotImplementedException(),
                    };

                    parameters.Add(parameterName, sqlDbType).Value = value;
                }
                catch (NotImplementedException ex)
                {
                    continue;
                }
            }

            return parameters;
        }

        public static T ConvertToObject<T>(DataRow row) where T : new()
        {
            if (row == null)
                return new();

            PropertyInfo[] properties;
            T obj;
            string columnName;
            object value;

            properties = typeof(T).GetProperties();
            obj = new();

            foreach (var property in properties)
            {
                // Verifica si la propiedad es pública y tiene un setter
                if (property.CanWrite)
                {
                    // Obtiene el nombre de la columna del DataRow que corresponde a la propiedad
                    columnName = property.Name;

                    // Verifica si la columna existe en el DataRow
                    if (row.Table.Columns.Contains(columnName))
                    {
                        value = row[columnName];

                        // Valida si el valor no es DBNull y asigna el valor a la propiedad
                        if (value != DBNull.Value)
                        {
                            // Convierte el valor al tipo de la propiedad
                            if (property.PropertyType.IsEnum)
                            {
                                object enumValue = Enum.ToObject(property.PropertyType, value);

                                property.SetValue(obj, enumValue);
                            }
                            else
                                property.SetValue(obj, Convert.ChangeType(value, property.PropertyType));
                        }
                    }
                }
            }

            return obj;
        }
    }

    public class TransactionUtils
    {
        public static T ExecuteWithTransaction<T>(ref DAO.DAOClass dao, Func<T> action)
        {
            T result;

            try
            {
                dao.BeginTransaction();

                result = action();

                dao.Commit();
            }
            catch (Exception ex)
            {
                dao.Rollback();
                throw;
            }

            return result;
        }
    }

    public class ErrorHandler
    {
        public static Error Handler(Exception ex)
        {
            return new(ex.Message, ex switch
            {
                ExceptionWeb => ((ExceptionWeb)ex).ErrorType,
                FormatException or InvalidCastException => eErrorType.Format,
                SqlException => eErrorType.Sql,
                _ => eErrorType.Unknown
            });
        }
    }
}
