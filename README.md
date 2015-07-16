vagrant-ansible-sandbox
=======================

A vagrant environment for playing around and learning ansible.

1. Install ansible: `pip install ansible`
2. Start env: `vagrant up`
3. Ssh into the admnode `vagrant ssh admnode`
4. Run a playbook! `$ cd /vagrant && ansible-playbook -i inventory playbooks/test.yml`
