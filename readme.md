# Simple username blocking of shiboleth users in ezproxy

## Files needed
- shibuser.txt.pre
    - Containing information that needs to at the top of shibuser.txt
- shibuser.txt.post
    - Containing group and admin information
- shibuser.denied
    - Containg usernames to be blocked. One username per line

### shibuser.txt.pre example
```
If !(auth:issuer eq "https://issuer.url");
   Deny unaffiliated.html
```

### shibuser.txt.post example
```
Group Default
If Any(auth:urn:oid:1.3.6.1.4.1.5923.1.1.1.9, "student user group");
   Group +Valid
If Any(auth:urn:oid:1.3.6.1.4.1.5923.1.1.1.9, "employee user group");
   Group +Valid +Employee
If auth:urn:oid:1.3.6.1.4.1.5923.1.1.1.6 eq "admin@somewhere";
   Admin
Set login:loguser = auth:urn:oid:1.3.6.1.4.1.5923.1.1.1.6
```

### shibuser.denied example
```
user1@site
user2@site
```