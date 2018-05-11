ansible-playbook -i inventory/awsaccount1/us-east-1/stage/host.ini -e "ans_destroy=true" playbooks/deploy_infra_service1.yml
