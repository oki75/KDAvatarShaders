//KDAvaterShaders_Outline.cginc
//KDShader
//KDAvaterShaders ver.1.1
//v.1.1.00
//https://github.com/oki75/KDAvaterShaders           


             //#pragma multi_compile_fog
             //#pragma multi_compile_local _IS_CLIPPING_OFF 
			 //#pragma shader_feature_local _PARALLAX_ON 
			 //#pragma shader_feature_local _DETAILBLEND_ON 
			 //#pragma shader_feature_local _EYEHIANDLIMBUS_ON
 
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "AutoLIght.cginc"
            #include "UnityStandardUtils.cginc"
            #include "UnityShaderVariables.cginc"

			#include "KDShader_Function.cginc"

            #if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
			#endif//ASE Sampling Macros

             struct appdata
			 {
				    float4 vertex : POSITION;
				    float3 normal : NORMAL;
			 	    float4 texcoord : TEXCOORD0;
				    UNITY_VERTEX_INPUT_INSTANCE_ID
				    float4 ase_tangent : TANGENT;
				    float4 ase_texcoord1 : TEXCOORD1;
			 };

			 struct v2f
			 {
				    float4 vertex : SV_POSITION;
				    float4 texcoord : TEXCOORD0;
				    UNITY_VERTEX_OUTPUT_STEREO
				    float4 ase_texcoord1 : TEXCOORD1;
				    float4 ase_texcoord2 : TEXCOORD2;
				    float4 ase_texcoord3 : TEXCOORD3;
				    float4 ase_texcoord4 : TEXCOORD4;
			//Fog
					UNITY_FOG_COORDS(5)
		    };

			 float _Is_LightColor_Outline;
			 float _BlendShadowColor;
		    float4 _Outline_Color;
			 UNITY_DECLARE_TEX2D_NOSAMPLER(_OutlineTex);
			SamplerState sampler_OutlineTex;
			 half _Outline_Width;

				 			      
			       float _ZWrite;
			       float _SrcBlend;
			       float _DstBlend;
			       float _CullMode;
			      
			

		//	fixed        _Cutoff;
			
			fixed        _Is_NormalMapToHighColor;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_NormalMap);
			 SamplerState sampler_NormalMap;
			 float4       _NormalMap_ST;

			 fixed        _NormalMap_UVSet2_Toggle;
			 float        _BumpScale;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_NormalMap2);
			 SamplerState sampler_NormalMap2;
			 float4       _NormalMap2_ST;

			 fixed        _NormalMap2_UVSet2_Toggle;
			 float        _BumpScale2;

             UNITY_DECLARE_TEX2D_NOSAMPLER(_ParallaxMap);
			 SamplerState sampler_ParallaxMap;
			 float4       _ParallaxMap_ST;
			 
			 float        _ParallaxScale;
             fixed        _ParallaxToggle;
			 float        _NormalMapParallax;
			 float        _HighColorParallax;
			 float        _Detail_Parallax;
		     fixed        _BaseParallax;
			 fixed        _FixShadeParallax;

			 fixed        _Is_BLD;
			 float        _Offset_X_Axis_BLD;
			 float        _Offset_Y_Axis_BLD;
			 float        _Offset_Z_Axis_BLD;

             float4       _HighColor;
			 float        _DubleHighColor_Toggle;
			 float        _HighColorHue;
			 float        _HighColorSaturation;
			 half         _HighColor_Ratio;
			 float        _BlurLevel;
             
			 
			 float        _Shininess;
			 fixed        _Anisotropic_TangentNormal_Toggle;
			 float        _aniso_offset;
			 fixed        _Anisotropic_highlight_Toggle;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_Set_AnisotropicMask);
			 SamplerState sampler_Set_AnisotropicMask;

			 fixed        _HighColorMask_UVSet2_Toggle;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_Set_HighColorMask);
			 SamplerState sampler_Set_HighColorMask;
			 float4       _Set_HighColorMask_ST;

			 float        _Tweak_HighColorMaskLevel;

			 fixed        _LightDirection_MaskOn;
			 fixed        _Is_NormalMapToRimLight;
			 float        _RimLight_Power;
			 float4       _RimLightColor;
			 float        _Tweak_RimLightMaskLevel;
			 fixed        _RimLightToggle;

             UNITY_DECLARE_TEX2D_NOSAMPLER(_RGB_mask);
			 SamplerState sampler_RGB_mask;
			 float4       _RGB_mask_ST;
			 

			
			 float        _ShadeNormal;
			 fixed        _Use_BaseAsFix;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
			 SamplerState sampler_MainTex;
			 float4       _MainTex_ST;
			 
			 UNITY_DECLARE_TEX2D_NOSAMPLER(_DecalMap);
			 SamplerState sampler_DecalMap;
			 float4       _DecalMap_ST;

			 fixed        _Decal_UVSet2_Toggle;
			 fixed        _Decal_Toggle;
			 float4       _FixShadeColor;

             UNITY_DECLARE_TEX2D_NOSAMPLER(_FixShadeColorMap);
			 SamplerState sampler_FixShadeColorMap;
			 float4       _FixShadeColorMap_ST;

			 fixed        _Use_BaseAs2nd;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_2nd_ShadeMap);
			 SamplerState sampler_2nd_ShadeMap;
			 float4       _2nd_ShadeMap_ST;
			 
			 float4       _2nd_ShadeColor;
			 fixed        _Use_BaseAs1st;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_1st_ShadeMap);
			 SamplerState sampler_1st_ShadeMap;
             float4       _1st_ShadeMap_ST;
			
			 float4       _1st_ShadeColor;
			 float4       _BaseColor;

			 UNITY_DECLARE_TEX2D_NOSAMPLER(_FixShadeMap);
			 SamplerState sampler_FixShadeMap;
			 float4       _FixShadeMap_ST;
			
			 fixed        _Fix_ShadeMap_UVSet2_Toggle;
			 float        _BaseColor_Step;
			 float        _BaseShade_Feather;
			 float        _ShadeColor_Step;
			 float        _1st2nd_Shades_Feather;
			 float        _HighColorBlurShadow;
			 float        _Tweak_HighColorBlurShadowLevel;
			 float        _Tweak_FixShadeMapLevel;
//EyeLens 
			 float _EyeHi2_Blend;
			 float _EyeHi_Toggle;
			 half4 _LimbusColor;
			 half _Limbus_Scale;
			 half _LimbusAdjustMirror;
			 float2 _LimbusTilling;
			 half _LimbusOffsetX;
			 half _LimbusOffsetY;
			 half _Limbus_BlurStep;
			 half _Limbus_BlurFeather;
			 half _EyeHiAndLimbusMirrorON;

			UNITY_DECLARE_TEX2D_NOSAMPLER(_EyeBase);
			SamplerState sampler_EyeBase;

			 float _BlendAddEyeBase;
			 half4 _EyeHiColor;
			 half _EyeHi_Scale;
			 half _EyeHiAdjustMirror;
			 float2 _EyeHiTilling;
			 half _EyeHiOffsetX;
			 half _EyeHiOffsetY;
			 half _EyeHi_BlurStep;
			 half _EyeHi_BlurFeather;
			 half4 _EyeHi2Color;
			 half _EyeHi2_Scale;
			 half _EyeHi2AdjustMirror;
			 float2 _EyeHi2Tilling;
			 half _EyeHi2OffsetX;
			 half _EyeHi2OffsetY;
			 half _EyeHi2_BlurStep;
			 half _EyeHi2_BlurFeather;
//			 
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MatCap_Sampler);
			SamplerState sampler_MatCap_Sampler;

			 float4       _MatCapColor;
			 float        _Tweak_MatcapMaskLevel;
			 float        _Tweak_Matcap_Emission_Level;
			 float        _Unlit_Intensity;
			 float        _AmbientMinimum;
			 uniform half _AmbientMax;

			UNITY_DECLARE_TEX2D_NOSAMPLER(_Emissive_Tex);
			SamplerState sampler_Emissive_Tex;
            float4       _Emissive_Tex_ST;
			
			float4       _Emissive_Color;

//_Clipping
             UNITY_DECLARE_TEX2D_NOSAMPLER(_ClippingMask);
             SamplerState sampler_ClippingMask;  float4 _ClippingMask_ST;
			 float   _Clipping_Level;
			 fixed   _Inverse_Clipping;
			 fixed   _Use_Decal_alpha;
			 float  _Tweak_transparency;

			   

			        v2f vert ( appdata v  )
			      {
				    v2f o;
				    UNITY_SETUP_INSTANCE_ID ( v );
				    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO ( o );
				    o.texcoord.xy = v.texcoord.xy;
				    o.texcoord.zw = 0;
				    float3 MyLocalVar;
				    float4 unityObjectToClipPos17_g487 = UnityObjectToClipPos( v.vertex.xyz );
				    float2 uv_RGB_mask = v.texcoord.xy * _RGB_mask_ST.xy + _RGB_mask_ST.zw;
				    float4 tex2DNode146 = SAMPLE_TEXTURE2D_LOD( _RGB_mask, sampler_RGB_mask, uv_RGB_mask, 0.0 );
				    float Bmask142 = tex2DNode146.b;
				    float OutLineSampler145 = Bmask142;
				    
				    float3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
				    o.ase_texcoord1.xyz = ase_worldTangent;
				    float3 ase_worldNormal = UnityObjectToWorldNormal(v.normal);
				    o.ase_texcoord2.xyz = ase_worldNormal;
				    float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				    float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				    o.ase_texcoord3.xyz = ase_worldBitangent;
				    float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				    o.ase_texcoord4.xyz = ase_worldPos;
				    
				    o.texcoord.zw = v.ase_texcoord1.xy;
				    
				    //setting value to unused interpolator channels and avoid initialization warnings
				    o.ase_texcoord1.w = 0;
				    o.ase_texcoord2.w = 0;
				    o.ase_texcoord3.w = 0;
				    o.ase_texcoord4.w = 0;
				    v.vertex.xyz += ( v.normal * ( 0.005 * _Outline_Width ) * min( unityObjectToClipPos17_g487.w , 0.15 ) * OutLineSampler145 );
				    o.vertex = UnityObjectToClipPos ( v.vertex );
					UNITY_TRANSFER_FOG(o,o.vertex);
				    return o;
			      }

			      fixed4 frag ( v2f i  ) : SV_Target
			      {

			    	fixed4 myColorVar;
				    float2 uv_OutlineTex138 = i.texcoord.xy;
				    float4 outlineTex468 = SAMPLE_TEXTURE2D( _OutlineTex, sampler_OutlineTex, uv_OutlineTex138 );
#ifdef _OUTLINETEXTOGGLE_ON
				    float4 staticSwitch594 = ( _Outline_Color * outlineTex468 );
#else
				    float4 staticSwitch594 = _Outline_Color;
#endif
				    float4 OutlineTex135 = saturate( staticSwitch594 );
				    float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				    float2 uv_ParallaxMap = i.texcoord.xy * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
				    float4 tex2DNode253 = SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, uv_ParallaxMap );
				    float3 ase_worldTangent = i.ase_texcoord1.xyz;
				    float3 ase_worldNormal = i.ase_texcoord2.xyz;
				    float3 ase_worldBitangent = i.ase_texcoord3.xyz;
				    float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				    float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				    float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				    float3 ase_worldPos = i.ase_texcoord4.xyz;
				    float3 ase_worldViewDir = UnityWorldSpaceViewDir(ase_worldPos);
				    ase_worldViewDir = normalize(ase_worldViewDir);
				    float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				    ase_tanViewDir = normalize(ase_tanViewDir);
				    float2 Offset320 = ( ( tex2DNode253.r - 1 ) * ase_tanViewDir.xy * _ParallaxScale ) + uv_ParallaxMap;
				    float2 Offset344 = ( ( SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, Offset320 ).r - 1 ) * ase_tanViewDir.xy * 0.0 ) + Offset320;
				    float2 Offset347 = ( ( SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, Offset344 ).r - 1 ) * ase_tanViewDir.xy * 0.0 ) + Offset344;
				    float2 Offset307 = ( ( SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, Offset347 ).r - 1 ) * ase_tanViewDir.xy * 0.0 ) + Offset347;
				    #ifdef _PARALLAX_ON
				    float2 staticSwitch418 = Offset307;
				    #else
				    float2 staticSwitch418 = uv_ParallaxMap;
				    #endif
				    float2 Parallaxoffset275 = staticSwitch418;
				    float parallaxtogle281 = tex2DNode253.g;
				    float2 lerpResult378 = lerp( uv_MainTex , ( ( Parallaxoffset275 + uv_MainTex ) / float2( 2,2 ) ) , (( _BaseParallax )?( parallaxtogle281 ):( 0.0 )));
				    float4 mainTex453 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, lerpResult378 );


             //EyeLens
                    
                    float time22 = 0.0;
					float2 voronoiSmoothId22 = 0;
					float2 id22 = 0;
				    float2 uv22 = 0;
            //Limbus
					float clampResult56_g455 = clamp( _Limbus_Scale , 0.0 , ( 1.0 / _Limbus_Scale ) );
					float2 temp_cast_1 = (clampResult56_g455).xx;
                    float2 LimbusOffset = (float2(_LimbusOffsetX , _LimbusOffsetY));
			        float2 LimbusUV = i.texcoord.xy * _LimbusTilling + LimbusOffset;
					float2 LimbusAdjustMirrorR = (float2(( -_LimbusAdjustMirror + ( 1.0 - LimbusUV.x ) ) , LimbusUV.y));
					float ClampR = clamp( _Limbus_Scale , 0.0 , ( 1.0 / _Limbus_Scale ) );
					float2 clampResult102 = clamp( LimbusAdjustMirrorR , float2( 0,0 ) , temp_cast_1 );
					float2 V01_UV = clampResult102 * _Limbus_Scale;

					float voroiR01_Mirror = voronoi01( V01_UV, time22, id22, uv22, 0, voronoiSmoothId22 );
					float BlurStepR01 = ( _Limbus_BlurStep * 0.1 );
					float BlurFeatherR01 = ( BlurStepR01 + ( _Limbus_BlurFeather * 0.1 ) );

					float MaskR01 = saturate( (-10.0 + (voroiR01_Mirror - BlurStepR01) * (1.0 - -10.0) / (BlurFeatherR01 - BlurStepR01)) );
					float LimbusR01 = ( saturate( (1.0 + (voroiR01_Mirror - BlurStepR01) * (0.0 - 1.0) / (BlurFeatherR01 - BlurStepR01)) ) + MaskR01 );
					float2 clampResult45 = clamp( LimbusUV , float2( 0,0 ) , temp_cast_1 );
					float2 coords22 = clampResult45 * _Limbus_Scale;

					float voroi22 = voronoi01( coords22, time22, id22, uv22, 0, voronoiSmoothId22 );
					float temp_output_154 = saturate( (-10.0 + (voroi22 - BlurStepR01) * (1.0 - -10.0) / (BlurFeatherR01 - BlurStepR01)) );
					float Limbus476 = lerp( LimbusR01 , ( LimbusR01 * ( saturate( (1.0 + (voroi22 - BlurStepR01) * (0.0 - 1.0) / 
					                      (BlurFeatherR01 - BlurStepR01)) ) + temp_output_154 ) ) , (( _EyeHiAndLimbusMirrorON )?( 1.0 ):( 0.0 )));
		
					float4 lerpResult565 = lerp( _LimbusColor , mainTex453 , Limbus476);
				    float4 tex2DNode517 = SAMPLE_TEXTURE2D( _EyeBase, sampler_EyeBase, ( LimbusUV * _Limbus_Scale ) );
				    float4 lerpResult518 = lerp( _LimbusColor , tex2DNode517 , Limbus476);

					float lerpResult647 = lerp( MaskR01 , ( MaskR01 * temp_output_154 ) , (( _EyeHiAndLimbusMirrorON )?( 1.0 ):( 0.0 )));
                 
				    float4 lerpResult530 = lerp( lerpResult518 , mainTex453 , lerpResult647);
				    float4 lerpResult689 = lerp( lerpResult565 , lerpResult530 , (( _BlendAddEyeBase )?( 1.0 ):( 0.0 )));
				
				//EyeHi
				    
				    float2 EyeHiOffset = (float2(_EyeHiOffsetX , _EyeHiOffsetY));
				    float2 EyeHiUV = i.texcoord.xy * _EyeHiTilling + EyeHiOffset;
				    float2 EyeHiAdjustMirrorR = (float2(( -_EyeHiAdjustMirror + ( 1.0 - EyeHiUV.x ) ) , EyeHiUV.y));
				    float  EyeHi_ScaleR = clamp( _EyeHi_Scale , 0.0 , ( 1.0 / _EyeHi_Scale ) );
				    float2 clampResult205 = clamp( EyeHiAdjustMirrorR , float2( 0,0 ) , ( EyeHi_ScaleR).xx );
				    float2 V02_UV = clampResult205 * _EyeHi_Scale;

				    float voroiR02 = voronoi01( V02_UV, time22, id22, uv22, 0, voronoiSmoothId22 );
				    float BlurStepR02 = ( _EyeHi_BlurStep * 0.1 );
				    float BlurFeatherR02 = ( BlurStepR02 + ( _EyeHi_BlurFeather * 0.1 ) );
				    float MaskR02 = saturate( (-10.0 + (voroiR02 - BlurStepR02) * (1.0 - -10.0) / (BlurFeatherR02 - BlurStepR02)) );
				    float EyeHiR02 = ( saturate( (1.0 + (voroiR02 - BlurStepR02) * (0.0 - 1.0) / (BlurFeatherR02 - BlurStepR02)) ) + MaskR02 );

				    float voroi206_g455 = voronoi01( V02_UV, time22, id22, uv22, 0, voronoiSmoothId22 );
				    float temp_output_58_0_g455 = ( _EyeHi_BlurStep * 0.1 );
				    float temp_output_63_0_g455 = ( temp_output_58_0_g455 + ( _EyeHi_BlurFeather * 0.1 ) );
				    float temp_output_197_0_g455 = saturate( (-10.0 + (voroi206_g455 - temp_output_58_0_g455) * (1.0 - -10.0) / (temp_output_63_0_g455 - temp_output_58_0_g455)) );
				    float temp_output_216_0_g455 = ( saturate( (1.0 + (voroi206_g455 - temp_output_58_0_g455) * (0.0 - 1.0) / (temp_output_63_0_g455 - temp_output_58_0_g455)) ) + temp_output_197_0_g455 );
				
				    float2 temp_cast_3 = ( EyeHi_ScaleR).xx;
				    float2 clampResult65_g455 = clamp( EyeHiUV , float2( 0,0 ) , temp_cast_3 );
				    float2 coords61_g455 = clampResult65_g455 * _EyeHi_Scale;
				   
				    float voroi61_g455 = voronoi01( coords61_g455, time22, id22, uv22, 0, voronoiSmoothId22 );
				    float temp_output_224_0_g455 = saturate( (-10.0 + (voroi61_g455 - temp_output_58_0_g455) * (1.0 - -10.0) / (temp_output_63_0_g455 - temp_output_58_0_g455)) );
				    float lerpResult676 = lerp( temp_output_216_0_g455 , ( temp_output_216_0_g455 * ( saturate( (1.0 + (voroi61_g455 - temp_output_58_0_g455) * (0.0 - 1.0) / (temp_output_63_0_g455 - temp_output_58_0_g455)) ) + temp_output_224_0_g455 ) ) , (( _EyeHiAndLimbusMirrorON )?( 1.0 ):( 0.0 )));
				    float EyeHi675 = lerpResult676;
				   
				    float4 lerpResult740 = lerp( _EyeHiColor , lerpResult689 , EyeHi675);
				    float4 eyebasemap673 = tex2DNode517;
				    float4 lerpResult678 = lerp( _EyeHiColor , eyebasemap673 , EyeHi675);
				    float lerpResult677 = lerp( temp_output_197_0_g455 , ( temp_output_197_0_g455 * temp_output_224_0_g455 ) , (( _EyeHiAndLimbusMirrorON )?( 1.0 ):( 0.0 )));
				    float4 lerpResult681 = lerp( lerpResult678 , lerpResult689 , lerpResult677);
				    float4 lerpResult723 = lerp( lerpResult740 , lerpResult681 , (( _BlendAddEyeBase )?( 1.0 ):( 0.0 )));

				//EyeHi2  

				    float2 appendResult256_g455 = (float2(_EyeHi2OffsetX , _EyeHi2OffsetY));
				    float2 texCoord253_g455 = i.texcoord.xy * _EyeHi2Tilling + appendResult256_g455;
				    float2 appendResult257_g455 = (float2(( -_EyeHi2AdjustMirror + ( 1.0 - texCoord253_g455.x ) ) , texCoord253_g455.y));
				    float clampResult252_g455 = clamp( _EyeHi2_Scale , 0.0 , ( 1.0 / _EyeHi2_Scale ) );
				    float2 temp_cast_4 = (clampResult252_g455).xx;
				    float2 clampResult269_g455 = clamp( appendResult257_g455 , float2( 0,0 ) , temp_cast_4 );
				    float2 coords268_g455 = clampResult269_g455 * _EyeHi2_Scale;
				    float voroi268_g455 = voronoi01( coords268_g455, time22, id22, uv22, 0, voronoiSmoothId22 );
				    float temp_output_249_0_g455 = ( _EyeHi2_BlurStep * 0.1 );
				    float temp_output_259_0_g455 = ( temp_output_249_0_g455 + ( _EyeHi2_BlurFeather * 0.1 ) );
				    float temp_output_271_0_g455 = saturate( (-10.0 + (voroi268_g455 - temp_output_249_0_g455) * (1.0 - -10.0) / (temp_output_259_0_g455 - temp_output_249_0_g455)) );
				    float temp_output_275_0_g455 = ( saturate( (1.0 + (voroi268_g455 - temp_output_249_0_g455) * (0.0 - 1.0) / (temp_output_259_0_g455 - temp_output_249_0_g455)) ) + temp_output_271_0_g455 );

				    float2 temp_cast_5 = (clampResult252_g455).xx;
				    float2 clampResult255_g455 = clamp( texCoord253_g455 , float2( 0,0 ) , temp_cast_5 );
				    float2 coords289_g455 = clampResult255_g455 * _EyeHi2_Scale;
		
				    float voroi289_g455 = voronoi01( coords289_g455, time22, id22, uv22, 0, voronoiSmoothId22 );
				    float temp_output_274_0_g455 = saturate( (-10.0 + (voroi289_g455 - temp_output_249_0_g455) * (1.0 - -10.0) / (temp_output_259_0_g455 - temp_output_249_0_g455)) );
				    float lerpResult827 = lerp( temp_output_275_0_g455 , ( temp_output_275_0_g455 * ( saturate( (1.0 + (voroi289_g455 - temp_output_249_0_g455) * (0.0 - 1.0) / (temp_output_259_0_g455 - temp_output_249_0_g455)) ) + temp_output_274_0_g455 ) ) , (( _EyeHiAndLimbusMirrorON )?( 1.0 ):( 0.0 )));
				    float EyeHi2828 = lerpResult827;
				  
				  
				    float4 lerpResult842 = lerp( _EyeHi2Color , lerpResult740 , EyeHi2828);
				    float4 lerpResult833 = lerp( _EyeHi2Color , eyebasemap673 , EyeHi2828);
				    float lerpResult829 = lerp( temp_output_271_0_g455 , ( temp_output_271_0_g455 * temp_output_274_0_g455 ) , (( _EyeHiAndLimbusMirrorON )?( 1.0 ):( 0.0 )));
				    float4 lerpResult830 = lerp( lerpResult833 , lerpResult681 , lerpResult829);
				    float4 lerpResult847 = lerp( lerpResult842 , lerpResult830 , (( _BlendAddEyeBase )?( 1.0 ):( 0.0 )));
#ifdef _EYEHIANDLIMBUS_ON
				    float4 staticSwitch948 = (( _EyeHi2_Blend )?( lerpResult847 ):( (( _EyeHi_Toggle )?( lerpResult723 ):( lerpResult689 )) ));
#else
				    float4 staticSwitch948 = mainTex453;
#endif
				    float4 eye_base605 = staticSwitch948;			

				    float2 uv_DecalMap = i.texcoord.xy * _DecalMap_ST.xy + _DecalMap_ST.zw;
				    float2 uv2_DecalMap = i.texcoord.zw * _DecalMap_ST.xy + _DecalMap_ST.zw;

				    float4 Decal_RGBA = SAMPLE_TEXTURE2D( _DecalMap, sampler_DecalMap, (( _Decal_UVSet2_Toggle )?( uv2_DecalMap ):( uv_DecalMap )) );
				    float4 Decal181 = Decal_RGBA;
				    float Decal_alpha166 = Decal_RGBA.a;
				    float4 lerpResult180 = lerp( eye_base605 , Decal181 , Decal_alpha166);
				    float4 lerpResult183 = lerp( eye_base605 , lerpResult180 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				    float2 uv_FixShadeMap = i.texcoord.xy * _FixShadeMap_ST.xy + _FixShadeMap_ST.zw;
				    float2 uv2_FixShadeMap = i.texcoord.zw * _FixShadeMap_ST.xy + _FixShadeMap_ST.zw;

				    float2 lerpResult282 = lerp( (( _Fix_ShadeMap_UVSet2_Toggle )?( uv2_FixShadeMap ):( uv_FixShadeMap )) , ( ( Parallaxoffset275 + (( _Fix_ShadeMap_UVSet2_Toggle )?( uv2_FixShadeMap ):( uv_FixShadeMap )) ) / float2( 2,2 ) ) , (( _FixShadeParallax )?( parallaxtogle281 ):( 0.0 )));
				    float4 fixShadeColorMap460 = SAMPLE_TEXTURE2D( _FixShadeColorMap, sampler_FixShadeColorMap, lerpResult282 );
				    float4 Fix_Shade176 = saturate( ( (( _Use_BaseAsFix )?( lerpResult183 ):( float4( 1,1,1,0 ) )) * _FixShadeColor * fixShadeColorMap460 ) );
				   
				    float4 secondShadeMap459 = SAMPLE_TEXTURE2D( _2nd_ShadeMap, sampler_2nd_ShadeMap, lerpResult378 );
				    float4 lerpResult153 = lerp( secondShadeMap459 , Decal181 , Decal_alpha166);
				    float4 lerpResult165 = lerp( secondShadeMap459 , lerpResult153 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				    float4 shadow2173 = saturate( ( (( _Use_BaseAs2nd )?( lerpResult183 ):( lerpResult165 )) * _2nd_ShadeColor ) );
				    float4 firstShadeMap455 = SAMPLE_TEXTURE2D( _1st_ShadeMap, sampler_1st_ShadeMap, lerpResult378 );
				    float4 lerpResult170 = lerp( firstShadeMap455 , Decal181 , Decal_alpha166);
				    float4 lerpResult169 = lerp( firstShadeMap455 , lerpResult170 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				    float4 shadow1171 = saturate( ( (( _Use_BaseAs1st )?( lerpResult183 ):( lerpResult169 )) * _1st_ShadeColor ) );
				    float4 Base172 = saturate( ( lerpResult183 * _BaseColor ) );

				    float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				    float4 transform53_g332 = mul(unity_ObjectToWorld,float4( ( ( float3(1,0,0) * ( _Offset_X_Axis_BLD * 10.0 ) ) + ( float3(0,1,0) * ( _Offset_Y_Axis_BLD * 10.0 ) ) + ( float3(0,0,-1) * ( 1.0 - _Offset_Z_Axis_BLD ) ) ) , 0.0 ));
				    float4 normalizeResult44_g332 = normalize( transform53_g332 );
				    float2 uv_NormalMap = i.texcoord.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
				    float2 uv2_NormalMap = i.texcoord.zw * _NormalMap_ST.xy + _NormalMap_ST.zw;

				    float2 lerpResult437 = lerp( (( _NormalMap_UVSet2_Toggle )?( uv2_NormalMap ):( uv_NormalMap )) , ( ( Parallaxoffset275 + (( _NormalMap_UVSet2_Toggle )?( uv2_NormalMap ):( uv_NormalMap )) ) / float2( 2,2 ) ) , (( _NormalMapParallax )?( parallaxtogle281 ):( 0.0 )));
				    float2 uv_NormalMap2 = i.texcoord.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
				    float2 uv2_NormalMap2 = i.texcoord.zw * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
				    float2 lerpResult445 = lerp( (( _NormalMap2_UVSet2_Toggle )?( uv2_NormalMap2 ):( uv_NormalMap2 )) , ( ( (( _NormalMap2_UVSet2_Toggle )?( uv2_NormalMap2 ):( uv_NormalMap2 )) + Parallaxoffset275 ) / float2( 2,2 ) ) , (( _Detail_Parallax )?( parallaxtogle281 ):( 0.0 )));
				    #ifdef _DETAILBLEND_ON
				    float3 staticSwitch451 = BlendNormals( UnpackScaleNormal( float4( UnpackNormal( SAMPLE_TEXTURE2D( _NormalMap, sampler_NormalMap, lerpResult437 ) ) , 0.0 ), _BumpScale ) , UnpackScaleNormal( SAMPLE_TEXTURE2D( _NormalMap2, sampler_NormalMap2, lerpResult445 ), _BumpScale2 ) );
				    #else
				    float3 staticSwitch451 = UnpackScaleNormal( float4( UnpackNormal( SAMPLE_TEXTURE2D( _NormalMap, sampler_NormalMap, lerpResult437 ) ) , 0.0 ), _BumpScale );
				    #endif
				    float3 normalizeResult204 = normalize( staticSwitch451 );
				    float3 Normalmap202 = normalizeResult204;

				    float3 tanNormal45_g332 = (( _ShadeNormal )?( Normalmap202 ):( float3( 0,0,1 ) ));
				    float3 worldNormal45_g332 = normalize( float3(dot(tanToWorld0,tanNormal45_g332), dot(tanToWorld1,tanNormal45_g332), dot(tanToWorld2,tanNormal45_g332)) );
				    float dotResult39_g332 = dot( (( _Is_BLD )?( normalizeResult44_g332 ):( float4( worldSpaceLightDir , 0.0 ) )) , float4( worldNormal45_g332 , 0.0 ) );
				    float HalfLambert111_g332 = ( dotResult39_g332 * 0.5 );
				    float HalfLambert84 = HalfLambert111_g332;
				    float set_FixshadeMask222 = SAMPLE_TEXTURE2D( _FixShadeMap, sampler_FixShadeMap, lerpResult282 ).g;

				    float temp_output_4_0_g456 = ( ( 0.5 + HalfLambert84 ) * pow( set_FixshadeMask222 , 0.5 ) );
				    float clampResult7_g456 = clamp( (0.0 + (temp_output_4_0_g456 - _BaseColor_Step) * (1.0 - 0.0) / (( _BaseColor_Step + _BaseShade_Feather ) - _BaseColor_Step)) , 0.0 , 1.0 );
				    float RampShader85 = clampResult7_g456;
				    float4 lerpResult94 = lerp( shadow1171 , Base172 , RampShader85);
				    float clampResult2_g456 = clamp( (0.0 + (temp_output_4_0_g456 - _ShadeColor_Step) * (1.0 - 0.0) / (( _ShadeColor_Step + _1st2nd_Shades_Feather ) - _ShadeColor_Step)) , 0.0 , 1.0 );
				    float RampShader181 = clampResult2_g456;
				    float4 lerpResult104 = lerp( shadow2173 , lerpResult94 , RampShader181);

				    float2 uv_Set_HighColorMask = i.texcoord.xy * _Set_HighColorMask_ST.xy + _Set_HighColorMask_ST.zw;
				    float4 HighLightMipMapBlur918 = SAMPLE_TEXTURE2D_LOD( _Set_HighColorMask, sampler_Set_HighColorMask, uv_Set_HighColorMask, _BlurLevel );
				    float2 uv2_Set_HighColorMask = i.texcoord.zw * _Set_HighColorMask_ST.xy + _Set_HighColorMask_ST.zw;

				    float2 lerpResult426 = lerp( (( _HighColorMask_UVSet2_Toggle )?( uv2_Set_HighColorMask ):( uv_Set_HighColorMask )) , ( ( Parallaxoffset275 + (( _HighColorMask_UVSet2_Toggle )?( uv2_Set_HighColorMask ):( uv_Set_HighColorMask )) ) / float2( 2,2 ) ) , (( _HighColorParallax )?( parallaxtogle281 ):( 0.0 )));
				    float4 HighColorMask242 = SAMPLE_TEXTURE2D( _Set_HighColorMask, sampler_Set_HighColorMask, lerpResult426 );
				    float4 lerpResult922 = lerp( HighLightMipMapBlur918 , float4( 1,1,1,0 ) , HighColorMask242);
				    float grayscale917 = Luminance(lerpResult922.rgb);
				    float lerpResult920 = lerp( 1.0 , grayscale917 , _Tweak_HighColorBlurShadowLevel);
				    float lerpResult96 = lerp( 1.0 , ( set_FixshadeMask222 * (( _HighColorBlurShadow )?( lerpResult920 ):( 1.0 )) ) , _Tweak_FixShadeMapLevel);
				    float4 lerpResult105 = lerp( Fix_Shade176 , lerpResult104 , lerpResult96);
				    float4 shade103 = lerpResult105;

				    float3 localFunction_ShadeSH920_g332 = ShadeSH9(half4(0,0,0,1));
				    float3 localFunction_ShadeSH9_219_g332 = ShadeSH9(half4(0,-1,0,1));
				    half3 defaultLightColor21_g332 = saturate( max( ( half3(0.05,0.05,0.05) * _Unlit_Intensity ) , ( max( localFunction_ShadeSH920_g332 , localFunction_ShadeSH9_219_g332 ) * _Unlit_Intensity ) ) );
				    #if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				    float4 ase_lightColor = 0;
				    #else //aselc
				    float4 ase_lightColor = _LightColor0;
				    #endif //aselc
				    float3 lerpResult14_g332 = lerp( max( defaultLightColor21_g332 , ase_lightColor.rgb ) , max( defaultLightColor21_g332 , saturate( ase_lightColor.rgb ) ) , 1.0);
				    float3 ifLocalVar7_g332 = 0;
				    if( _WorldSpaceLightPos0.w > 0.0 )
				    ifLocalVar7_g332 = ( float3( 0,0,0 ) * lerpResult14_g332 );
				    else if( _WorldSpaceLightPos0.w == 0.0 )
				    ifLocalVar7_g332 = lerpResult14_g332;
				    else if( _WorldSpaceLightPos0.w < 0.0 )
				    ifLocalVar7_g332 = lerpResult14_g332;
				    float3 temp_cast_13 = (_AmbientMinimum).xxx;
				    float3 temp_cast_14 = (_AmbientMax).xxx;
				    float3 clampResult27_g332 = clamp( ifLocalVar7_g332 , temp_cast_13 , temp_cast_14 );
				    half3 Lighting28_g332 = clampResult27_g332;
				    float3 Lighting82 = Lighting28_g332;

					float4 break2215 = (( _Is_LightColor_Outline )?( ( (( _BlendShadowColor )?( ( OutlineTex135 * shade103 ) ):( OutlineTex135 )) * float4( Lighting82 , 0.0 ) ) ):( (
						( _BlendShadowColor )?( ( OutlineTex135 * shade103 ) ):( OutlineTex135 )) ));
				    float4 appendResult18_g487 = (float4(break2215.x , break2215.y , break2215.z , 1.0));

#ifdef _IS_OUTLINE_CLIPPING_YES
//_Clipping				   			    
				    float4 break39 = appendResult18_g487;
				    float2 uv_ClippingMask = i.texcoord.xy * _ClippingMask_ST.xy + _ClippingMask_ST.zw;
				   float Clipping_Mask1980_g1 = SAMPLE_TEXTURE2D( _ClippingMask, sampler_ClippingMask, uv_ClippingMask ).r;
				    float temp_output_71_2181 = saturate( (0.0 + ((( _Inverse_Clipping )?( ( 1.0 - (( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal_RGBA.a ) ):( Clipping_Mask1980_g1 )) ) ):( (
						( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal_RGBA.a ) ):( Clipping_Mask1980_g1 )) )) - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) )) * (1.0 - 0.0) / (_Tweak_transparency - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) ))) );
				    float4 appendResult38 = (float4(break39.r , break39.g , break39.b , temp_output_71_2181));
				    
				    myColorVar = appendResult38;
					

#elif _IS_OUTLINE_CLIPPING_NO
				  
				   myColorVar = appendResult18_g487;
					
#endif
					UNITY_APPLY_FOG(i.fogCoord,  myColorVar);
				    return myColorVar;
			      }
				   