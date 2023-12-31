//**************************************************************************
//
//                        Sybase Inc. 
//
//    THIS IS A TEMPORARY FILE GENERATED BY POWERBUILDER. IF YOU MODIFY 
//    THIS FILE, YOU DO SO AT YOUR OWN RISK. SYBASE DOES NOT PROVIDE 
//    SUPPORT FOR .NET ASSEMBLIES BUILT WITH USER-MODIFIED CS FILES. 
//
//**************************************************************************

#line 1 "c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvcom\\common.pbl\\common.pblx\\n_cst_error.sru"
#line hidden
#line 1 "n_cst_error"
#line hidden
[Sybase.PowerBuilder.PBGroupAttribute("n_cst_error",Sybase.PowerBuilder.PBGroupType.UserObject,"","c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvcom\\common.pbl\\common.pblx",null,"pbservice125")]
internal class c__n_cst_error : Sybase.PowerBuilder.PBNonVisualObject
{
	#line hidden
	[Sybase.PowerBuilder.PBVariableAttribute(Sybase.PowerBuilder.VariableTypeKind.kInstanceVar, "is_message", null, "n_cst_error", "", typeof(Sybase.PowerBuilder.PBString), Sybase.PowerBuilder.PBModifier.Protected, "= \"\"")]
	protected Sybase.PowerBuilder.PBString is_message = new Sybase.PowerBuilder.PBString("");
	[Sybase.PowerBuilder.PBVariableAttribute(Sybase.PowerBuilder.VariableTypeKind.kInstanceVar, "icd_parent", null, "n_cst_error", null, null, Sybase.PowerBuilder.PBModifier.Protected, "")]
	protected Sybase.PowerBuilder.PBClassDefinition icd_parent = null;

	#line 1 "n_cst_error.of_getmessage(S)"
	#line hidden
	[Sybase.PowerBuilder.PBFunctionAttribute("of_getmessage", new string[]{}, Sybase.PowerBuilder.PBModifier.Public, Sybase.PowerBuilder.PBFunctionType.kPowerscriptFunction)]
	public virtual Sybase.PowerBuilder.PBString of_getmessage()
	{
		#line hidden
		#line 1
		return is_message;
		#line hidden
	}

	#line 1 "n_cst_error.of_seterror(ICpowerobject.S)"
	#line hidden
	[Sybase.PowerBuilder.PBFunctionAttribute("of_seterror", new string[]{"powerobject", "string"}, Sybase.PowerBuilder.PBModifier.Public, Sybase.PowerBuilder.PBFunctionType.kPowerscriptFunction)]
	public virtual Sybase.PowerBuilder.PBInt of_seterror(Sybase.PowerBuilder.PBPowerObject apo_parentobject, Sybase.PowerBuilder.PBString as_message)
	{
		#line hidden
		Sybase.PowerBuilder.PBException th = null;
		try
		{
			try
			{
				#line 2
				is_message = as_message;
				#line hidden
				#line 3
				icd_parent = (Sybase.PowerBuilder.PBClassDefinition)(((Sybase.PowerBuilder.PBPowerObject)(Sybase.PowerBuilder.PBSystemFunctions.PBCheckNull(apo_parentobject.ClassDefinition))));
				#line hidden
			}
			catch (System.DivideByZeroException)
			{
				Sybase.PowerBuilder.PBRuntimeError.Throw(Sybase.PowerBuilder.RuntimeErrorCode.RT_R0001);
				throw new System.Exception();
			}
			catch (System.NullReferenceException)
			{
				Sybase.PowerBuilder.PBRuntimeError.Throw(Sybase.PowerBuilder.RuntimeErrorCode.RT_R0002);
				throw new System.Exception();
			}
			catch (System.IndexOutOfRangeException)
			{
				Sybase.PowerBuilder.PBRuntimeError.Throw(Sybase.PowerBuilder.RuntimeErrorCode.RT_R0003);
				throw new System.Exception();
			}
		}
		#line 4
		catch (Sybase.PowerBuilder.PBExceptionE __PB_TEMP_th__temp)
		#line hidden
		{
			th = __PB_TEMP_th__temp.E;
			#line 5
			return new Sybase.PowerBuilder.PBInt(-1);
			#line hidden
		}
		#line 7
		return new Sybase.PowerBuilder.PBInt(1);
		#line hidden
	}

	#line 1 "n_cst_error.of_geterror(Cstr_error.)"
	#line hidden
	[Sybase.PowerBuilder.PBFunctionAttribute("of_geterror", new string[]{}, Sybase.PowerBuilder.PBModifier.Public, Sybase.PowerBuilder.PBFunctionType.kPowerscriptFunction)]
	public virtual c__str_error of_geterror()
	{
		#line hidden
		c__str_error lstr_err = (c__str_error) Sybase.PowerBuilder.PBSessionBase.GetCurrentSession().CreateInstance(typeof(c__str_error));
		#line 2
		lstr_err.errortext = is_message;
		#line hidden
		#line 3
		return lstr_err;
		#line hidden
	}

	#line hidden
	[Sybase.PowerBuilder.PBEventAttribute("create")]
	public override void create()
	{
		#line hidden
		#line hidden
		base.create();
		#line hidden
		#line hidden
		;
		#line hidden
	}

	#line hidden
	[Sybase.PowerBuilder.PBEventAttribute("destroy")]
	public override void destroy()
	{
		#line hidden
		#line hidden
		this.TriggerEvent(new Sybase.PowerBuilder.PBString("destructor"));
		#line hidden
		#line hidden
		base.destroy();
		#line hidden
	}

	void _init()
	{
		this.CreateEvent += new Sybase.PowerBuilder.PBEventHandler(this.create);
		this.DestroyEvent += new Sybase.PowerBuilder.PBEventHandler(this.destroy);

		if (System.ComponentModel.LicenseManager.UsageMode != System.ComponentModel.LicenseUsageMode.Designtime)
		{
		}
	}

	public c__n_cst_error()
	{
		_init();
	}


	public static explicit operator c__n_cst_error(Sybase.PowerBuilder.PBAny v)
	{
		if (v.Value is Sybase.PowerBuilder.PBUnboundedAnyArray)
		{
			Sybase.PowerBuilder.PBUnboundedAnyArray a = (Sybase.PowerBuilder.PBUnboundedAnyArray)v.Value;
			c__n_cst_error vv = new c__n_cst_error();
			if (vv.FromUnboundedAnyArray(a) > 0)
			{
				return vv;
			}
			else
			{
				return null;
			}
		}
		else
		{
			return (c__n_cst_error) v.Value;
		}
	}
}
 