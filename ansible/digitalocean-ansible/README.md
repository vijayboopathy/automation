# How to use these Playbooks?

## Snapshot ID/Image ID

To find out your snapshots ID, run the following API call.

```
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer <YOUR_API_TOKEN>" "https://api.digitalocean.com/v2/images?page=1&per_page=1&private=true"
```
Replace <YOUR_API_TOKEN> with your DO API token.

Use that ID as your Image ID in vars.yml file. Then you are good to lauch droplets with custom images.


## SSH-Key ID

To find your SSH key ID, use the following API call. Then put the ID in vars.yml to use it.

```
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer <YOUR_API_Token>" "https://api.digitalocean.com/v2/account/keys"
```

## vars.yml Template

```
do_token: <YOUR_API_TOKEN>
size: 512mb
region: nyc3
image: "ubuntu-14-04-x64"
ssh_id: 8016477
user_data: "{{ lookup('file', 'user-data.sh') }}"
```

## Launch Servers

To lauch ==> 

```
ansible-playbook lauch.yml
```


To destroy ==> 

```
ansible-playbook destroy.yml
```

## One Last Thing...

After lauching the servers, wait for couple of minutes. The start-up script will have to install docker, docker-compose and bring up codespaces. It will normally take 2 or 3 mins.
