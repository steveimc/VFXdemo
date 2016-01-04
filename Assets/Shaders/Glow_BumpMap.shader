Shader "TiB/Glow Bump" {
	Properties {
		_ColorTint ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_BumpIntensity ("Bump Intensity", Range(-2,2)) = 0.0
		_Illum ("Illumin Map (A)", 2D) = "white" {}
		_RimColor("rim Color", Color) = (1,1,1,1)
		_RimPower("Rim Power", Range(1.0, 6.0)) = 3.0

	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input 
		{
			float4 color : Color;
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_Illum;
			float3 viewDir;
		};

		half _Glossiness;
		half _Metallic;
		float4 _ColorTint;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Illum;
		float4 _RimColor;
		float _RimPower;
		half _BumpIntensity;


		void surf (Input IN, inout SurfaceOutputStandard o) 
		{

			fixed4 tex = tex2D (_MainTex, IN.uv_MainTex) * _ColorTint;
			o.Albedo = tex.rgb;

			o.Normal = UnpackNormal (tex2D(_BumpMap, IN.uv_BumpMap));
			o.Normal = float3(o.Normal.x * _BumpIntensity,o.Normal.y * _BumpIntensity,o.Normal.z);

			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));

			o.Emission = _RimColor.rgb * (tex2D(_Illum, IN.uv_Illum).a * _RimPower);
			o.Alpha = tex.a;

			
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
