//KDShader
//KDAvaterShaders ver.1.0
//v.1.1.00
//https://github.com/oki75/KDAvaterShaders          

Shader "Hidden/KDShader/KDAvaterShaders_SC_Pass"
{
	
	
		SubShader{
            
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
		      
	
  }
