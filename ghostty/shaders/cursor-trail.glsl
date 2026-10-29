// Cursor trail: when the cursor jumps (not when you type one character),
// a short tapered glow streaks from where it was to where it landed.
// Ghostty gives iCurrentCursor / iPreviousCursor as (left, top, width, height)
// in pixels, with y measured from the bottom like fragCoord.

const float DURATION = 0.20;   // seconds the trail lasts
const float OPACITY = 0.55;

// Distance from p to the segment a-b; h returns how far along it p projects (0 at a, 1 at b)
float segmentDistance(vec2 p, vec2 a, vec2 b, out float h) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    h = clamp(dot(pa, ba) / max(dot(ba, ba), 1e-4), 0.0, 1.0);
    return length(pa - ba * h);
}

vec2 cursorCenter(vec4 cursor) {
    return cursor.xy + vec2(cursor.z, -cursor.w) * 0.5;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord / iResolution.xy);

    float t = (iTime - iTimeCursorChange) / DURATION;
    if (t >= 1.0) return;
    // New window or config reload: there is no real previous cursor yet
    if (iTimeCursorChange <= 0.0 || iPreviousCursor.w <= 0.0 || dot(iPreviousCursor.xy, iPreviousCursor.xy) < 1.0) return;

    vec2 head = cursorCenter(iCurrentCursor);
    vec2 from = cursorCenter(iPreviousCursor);
    float height = iCurrentCursor.w;
    if (distance(head, from) < height) return;   // ordinary typing: no trail

    // The tail chases the head with an ease-out, so the streak shrinks into the cursor
    float eased = 1.0 - pow(1.0 - t, 3.0);
    vec2 tail = mix(from, head, eased);

    float along;
    float d = segmentDistance(fragCoord, tail, head, along);
    float radius = mix(height * 0.08, height * 0.45, along);   // thin tail, fat head

    float core = 1.0 - smoothstep(radius * 0.6, radius, d);
    float glow = (1.0 - smoothstep(radius, radius * 3.0, d)) * 0.35;
    float alpha = (core + glow) * OPACITY * (1.0 - t) * (1.0 - t);

    fragColor.rgb = mix(fragColor.rgb, iCurrentCursorColor.rgb, clamp(alpha, 0.0, 1.0));
}
