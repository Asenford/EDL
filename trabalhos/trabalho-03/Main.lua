function love.load()
	logo = love.graphics.newImage("uerj.png")
end
function love.draw()
	love.graphics.print("Hello World!", 300, 200)
	love.graphics.print("Aluno: Victor Matheus Machado Torres", 300, 250)
	love.graphics.draw(logo, 310, 270, 0, 10/60,10/65 )

end
