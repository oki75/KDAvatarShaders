//KDShader
//KDShader ver.1.0
//v.1.0.9
//https://github.com/oki75/KDShader           
//(C)KINAKODOUHU

Shader "KDShader/NoOutline/KDShader_Mobile_NoOutline_Clipping_StensilMask"
{
	Properties
	{

	  [HideInInspector]	_KDSVersion	                  ( "Version"	, Float ) = 1.00
      [HideInInspector] _KDSType                      ( "ShderType"	, Int ) = 1
     
     

	                    _Clipping_Level	              ("clipping_Level"	, Range( 0 , 1)) = 0
	                    _Tweak_transparency	          ("tweak_transparency"	, Range( 0 , 1)) = 0
          [ToggleUI]	_Inverse_Clipping	          ("Inverse_Clipping"	,Int) = 0
          [ToggleUI]	_Use_Decal_alpha	          ("Use_Decal_alpha"	, Int) = 0
	                    _ClippingMask	              ("clippingMask"	, 2D) = "black" {}   
					
		  [ToggleUI]    _Decal_UVSet2_Toggle          ("Decal_UVSet2_Toggle", Int) = 0
		  [ToggleUI]    _Decal_Toggle                 ("decal_Toggle", Int) = 0
		                _DecalMap                     ("decalMap", 2D) = "white" {}
		                _MainTex                      ("mainTex", 2D) = "white" {}
		                _BaseColor                    ("baseColor", Color) = (1,1,1,1)
		                _1st_ShadeMap                 ("firstShadeMap", 2D) = "white" {}
		  [ToggleUI]    _Use_BaseAs1st                ("use_BaseAs1st", Int) = 0
		                _1st_ShadeColor               ("1st_ShadeColor", Color) = (1,1,1,1)
		                _2nd_ShadeMap                 ("2ndShadeMap", 2D) = "white" {}
		  [ToggleUI]    _Use_BaseAs2nd                ("use_BaseAs2nd", Int) = 0
		                _2nd_ShadeColor               ("2nd_ShadeColor", Color) = (1,1,1,1)
		  [ToggleUI]    _Fix_ShadeMap_UVSet2_Toggle   ("fix_ShadeMap_UVSet2_Toggle", Int) = 0
		                _FixShadeColorMap             ("fixShadeColorMap", 2D) = "white" {}
		  [ToggleUI]    _Use_BaseAsFix                ("use_BaseAsFix", Int) = 0
		                _FixShadeMap                  ("fixShadeMap", 2D) = "white" {}
		                _Tweak_FixShadeMapLevel       ("tweak_FixShadeMapLevel", Range( 0 , 2)) = 1
		                _FixShadeColor                ("fixShadeColor", Color) = (1,1,1,1)
		  [ToggleUI]    _NormalMap_UVSet2_Toggle      ("NormalMap_UVSet2_Toggle", Int) = 0
		   [Normal]     _NormalMap                    ("NormalMap", 2D) = "bump" {}
		                _BumpScale                    ("NormalScale", Range( 0 , 1)) = 0
		  [ToggleUI]    _NormalMap2_UVSet2_Toggle     ("Detail_UVSet2_Toggle", Int) = 0
		   [Normal]     _NormalMap2                   ("DetailMap", 2D) = "bump" {}
		                _BumpScale2                   ("DetailScale", Range( 0 , 1)) = 0
		  [ToggleUI]    _ShadeNormal                  ("Shade Normal", Int) = 1
		                _BaseColor_Step               ("baseColor_Step", Range( 0 , 1)) = 0
		                _BaseShade_Feather            ("Base/Shade Feather", Range( 0 , 1)) = 0
		                _ShadeColor_Step              ("shadeColor_Step", Range( 0 , 1)) = 0
		                _1st2nd_Shades_Feather        ("first2nd_Shades_Feather", Range( 0 , 1)) = 0

		                _RGB_mask                     ("RGB_mask", 2D) = "white" {}
		  [ToggleUI]    _ParallaxToggle               ("parallaxToggle", Int) = 0
		  [ToggleUI]    _FixShadeParallax             ("fixShadeParallax", Int) = 0
		                _ParallaxMap                  ("parallaxMap", 2D) = "white" {}
		                _ParallaxScale                ("parallaxScale", Range( 0 , 0.1)) = 0.02578901

		  [ToggleUI]    _HighColorMask_UVSet2_Toggle     ("HighColorMask_UVSet2_Toggle", Float) = 0
		                _Set_HighColorMask               ("HighColorMask", 2D) = "white" {}
		                _Set_AnisotropicMask             ("AnisotropicMask", 2D) = "white" {}
		                _Tweak_HighColorMaskLevel        ("tweak_HighColorMaskLevel", Range( 0 , 1)) = 0
		  [ToggleUI]    _Anisotropic_highlight_Toggle    ("Anisotropic_highlight_Toggle", Int) = 0
		  [ToggleUI]    _Anisotropic_TangentNormal_Toggle("Anisotropic_Tangent Normal_Toggle", Int) = 0
		                _aniso_offset                    ("aniso_offset", Range( -1 , 1)) = 0.5927008
		                _HighColor                       ("HighColor", Color) = (1,1,1,1)
		                _Shininess                       ("shininess", Range( 0 , 1)) = 0.2917107
		  [ToggleUI]    _Is_NormalMapToHighColor         ("HighColor Normal", Int) = 0
		  [ToggleUI]    _RimLightToggle                  ("RimLightToggle", Int) = 1
		  [ToggleUI]    _LightDirection_MaskOn           ("LightDirection_MaskOn", Int) = 1
		  [ToggleUI]    _Is_NormalMapToRimLight          ("RimLightNormal", Int) = 0
		                _Tweak_RimLightMaskLevel         ("tweak_RimLightMaskLevel", Range( 0 , 1)) = 0.4375842
		                _RimLight_Power                  ("rimLight_Power", Range( 0 , 1)) = 0.267599
		                _RimLightColor                   ("RimLightColor", Color) = (1,1,1,1)
		                _MatCap_Sampler                  ("matCap_Sampler", 2D) = "white" {}
		                _Tweak_MatcapMaskLevel           ("tweak_MatcapMaskLevel", Range( 0 , 1)) = 0
		                _Tweak_Matcap_Emission_Level     ("tweak_Matcap_Emission_Level", Range( 0 , 1)) = 0
		      [HDR]     _MatCapColor                     ("matCapColor", Color) = (1,1,1,1)
		                _Emissive_Tex                    ("emissive_Tex", 2D) = "black" {}
		      [HDR]     _Emissive_Color                  ("emissive_Color", Color) = (1,1,1,1)

//						_Outline_Color                   ("Outline Color", Color) = (1,1,1,1)
//		  [ToggleUI]    _BlendShadowColor                ("BlendShadowColor", Int) = 0
//		                _Outline_Width                   ("Outline Width", Range( 0 , 10)) = 0.7
//		  [ToggleUI]    _OutlineTexToggle                ("outlineTexToggle", Int) = 0
//		[NoScaleOffset] _OutlineTex                      ("outlineTex", 2D) = "white" {}

		                _Unlit_Intensity                 ("unlit_Intensity", Range( 0 , 5)) = 1
		  [ToggleUI]    _Is_BLD                          ("Is_BLD", Int) = 0
		                _Offset_X_Axis_BLD               ("offset_X_Axis_BLD", Range( -1 , 1)) = 0
		                _Offset_Y_Axis_BLD               ("offset_Y_Axis_BLD", Range( -1 , 1)) = 0
						_Offset_Z_Axis_BLD               ("offset_Z_Axis_BLD", Range( -1 , 1)) = 0
		                _AmbientMinimum                  ("AmbientMinimum", Range( 0 , 1)) = 0
		                _StencilReference                ("Stencil Reference", Int) = 2		               
		  [Enum(OFF,0,FRONT,1,BACK,2)]
		                _CullMode("CullMode", Int) = 2
		

	}
	
		SubShader{

		     Tags { "IgnoreProjector"="True" "RenderType"="Opaque" "Queue"="Geometry" }   

		        LOD 0

			      ZWrite On

	              Blend Off

				  Stencil
				  {
				   	Ref [_StencilReference]
				   	Comp Always
				   	Pass Replace
				   	Fail Keep
				   	ZFail Keep
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
			      #include "UnityCG.cginc"
			      #include "AutoLight.cginc"
	              #include "Lighting.cginc"

			      #pragma multi_compile _IS_CLIPPING_MODE

			      #include "./cginc/KDShader_MultiPassUnlit.cginc"

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
		              #include "./cginc/KDShader_ShadowCaster.cginc"
			 
           
			        ENDCG
			   }
		}

	    FallBack "Legacy Shaders/VertexLit"
	  
	    CustomEditor "KD.KDInspector"	
	
}