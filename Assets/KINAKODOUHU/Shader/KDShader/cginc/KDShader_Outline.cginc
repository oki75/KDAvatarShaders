//KDShader_ShadowCaster.cginc
//KDShader ver.1.0
//v.1.0.9
//https://github.com/oki75/KDShader           
//(C)KINAKODOUHU

// #pragma multi_compile _IS_OUTLINE_CLIPPING_NO _IS_OUTLINE_CLIPPING_YES 
 struct appdata
			      {
				    float4 vertex : POSITION;
				    float3 normal : NORMAL;
			 	    float4 texcoord : TEXCOORD0;
				    UNITY_VERTEX_INPUT_INSTANCE_ID
				    float4 ase_texcoord1 : TEXCOORD1;
				    float4 ase_tangent : TANGENT;
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
				    UNITY_SHADOW_COORDS(5)
			      };

				 
				
			      
			   
			      uniform float     _Outline_Width;
			      uniform sampler2D _RGB_mask;
			      uniform float4    _RGB_mask_ST;
			      uniform fixed     _BlendShadowColor;
			      uniform fixed     _OutlineTexToggle;
			      uniform fixed     _Use_BaseAsFix;
			      uniform sampler2D _MainTex;
			      uniform float4    _MainTex_ST;
			      uniform sampler2D _DecalMap;
			      uniform fixed     _Decal_UVSet2_Toggle;
			      uniform float4    _DecalMap_ST;
			      uniform fixed     _Decal_Toggle;
			      uniform float4    _FixShadeColor;
			      uniform sampler2D _FixShadeColorMap;
			      uniform float4    _FixShadeColorMap_ST;
			      uniform fixed       _Use_BaseAs2nd;
			      uniform sampler2D _2nd_ShadeMap;
			      uniform float4    _2nd_ShadeMap_ST;
			      uniform float4    _2nd_ShadeColor;
			      uniform fixed       _Use_BaseAs1st;
			      uniform sampler2D _1st_ShadeMap;
			      uniform float4    _1st_ShadeMap_ST;
			      uniform float4    _1st_ShadeColor;
			      uniform float4    _BaseColor;
			      uniform fixed     _Is_BLD;
			      uniform float     _Offset_X_Axis_BLD;
			      uniform float     _Offset_Y_Axis_BLD;
				  uniform float     _Offset_Z_Axis_BLD;
			      uniform fixed     _ShadeNormal;
			      uniform sampler2D _NormalMap;
			      uniform fixed     _NormalMap_UVSet2_Toggle;
			      uniform float4    _NormalMap_ST;
			      uniform sampler2D _ParallaxMap;
			      uniform float4    _ParallaxMap_ST;
			      uniform float     _ParallaxScale;
			      uniform fixed     _ParallaxToggle;
			      uniform float     _BumpScale;
			      uniform sampler2D _NormalMap2;
			      uniform fixed     _NormalMap2_UVSet2_Toggle;
			      uniform float4    _NormalMap2_ST;
			      uniform float     _BumpScale2;
			      uniform sampler2D _FixShadeMap;
			      uniform fixed     _Fix_ShadeMap_UVSet2_Toggle;
			      uniform float4    _FixShadeMap_ST;
			      uniform fixed     _FixShadeParallax;
			      uniform float     _BaseColor_Step;
			      uniform float     _BaseShade_Feather;
			      uniform float     _ShadeColor_Step;
			      uniform float     _1st2nd_Shades_Feather;
			      uniform float     _Tweak_FixShadeMapLevel;
			      uniform float4    _Outline_Color;
			      uniform sampler2D _OutlineTex;
			      uniform float     _Unlit_Intensity;
			      uniform float     _AmbientMinimum;
//
#ifdef _IS_OUTLINE_CLIPPING_YES
//_Mobile_Clipping
            uniform sampler2D _ClippingMask; uniform float4 _ClippingMask_ST;
			uniform fixed _Clipping_Level;
			uniform fixed _Inverse_Clipping;
			uniform fixed _Use_Decal_alpha;
			uniform float _Tweak_transparency;

#elif _IS_OUTLINE_CLIPPING_NO
            uniform fixed _Clipping_Level;
//_Mobile
#endif
			      float3 Function_ShadeSH9(  )
			      {
			      	return ShadeSH9(half4(0,0,0,1));
			      }
			      
			      float3 Function_ShadeSH9_2(  )
			      {
			      	return ShadeSH9(half4(0,-1,0,1));
			      }
			      


			      v2f vert ( appdata v  )
			      {
				    v2f o;
				    UNITY_SETUP_INSTANCE_ID ( v );
					UNITY_INITIALIZE_OUTPUT(v2f, o);
				    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO ( o );
				    o.texcoord.xy = v.texcoord.xy;
				    o.texcoord.zw = 0;
				    float3 MyLocalVar;
				    float4 unityObjectToClipPos2115_g1 = UnityObjectToClipPos( v.vertex.xyz );
				    float2 uv_RGB_mask = v.texcoord.xy * _RGB_mask_ST.xy + _RGB_mask_ST.zw;
				    float4 tex2DNode53_g1 = tex2Dlod( _RGB_mask, float4( uv_RGB_mask, 0, 0.0) );
				    float Bmask72_g1 = tex2DNode53_g1.b;
				    float OutLineSampler1981_g1 = Bmask72_g1;
				    
				    float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				    o.ase_texcoord1.xyz = ase_worldPos;
				    float3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
				    o.ase_texcoord2.xyz = ase_worldTangent;
				    float3 ase_worldNormal = UnityObjectToWorldNormal(v.normal);
				    o.ase_texcoord3.xyz = ase_worldNormal;
				    float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				    float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				    o.ase_texcoord4.xyz = ase_worldBitangent;
				    
				    o.texcoord.zw = v.ase_texcoord1.xy;
				    
				    //setting value to unused interpolator channels and avoid initialization warnings
				    o.ase_texcoord1.w = 0;
				    o.ase_texcoord2.w = 0;
				    o.ase_texcoord3.w = 0;
				    o.ase_texcoord4.w = 0;
				    v.vertex.xyz += ( v.normal * ( 0.005 * _Outline_Width ) * min( unityObjectToClipPos2115_g1.w , 0.15 ) * OutLineSampler1981_g1 );
				    o.vertex = UnityObjectToClipPos ( v.vertex );
				    return o;
			      }

			      fixed4 frag ( v2f i  ) : SV_Target
			      {
			    	fixed4 myColorVar;
				    float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				    float4 tex2DNode3_g1 = tex2D( _MainTex, uv_MainTex );
				    float2 uv_DecalMap = i.texcoord.xy * _DecalMap_ST.xy + _DecalMap_ST.zw;
				    float2 uv2_DecalMap = i.texcoord.zw * _DecalMap_ST.xy + _DecalMap_ST.zw;
				    float4 tex2DNode1994_g1 = tex2D( _DecalMap, (( _Decal_UVSet2_Toggle )?( uv2_DecalMap ):( uv_DecalMap )) );
				    float4 Decal2000_g1 = tex2DNode1994_g1;
				    float Decal_mask2253_g1 = tex2DNode1994_g1.a;
				    float4 lerpResult2259_g1 = lerp( tex2DNode3_g1 , Decal2000_g1 , Decal_mask2253_g1);
				    float4 lerpResult2279_g1 = lerp( tex2DNode3_g1 , lerpResult2259_g1 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				    float2 uv_FixShadeColorMap = i.texcoord.xy * _FixShadeColorMap_ST.xy + _FixShadeColorMap_ST.zw;
				    float4 Fix_Shade70_g1 = saturate( ( (( _Use_BaseAsFix )?( lerpResult2279_g1 ):( float4( 1,1,1,0 ) )) * _FixShadeColor * tex2D( _FixShadeColorMap, uv_FixShadeColorMap ) ) );
				    float2 uv_2nd_ShadeMap = i.texcoord.xy * _2nd_ShadeMap_ST.xy + _2nd_ShadeMap_ST.zw;
				    float4 tex2DNode1291_g1 = tex2D( _2nd_ShadeMap, uv_2nd_ShadeMap );
				    float4 lerpResult2289_g1 = lerp( tex2DNode1291_g1 , Decal2000_g1 , Decal_mask2253_g1);
				    float4 lerpResult2299_g1 = lerp( tex2DNode1291_g1 , lerpResult2289_g1 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				    float4 shadow21296_g1 = saturate( ( (( _Use_BaseAs2nd )?( lerpResult2279_g1 ):( lerpResult2299_g1 )) * _2nd_ShadeColor ) );
				    float2 uv_1st_ShadeMap = i.texcoord.xy * _1st_ShadeMap_ST.xy + _1st_ShadeMap_ST.zw;
				    float4 tex2DNode1473_g1 = tex2D( _1st_ShadeMap, uv_1st_ShadeMap );
				    float4 lerpResult2283_g1 = lerp( tex2DNode1473_g1 , Decal2000_g1 , Decal_mask2253_g1);
				    float4 lerpResult2298_g1 = lerp( tex2DNode1473_g1 , lerpResult2283_g1 , (( _Decal_Toggle )?( 1.0 ):( 0.0 )));
				    float4 shadow147_g1 = saturate( ( (( _Use_BaseAs1st )?( lerpResult2279_g1 ):( lerpResult2298_g1 )) * _1st_ShadeColor ) );
				    float4 Base1120_g1 = saturate( ( lerpResult2279_g1 * _BaseColor ) );
				    float3 ase_worldPos = i.ase_texcoord1.xyz;
				    float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				    float3 LightDirection2191_g1 = worldSpaceLightDir;
				    float3 appendResult2137_g1 = (float3(_Offset_X_Axis_BLD , _Offset_Y_Axis_BLD , _Offset_Z_Axis_BLD));
				    float2 uv_NormalMap = i.texcoord.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
				    float2 uv2_NormalMap = i.texcoord.zw * _NormalMap_ST.xy + _NormalMap_ST.zw;
				    float2 texCoord2385_g1 = i.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				    float2 uv_ParallaxMap = i.texcoord.xy * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
				    float4 tex2DNode2323_g1 = tex2D( _ParallaxMap, uv_ParallaxMap );
				    float ParallaxHightMap2324_g1 = tex2DNode2323_g1.r;
				    float3 ase_worldTangent = i.ase_texcoord2.xyz;
				    float3 ase_worldNormal = i.ase_texcoord3.xyz;
				    float3 ase_worldBitangent = i.ase_texcoord4.xyz;
				    float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				    float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				    float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				    float3 ase_worldViewDir = UnityWorldSpaceViewDir(ase_worldPos);
				    ase_worldViewDir = normalize(ase_worldViewDir);
				    float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				    ase_tanViewDir = normalize(ase_tanViewDir);
				    float2 Offset2402_g1 = ( ( ParallaxHightMap2324_g1 - 1 ) * ase_tanViewDir.xy * _ParallaxScale ) + texCoord2385_g1;
				    float2 Offset2364_g1 = ( ( tex2D( _ParallaxMap, Offset2402_g1 ).r - 1 ) * ase_tanViewDir.xy * _ParallaxScale ) + Offset2402_g1;
				    float2 Offset2335_g1 = ( ( tex2D( _ParallaxMap, Offset2364_g1 ).r - 1 ) * ase_tanViewDir.xy * _ParallaxScale ) + Offset2364_g1;
				    float2 Offset2358_g1 = ( ( tex2D( _ParallaxMap, Offset2335_g1 ).r - 1 ) * ase_tanViewDir.xy * _ParallaxScale ) + Offset2335_g1;
				    float2 Parallaxoffset2394_g1 = Offset2358_g1;
				    float3 ParallaxNormal2341_g1 = UnpackNormal( tex2D( _NormalMap, Parallaxoffset2394_g1 ) );
				    float ParallaxMask2326_g1 = (( _ParallaxToggle )?( tex2DNode2323_g1.g ):( 0.0 ));
				    float4 lerpResult2424_g1 = lerp( tex2D( _NormalMap, (( _NormalMap_UVSet2_Toggle )?( uv2_NormalMap ):( uv_NormalMap )) ) , float4( ParallaxNormal2341_g1 , 0.0 ) , ParallaxMask2326_g1);
				    float2 uv_NormalMap2 = i.texcoord.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
				    float2 uv2_NormalMap2 = i.texcoord.zw * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
				    float3 normalizeResult1858_g1 = normalize( BlendNormals( UnpackScaleNormal( lerpResult2424_g1, _BumpScale ) , UnpackScaleNormal( tex2D( _NormalMap2, (( _NormalMap2_UVSet2_Toggle )?( uv2_NormalMap2 ):( uv_NormalMap2 )) ), _BumpScale2 ) ) );
				    float3 Normalmap137_g1 = normalizeResult1858_g1;
				    float3 tanNormal2132_g1 = (( _ShadeNormal )?( Normalmap137_g1 ):( float3( 0,0,1 ) ));
				    float3 worldNormal2132_g1 = normalize( float3(dot(tanToWorld0,tanNormal2132_g1), dot(tanToWorld1,tanNormal2132_g1), dot(tanToWorld2,tanNormal2132_g1)) );
				    float dotResult2135_g1 = dot( (( _Is_BLD )?( ( appendResult2137_g1 + float3(0,1,-1) ) ):( LightDirection2191_g1 )) , worldNormal2132_g1 );
				    float HalfLambert64_g1 = ( dotResult2135_g1 * 0.5 );
				    float2 uv_FixShadeMap = i.texcoord.xy * _FixShadeMap_ST.xy + _FixShadeMap_ST.zw;
				    float2 uv2_FixShadeMap = i.texcoord.zw * _FixShadeMap_ST.xy + _FixShadeMap_ST.zw;

				    float Parallax_FixShade2393_g1 = tex2D( _FixShadeMap, Parallaxoffset2394_g1 ).b;
				    float lerpResult2420_g1 = lerp( tex2D( _FixShadeMap, (( _Fix_ShadeMap_UVSet2_Toggle )?( uv2_FixShadeMap ):( uv_FixShadeMap )) ).b , Parallax_FixShade2393_g1 , (( _FixShadeParallax )?( ParallaxMask2326_g1 ):( 0.0 )));
				    float set_FixshadeMask2230_g1 = lerpResult2420_g1;

				    float temp_output_2232_0_g1 = ( ( 0.5 + HalfLambert64_g1 ) * pow( set_FixshadeMask2230_g1 , 0.5 ) );
				    float clampResult1357_g1 = clamp( (0.0 + (temp_output_2232_0_g1 - _BaseColor_Step) * (1.0 - 0.0) / (( _BaseColor_Step + _BaseShade_Feather ) - _BaseColor_Step)) , 0.0 , 1.0 );
				    float RampShader79_g1 = clampResult1357_g1;
				    float4 lerpResult1448_g1 = lerp( shadow147_g1 , Base1120_g1 , RampShader79_g1);
				    float clampResult1301_g1 = clamp( (0.0 + (temp_output_2232_0_g1 - _ShadeColor_Step) * (1.0 - 0.0) / (( _ShadeColor_Step + _1st2nd_Shades_Feather ) - _ShadeColor_Step)) , 0.0 , 1.0 );
				    float RampShader11306_g1 = clampResult1301_g1;
				    float4 lerpResult1447_g1 = lerp( shadow21296_g1 , lerpResult1448_g1 , RampShader11306_g1);
				    float lerpResult2321_g1 = lerp( 1.0 , set_FixshadeMask2230_g1 , _Tweak_FixShadeMapLevel);
				    float4 lerpResult2243_g1 = lerp( Fix_Shade70_g1 , lerpResult1447_g1 , lerpResult2321_g1);
				    float4 shade2246_g1 = lerpResult2243_g1;
				    float2 uv_OutlineTex1284_g1 = i.texcoord.xy;
				    float4 OutlineTex1984_g1 = saturate( (( _OutlineTexToggle )?( ( shade2246_g1 * tex2D( _OutlineTex, uv_OutlineTex1284_g1 ) ) ):( ( shade2246_g1 * _Outline_Color ) )) );
				    UNITY_LIGHT_ATTENUATION(ase_atten, i, ase_worldPos)
				    float3 localFunction_ShadeSH92155_g1 = Function_ShadeSH9();
				    float3 localFunction_ShadeSH9_22156_g1 = Function_ShadeSH9_2();
				    float3 defaultLightColor2160_g1 = saturate( max( ( half3(0.05,0.05,0.05) * _Unlit_Intensity ) , ( max( localFunction_ShadeSH92155_g1 , localFunction_ShadeSH9_22156_g1 ) * _Unlit_Intensity ) ) );
				    #if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				    float4 ase_lightColor = 0;
				    #else //aselc
				    float4 ase_lightColor = _LightColor0;
				    #endif //aselc
				    float3 lerpResult2151_g1 = lerp( max( defaultLightColor2160_g1 , ase_lightColor.rgb ) , max( defaultLightColor2160_g1 , saturate( ase_lightColor.rgb ) ) , 1.0);
				    float3 ifLocalVar2141_g1 = 0;
				    if( _WorldSpaceLightPos0.w <= 0.0 )
				    ifLocalVar2141_g1 = lerpResult2151_g1;
				    else
				    ifLocalVar2141_g1 = ( ase_atten * lerpResult2151_g1 );
				    float3 temp_cast_3 = (_AmbientMinimum).xxx;
				    float3 clampResult2162_g1 = clamp( ifLocalVar2141_g1 , temp_cast_3 , float3( 1,1,1 ) );
				    float3 Lighting331_g1 = clampResult2162_g1;
			//
					float4 break2215_g1 = (( _BlendShadowColor )?( ( OutlineTex1984_g1 * float4( Lighting331_g1 , 0.0 ) ) ):( OutlineTex1984_g1 ));
				    float4 appendResult2216_g1 = (float4(break2215_g1.r , break2215_g1.g , break2215_g1.b , 1.0));
//
#ifdef _IS_OUTLINE_CLIPPING_YES
//_Mobile_Clipping				   			    
				    float4 break39 = appendResult2216_g1;
				    float2 uv_ClippingMask = i.texcoord.xy * _ClippingMask_ST.xy + _ClippingMask_ST.zw;
				    float Clipping_Mask1980_g1 = tex2D( _ClippingMask, uv_ClippingMask ).r;
				    float temp_output_71_2181 = saturate( (0.0 + ((( _Inverse_Clipping )?( ( 1.0 - (( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal2000_g1.a ) ):( Clipping_Mask1980_g1 )) ) ):( (( _Use_Decal_alpha )?( ( Clipping_Mask1980_g1 + Decal2000_g1.a ) ):( Clipping_Mask1980_g1 )) )) - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) )) * (1.0 - 0.0) / (_Tweak_transparency - ( _Tweak_transparency - ( 1.0 - _Clipping_Level ) ))) );
				    float4 appendResult38 = (float4(break39.r , break39.g , break39.b , temp_output_71_2181));
				    
				    myColorVar = appendResult38;
					

#elif _IS_OUTLINE_CLIPPING_NO
//_Mobile
				  
				   myColorVar = appendResult2216_g1;
					
#endif
                    clip(myColorVar.a - _Clipping_Level);
				    return myColorVar;
			      }
		          