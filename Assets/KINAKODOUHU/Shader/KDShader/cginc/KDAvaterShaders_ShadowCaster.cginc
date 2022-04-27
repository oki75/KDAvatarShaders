//KDAvaterShaders_ShadowCaster.cginc
//KDShader
//KDAvaterShaders ver.1.0
//v.1.1.1
//https://github.com/oki75/KDShader           



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
			