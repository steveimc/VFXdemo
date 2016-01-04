Shader "TiB/Diffuse Outline" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_ColorOutline ("Color Outline", Color) = (1,1,1,1)
		_OutLinePower("Outline Power", Range(1.0, 6.0)) = 3.0
        _Outline ("Outline width", Range (0, 1)) = .005
	}
	SubShader 
	{

	 Tags {"Queue"="Overlay" }

		ZWrite Off
		ZTest LEqual
		Cull Off

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert 
		struct Input 
		{
			float2 uv_MainTex;
		};

		float4 _ColorOutline;
		float _Outline;
		float _OutLinePower;

		void vert (inout appdata_full v) 
		{
			v.vertex.xyz += v.normal * _Outline;
		}

		sampler2D _MainTex;

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = _ColorOutline.rgb;
			o.Emission = _ColorOutline.rgb * _OutLinePower;
		}
		ENDCG

		ZTest LEqual
		ZWrite On
		Cull Back
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Emission = _Glossiness;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;

		}
		ENDCG
	} 
	FallBack "Diffuse"
}
