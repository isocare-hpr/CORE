using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_mbreqtrnmb
	{
		internal str_mbreqtrnmb(c__str_mbreqtrnmb __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_mbreqtrnmb __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string member_no;
		[DataMember] 
		public string xml_reqopt;
		[DataMember] 
		public string xml_reqlist;
		[DataMember] 
		public string xml_request;
		[DataMember] 
		public string entry_id;
		[DataMember] 
		public string reqdoc_no;
		[DataMember] 
		public string message;
		internal void CopyTo(c__str_mbreqtrnmb __x__)
		{
			__x__.member_no = member_no;
			__x__.xml_reqopt = xml_reqopt;
			__x__.xml_reqlist = xml_reqlist;
			__x__.xml_request = xml_request;
			__x__.entry_id = entry_id;
			__x__.reqdoc_no = reqdoc_no;
			__x__.message = message;
		}
		internal static void CopyFrom(out str_mbreqtrnmb __this__, c__str_mbreqtrnmb __x__)
		{
			__this__.member_no = __x__.member_no;
			__this__.xml_reqopt = __x__.xml_reqopt;
			__this__.xml_reqlist = __x__.xml_reqlist;
			__this__.xml_request = __x__.xml_request;
			__this__.entry_id = __x__.entry_id;
			__this__.reqdoc_no = __x__.reqdoc_no;
			__this__.message = __x__.message;
		}
		public static explicit operator object[](str_mbreqtrnmb __this__)
		{
			return new object[] {
				__this__.member_no
				,__this__.xml_reqopt
				,__this__.xml_reqlist
				,__this__.xml_request
				,__this__.entry_id
				,__this__.reqdoc_no
				,__this__.message
			};
		}
	}
} 