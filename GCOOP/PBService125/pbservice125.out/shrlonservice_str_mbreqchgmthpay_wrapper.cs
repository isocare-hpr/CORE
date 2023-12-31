using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_mbreqchgmthpay
	{
		internal str_mbreqchgmthpay(c__str_mbreqchgmthpay __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_mbreqchgmthpay __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string coop_id;
		[DataMember] 
		public string member_no;
		[DataMember] 
		public string memcoop_id;
		[DataMember] 
		public System.DateTime chgmthpay_date;
		[DataMember] 
		public string xml_master;
		[DataMember] 
		public string xml_detailshr;
		[DataMember] 
		public string xml_detaillon;
		[DataMember] 
		public string entry_id;
		[DataMember] 
		public string xml_reqopt;
		[DataMember] 
		public string xml_reqlist;
		internal void CopyTo(c__str_mbreqchgmthpay __x__)
		{
			__x__.coop_id = coop_id;
			__x__.member_no = member_no;
			__x__.memcoop_id = memcoop_id;
			__x__.chgmthpay_date = chgmthpay_date;
			__x__.xml_master = xml_master;
			__x__.xml_detailshr = xml_detailshr;
			__x__.xml_detaillon = xml_detaillon;
			__x__.entry_id = entry_id;
			__x__.xml_reqopt = xml_reqopt;
			__x__.xml_reqlist = xml_reqlist;
		}
		internal static void CopyFrom(out str_mbreqchgmthpay __this__, c__str_mbreqchgmthpay __x__)
		{
			__this__.coop_id = __x__.coop_id;
			__this__.member_no = __x__.member_no;
			__this__.memcoop_id = __x__.memcoop_id;
			__this__.chgmthpay_date = __x__.chgmthpay_date;
			__this__.xml_master = __x__.xml_master;
			__this__.xml_detailshr = __x__.xml_detailshr;
			__this__.xml_detaillon = __x__.xml_detaillon;
			__this__.entry_id = __x__.entry_id;
			__this__.xml_reqopt = __x__.xml_reqopt;
			__this__.xml_reqlist = __x__.xml_reqlist;
		}
		public static explicit operator object[](str_mbreqchgmthpay __this__)
		{
			return new object[] {
				__this__.coop_id
				,__this__.member_no
				,__this__.memcoop_id
				,__this__.chgmthpay_date
				,__this__.xml_master
				,__this__.xml_detailshr
				,__this__.xml_detaillon
				,__this__.entry_id
				,__this__.xml_reqopt
				,__this__.xml_reqlist
			};
		}
	}
} 