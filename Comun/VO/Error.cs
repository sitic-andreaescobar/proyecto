using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    [DataContract]
    public class Error
    {
        [DataMember(EmitDefaultValue = false)]
        public string Message { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public eErrorType ErrorType { get; set; }

        public Error() { }

        public Error(string message, eErrorType errorType)
        {
            Message = message;
            ErrorType = errorType;
        }
    }
}
