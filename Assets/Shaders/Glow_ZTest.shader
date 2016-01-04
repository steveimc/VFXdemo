Shader "TiB/Glow ZTest" {
	Properties {
		_CullingColor ("Cull Color", Color) = (1,1,1,1)
		_ColorTint ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Illum ("Illumin Map (A)", 2D) = "white" {}
		_RimPower("Rim Power", Range(1.0, 6.0)) = 3.0
		_OutLinePower("Outline Power", Range(1.0, 6.0)) = 3.0
        _Outline ("Outline width", Range (0, 1)) = .005

	}
	SubShader 
	{
		Pass
        {
            ZWrite Off
            ZTest Greater
            Lighting Off
            Color [_CullingColor]
        }

		ZTest LEqual
		ZWrite On
		Cull Back
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

		float4 _ColorTint;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Illum;
		float _RimPower;
		half _BumpIntensity;


		void surf (Input IN, inout SurfaceOutputStandard o) 
		{

			fixed4 tex = tex2D (_MainTex, IN.uv_MainTex) * _ColorTint;
			o.Albedo = tex.rgb;

			o.Emission = _ColorTint.rgb * (tex2D(_Illum, IN.uv_Illum).a * _RimPower);
			o.Alpha = tex.a;
		
		}
		ENDCG

	} 
	FallBack "Diffuse"
}
