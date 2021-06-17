rg=rg-test-container

az container create \
--resource-group $rg \
--name doom555 \
--image mattipaksula/http-doom \
--dns-name-label doom555 \
--ports 8080