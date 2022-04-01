//KDShader
//KDAvaterShaders ver.1.0
//v.1.1.00
//https://github.com/oki75/KDAvaterShaders          

Shader "KDShader/KDAvaterShaders"
{
	Properties
	{
	    [HideInInspector]	_KdaVerX	                  ( "KdaVerX"	, Float ) = 1
		[HideInInspector]	_KdaVerY	                  ( "KdaVerY"	, Float ) = 1
		[HideInInspector]	_KdaVerZ	                  ( "KdaVerZ"	, Float ) = 00
        [HideInInspector]   _KDSType                      ( "ShderType"	, Int ) = 1

	    
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0,1)) = 0

	                      _Clipping_Level("clipping_Level", Range( 0 , 1)) = 0
		                  _Tweak_transparency("tweak_transparency", Range( 0 , 1)) = 0.24
		[ToggleUI]        _Inverse_Clipping("Inverse_Clipping", Float) = 0
		[ToggleUI]        _Use_Decal_alpha("Use_Decal_alpha", Float) = 0
		                  _ClippingMask("clippingMask", 2D) = "black" {}


		[ToggleUI]_Decal_UVSet2_Toggle("Decal_UVSet2_Toggle", Float) = 1
		[ToggleUI]_Decal_Toggle("decal_Toggle", Float) = 0
		          _DecalMap("decalMap", 2D) = "white" {}

				  _MainTex("mainTex", 2D) = "white" {}
	              _BaseColor("baseColor", Color) = (1,1,1,1)

		          _1st_ShadeMap("firstShadeMap", 2D) = "white" {}
        [ToggleUI]_Use_BaseAs1st("use_BaseAs1st", Float) = 1	
		          _1st_ShadeColor("1st_ShadeColor", Color) = (1,1,1,1)

		          _2nd_ShadeMap("2ndShadeMap", 2D) = "white" {}
        [ToggleUI]_Use_BaseAs2nd("use_BaseAs2nd", Float) = 1
		          _2nd_ShadeColor("2nd_ShadeColor", Color) = (1,1,1,1)

		[ToggleUI]_Fix_ShadeMap_UVSet2_Toggle("fix_ShadeMap_UVSet2_Toggle", Float) = 0
		
		          _FixShadeMap("fixShadeMap", 2D) = "white" {}
	    [ToggleUI]_Use_BaseAsFix("use_BaseAsFix", Float) = 1
				  _FixShadeColor("fixShadeColor", Color) = (1,1,1,1)
				  _FixShadeColorMap("fixShadeColorMap", 2D) = "white" {}
				  _Tweak_HighColorBlurShadowLevel("Tweak_HighColorBlurShadowLevel", Range( 0 , 1)) = 0.4329458
				  _Tweak_FixShadeMapLevel("tweak_FixShadeMapLevel", Range( 0 , 2)) = 1
				  

        [ToggleUI]_NormalMap_UVSet2_Toggle("NormalMap_UVSet2_Toggle", Float) = 0
		  [Normal]_NormalMap("NormalMap", 2D) = "bump" {}
		          _BumpScale("NormalScale", Range( 0 , 1)) = 0

	    [Toggle(_DETAILBLEND_ON)] _DetailBlend("DetailBlend", Float) = 0
		[ToggleUI]_NormalMap2_UVSet2_Toggle("Detail_UVSet2_Toggle", Float) = 0
		  [Normal]_NormalMap2("Detail", 2D) = "bump" {}
		          _BumpScale2("DetailScale", Range( 0 , 1)) = 0

        [ToggleUI]_ShadeNormal("Shade Normal", Float) = 1
                  _BaseColor_Step("baseColor_Step", Range( 0 , 1)) = 0
		          _BaseShade_Feather("Base/Shade Feather", Range( 0 , 1)) = 0
		          _ShadeColor_Step("shadeColor_Step", Range( 0 , 1)) = 0
		          _1st2nd_Shades_Feather("first2nd_Shades_Feather", Range( 0 , 1)) = 0

			      _RGB_mask("RGB_mask/R=RimLight,G=MatCap,B=outline", 2D) = "white" {}
		
		[Toggle(_PARALLAX_ON)] _Parallax("Parallax", Float) = 0
		                       _ParallaxMap("parallaxMap", 2D) = "gray" {}
		                       _ParallaxScale("parallaxScale", Range( 0 , 1)) = 0.02578901

		[ToggleUI]_NormalMapParallax("NormalMapParallax", Float) = 0
		[ToggleUI]_Detail_Parallax("Detail_Parallax", Float) = 0
		[ToggleUI]_BaseParallax("BaseParallax", Float) = 0
		[ToggleUI]_FixShadeParallax("fixShadeParallax", Float) = 0
		[ToggleUI]_HighColorParallax("HighColorParallax", Float) = 0
	
		
		


		[ToggleUI]_DubleHighColor_Toggle("dubleHighColor_Toggle", Float) = 1
		[ToggleUI]_Anisotropic_highlight_Toggle("Anisotropic_highlight_Toggle", Float) = 0
		
		[ToggleUI]_Anisotropic_TangentNormal_Toggle("Anisotropic_TangentNormal_Toggle", Float) = 1
		_aniso_offset("aniso_offset", Range( -1 , 1)) = 0.07546695
		
		
		_Shininess("Shininess", Range( 0.01 , 1)) = 0.5132942
		[ToggleUI]_Is_NormalMapToHighColor("HighColor Normal", Float) = 0
		_HighColorHue("HighColorHue", Range( 0 , 1)) = 0.06228113
		_HighColorSaturation("HighColorSaturation", Range( -1 , 1)) = -0.1953587
		
		_Tweak_HighColorMaskLevel("tweak_HighColorMaskLevel", Range( 0 , 1)) = 1
		
		_HighColor_Ratio("HighColor_Ratio", Range( 0 , 1)) = 0.5697438
		_HighColor("HighColor", Color) = (1,0.0990566,0.0990566,1)
	
		
		[ToggleUI]_HighColorBlurShadow("HighColorBlurShadow", Float) = 0
		
		[Toggle(_EYEHIANDLIMBUS_ON)] _EyeHiAndLimbus("EyeHiAndLimbus", Float) = 0

		  [ToggleUI]_BlendAddEyeBase("BlendAddEyeBase", Float) = 1
		  _EyeBase("EyeBase", 2D) = "white" {}

		  [ToggleUI]_EyeHi_Toggle("EyeHi_Toggle", Float) = 0
		     [ToggleUI]_EyeHi2_Blend("EyeHi2_Blend", Float) = 0
		  [ToggleUI]_EyeHiAndLimbusMirrorON("EyeHiAndLimbusMirrorON", Float) = 1

		_LimbusColor("LimbusColor", Color) = (0.3584906,0.245194,0.245194,1)
		_EyeHiColor("EyeHiColor", Color) = (0.990566,0.9571414,0.855064,1)
		_EyeHi2Color("EyeHi2Color", Color) = (0.3553756,0.453597,0.6226415,1)
		
	    _Limbus_BlurStep("Limbus_BlurStep", Range( 0 , 1)) = 0.3467462
		
		_Limbus_Scale("Limbus_Scale", Range( 1 , 15)) = 1
		_Limbus_BlurFeather("Limbus_BlurFeather", Range( 0 , 1)) = 0.3461028
		_LimbusOffsetX("LimbusOffsetX", Range( -1 , 1)) = 0.1913488
		_LimbusOffsetY("LimbusOffsetY", Range( -1 , 1)) = -0.1267346
		_LimbusAdjustMirror("LimbusAdjustMirror", Range( -1 , 1)) = -0.4239556
		_LimbusTilling("LimbusTilling", Vector) = (1,1,0,0)

		_EyeHiTilling("EyeHiTilling", Vector) = (1,1,0,0)
		_EyeHi_Scale("EyeHi_Scale", Range( 0 , 30)) = 1
		_EyeHiOffsetX("EyeHiOffsetX", Range( -1 , 1)) = 0.03070339
		_EyeHiOffsetY("EyeHiOffsetY", Range( -1 , 1)) = 0
		_EyeHiAdjustMirror("EyeHiAdjustMirror", Range( -1 , 1)) = 0.00738687
		_EyeHi_BlurStep("EyeHi_BlurStep", Range( 0 , 1)) = 0.7508348
		_EyeHi_BlurFeather("EyeHi_BlurFeather", Range( 0 , 1)) = 0.4237356
		
		
		
		_EyeHi2Tilling("EyeHi2Tilling", Vector) = (1,1,0,0)
		_EyeHi2_Scale("EyeHi2_Scale", Range( 0 , 30)) = 1
		_EyeHi2AdjustMirror("EyeHi2AdjustMirror", Range( -1 , 1)) = 0
		_EyeHi2_BlurStep("EyeHi2_BlurStep", Range( 0 , 1)) = 0.7508348
		_EyeHi2_BlurFeather("EyeHi2_BlurFeather", Range( 0 , 1)) = 0.4237356
        _EyeHi2OffsetX("EyeHi2OffsetX", Range( -1 , 1)) = 0.03070339
		_EyeHi2OffsetY("EyeHi2OffsetY", Range( -1 , 1)) = 0
		
		
		
		[ToggleUI]_HighColorMask_UVSet2_Toggle("HighColorMask_UVSet2_Toggle", Float) = 0
		
		_BlurLevel("BlurLevel", Range( 0 , 10)) = 8.165618
		_Set_HighColorMask("HighColorMask", 2D) = "white" {}
		[Toggle(_)]_RimLightToggle("RimLightToggle", Float) = 1
		[ToggleUI]_LightDirection_MaskOn("LightDirection_MaskOn", Float) = 1
		[ToggleUI]_Is_NormalMapToRimLight("RimLightNormal", Float) = 0
		_Tweak_RimLightMaskLevel("tweak_RimLightMaskLevel", Range( 0 , 1)) = 1
		_RimLightColor("RimLightColor", Color) = (0.4433962,0.4433962,0.4433962,1)
		_RimLight_Power("rimLight_Power", Range( 0 , 1)) = 0.267599
		
		_Set_AnisotropicMask("AnisotropicMask", 2D) = "white" {}
	
		_MatCap_Sampler("matCap_Sampler", 2D) = "white" {}
		_Tweak_MatcapMaskLevel("tweak_MatcapMaskLevel", Range( 0 , 1)) = 0
		
	   

		_Tweak_Matcap_Emission_Level("tweak_Matcap_Emission_Level", Range( 0 , 1)) = 0.5485282
        [HDR]_MatCapColor("matCapColor", Color) = (1,1,1,1)
		_Emissive_Tex("emissive_Tex", 2D) = "black" {}
	    [HDR]_Emissive_Color("emissive_Color", Color) = (1,1,1,1)
		
		_Outline_Color("Outline Color", Color) = (1,1,1,1)
		[ToggleUI]_Is_LightColor_Outline("Is_LightColor_Outline", Float) = 1
		[ToggleUI]_BlendShadowColor("BlendShadowColor", Float) = 1
		_Outline_Width("Outline Width", Range( 0 , 10)) = 3.820995
		[Toggle(_OUTLINETEXTOGGLE_ON)] _OutlineTexToggle("outlineTexToggle", Float) = 0
		[NoScaleOffset]_OutlineTex("outlineTex", 2D) = "white" {}

		_Unlit_Intensity("unlit_Intensity", Range( 0 , 5)) = 1
		[ToggleUI]_Is_BLD("Is_BLD", Float) = 0
		_Offset_X_Axis_BLD("offset_X_Axis_BLD", Range( -1 , 1)) = -1
		_Offset_Y_Axis_BLD("offset_Y_Axis_BLD", Range( -1 , 1)) = 1
		_Offset_Z_Axis_BLD("offset_Z_Axis_BLD", Range( -1 , 1)) = -1

		_AmbientMax("AmbientMax", Range( 0.5 , 1)) = 0.8301814
		_AmbientMinimum("AmbientMinimum", Range( 0 , 1)) = 0

		
		[Enum(UnityEngine.Rendering.CullMode)]
		                 _CullMode("CullMode", Float) = 2
                         
		[HideInInspector][Enum(Opeaque,0,Cutout,1,Transparent,3,StencilMask,4,StencilOut,5)]	_RenderMode("renderMode",Float) = 0

		[HideInInspector] _BlendMode ("__mode", Float) = 0.0
        [HideInInspector] _SrcBlend ("__src", Float) = 1.0
        [HideInInspector] _DstBlend ("__dst", Float) = 0.0
        [HideInInspector] _ZWrite ("__zw", Float) = 1.0
		
	                     [Header(Stencil)]                               _StencilRef("Stencil Ref", Range(0, 255)) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]   _StencilComp("Stencil Comp", Float) = 8// ALways
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilPassOp("Stencil Pass Op", Float) = 0// Keep
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilZFailOp("Stencil ZFail Op", Float) = 0// Keep

	}
	
		SubShader{

		     Tags { "IgnoreProjector"="True" "RenderType"="TransparentCutout" "Queue"="Geometry" }   

		        LOD 0

			      ZWrite [_ZWrite]

	              Blend [_SrcBlend][_DstBlend]

				   Stencil
            {
                Ref [_StencilRef]
                Comp [_StencilComp]
                Pass [_StencilPassOp]
                ZFail [_StencilZFailOp]
           }

				   
   
	            
		       Pass {
			      
				  Name "FORWARD"

			      Cull[_CullMode]

	
				 
			      Tags { "LightMode"="ForwardBase" }
			      
				 CGPROGRAM

			


			 #pragma vertex vert
			 #pragma fragment frag
		     #pragma target 4.0 

             #pragma multi_compile_fog

			 
             #pragma multi_compile_local _IS_CLIPPING_OFF _IS_CLIPPING_MODE _IS_CLIPPING_TRANSMODE
			 #pragma shader_feature_local _CONVERTTEXTUREMODE_ON 
			 #pragma shader_feature_local _PARALLAX_ON 
			 #pragma shader_feature_local _DETAILBLEND_ON 
			 #pragma shader_feature_local _EYEHIANDLIMBUS_ON
			
			 
			 #include "./cginc/KDAvaterShaders_Core.cginc"
			 
			
			
			
			ENDCG
		}
		 Pass{
			   	Tags { "LightMode"="ForwardBase" }
			      Name "Outline" 

				  Cull Front

				  

			      CGPROGRAM
			     
			     #pragma vertex vert
			     #pragma fragment frag
				 #pragma multi_compile_fog
			     #pragma target 4.0 

				 #pragma multi_compile_local _IS_OUTLINE_CLIPPING_YES _IS_OUTLINE_CLIPPING_NO
		         
		         #include "./cginc/KDAvaterShaders_Outline.cginc"


			     
			      ENDCG
				  }

				   Pass {
				    Tags { "LightMode"="ShadowCaster" }

                      Name "ShadowCaster"

		              Offset 1, 1
                      Cull Off

		              CGPROGRAM

                      #pragma vertex vert
                      #pragma fragment frag
					  #pragma fragmentoption ARB_precision_hint_fastest
			          #pragma multi_compile_shadowcaster
			          #pragma target 4.0
		              #include "UnityCG.cginc"
		              #include "./cginc/KDAvaterShaders_ShadowCaster.cginc"
			 
           
			        ENDCG
					}
	}	
		      
	 FallBack "Legacy Shaders/VertexLit"
	
	CustomEditor "KD.KDAvaterShadersInspector"
	
  }
