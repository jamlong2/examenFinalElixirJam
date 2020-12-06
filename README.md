
			#erlang y elixir
			wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb 
			sudo dpkg -i erlang-solutions_1.0_all.deb
			sudo apt-get update
			sudo apt-get install esl-erlang
			sudo apt-get install elixir
			sudo mix local.hex
			wget https://github.com/phoenixframework/archives/raw/master/phx_new.ez 
			sudo mix archive.install ./phx_new.ez
			sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
			source ~/.bashrc
			nvm install 8.12.0
			nvm use 8.12.0
				
			#postgres
			sudo apt-get update
			sudo apt-get install postgresql postgresql-contrib
		        sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password 'postgres';"
			sudo systemctl restart postgresql.service
			
			sudo apt update
			sudo apt install nginx 
			
			#corriendo el proyecto
			sudo apt-get install -y inotify-tools
			sudo mix phoenix.new ~/phoenix_project_test
			cd ~/phoenix_project_test
			sudo mix ecto.create
			sudo sed -i 's/{:cowboy, "~> 1.0"}/{:cowboy, "~> 1.0"}, {:plug_cowboy, "~> 1.0"}/'  mix.exs
			sudo mix deps.get
			sudo mix phx.server
	