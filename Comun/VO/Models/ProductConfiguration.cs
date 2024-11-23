using System;
using System.Runtime.Serialization;

namespace VO
{
    [DataContract]
    public class ProductConfiguration
    {
        [DataMember(EmitDefaultValue = false)]
        public int Id { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public int ProductId { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public string ConfigurationName { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public string Value { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public DateTime CreatedAt { get; set; }
        [DataMember(EmitDefaultValue = false)]
        public DateTime UpdatedAt { get; set; }
    }
}
