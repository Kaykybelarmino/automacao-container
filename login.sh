#!/bin/bash
echo "Instalando interface para SQL Server"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools

echo "Adicionando binários da interface"
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/mssql-tools/lib"' >> ~/.bashrc
source ~/.bashrc

servidor="52.7.105.138"
usuario="sa"
senha="medconnect123"
banco="medconnect"

echo "Insira seu email:"
echo
read email
echo
echo "Insira sua senha:"
echo
read bancoSenha

comando_sql="SELECT COUNT(*) FROM Usuario WHERE email='$email' AND senha='$bancoSenha'"

response=$(/opt/mssql-tools/bin/sqlcmd -S $servidor -U $usuario -P $senha -d $banco -h -1 -W -s "," -Q "$comando_sql" | grep -oP '\d+' -m 1
)

if [ $response -eq 1 ]; then
        echo "Login realizado com sucesso!"
        export EMAIL_USUARIO=$email
        export SENHA_USUARIO=$bancoSenha
        chmod +x solucao.sh
        . solucao.sh
else
        echo "Houve um erro no login, verifique a senha e o email novamente"

fi

