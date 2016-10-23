Role Name
=========

* Docker

Requirements
------------

* ansible >= 2.0 ( **pip install ansible** )

Platforms
---------

  - CentOS-7.X
  - Ubuntu

Prerequisite
------------

* Clone the git repo. ( git clone https://github.com/initcron-deveops/automation.git )

* Change the directory to **automation/ansible/Docker**

* Edit the Host file in ansible default directory with "ansible_ssh_user"
  
	- /etc/ansible/hosts

* Edit the docker.yml to specify the host to be installed
    
<pre>    
	  hosts: servers
          roles:
             - docker
</pre>

* To add user to the Docker group
   
  - Edit defaults/main.yml

    to specify the user, depends on os_family

<pre>
         RedHat_User: centos
         Debian_User: ubuntu  
</pre>

* If Docker-Compose to be installed (Optional)
   
        * false ===> Do nothing
	* true  ===> Install

  - Edit defaults/main.yml

"True" Flag will install docker compose.

<pre>
         compose: true
</pre>

Run the ansible
---------------

<pre>
        ansible-playbook docker.yml
</pre> 
