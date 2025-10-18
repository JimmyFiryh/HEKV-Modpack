// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//	Created by Nils Daumann on 19.06.2011.
//	Copyright (c) 2011 Nils Daumann

//	LICENSE:
//	Without a written permission by Nils Ole Daumann, you are not
//	allowed to temporary or permanent rent, sell, transfer, pawn or
//	otherwise distribute this file.
//	The license for this file cannot be transferred to a third party.
//	You are allowed to manipulate the file at will (at your own risk).
//	But you are not allowed to under any circumstances and without
//	a written permission by Nils Ole Daumann rent, transfer, sell,
//	pawn or otherwise distribute the manipulated file.
//	The only exception is the distribution of this original or manipulated file
//	as part of real time applications, ensuring that the file is
//	not allowed to be used outside of these applications by a third party.

//	www.slindev.com

Shader "Hidden/SlinDev/Desktop/PostProcessing/FXAA"
{
	Properties
	{
		_MainTex ("Base (RGB)", RECT) = "white" {}
	}

	SubShader
	{
		Pass
		{
			ZTest Always
			Cull Off
			ZWrite Off
			Fog { Mode off }
	
			CGPROGRAM
				#pragma target 3.0
				#pragma glsl
				#pragma vertex vert
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest 
				#include "UnityCG.cginc"
				
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_TexelSize;
				
				struct v2f
				{
					float4 pos : POSITION;
					float4 posPos : TEXCOORD0;
				};
				
				/*============================================================================
				                  FXAA v2 CONSOLE by TIMOTHY LOTTES @ NVIDIA                                
				============================================================================*/
				v2f vert(appdata_img v)
				{
				    #define FXAA_SUBPIX_SHIFT 0.25
				    //(1.0/4.0)
				    
				    v2f o;
				    o.pos = UnityObjectToClipPos (v.vertex);
				    o.posPos.xy = v.texcoord.xy;
				    o.posPos.zw = o.posPos.xy - (_MainTex_TexelSize.xy * (0.5 + FXAA_SUBPIX_SHIFT));
				    return o;
				}
				        
				float4 frag(v2f i) : COLOR0
				{
				    #define FXAA_REDUCE_MIN   (1.0/128.0)
				    #define FXAA_REDUCE_MUL   (1.0/8.0)
				    #define FXAA_SPAN_MAX     8.0
				    
				    float3 rgbNW = tex2Dlod(_MainTex, float4(i.posPos.zw, 0.0, 0.0)).xyz;
				    float3 rgbNE = tex2Dlod(_MainTex, float4(i.posPos.zw+float2(_MainTex_TexelSize.x, 0.0), 0.0, 0.0)).xyz;
				    float3 rgbSW = tex2Dlod(_MainTex, float4(i.posPos.zw+float2(0.0, _MainTex_TexelSize.y), 0.0, 0.0)).xyz;
				    float3 rgbSE = tex2Dlod(_MainTex, float4(i.posPos.zw+_MainTex_TexelSize.xy, 0.0, 0.0)).xyz;
				    float3 rgbM  = tex2Dlod(_MainTex, float4(i.posPos.xy, 0.0, 0.0)).xyz;
				    
				    float3 luma = float3(0.299, 0.587, 0.114);
				    float lumaNW = dot(rgbNW, luma);
				    float lumaNE = dot(rgbNE, luma);
				    float lumaSW = dot(rgbSW, luma);
				    float lumaSE = dot(rgbSE, luma);
				    float lumaM  = dot(rgbM,  luma);
				    
				    float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
				    float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));
				    
				    float2 dir; 
				    dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
				    dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));
				    
				    float dirReduce = max(
				        (lumaNW + lumaNE + lumaSW + lumaSE) * (0.25 * FXAA_REDUCE_MUL),
				        FXAA_REDUCE_MIN);
				    float rcpDirMin = 1.0/(min(abs(dir.x), abs(dir.y)) + dirReduce);
				    dir = min(float2( FXAA_SPAN_MAX,  FXAA_SPAN_MAX), 
				          max(float2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX), 
				          dir * rcpDirMin)) * _MainTex_TexelSize.xy;
				          
				    float3 rgbA = (1.0/2.0) * (
				        tex2Dlod(_MainTex, float4(i.posPos.xy + dir * (1.0/3.0 - 0.5), 0.0, 0.0)).xyz +
				        tex2Dlod(_MainTex, float4(i.posPos.xy + dir * (2.0/3.0 - 0.5), 0.0, 0.0)).xyz);
				    float3 rgbB = rgbA * (1.0/2.0) + (1.0/4.0) * (
				        tex2Dlod(_MainTex, float4(i.posPos.xy + dir * (0.0/3.0 - 0.5), 0.0, 0.0)).xyz +
				        tex2Dlod(_MainTex, float4(i.posPos.xy + dir * (3.0/3.0 - 0.5), 0.0, 0.0)).xyz);
				    float lumaB = dot(rgbB, luma);
				    
				    if((lumaB < lumaMin) || (lumaB > lumaMax))
				    	return float4(rgbA, 1.0);
				    
				    return float4(rgbB, 1.0);
				}
			ENDCG
		}
	}
	
	Fallback off
}