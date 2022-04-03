//KDAvatarShaders_Core.cginc
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
				float4 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
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
			
			
			
			fixed        _CullMode;
			
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

            
          

			v2f vert ( appdata v )
			{
				
				v2f o;

				UNITY_SETUP_INSTANCE_ID ( v );
				UNITY_INITIALIZE_OUTPUT(v2f, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO ( o );

				o.texcoord.xy = v.texcoord.xy;
				o.texcoord.zw = 0;
				float3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
				o.ase_texcoord1.xyz = ase_worldTangent;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
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
				v.vertex.xyz +=  float3( 0,0,0 ) ;
				
				o.vertex = UnityObjectToClipPos ( v.vertex );
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			fixed4 frag ( v2f i  ) : SV_Target
			{
				fixed4 myColorVar;
             
			
			    float3 ase_worldPos = i.ase_texcoord4.xyz;
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(ase_worldPos);
				ase_worldViewDir = normalize(ase_worldViewDir);
			    float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);

			 //BLD
				float4 transform2434_g1 = mul(unity_ObjectToWorld,float4( ( ( float3(1,0,0) * ( _Offset_X_Axis_BLD * 10.0 ) ) + 
				    ( float3(0,1,0) * ( _Offset_Y_Axis_BLD * 10.0 ) ) + ( float3(0,0,-1) * ( 1.0 - _Offset_Z_Axis_BLD ) ) ) , 0.0 ));
				float4 BLD2460_g1 = normalize( transform2434_g1 );
			    float4 WSLD = (( _Is_BLD )?( BLD2460_g1 ):( float4( worldSpaceLightDir , 0.0 ) ));

				//Lighting
				UNITY_LIGHT_ATTENUATION(ase_atten, i, ase_worldPos)
				float3 SH9 = ShadeSH9(half4(0,0,0,1));
				float3 SH9_2 = ShadeSH9(half4(0,-1,0,1));
				float3 defaultLC = saturate( max( ( half3(0.05,0.05,0.05) * _Unlit_Intensity ) , ( max( SH9 , SH9_2 ) * _Unlit_Intensity ) ) );

#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				float4 ase_lightColor = 0;
#else //aselc
				float4 ase_lightColor = _LightColor0;
#endif //aselc
			  //Filter_LightColor
				float3 FLC_lerpR = lerp( max( defaultLC , ase_lightColor.rgb ) , max( defaultLC , saturate( ase_lightColor.rgb ) ) , 1.0);
				float3 NoDL = 0;
				if( _WorldSpaceLightPos0.w > 0.0 )
				NoDL = ( float3( 0,0,0 ) * FLC_lerpR );
				else if( _WorldSpaceLightPos0.w == 0.0 )
				NoDL = FLC_lerpR;
				else if( _WorldSpaceLightPos0.w < 0.0 )
				NoDL = FLC_lerpR;
				
				float3 temp_cast_23 = (_AmbientMinimum).xxx;
				float3 temp_cast_24 = (_AmbientMax).xxx;
				float3 clampResult27_g332 = clamp( NoDL , temp_cast_23 , temp_cast_24 );
				half3 Lighting28_g332 = clampResult27_g332;
				float3 Lighting82 = Lighting28_g332;


			 //uv2
				float2 uv_NormalMap = i.texcoord.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
				float2 uv2_NormalMap = i.texcoord.zw * _NormalMap_ST.xy + _NormalMap_ST.zw;

                float2 uv_NormalMap2 = i.texcoord.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
				float2 uv2_NormalMap2 = i.texcoord.zw * _NormalMap2_ST.xy + _NormalMap2_ST.zw;

				float2 uv_ParallaxMap = i.texcoord.xy * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
            
				float2 uv_DecalMap = i.texcoord.xy * _DecalMap_ST.xy + _DecalMap_ST.zw;
				float2 uv2_DecalMap = i.texcoord.zw * _DecalMap_ST.xy + _DecalMap_ST.zw;
				
				float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;

				float2 uv_FixShadeMap = i.texcoord.xy * _FixShadeMap_ST.xy + _FixShadeMap_ST.zw;
				float2 uv2_FixShadeMap = i.texcoord.zw * _FixShadeMap_ST.xy + _FixShadeMap_ST.zw;
				float2 uv_FixShadeColorMap = i.texcoord.xy * _FixShadeColorMap_ST.xy + _FixShadeColorMap_ST.zw;

				float2 uv_RGB_mask = i.texcoord.xy * _RGB_mask_ST.xy + _RGB_mask_ST.zw;

				float2 uv_Set_HighColorMask = i.texcoord.xy * _Set_HighColorMask_ST.xy + _Set_HighColorMask_ST.zw;
				float2 uv2_Set_HighColorMask = i.texcoord.zw * _Set_HighColorMask_ST.xy + _Set_HighColorMask_ST.zw;

				float2 uv_Emissive_Tex = i.texcoord.xy * _Emissive_Tex_ST.xy + _Emissive_Tex_ST.zw;
	
		   
							
            //Parallax R=hight G=Mask
				
				float4 parallaxMap = SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, uv_ParallaxMap );
				float HightMap = parallaxMap.r;

				float3 ase_worldTangent = i.ase_texcoord1.xyz;
				float3 ase_worldNormal = i.ase_texcoord2.xyz;
				float3 ase_worldBitangent = i.ase_texcoord3.xyz;

				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );

				

				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);

				float2 Offset2402_g1 = ( ( parallaxMap.r - 1 ) * ase_tanViewDir.xy * _ParallaxScale ) + uv_ParallaxMap;
				float2 Offset2364_g1 = ( ( SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, Offset2402_g1 ).r - 1 ) * ase_tanViewDir.xy * 0.0 ) + Offset2402_g1;
				float2 Offset2335_g1 = ( ( SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, Offset2364_g1 ).r - 1 ) * ase_tanViewDir.xy * 0.0 ) + Offset2364_g1;
				float2 Offset2358_g1 = ( ( SAMPLE_TEXTURE2D( _ParallaxMap, sampler_ParallaxMap, Offset2335_g1 ).r - 1 ) * ase_tanViewDir.xy * 0.0 ) + Offset2335_g1;
#ifdef _PARALLAX_ON
				float2 staticSwitch418 = Offset2358_g1;
#else
				float2 staticSwitch418 = uv_ParallaxMap;
#endif
				float2 Parallaxoffset275 = staticSwitch418;
				float parallaxtogle281 = parallaxMap.g;

				 //MainTex
			    float2 lerpResult378 = lerp( uv_MainTex , ( ( Parallaxoffset275 + uv_MainTex ) / 
				float2( 2,2 ) ) , (( _BaseParallax )?( parallaxtogle281 ):( 0.0 )));
                
				float4 mainTex453 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, lerpResult378 );

            
               //HighColorMipMapBlur
			
				
				float2 lerpResult426 = lerp( (( _HighColorMask_UVSet2_Toggle )?( uv2_Set_HighColorMask ):( uv_Set_HighColorMask )) , ( ( Parallaxoffset275 + (( _HighColorMask_UVSet2_Toggle )?( uv2_Set_HighColorMask ):( uv_Set_HighColorMask )) ) / 
				float2( 2,2 ) ) , (( _HighColorParallax )?( parallaxtogle281 ):( 0.0 )));

				float4 HighColorMask242 = SAMPLE_TEXTURE2D( _Set_HighColorMask, sampler_Set_HighColorMask, lerpResult426 );
			
				float3 hsvTorgb48_g486 = RGBToHSV( HighColorMask242.rgb );

				float3 HighColorHS = HSVToRGB( float3(( _HighColorHue + hsvTorgb48_g486.x ),( _HighColorSaturation + hsvTorgb48_g486.y ),hsvTorgb48_g486.z) );
				float grayscale81_g4 = Luminance(HighColorHS);

            //MipMapBlur
			
				float4 HighColorMipMapBlur = SAMPLE_TEXTURE2D_LOD( _Set_HighColorMask, sampler_Set_HighColorMask, lerpResult426, _BlurLevel );
	           
			    float grayscale953 = Luminance(HighColorMipMapBlur.rgb);
				float grayscale917 = Luminance(HighColorMask242.rgb);

				float lerpResult955 = lerp( 1.0 , 0.0 , ( grayscale953 - grayscale917 ));

				float lerpResult920 = lerp( 1.0 , lerpResult955 , _Tweak_HighColorBlurShadowLevel);
				             
            //NormalBlend
				
				float2 lerpResult437 = lerp( (( _NormalMap_UVSet2_Toggle )?( uv2_NormalMap ):( uv_NormalMap )) , ( ( Parallaxoffset275 + (( _NormalMap_UVSet2_Toggle )?( uv2_NormalMap ):( uv_NormalMap )) ) / 
				float2( 2,2 ) ) , (( _NormalMapParallax )?( parallaxtogle281 ):( 0.0 )));

				float2 lerpResult445 = lerp( (( _NormalMap2_UVSet2_Toggle )?( uv2_NormalMap2 ):( uv_NormalMap2 )) , ( ( (( _NormalMap2_UVSet2_Toggle )?( uv2_NormalMap2 ):( uv_NormalMap2 )) + Parallaxoffset275 ) / 
				float2( 2,2 ) ) , (( _Detail_Parallax )?( parallaxtogle281 ):( 0.0 )));
//
 #ifdef _DETAILBLEND_ON
				float3 staticSwitch451 = BlendNormals( UnpackScaleNormal( SAMPLE_TEXTURE2D( _NormalMap, sampler_NormalMap, lerpResult437 ), _BumpScale ) , 
				                                       UnpackScaleNormal( SAMPLE_TEXTURE2D( _NormalMap2, sampler_NormalMap2, lerpResult445 ), _BumpScale2 ) );
 #else
				float3 staticSwitch451 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _NormalMap, sampler_NormalMap, lerpResult437 ), _BumpScale );
#endif
				float3 normalizeResult204 = normalize( staticSwitch451 );
			    float3 Normalmap202 = normalizeResult204;
              //NHighColor
				float3 NHighColor = (( _Is_NormalMapToHighColor )?( Normalmap202 ):( float3( 0,0,1 ) ));

				float3 worldNormal19_g486 = float3(dot(tanToWorld0,NHighColor), dot(tanToWorld1,NHighColor), dot(tanToWorld2,NHighColor));

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
			
            //Blin-Phong reflection
				float4 BlinPhV = normalize( ( float4( ase_worldViewDir , 0.0 ) + WSLD ) );
				float BlinPhRef = dot( float4( worldNormal19_g486 , 0.0 ) , BlinPhV );
				
				
				float Shininess128 = ( _Shininess * 128.0 );
				float3 normalizeResult25_g486 = normalize( ( ase_worldViewDir + float3( 0,2,0 ) ) );
				
				float dotResult32_g486 = dot( float4( worldNormal19_g486 , 0.0 ) , (( _Anisotropic_TangentNormal_Toggle )?( 
				float4( normalizeResult25_g486 , 0.0 ) ):( BlinPhV )) );

				float AnisotropicMask239 = SAMPLE_TEXTURE2D( _Set_AnisotropicMask, sampler_Set_AnisotropicMask, lerpResult426 ).r;
				float lerpResult18_g486 = lerp( pow( max( BlinPhRef , 0.0 ) , Shininess128 ) , pow( max( 0.0 , sin( radians( ( 
					( dotResult32_g486 + _aniso_offset ) * 180.0 ) ) ) ) , Shininess128 ) , (( _Anisotropic_highlight_Toggle )?( AnisotropicMask239 ):( 0.0 )));
				
				
				float lerpResult101_g486 = lerp( lerpResult18_g486 , grayscale81_g4 , _HighColor_Ratio);

				float lerpResult79_g486 = lerp( lerpResult18_g486 , ( ( lerpResult18_g486 + lerpResult101_g486 ) / 2.0 ) , (( _DubleHighColor_Toggle )?( 1.0 ):( 0.0 )));
				float4 lerpResult86_g486 = lerp( float4( 0,0,0,0 ) , ( _HighColor * float4( HighColorHS , 0.0 ) ) , ( lerpResult79_g486 * _Tweak_HighColorMaskLevel ));
				float4 HighColorF243 = saturate( lerpResult86_g486 );


            //NormalToRim
				float3 tanNormal4_g485 = (( _Is_NormalMapToRimLight )?( Normalmap202 ):( float3( 0,0,1 ) ));

                float3 worldNormal4_g485 = float3(dot(tanToWorld0,tanNormal4_g485), dot(tanToWorld1,tanNormal4_g485), dot(tanToWorld2,tanNormal4_g485));
				float dotResult23_g485 = dot( worldNormal4_g485 , ase_worldViewDir );

				float temp_output_7_0_g485 = ( 1.0 - saturate( dotResult23_g485 ) );

				float lerpResult5_g485 = lerp( temp_output_7_0_g485 , pow( temp_output_7_0_g485 , 5.0 ) , ( 1.0 - _RimLight_Power ));
				float4 RimLightColor238 = _RimLightColor;

			//RGB_mask	
				float4 tex2DNode146 = SAMPLE_TEXTURE2D( _RGB_mask, sampler_RGB_mask, uv_RGB_mask );
				float Rmask140 = tex2DNode146.r;
				float set_RimLightMask143 = Rmask140;
				
				float4 lerpResult9_g485 = lerp( float4( 0,0,0,0 ) , ( lerpResult5_g485 * RimLightColor238 ) , set_RimLightMask143);
				float4 lerpResult11_g485 = lerp( float4( 0,0,0,0 ) , lerpResult9_g485 , _Tweak_RimLightMaskLevel);
				float4 lerpResult13_g485 = lerp( float4( 0,0,0,0 ) , lerpResult11_g485 , _RimLightToggle);

				float3 tanNormal45_g332 = (( _ShadeNormal )?( Normalmap202 ):( float3( 0,0,1 ) ));

				float3 worldNormal45_g332 = normalize( 
				float3(dot(tanToWorld0,tanNormal45_g332), dot(tanToWorld1,tanNormal45_g332), dot(tanToWorld2,tanNormal45_g332)) );
				
			//HalfLambert	

                float dotResult2135_g1 = dot( (( _Is_BLD )?( BLD2460_g1 ):( float4(  worldSpaceLightDir , 0.0 ) )) , float4( worldNormal45_g332 , 0.0 ) );
				float HalfLambert84 = ( dotResult2135_g1 * 0.5 );
				float4 lerpResult2089_g1 = lerp( float4( 0,0,0,0 ) , lerpResult13_g485 , HalfLambert84);
				float4 RimLightF289 = saturate( (( _LightDirection_MaskOn )?( lerpResult2089_g1 ):( lerpResult13_g485 )) );

			//Decal	

				float4 Decal_RGBA = SAMPLE_TEXTURE2D( _DecalMap, sampler_DecalMap, (( _Decal_UVSet2_Toggle )?( uv2_DecalMap ):( uv_DecalMap )) );

                float4 lerpResult180 = lerp( eye_base605 , Decal_RGBA , Decal_RGBA.a);

				float4 lerpResult183 = lerp( eye_base605 , lerpResult180 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				    
			//Fixshade

                //UV
			    float2 lerpResult282 = lerp( (( _Fix_ShadeMap_UVSet2_Toggle )?( uv2_FixShadeMap ):( uv_FixShadeMap )) , ( ( Parallaxoffset275 + (( _Fix_ShadeMap_UVSet2_Toggle )?( uv2_FixShadeMap ):( uv_FixShadeMap )) ) / 
				float2( 2,2 ) ) , (( _FixShadeParallax )?( parallaxtogle281 ):( 0.0 )));
                //ColorMap
			    float4 fixShadeColorMap460 = SAMPLE_TEXTURE2D( _FixShadeColorMap, sampler_FixShadeColorMap, lerpResult282 );
                //Blend
				float4 Fix_Shade176 = saturate( ( (( _Use_BaseAsFix )?( lerpResult183 ):( float4( 1,1,1,0 ) )) * _FixShadeColor * fixShadeColorMap460 ) );
                //Mask
			    float set_FixshadeMask222 = SAMPLE_TEXTURE2D( _FixShadeMap, sampler_FixShadeMap, lerpResult282 ).g;
			//2nd	
				float4 secondShadeMap459 = SAMPLE_TEXTURE2D( _2nd_ShadeMap, sampler_2nd_ShadeMap, lerpResult378 );
				float4 lerpResult153 = lerp( secondShadeMap459 , Decal_RGBA , Decal_RGBA.a);
				float4 lerpResult165 = lerp( secondShadeMap459 , lerpResult153 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				float4 shadow2173 = saturate( ( (( _Use_BaseAs2nd )?( lerpResult183 ):( lerpResult165 )) * _2nd_ShadeColor ) );
            //1st
				float4 firstShadeMap455 = SAMPLE_TEXTURE2D( _1st_ShadeMap, sampler_1st_ShadeMap, lerpResult378 );
				float4 lerpResult170 = lerp( firstShadeMap455 , Decal_RGBA , Decal_RGBA.a);
				float4 lerpResult169 = lerp( firstShadeMap455 , lerpResult170 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				float4 shadow1171 = saturate( ( (( _Use_BaseAs1st )?( lerpResult183 ):( lerpResult169 )) * _1st_ShadeColor ) );
				float4 Base172 = saturate( ( lerpResult183 * _BaseColor ) );
				
                
				//RampShader
				 float DFixShade = ( ( 0.5 + HalfLambert84 ) * pow( set_FixshadeMask222 , 0.5 ) );
                 float clampResult7_g456 = clamp( (0.0 + (DFixShade - _BaseColor_Step) * (1.0 - 0.0) / 
				 (( _BaseColor_Step + _BaseShade_Feather ) - _BaseColor_Step)) , 0.0 , 1.0 );
				float RampShader85 = clampResult7_g456;
				float4 lerpResult94 = lerp( shadow1171 , Base172 , RampShader85);
				float clampResult2_g456 = clamp( (0.0 + (DFixShade - _ShadeColor_Step) * (1.0 - 0.0) / 
				(( _ShadeColor_Step + _1st2nd_Shades_Feather ) - _ShadeColor_Step)) , 0.0 , 1.0 );
				float RampShader181 = clampResult2_g456;
				float4 lerpResult104 = lerp( shadow2173 , lerpResult94 , RampShader181);

                float lerpResult96 = lerp( 1.0 , ( set_FixshadeMask222 * (( _HighColorBlurShadow )?( lerpResult920 ):( 1.0 )) ) , _Tweak_FixShadeMapLevel);

				float4 lerpResult105 = lerp( Fix_Shade176 , lerpResult104 , lerpResult96);
				
				float4 shade103 = lerpResult105;
            	

				float3 tanNormal8_g484 = Normalmap202;
				float3 worldNormal8_g484 = float3(dot(tanToWorld0,tanNormal8_g484), dot(tanToWorld1,tanNormal8_g484), dot(tanToWorld2,tanNormal8_g484));	
				float4 matCap_Sampler462 = SAMPLE_TEXTURE2D( _MatCap_Sampler, sampler_MatCap_Sampler, ( ( (mul( float4( worldNormal8_g484 , 0.0 ), UNITY_MATRIX_V ).xyz).xy * 0.5 ) + 0.5 ) );
				float Gmask141 = tex2DNode146.g;
				float set_MatcapMask144 = Gmask141;
				float4 lerpResult266 = lerp( float4( 0,0,0,0 ) , ( matCap_Sampler462 * _MatCapColor ) , set_MatcapMask144);
				float4 lerpResult268 = lerp( float4( 0,0,0,0 ) , lerpResult266 , _Tweak_MatcapMaskLevel);
				float4 Matcap271 = saturate( lerpResult268 );
				float4 lerpResult97 = lerp( Matcap271 , float4( 0,0,0,0 ) , _Tweak_Matcap_Emission_Level);
			
			//Emission
				
                float4 emissive_Tex464 = SAMPLE_TEXTURE2D( _Emissive_Tex, sampler_Emissive_Tex, lerpResult378 );
                float4 Emission272 = saturate( ( emissive_Tex464 * _Emissive_Color ) );
			
				float4 lerpResult93 = lerp( float4( 0,0,0,0 ) , Matcap271 , _Tweak_Matcap_Emission_Level);
			//Final	
				float4 break102 = saturate( ( ( saturate( ( HighColorF243 + RimLightF289 + shade103 + lerpResult97 ) ) * 
				float4( Lighting82 , 0.0 ) ) + Emission272 + lerpResult93 ) );
				
				float4 appendResult2213_g1 = (float4(break102.r , break102.g , break102.b , 1.0));
//
#ifdef _IS_CLIPPING_MODE
//_Mobile_Clipping
				float4 break37 = appendResult2213_g1;
				float2 uv_ClippingMask = i.texcoord.xy * _ClippingMask_ST.xy + _ClippingMask_ST.zw;
				float Clipping_Mask1980_g1 = SAMPLE_TEXTURE2D( _ClippingMask, sampler_ClippingMask, uv_ClippingMask ).r;
				float temp_output_71_2181 = saturate( (0.0 + ((( _Inverse_Clipping )?( ( 1.0 - (( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal_RGBA.a ) ):( Clipping_Mask1980_g1 )) ) ):( 
					(( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal_RGBA.a ) ):( Clipping_Mask1980_g1 )) )) - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) )) * (1.0 - 0.0) / 
					(_Tweak_transparency - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) ))) );
				float4 appendResult36 = (float4(break37.r , break37.g , break37.b , temp_output_71_2181));

				myColorVar = appendResult36;

				clip(myColorVar.a - _Clipping_Level);

#elif _IS_CLIPPING_TRANSMODE
//_Mobile_TransClipping
                float4 break37 = appendResult2213_g1;
				float2 uv_ClippingMask = i.texcoord.xy * _ClippingMask_ST.xy + _ClippingMask_ST.zw;
				float Clipping_Mask1980_g1 = SAMPLE_TEXTURE2D( _ClippingMask, sampler_ClippingMask, uv_ClippingMask ).r;
				float temp_output_71_2181 = saturate( (0.0 + ((( _Inverse_Clipping )?( ( 1.0 - (( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal_RGBA.a ) ):( Clipping_Mask1980_g1 )) ) ):( 
					(( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal_RGBA.a ) ):( Clipping_Mask1980_g1 )) )) - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) )) * (1.0 - 0.0) / (_Tweak_transparency - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) ))) );
				float4 appendResult36 = (float4(break37.r , break37.g , break37.b , temp_output_71_2181));

				myColorVar = appendResult36;
           
#elif _IS_CLIPPING_OFF
//_Mobile
                myColorVar = appendResult2213_g1;
#endif
				UNITY_APPLY_FOG(i.fogCoord, myColorVar);
				return myColorVar;
			}