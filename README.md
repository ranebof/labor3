aws ec2 run-instances --image-id ami-053b0d53c279acc90 \
--count 1 \
--instance-type t2.micro \
--key-name key-first \
--security-group-ids sg-03df720334a928911 \
--subnet-id subnet-03bcd3414db6a39eb \
--user-data file://script.sh

#Команда на запуск
ssh -i key-firts.pem ec2-user@<your-ec2-ip>
