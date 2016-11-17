Role Name
=========

- rundeck

Requirements
------------

* ansible >= 2.0 ( **pip install ansible** )

Platforms
---------

  - CentOS-6.8
  - CentOS-7.x

Prerequisite
------------

* Clone the git repo. ( git clone https://github.com/initcron-deveops/automation.git )

* Change the directory to **automation/ansible/rundeck**

* Edit the Host file in ansible default directory with "ansible_ssh_user"

        - /etc/ansible/hosts

* Edit the rundeck.yml to specify the host to be installed

        * hosts: servers
          sudo: yes
          roles:
             - rundeck

Run the Playbook
---------------

<pre>
        ansible-playbook rundeck.yml
</pre>

Configure Node
--------------

* configure node with ssh key

         - ssh-keygen -t rsa

*  Copy the public key to authorized_keys

*  Copy the private key to rundeck server directory

          - /var/lib/rundeck/client.key

Add Node in Rundeck Server
--------------------------

* Add the node in server to resolve client hostname

	 - /etc/hosts

* Edit the file

          - /var/rundeck/projects/[projectname]/etc/resources.xml

* Add the node config inside the Project

<pre>

  node name="servername" description="Dev MySQL" tags="" hostname="servername" osArch="amd64" osFamily="unix" osName="Linux" osVersion="2.6.32-504.8.1.el6.x86_64" username="userAccount" ssh-keypath="/var/lib/rundeck/client.key"

</pre>
Check the log for error.
