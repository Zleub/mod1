function love.load()

	-- local pix_function = [[
	-- 	extern vec3 test;
	-- 	extern number time;

	-- 	vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
	-- 	{
	-- 		if (screen_coords.x >= test.x - 10 && screen_coords.x <= test.x + 10
	-- 			&&
	-- 			screen_coords.y >= test.y - 10 && screen_coords.y <= test.y + 10)
	-- 		{
	-- 			vec4 texcolor = Texel(texture, texture_coords);
	-- 			return (texcolor);
	-- 		}
	-- 		return (tan(abs(cos(time))) * color);
	-- 	}
	-- ]]

	local pix_function = [[
		extern vec3 test;

		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
		{
			if (screen_coords.x >= test.x - test.z && screen_coords.x <= test.x + test.z
					&&
				screen_coords.y >= test.y - test.z && screen_coords.y <= test.y + test.z)
			{
				if ((screen_coords.x - test.x) * (screen_coords.x - test.x) + (screen_coords.y - test.y) * (screen_coords.y - test.y) * 4 <= test.z * test.z + test.z)
				{
					return (color);
				}
			}
			vec4 texcolor = vec4(0.0, 0.0, 1.0, 1.0);
			return (texcolor);
		}
	]]

	shader = love.graphics.newShader(pix_function)
end

t = 0
function love.update(dt)
	t = t + dt
	-- shader:send("time", t)
	shader:send("test", {love.window.getWidth() / 2, love.window.getHeight() / 2, 100 - t * 10} )
end

function love.draw()
	local vertices = {
		0, love.window.getHeight()/ 2,
		love.window.getWidth() / 2, 0,
		love.window.getWidth(), love.window.getHeight() / 2,
		love.window.getWidth() / 2, love.window.getHeight(),
	}

	love.graphics.setColor(0, 127, 0, 255)
	love.graphics.setShader(shader)
	love.graphics.polygon("fill", vertices)
	love.graphics.setShader()
	love.graphics.setColor(255, 255, 255, 255)
end
