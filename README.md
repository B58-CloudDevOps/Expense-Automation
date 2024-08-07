# Expense-Automation

Expense project automation will be addressed keeping the Non-Functional Requiments in to consideration.

We are also going to create our onw DNS Domain both for internal and external records.



For ex: shipping.flikrt.com , payment.flikrt.com   ( Public Domains : These records can be accessed from the public network )

        A Records
        100.200.120.150 ---> shipping.flikrt.com
        100.200.130.150 ---> payment.flikrt.com

        CNAME Records 
        abc.testlb.globaldns.sampler.com    ----> global.flikrt.com 


### How it works,  when if an org wants to move them domain name system to cloud from on-prem 

    1) They create the domain with the same name on AWS Route53 
    2) They will change the nameServer details on cloud. ( Domain migration )