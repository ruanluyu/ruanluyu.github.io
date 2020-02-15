{
	tabColor: "#a00", editorTheme: "dark", backgroundColor: "#ffffff", width:320,height:180,GUIClosed: true,

	

	textures: [
		{ 
			url: "MiLai.png", 
			wrap: "repeat", // repeat (default), clamp
			name: "milai",
		},
		{
			url: "noise.jpg", 
			wrap: "repeat", // repeat (default), clamp
			name: "noise_texture",
		}
	],

	fragmentShaderFile: "shader.glsl",
	animated: true,
}