dburl=${dburl//\//\\\/}
dburl=${dburl//&/\\&}
configPath=/usr/local/tomcat/webapps/ssm-crud/WEB-INF/classes/dbconfig.properties
sed -i 's/\(jdbc.url=\).*/\1'$dburl'/' $configPath
sed -i 's/\(jdbc.username=\).*/\1'$dbuser'/' $configPath
sed -i 's/\(jdbc.password=\).*/\1'$dbpwd'/' $configPath
sed -i 's/\(dbcp.maxActive=\).*/\1'$DbConnectionMaxActive'/' $configPath