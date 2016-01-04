Shader "TiB Interactive/Diffuse" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
	}
	SubShader 
	{
		Tags {"Queue"="Overlay"}

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		struct Input 
		{
			float2 uv_MainTex;
		};

		half _Glossiness;
		fixed4 _Color;
		sampler2D _MainTex;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 tex = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = tex.rgb;
			// Metallic and smoothness come from slider variables
			o.Smoothness = _Glossiness;
			o.Alpha = tex.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
