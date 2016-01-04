Shader "TiB Interactive/Glow Outline" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_OutLinePower("Outline Power", Range(1.0, 6.0)) = 3.0
	}
	SubShader 
	{

		Tags { "Queue" = "Geometry+1" }
		ZWrite Off

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input 
		{
			float2 uv_MainTex;
		};

		fixed4 _Color;
		fixed _OutLinePower;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
			o.Emission = _Color.rgb * _OutLinePower;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
