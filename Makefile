build_minecraft_container:
	docker build -t xmconstantx/minecraft minecraft/.

push_minecraft_container:
	docker push xmconstantx/minecraft