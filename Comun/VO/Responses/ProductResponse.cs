using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    [DataContract]
    public class ProductResponse : Response
    {
        [DataMember (EmitDefaultValue = false)]
        public Product Product { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public List<Product> Products { get; set; }
    }
}
