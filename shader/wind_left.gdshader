shader_type canvas_item;
render_mode blend_mix;

// Настройки ветра.
uniform float speed = 1.0;
uniform float minStrength : hint_range(0.0, 1.0) = 0.05;
uniform float maxStrength : hint_range(0.0, 1.0) = 0.01;
uniform float strengthScale = 80.0;
uniform float interval = 3.5;
uniform float detail = 1.0;
uniform float distortion : hint_range(0.0, 1.0);
uniform float heightOffset : hint_range(0.0, 1.0);

// С помощью offset можно задать разное движение для каждого объекта.
uniform float offset = 0.0; 

float getWind(vec2 vertex, vec2 uv, float time) {
    float diff = pow(maxStrength - minStrength, 2.0);
    
    // Используем синусоиду для изменения силы ветра
    float windCurve = sin(time / interval * 3.14159) * sin(time / interval * 3.14159);
    float strength = clamp(minStrength + diff * windCurve, minStrength, maxStrength) * strengthScale;
    
    float wind = (sin(time) + cos(time * detail)) * strength * max(0.0, (1.0 - uv.y) - heightOffset);
    
    return wind; 
}

void vertex() {
    float time = TIME * speed + offset;
    VERTEX.x -= getWind(VERTEX.xy, UV, time); // Вертексы отклоняются в обратном направлении
}
