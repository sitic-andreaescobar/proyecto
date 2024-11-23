using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    public class ExceptionWeb : Exception
    {
        public eErrorType ErrorType { get; set; } = eErrorType.None;

        public ExceptionWeb() { }

        public ExceptionWeb(string message) : base(message) { }

        public ExceptionWeb(string message, eErrorType errorType) : base(message)
        {
            ErrorType = errorType;
        }
    }
}
