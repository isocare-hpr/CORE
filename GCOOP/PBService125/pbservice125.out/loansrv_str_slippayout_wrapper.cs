using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_slippayout
	{
		internal str_slippayout(c__str_slippayout __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_slippayout __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string initfrom_type;
		[DataMember] 
		public string member_no;
		[DataMember] 
		public string memcoop_id;
		[DataMember] 
		public string loancontract_no;
		[DataMember] 
		public string contcoop_id;
		[DataMember] 
		public string sliptype_code;
		[DataMember] 
		public System.DateTime slip_date;
		[DataMember] 
		public System.DateTime operate_date;
		[DataMember] 
		public string xml_sliphead;
		[DataMember] 
		public string xml_slipdet;
		[DataMember] 
		public string xml_slipcutlon;
		[DataMember] 
		public string xml_slipcutetc;
		[DataMember] 
		public string xml_expense;
		[DataMember] 
		public string entry_id;
		[DataMember] 
		public string coop_id;
		[DataMember] 
		public string payoutorder_no;
		[DataMember] 
		public string payoutslip_no;
		[DataMember] 
		public string payinslip_no;
		[DataMember] 
		public bool receiptno_flag;
		internal void CopyTo(c__str_slippayout __x__)
		{
			__x__.initfrom_type = initfrom_type;
			__x__.member_no = member_no;
			__x__.memcoop_id = memcoop_id;
			__x__.loancontract_no = loancontract_no;
			__x__.contcoop_id = contcoop_id;
			__x__.sliptype_code = sliptype_code;
			__x__.slip_date = slip_date;
			__x__.operate_date = operate_date;
			__x__.xml_sliphead = xml_sliphead;
			__x__.xml_slipdet = xml_slipdet;
			__x__.xml_slipcutlon = xml_slipcutlon;
			__x__.xml_slipcutetc = xml_slipcutetc;
			__x__.xml_expense = xml_expense;
			__x__.entry_id = entry_id;
			__x__.coop_id = coop_id;
			__x__.payoutorder_no = payoutorder_no;
			__x__.payoutslip_no = payoutslip_no;
			__x__.payinslip_no = payinslip_no;
			__x__.receiptno_flag = receiptno_flag;
		}
		internal static void CopyFrom(out str_slippayout __this__, c__str_slippayout __x__)
		{
			__this__.initfrom_type = __x__.initfrom_type;
			__this__.member_no = __x__.member_no;
			__this__.memcoop_id = __x__.memcoop_id;
			__this__.loancontract_no = __x__.loancontract_no;
			__this__.contcoop_id = __x__.contcoop_id;
			__this__.sliptype_code = __x__.sliptype_code;
			__this__.slip_date = __x__.slip_date;
			__this__.operate_date = __x__.operate_date;
			__this__.xml_sliphead = __x__.xml_sliphead;
			__this__.xml_slipdet = __x__.xml_slipdet;
			__this__.xml_slipcutlon = __x__.xml_slipcutlon;
			__this__.xml_slipcutetc = __x__.xml_slipcutetc;
			__this__.xml_expense = __x__.xml_expense;
			__this__.entry_id = __x__.entry_id;
			__this__.coop_id = __x__.coop_id;
			__this__.payoutorder_no = __x__.payoutorder_no;
			__this__.payoutslip_no = __x__.payoutslip_no;
			__this__.payinslip_no = __x__.payinslip_no;
			__this__.receiptno_flag = __x__.receiptno_flag;
		}
		public static explicit operator object[](str_slippayout __this__)
		{
			return new object[] {
				__this__.initfrom_type
				,__this__.member_no
				,__this__.memcoop_id
				,__this__.loancontract_no
				,__this__.contcoop_id
				,__this__.sliptype_code
				,__this__.slip_date
				,__this__.operate_date
				,__this__.xml_sliphead
				,__this__.xml_slipdet
				,__this__.xml_slipcutlon
				,__this__.xml_slipcutetc
				,__this__.xml_expense
				,__this__.entry_id
				,__this__.coop_id
				,__this__.payoutorder_no
				,__this__.payoutslip_no
				,__this__.payinslip_no
				,__this__.receiptno_flag
			};
		}
	}
} 