Shader "TiB Interactive/Glow" 
{
	Properties 
	{

		_Color ("Color Tint", Color) = (1,1,1,1)
		_RimPower("Rim Power", Range(1.0, 6.0)) = 3.0

	}

	SubShader 
	{
		Tags {"Queue"="Overlay"}

		Cull Back
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input 
		{
			float4 color : Color;
			float3 viewDir;
		};

		float4 _Color;
		float _RimPower;



		void surf (Input IN, inout SurfaceOutputStandard o) 
		{

			o.Albedo = _Color.rgb;

			o.Emission = _Color.rgb * _RimPower;

			o.Alpha = _Color.a;
		
		}
		ENDCG

	} 
	FallBack "Diffuse"
}
