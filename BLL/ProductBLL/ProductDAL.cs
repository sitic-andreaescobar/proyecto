using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VO;

namespace DAL
{
    internal class ProductDAL
    {
        #region Variables & Properties
        private readonly DAO.DAOClass _dao = null;

        internal DAO.DAOClass Dao { get { return _dao; } }
        #endregion

        #region Constructors
        internal ProductDAL(DAO.DAOClass dao)
        {
            _dao = dao;
        }
        #endregion

        #region Methods
        internal DataTable GetById(int id)
        {
            using(SqlCommand sqlCommand = new())
            {
                SqlParameterCollection parameters = sqlCommand.Parameters;
                parameters.Add("@Id", SqlDbType.Int).Value = id;
                return _dao.QueryInformation($"{Schema.Products}.{Procedures.GetById}", parameters);
            }
        }

        internal DataTable GetAll()
        {
            return _dao.QueryInformation($"{Schema.Products}.{Procedures.GetAll}");
        }

        internal bool Insert(Product product)
        {
            SqlParameterCollection parameters = Utilities.CommonUtils.AddParametersFromObject<Product>(product);
            parameters["@Id"].Direction = ParameterDirection.Output;

            return (_dao.ExecuteProcedureWithIdentity($"{Schema.Products}.{Procedures.Insert}", parameters) > 0) ? 
                Dao.Identity > 0 : false;            
        }

        internal bool Update(Product product)
        {        
            SqlParameterCollection parameters = Utilities.CommonUtils.AddParametersFromObject<Product>(product);           
            return _dao.ExecuteProcedure($"{Schema.Products}.{Procedures.Update}", parameters) > 0;            
        }

        internal bool Delete(int id)
        {
            using (SqlCommand sqlCommand = new())
            {
                SqlParameterCollection parameters = sqlCommand.Parameters;
                parameters.Add("@Id", SqlDbType.Int).Value = id;
                return _dao.ExecuteProcedure($"{Schema.Products}.{Procedures.Delete}", parameters) > 0;
            }
        }
        #endregion        
    }
}
