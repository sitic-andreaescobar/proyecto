using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class DAOClass
    {
        SqlConnection _connectionString = null;
        SqlTransaction _transaction = null;

        public int Identity { get; set; }

        static string server = "";
        static string dateBase = "";
        static string connectionString = string.Format("server={0}; database={1}; integrated security = true", server, dateBase);

        public DAOClass()
        {
            _connectionString = new(connectionString);

            Open();
        }

        private void Open()
        {
            if (_connectionString.State == ConnectionState.Closed)
                _connectionString.Open();            
        }


        private void Close()
        {
            if (_connectionString.State == ConnectionState.Open)
                _connectionString.Close();
        }

        public void BeginTransaction()
        {
            if (_connectionString.State == ConnectionState.Open)
                _transaction = _connectionString.BeginTransaction();
        }

        public void Commit()
        {
            if (_transaction != null)
                _transaction.Commit();
        }

        public void Rollback()
        {
            if (_transaction != null)
                _transaction.Rollback();
        }

        public DataTable QueryInformation(string procedureName, SqlParameterCollection parameters = null)
        {
            DataTable dt = new();
            using (SqlCommand sqlCmd = new(procedureName, _connectionString))
            {
                sqlCmd.CommandType = CommandType.StoredProcedure;

                if(parameters != null)
                    foreach (SqlParameter param in parameters)
                    {
                        sqlCmd.Parameters.Add(param.ParameterName, param.SqlDbType);
                        sqlCmd.Parameters[sqlCmd.Parameters.Count - 1].Value = param.Value;
                    }

                using (SqlDataAdapter sqlDataAdapter = new (sqlCmd))
                    sqlDataAdapter.Fill(dt);
            }
            return dt;
        }

        public int ExecuteProcedure(string procedureName, SqlParameterCollection parameters)
        {
            int rows = 0;
            using (SqlCommand sqlCmd = new (procedureName, _connectionString))
            {
                sqlCmd.CommandType = CommandType.StoredProcedure;
                
                sqlCmd.Transaction = _transaction;
                foreach (SqlParameter param in parameters)
                {
                    sqlCmd.Parameters.Add(param.ParameterName, param.SqlDbType);
                    sqlCmd.Parameters[sqlCmd.Parameters.Count - 1].Value = param.Value;
                }

                rows = sqlCmd.ExecuteNonQuery();
            }
            return rows;
        }

        //Pendiente
        public int ExecuteProcedureWithIdentity(string procedureName, SqlParameterCollection parameters)
        {           
            int rows = 0;
            string nameOutput = string.Empty;

            using (SqlCommand sqlCmd = new(procedureName, _connectionString))
            {
                sqlCmd.CommandType = CommandType.StoredProcedure;

                sqlCmd.Transaction = _transaction;
                foreach (SqlParameter param in parameters)
                {
                    sqlCmd.Parameters.Add(param.ParameterName, param.SqlDbType);
                    sqlCmd.Parameters[sqlCmd.Parameters.Count - 1].Value = param.Value;
                    if (param.Direction == ParameterDirection.Output || param.Direction == ParameterDirection.ReturnValue)                    
                        nameOutput = param.ParameterName;                    
                }

                rows = sqlCmd.ExecuteNonQuery();

                Identity = Int32.Parse(sqlCmd.Parameters[nameOutput].Value.ToString());
            }
            return rows;
        }

    }
}
