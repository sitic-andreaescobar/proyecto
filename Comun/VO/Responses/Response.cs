using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    [DataContract]
    public class Response
    {
        [DataMember (EmitDefaultValue = false)]
        public Error Error { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public bool IsSucess { get; set; }
    }
}
