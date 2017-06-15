function love.load()
	larguraTela = 1280
	alturaTela = 720
	
	player = {x = 62, l = 70, a = 60, y = 200, gravity = 0}
	
	quantidadePulos={'*','*','*','*','*','*'}
	--trabalho 7 esse array está sendo construido para armazenar a
		  --quantidade de pulos que o jogador tem inicialmente.
	--Escopo: Por ser uma variável global, estará visivel durante toda a execução 
	-- 	  e em qualquer parte da aplicação.
	--Tempo de vida: O array é iniciado com a quatidade maxima de pulos que o jogador pode
	-- 		utilizar para chegar ao proximo cano, sendo decrementado toda vez que o pulo é executado
	--		e reiniciado com somente 4 elementos ao passar pelo proximo cano, sendo assim
	--		sua duração é durante todo o tempo de execução do jogo.
	--Alocação: Ao iniciar o jogo e toda a vez que o jogador passa por um cano onde o array é iniciado com 5 elementos.
	--Desalocação: Ao executar o pulo será decrementado um elemento do array, se o array estiver vazio o jogador não poderá pular.
	
	placar = {}
	
	posicaoPlacar = {15,15}
	
	fraseTutorial='visivel'

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
		quantidadePulos={'*','*','*','*','*','*'}
		--trabalho 7 array sendo reiniciado com a quantidade maxima de elementos duranto o reset do jogo.
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
			quantidadePulos={'*','*','*','*'}

			--trabalho 7 Array sendo iniciado com somente 4 elementos, após passar pelo cano.

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
	--trabalho 7 Imprimindo o array com a quantidade de pulos na tela.
	love.graphics.print(quantidadePulos, 15, 550, 0 , 5,5)
	if fraseTutorial == 'visivel' then
		love.graphics.print('Aperte qualquer tecla para voar', 0, 300,0, 5, 5)
	end
	
end

function love.keypressed(key)
	fraseTutorial = 'invisivel'
	--trabalho 7 Testa se existem elementos no array para que seja possivel executar o comando.
	if table.getn(quantidadePulos) > 0 then
		if player.y > 0 then
			player.gravity = -420
			table.remove(quantidadePulos)
			-- trabalho 7 Array sendo decrementado 1 elemento após a execução do comando.
		end
	end
end
