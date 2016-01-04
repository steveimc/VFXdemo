Shader "TiB/Glow Transparent" {
	Properties {
		_ColorTint ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Illum ("Illumin Map (A)", 2D) = "white" {}
		_RimColor("rim Color", Color) = (1,1,1,1)
		_RimPower("Rim Power", Range(1.0, 6.0)) = 3.0

	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alpha:blend

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input 
		{
			float4 color : Color;
			float2 uv_MainTex;
			float2 uv_Illum;
			float3 viewDir;
		};

		float4 _ColorTint;
		sampler2D _MainTex;
		sampler2D _Illum;
		float4 _RimColor;
		float _RimPower;


		void surf (Input IN, inout SurfaceOutputStandard o) 
		{

			fixed4 tex = tex2D (_MainTex, IN.uv_MainTex) * _ColorTint;
			o.Albedo = tex.rgb;

			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));

			o.Emission = _RimColor.rgb * (tex2D(_Illum, IN.uv_Illum).a * _RimPower);
			o.Alpha = tex.a;
	
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
