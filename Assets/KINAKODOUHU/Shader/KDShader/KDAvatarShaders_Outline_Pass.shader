//KDShader
//KDAvaterShaders ver.1.0
//v.1.1.1
//https://github.com/oki75/KDAvaterShaders          

Shader "Hidden/KDShader/KDAvatarShaders_Outline_Pass"
{
		SubShader
		
		{

		 Pass{
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
			      Name "Outline" 

				  Cull Front

				  

			      CGPROGRAM
			     
			     #pragma vertex vert
			     #pragma fragment frag
				 #pragma target 4.0 
                 #pragma multi_compile_fog
				 #pragma multi_compile _IS_OUTLINE_CLIPPING_YES _IS_OUTLINE_CLIPPING_NO
		         
		         #include "./cginc/KDAvatarShaders_Outline.cginc"


			     
			      ENDCG
				  }

				   
	}	
		      	
  }
