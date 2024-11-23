using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    /// <summary>
    /// Representa los diferentes esquemas manejados en este microservicio.
    /// </summary>
    public class Schemas
    {
        /// <summary>
        /// Esquema Dbo
        /// </summary>
        public static readonly string dbo = "dbo";
    }

    public static class Procedures
    {
        /// <summary>
        /// Procedimiento para obtener todos
        /// </summary>
        public static readonly string GetProcedureParameters = "GetProcedureParameters";
    }
}
