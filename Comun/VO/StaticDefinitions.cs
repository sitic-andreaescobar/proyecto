using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    public enum eStockStatus
    {
        IN_STOCK = 1,
        OUT_OF_STOCK,
        LOW_STOCK
    }

    public enum eDbAction
    {
        Insert = 1,
        Update = 2,
        Delete
    }

    public enum eErrorType
    {
        None = 0,       //Ninguno
        NotFound = 1,   //No se encontró registro o cualquier dato
        Format,         //Error de conversión
        Sql,            //Error de sql
        Validation,     //Errores controlados
        Connection,     //Error de conexión
        Timeout,        //Error de timeout por bloqueos o interbloqueos
        Unknown = 99    //Desconocido
    }

    //Representaciones

    /// <summary>
    ///  Representa los diferentes esquemas que se manejan en este microservicio.
    /// </summary>
    public class Schema
    {
        /// <summary>
        /// Esquema de Products
        /// </summary>
        public static readonly string Products = "Products";

        /// <summary>
        /// Esquema de Product_Configurations
        /// </summary>
        public static readonly string ProductConfigurations = "Product_Configurations";

        /// <summary>
        /// Esquema de Carts
        /// </summary>
        public static readonly string Carts = "Carts";

        /// <summary>
        /// Esquema de Cart_Items
        /// </summary>
        public static readonly string CartItems = "Cart_Items";

        /// <summary>
        /// Esquema de Orders
        /// </summary>
        public static readonly string Orders = "Orders";

        /// <summary>
        /// Esquema de Order_Items
        /// </summary>
        public static readonly string OrderItems = "Order_Items";
    }

    /// <summary>
    ///  Representa los diferentes procedimientos que se manejan en este microservicio.
    /// </summary>
    public class Procedures
    {
        /// <summary>
        /// Procedimiento para insertar
        /// </summary>
        public static readonly string Insert = "Insert";

        /// <summary>
        /// Procedimiento para actualizar
        /// </summary>
        public static readonly string Update = "Update";

        /// <summary>
        /// Procedimiento para eliminar
        /// </summary>
        public static readonly string Delete = "Delete";

        /// <summary>
        /// Procedimiento para obtener un registro por identificador
        /// </summary>
        public static readonly string GetById = "GetById";

        /// <summary>
        /// Procedimiento para obtener todos los registros
        /// </summary>
        public static readonly string GetAll = "GetAll";        
    }
}
