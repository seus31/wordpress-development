init: up install ja-setup plugin-setup theme-setup
up:
	docker compose up -d
install:
	sleep 10
	docker compose run --rm wp-cli wp core install --url=localhost:8000 --title="Wordpress開発環境" \
     --admin_user=admin_user --admin_password=admin_password --admin_email=admin@example.com
ja-setup:
	docker compose run --rm wp-cli wp core language install ja --activate
plugin-setup:
	# 事前にインストールするプラグインを指定
	# --activate オプションをつけると有効化される
	# docker compose run --rm wp-cli wp plugin install backwpup --activate
theme-setup:
	# 事前にインストールするテーマを指定
	# --activate オプションをつけると有効化される
	# docker compose run --rm wp-cli wp theme install twentytwentytwo --activate
plugin-install:
	docker compose run --rm wp-cli wp plugin install $(PLUGIN)
plugin-activate:
	docker compose run --rm wp-cli wp plugin activate $(PLUGIN)
plugin-install-activate: plugin-install plugin-activate
theme-install:
	docker compose run --rm wp-cli wp theme install $(THEME)
theme-activate:
	docker compose run --rm wp-cli wp theme activate $(THEME)
theme-install-activate: theme-install theme-activate
down:
	docker compose down
clean:
	docker compose down --volumes
destroy:
	docker compose down --rmi all --volumes
