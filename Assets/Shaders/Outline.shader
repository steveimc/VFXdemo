Shader "TiB/Outline" 
{
	Properties 
	{

	  _Color ("Color", Color) = (1,1,1,1)
      _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
      _Shininess ("Shininess", Range(0.03,1)) = 0.078125
      _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
      _BumpMap ("Normal Map", 2D) = "bump" {}
      _RimColor ("Rim Color", Color) = (0.2,0.2,0.2,0.0)
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0

		_ColorOutline ("Outline Color", Color) = (1,1,1,1)
        _Outline ("Outline", Range (0, 1)) = .005

	}
	SubShader 
	{
		Tags {"Queue"="Transparent" }
		ZTest Less
		ZWrite Off

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert 

		 fixed4 _ColorTint, SpecColor;
		 half _Shininess;

		struct Input 
		{
			float2 uv_MainTex;
		};

		float4 _ColorOutline;
		float _Outline;
		float _OutLineSize;

		void vert (inout appdata_full v) 
		{
			v.vertex.xyz += v.normal * _Outline;
		}

		sampler2D _MainTex;

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = _ColorOutline.rgb;
			o.Emission = _ColorOutline.rgb * 1.0f;
		}
		ENDCG

		ZTest LEqual
		ZWrite On
		Cull Back
      CGPROGRAM
      #pragma surface surf BlinnPhong
      
      fixed4 _Color, SpecColor;
      half _Shininess;
         
      struct Input 
	  {
          float2 uv_MainTex;
          float2 uv_BumpMap;
          float3 viewDir;
      };
      sampler2D _MainTex;
      sampler2D _BumpMap;
      float4 _RimColor;
      float _RimPower;

      void surf (Input IN, inout SurfaceOutput o) 
	  {
  		  fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);  
          o.Albedo = _Color.rgb;
          o.Gloss = tex.a;
          o.Alpha = tex.a * _Color.a;
          o.Specular = _Shininess;
          o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
          o.Emission = _RimColor.rgb * pow (rim, _RimPower);
      }
      ENDCG

	} 
	FallBack "Diffuse"
}
