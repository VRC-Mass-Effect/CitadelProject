// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KorroShaders/MassEffect_Prop"
{
	Properties
	{
		_Diff("Diff", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		[Normal]_Norm("Norm", 2D) = "bump" {}
		_Mask("Mask", 2D) = "white" {}
		_Gloss("Gloss", Range( 0 , 1)) = 1
		_SpecularColor("Specular Color", Color) = (1,1,1,1)
		_Emmissive("Emmissive", 2D) = "white" {}
		[Toggle]_EmissiveType("Emissive Type", Float) = 0
		[HDR]_EmmissiveColor("Emmissive Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Norm;
		uniform float4 _Norm_ST;
		uniform sampler2D _Diff;
		uniform float4 _Diff_ST;
		uniform float4 _Color;
		uniform float _EmissiveType;
		uniform sampler2D _Emmissive;
		uniform float4 _Emmissive_ST;
		uniform float4 _EmmissiveColor;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float4 _SpecularColor;
		uniform float _Gloss;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_Norm = i.uv_texcoord * _Norm_ST.xy + _Norm_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Norm, uv_Norm ) );
			float2 uv_Diff = i.uv_texcoord * _Diff_ST.xy + _Diff_ST.zw;
			o.Albedo = ( tex2D( _Diff, uv_Diff ) * _Color ).rgb;
			float2 uv_Emmissive = i.uv_texcoord * _Emmissive_ST.xy + _Emmissive_ST.zw;
			float4 tex2DNode11 = tex2D( _Emmissive, uv_Emmissive );
			o.Emission = ( lerp(tex2DNode11.r,tex2DNode11.g,_EmissiveType) * _EmmissiveColor ).rgb;
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode2 = tex2D( _Mask, uv_Mask );
			o.Specular = ( tex2DNode2.r * _SpecularColor ).rgb;
			o.Smoothness = ( (0.0 + (tex2DNode2.b - 0.5) * (0.85 - 0.0) / (1.0 - 0.5)) * _Gloss );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14001
1927;-84;1266;988;1092.574;324.947;1.029477;True;True
Node;AmplifyShaderEditor.SamplerNode;11;-890.8021,597.7997;Float;True;Property;_Emmissive;Emmissive;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-931.7617,109.3853;Float;True;Property;_Mask;Mask;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;-842.9512,-247.7516;Float;False;Property;_Color;Color;1;0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;15;-554.7214,631.28;Float;False;Property;_EmissiveType;Emissive Type;7;0;0;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;8;-537.3713,312.1544;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.5;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;0.85;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-923.9524,-468.8862;Float;True;Property;_Diff;Diff;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-845.1093,297.3354;Float;False;Property;_SpecularColor;Specular Color;5;0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;13;-792.6582,789.838;Float;False;Property;_EmmissiveColor;Emmissive Color;8;1;[HDR];0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-907.1093,467.3354;Float;False;Property;_Gloss;Gloss;4;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-281.0726,206.3766;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-280.1093,111.3354;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-279.5008,-2.760803;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-309.6582,629.838;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-927.7818,-80.86792;Float;True;Property;_Norm;Norm;2;1;[Normal];None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;KorroShaders/MassEffect_Prop;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;11;1
WireConnection;15;1;11;2
WireConnection;8;0;2;3
WireConnection;7;0;8;0
WireConnection;7;1;5;0
WireConnection;4;0;2;1
WireConnection;4;1;6;0
WireConnection;9;0;1;0
WireConnection;9;1;10;0
WireConnection;12;0;15;0
WireConnection;12;1;13;0
WireConnection;0;0;9;0
WireConnection;0;1;3;0
WireConnection;0;2;12;0
WireConnection;0;3;4;0
WireConnection;0;4;7;0
ASEEND*/
//CHKSM=0C3A53768C66140D7EA8B14F8AEA88D2A3BE0927