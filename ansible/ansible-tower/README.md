Role Name
=========

- ansible-tower

Requirements
------------

* ansible >= 2.0 ( **pip install ansible** )

Platforms
---------

  - CentOS-7.x

Prerequisite
------------

* Clone the git repo. ( git clone https://github.com/initcron-deveops/automation.git )

* Change the directory to **automation/ansible/ansible-tower**

* Edit the Host file in ansible default directory with "ansible_ssh_user"

        - hosts.ini

* Role Variables

```bash       
        # ansible-tower
	ansible_tower_url: http://releases.ansible.com/ansible-tower/setup/
	ansible_tower_version: 3.0.3
	ansible_tower_setup_dir: /opt

	# access credentials
	ansible_tower_pass: SECURE_PASSWORD
	ansible_tower_redis_pass: SECURE_PASSWORD

	# db credentials
	ansible_tower_database_name: awx
	ansible_tower_database_user: awx
	ansible_tower_database_pass: SECURE_PASSWORD
```

* Edit the rundeck.yml to specify the host to be installed

        * hosts: all
          sudo: yes
          roles:
             - ansible-tower

* Run the playbook
      
```bash
	ansible-playbook -i hosts.ini ansible-tower.yml
```

* Access the Asible-Tower 

```bash
	https://IP 
```
