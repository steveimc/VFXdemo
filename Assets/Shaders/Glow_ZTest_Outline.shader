Shader "TiB/Glow ZTest Outline" 
{
	Properties 
	{
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
		Tags {"Queue"="Transparent" }
// First pass of the shader is the outline of the character
// This pass only renders when the character is behind objects ////////////////////////////////////////////////////////////////////
		ZWrite Off 
		ZTest Greater // Render over other objects
		Cull Off // Render outwards and inwards faces for better outline

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert 
		struct Input 
		{
			float2 uv_MainTex;
		};

		float4 _ColorTint;
		float _Outline;
		float _OutLinePower;

		void vert (inout appdata_full v) 
		{
			v.vertex.xyz += v.normal * _Outline; // Extrude vertexes to show the outline
		}

		sampler2D _MainTex;

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = _ColorTint.rgb; // The outline color
			o.Emission = _ColorTint.rgb * _OutLinePower; // Control the glow on the outline
		}

		ENDCG
// Second pass renders when behind of objects and is the color of the character ///////////////////////////////////////////////
		Pass
        {
			// This pass renders on top of the outline pass which gives the impression of having an outline
            ZWrite Off
            ZTest Greater
            Lighting Off
            Color [_CullingColor]
        }

// Third pass is the normal character shader with glow ////////////////////////////////////////////////////////////////////////
		ZTest LEqual
		ZWrite On
		Cull Back
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
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
		sampler2D _BumpMap;
		sampler2D _Illum;
		float _RimPower;
		half _BumpIntensity;

// The important part on this pass is the illumination map which is in charge of giving the information on what is going or not to glow
		void surf (Input IN, inout SurfaceOutputStandard o) 
		{

			fixed4 tex = tex2D (_MainTex, IN.uv_MainTex) * _ColorTint;
			o.Albedo = tex.rgb;

			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));

			o.Emission = _ColorTint.rgb * (tex2D(_Illum, IN.uv_Illum).a * _RimPower);
			o.Alpha = tex.a;
		
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
