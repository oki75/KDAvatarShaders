//KDShader
//KDAvaterShaders ver.1.0
//v.1.1.00
//https://github.com/oki75/KDAvaterShaders          

Shader "Hidden/KDShader/KDAvaterShaders_Core_Pass"
{
	
	
		SubShader{
         
	      //FORWARD      
		       Pass {
			      
				  Name "FORWARD"

			      Cull[_CullMode]

	
				 
			      Tags { "LightMode"="ForwardBase" }
				  
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
		 
				
	}	
		      
	 
	
  }
