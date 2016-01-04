Shader "TiB/Crystal Transparent" 
{
	Properties 
	{	
		_Color ("Color", Color) = (1,1,1,1)	
		_Glossiness ("Smoothness", Range(0,1)) = 0.0
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	
	SubShader 
	{
	
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 600
          
		CGPROGRAM

		#pragma exclude_renderers gles

		#pragma surface surf Standard fullforwardshadows alpha:blend

		#pragma target 3.0
		
		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{

			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
