FROM tomcat:9.0
WORKDIR /usr/local/tomcat/webapps/
ENV dburl jdbc:mysql:loadbalance://192.168.1.94:5066,192.168.1.7:5066/db_ssm?loadBalanceAutoCommitStatementThreshold=5&loadBalanceHostRemovalGracePeriod=15000&loadBalanceBlacklistTimeout=60000&loadBalancePingTimeout=5000&retriesAllDown=10&connectTimeout=10000&socketTimeout=60000
ENV dbuser root
ENV dbpwd Yuanhang123!
ENV DbConnectionMaxActive 250
COPY ddmdemo/target/ $WORKDIR
RUN sed -i "2i /usr/local/tomcat/webapps/ddmdemo/initDemo.sh" /usr/local/tomcat/bin/catalina.sh
RUN chmod 777 /usr/local/tomcat/webapps/ddmdemo/initDemo.sh
CMD ["catalina.sh", "run"]