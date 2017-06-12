function love.load()
	larguraTela = 1280
	alturaTela = 720
	
	player = {x = 62, l = 70, a = 60, y = 200, gravity = 0}
	-- Este é um exemplo de um registro, que guarda as informações do jogador.
	
	placar = {}
	 -- Este é um exemplo de uma array, que servirá para guardar a pontuação atual do jogador.
	
	posicaoPlacar = {15,15}
	-- Este é um exemplo de uma tupla, que guardara a posição do placar no jogo.
	
	fraseTutorial='visivel'
	-- Este é um exemplo de enumeração, onde fraseTutorial só poderá ser visivel ou invisivel dependendo da situação.

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
		player.y = 200
		player.gravity = 0

		cano1X = larguraTela
		cano1tamanhoY = defineCanoY()

		cano2X = larguraTela + ((larguraTela + canoLargura) / 2)
		cano2TamanhoY = defineCanoY()

		placar[1] = 0

		proximoCano = 1
	end

	reset()
end

function love.update(dt)
	player.gravity = player.gravity + (916 * dt)
	player.y = player.y + (player.gravity * dt)

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
		player.x < (canoX + canoLargura)
		and
		(player.x + player.l) > canoX
		and (
			player.y < canoTamanhoY
			or
			(player.y + player.a) > (canoTamanhoY + canoAltura)
		)
	end

	if testeColisao(cano1X, cano1tamanhoY)
	or testeColisao(cano2X, cano2TamanhoY)
	or player.y > alturaTela then
		reset()
	end

	local function updatePlacarCano(canoAtual, canoX, proximo)
		if proximoCano == canoAtual
		and (player.x > (canoX + canoLargura)) then
			placar[1] = placar[1] + 1
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
	love.graphics.rectangle('fill', player.x, player.y, player.l, player.a)

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
	love.graphics.print(placar, posicaoPlacar[1], posicaoPlacar[2], 0 , 5,5)
	if fraseTutorial == 'visivel' then
		love.graphics.print('Aperte qualquer tecla para voar', 40, 40,0, 5, 5)
	end
	
end

function love.keypressed(key)
	fraseTutorial = 'invisivel'
	if player.y > 0 then
		player.gravity = -420
	end
end
