// Remap all colors to grayscale
void main() {
    // Get the color of the texture
    vec4 color = texture2D(u_texture, v_tex_coord);
    
    // Conver to to grayscale using NTSC conversion weights
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    
    gl_FragColor = vec4(gray, gray, gray, color.a);
}
