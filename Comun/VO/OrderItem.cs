using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    [DataContract]
    public class OrderItem
    {
        [DataMember(EmitDefaultValue = false)]
        public int Id { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public int OrderId { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public int ProductId { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public int Quantity { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public double Price { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public DateTime CreatedAt { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public DateTime UpdatedAt { get; set; }
    }
}
