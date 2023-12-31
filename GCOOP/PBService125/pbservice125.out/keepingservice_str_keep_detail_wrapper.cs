using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_keep_detail
	{
		internal str_keep_detail(c__str_keep_detail __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_keep_detail __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string xml_main;
		[DataMember] 
		public string xml_detail;
		[DataMember] 
		public string sql_select_detail;
		internal void CopyTo(c__str_keep_detail __x__)
		{
			__x__.xml_main = xml_main;
			__x__.xml_detail = xml_detail;
			__x__.sql_select_detail = sql_select_detail;
		}
		internal static void CopyFrom(out str_keep_detail __this__, c__str_keep_detail __x__)
		{
			__this__.xml_main = __x__.xml_main;
			__this__.xml_detail = __x__.xml_detail;
			__this__.sql_select_detail = __x__.sql_select_detail;
		}
		public static explicit operator object[](str_keep_detail __this__)
		{
			return new object[] {
				__this__.xml_main
				,__this__.xml_detail
				,__this__.sql_select_detail
			};
		}
	}
} 