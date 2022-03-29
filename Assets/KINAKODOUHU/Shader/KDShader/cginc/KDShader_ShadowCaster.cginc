//KDShader_ShadowCaster.cginc
//KDShader ver.1.0
//v.1.0.8
//https://github.com/oki75/KDShader           
//(C)KINAKODOUHU


 struct appdata 
	    {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;		
		};	
 struct v2f {
              V2F_SHADOW_CASTER;
            };

            v2f vert (appdata v) {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target {
                SHADOW_CASTER_FRAGMENT(i)
            }
			