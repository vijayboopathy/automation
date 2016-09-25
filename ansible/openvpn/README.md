### Open VPN set up on AWS

####Requirements 

  * ansible >= 2.0 ( **pip install ansible** )
  * AWS credentials ( ACCESS and SECRET key)

###Prerequisite

* Clone the git repo. ( git clone git@github.com:ZephyrAnalytics/infra.git )

* Change the directory to **infra/ansible**

* Create a file called **.aws_cred** with following contents

<pre>
	[Credentials]
	aws_access_key_id = **Your_ACCESS_key**
	aws_secret_access_key = **Your_secret_key**
</pre>

* execute the following command to inform ansible to use the above creadentials while doing API calls to AWS.

<pre>
	export BOTO_CONFIG=./.aws_cred

</pre>

* Edit files in vars folder according to your requiremts. 

	*  Edit aws.yml 
	   * change the **key_name** ( Mandatory )
	   * Rest can be kept to defaults

	* Edit openvpn.yml
	   * Can be  kept to defaults

* Make sure you already have the SSH key with which you are creating the EC2.

* The SSH key should be add to your ssh-agent.

   To view the added the SSH-key 

   <pre>
   		ssh-add -l 
   </pre>

   If the above command show the ssh key then you are ready to run the ansible playbook
   If it does not shows up, then do the following steps

   <pre>
   		eval `ssh-agent`
   		ssh-add **path_to_your_ssh_key**
   </pre>

	Check key has been added or not again.

###Run the ansible 

<pre>
	ansible-playbook openvpn.yml
</pre>


###Verify 

  Add the .openvpn config created by ansible in ./clients folder to your open VPN client ( Tunnelblick for mac )
  Connect the open VPN server, once connected try the following command
  
  <pre>
  	ssh **private_IP_of_openVPN_server**
  </pre>
  
  If you get logged in to the server, that means the Open VPN is configured correctly.
  
  
