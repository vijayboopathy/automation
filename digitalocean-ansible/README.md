To find out your snapshots ID.

curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer b7d03a6947b217efb6f3ec3bd3504582" "https://api.digitalocean.com/v2/images?page=1&per_page=1&private=true"

Replace b7d03a6947b217efb6f3ec3bd3504582 with your DO API token.

Use that ID as your Image ID in vars.yml file. Then you are good to lauch droplets with custom images.


To lauch ==> ansible-playbook lauch.yml

To destroy ==> ansible-playbook destroy.yml


