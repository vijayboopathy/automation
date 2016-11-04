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
