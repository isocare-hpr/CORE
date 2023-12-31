using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_lncollmast
	{
		internal str_lncollmast(c__str_lncollmast __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_lncollmast __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string member_no;
		[DataMember] 
		public string xml_memdet;
		[DataMember] 
		public string xml_collmastlist;
		[DataMember] 
		public string collmast_no;
		[DataMember] 
		public string xml_collmastdet;
		[DataMember] 
		public string xml_collmemco;
		[DataMember] 
		public string xml_mrtg1;
		[DataMember] 
		public string xml_mrtg2;
		[DataMember] 
		public string xml_mrtg3;
		[DataMember] 
		public string xml_review;
		[DataMember] 
		public string xml_prop;
		[DataMember] 
		public string xml_colluse;
		[DataMember] 
		public string entry_id;
		[DataMember] 
		public string branch_id;
		[DataMember] 
		public string coop_id;
		internal void CopyTo(c__str_lncollmast __x__)
		{
			__x__.member_no = member_no;
			__x__.xml_memdet = xml_memdet;
			__x__.xml_collmastlist = xml_collmastlist;
			__x__.collmast_no = collmast_no;
			__x__.xml_collmastdet = xml_collmastdet;
			__x__.xml_collmemco = xml_collmemco;
			__x__.xml_mrtg1 = xml_mrtg1;
			__x__.xml_mrtg2 = xml_mrtg2;
			__x__.xml_mrtg3 = xml_mrtg3;
			__x__.xml_review = xml_review;
			__x__.xml_prop = xml_prop;
			__x__.xml_colluse = xml_colluse;
			__x__.entry_id = entry_id;
			__x__.branch_id = branch_id;
			__x__.coop_id = coop_id;
		}
		internal static void CopyFrom(out str_lncollmast __this__, c__str_lncollmast __x__)
		{
			__this__.member_no = __x__.member_no;
			__this__.xml_memdet = __x__.xml_memdet;
			__this__.xml_collmastlist = __x__.xml_collmastlist;
			__this__.collmast_no = __x__.collmast_no;
			__this__.xml_collmastdet = __x__.xml_collmastdet;
			__this__.xml_collmemco = __x__.xml_collmemco;
			__this__.xml_mrtg1 = __x__.xml_mrtg1;
			__this__.xml_mrtg2 = __x__.xml_mrtg2;
			__this__.xml_mrtg3 = __x__.xml_mrtg3;
			__this__.xml_review = __x__.xml_review;
			__this__.xml_prop = __x__.xml_prop;
			__this__.xml_colluse = __x__.xml_colluse;
			__this__.entry_id = __x__.entry_id;
			__this__.branch_id = __x__.branch_id;
			__this__.coop_id = __x__.coop_id;
		}
		public static explicit operator object[](str_lncollmast __this__)
		{
			return new object[] {
				__this__.member_no
				,__this__.xml_memdet
				,__this__.xml_collmastlist
				,__this__.collmast_no
				,__this__.xml_collmastdet
				,__this__.xml_collmemco
				,__this__.xml_mrtg1
				,__this__.xml_mrtg2
				,__this__.xml_mrtg3
				,__this__.xml_review
				,__this__.xml_prop
				,__this__.xml_colluse
				,__this__.entry_id
				,__this__.branch_id
				,__this__.coop_id
			};
		}
	}
} 