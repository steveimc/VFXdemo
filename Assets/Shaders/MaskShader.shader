Shader "TiB/UI Mask" 
{
     Properties 
	 {
         _Color ("Main Color", Color) = (1,1,1,1)
         _MainTex ("Base (RGBA)", 2D) = "white" {}
         _MaskTex ("Mask (RGBA)", 2D) = "white" {}
     }

     SubShader 
	 {
         Tags { "Queue" = "Transparent" }

         Pass 
		 {
             Blend SrcAlpha OneMinusSrcAlpha

             SetTexture [_MainTex] 
			 {
                 constantColor [_Color]
                 combine Constant * Texture
             }

             SetTexture [_MaskTex] 
			 {
                 combine Previous, Previous * Texture
             }
         }
     }

     Fallback "Sprites/Default"

 }