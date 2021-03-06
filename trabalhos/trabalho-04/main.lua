function love.load()
	larguraTela = 1280
	alturaTela = 720

	playerX = 62
	playerL = 70
	playerA = 60

	canoAltura = 200
	canoLargura = 108

	function defineCanoY()
		local canoYMinimo = 108
		local canoY = love.math.random(
			canoYMinimo,
			alturaTela - canoAltura - canoYMinimo
		)
		return canoY
	end

	function reset()
		playerY = 200
		playergravity = 0

		cano1X = larguraTela
		cano1tamanhoY = defineCanoY()

		cano2X = larguraTela + ((larguraTela + canoLargura) / 2)
		cano2TamanhoY = defineCanoY()

		placar = 0

		proximoCano = 1
	end

	reset()
end

function love.update(dt)
	playergravity = playergravity + (916 * dt)
	playerY = playerY + (playergravity * dt)

	local function canoMov(canoX, canoTamanhoY)
		canoX = canoX - (240 * dt)

		if (canoX + canoLargura) < 0 then
			canoX = larguraTela
			canoTamanhoY = defineCanoY()
		end

		return canoX, canoTamanhoY
	end

	cano1X, cano1tamanhoY = canoMov(cano1X, cano1tamanhoY)
	cano2X, cano2TamanhoY = canoMov(cano2X, cano2TamanhoY)

	function testeColisao(canoX, canoTamanhoY)
		return
		playerX < (canoX + canoLargura)
		and
		(playerX + playerL) > canoX
		and (
			playerY < canoTamanhoY
			or
			(playerY + playerA) > (canoTamanhoY + canoAltura)
		)
	end

	if testeColisao(cano1X, cano1tamanhoY)
	or testeColisao(cano2X, cano2TamanhoY)
	or playerY > alturaTela then
		reset()
	end

	local function updatePlacarCano(canoAtual, canoX, proximo)
		if proximoCano == canoAtual
		and (playerX > (canoX + canoLargura)) then
			placar = placar + 1
			proximoCano = proximo
		end
	end

	updatePlacarCano(1, cano1X, 2)
	updatePlacarCano(2, cano2X, 1)
end

function love.draw()
	love.graphics.setColor(137, 255, 235)
	love.graphics.rectangle('fill', 0, 0, larguraTela, alturaTela)

	love.graphics.setColor(224, 214, 68)
	love.graphics.rectangle('fill', playerX, playerY, playerL, playerA)

	local function criaCano(canoX, canoTamanhoY)
		love.graphics.setColor(94, 201, 72)
		love.graphics.rectangle(
			'fill',
			canoX,
			0,
			canoLargura,
			canoTamanhoY
		)
		love.graphics.rectangle(
			'fill',
			canoX,
			canoTamanhoY + canoAltura,
			canoLargura,
			alturaTela - canoTamanhoY - canoAltura
		)
	end

	criaCano(cano1X, cano1tamanhoY)
	criaCano(cano2X, cano2TamanhoY)

	love.graphics.setColor(0, 0, 0)
	love.graphics.print(placar, 15, 15, 0 , 5,5)
end

function love.keypressed(key)
	if playerY > 0 then
		playergravity = -420
	end
end

