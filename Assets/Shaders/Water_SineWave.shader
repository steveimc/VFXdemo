 
Shader "TiB/Water" 
{
	Properties 
	{
	   _Color ("Color", Color) = (1,1,1,1)
	   _MainTex ("Albedo (RGB)", 2D) = "white" {}
	   _Glossiness ("Smoothness", Range(0,1)) = 0.5
	   _Metallic ("Metallic", Range(0,1)) = 0.0
	   _RimColor ("Rim Color", Color) = (0.2,0.2,0.2,0.0)
       _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
	   _WaveAmplitude ("Wave Amplitude", Range(0,100)) = 0.0
	   _WaveOffset ("Wave Offset", Range(0,10)) = 0.0
	   _WaveSpeed ("Wave Speed", Range(0,100)) = 0.0
	}

 SubShader 
 {
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert

		#pragma target 3.0

		sampler2D _MainTex;
		half _Glossiness;
		half _Metallic;
		half _WaveAmplitude;
		half _WaveOffset;
		half _RimPower;
		half _WaveSpeed;
		fixed4 _Color;
		fixed4 _RimColor;

		struct Input 
		{
			float2 uv_MainTex;
			float3 viewDir;
			 INTERNAL_DATA
		};

		void vert (inout appdata_full v) 
		{
			float phase = _Time * _WaveSpeed;
			float offset = (v.vertex.x + (v.vertex.z * 0.2)) * _WaveOffset;
			v.vertex.y = sin(phase + offset) * _WaveAmplitude;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Emission = _Glossiness;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow (rim, _RimPower);

		}
		ENDCG
	} 
	FallBack "Diffuse"
}
 