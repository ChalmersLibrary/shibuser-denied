# Simple username blocking of shiboleth users in ezproxy

## What is this?

deniedfilewatcher.sh runs create-shibuser.sh when shibuser.denied is modified and creates a shibuser.txt file according to the format in the [shibboleth documentation at oclc](https://www.oclc.org/support/services/ezproxy/documentation/usr/shibboleth.en.html#shibuser).

## Usage

### With Filewatcher 
Start deniedfilewatcher.sh at machine startup and it will stat shibuser.denied every 5 seconds.

### With cronjob every 5 minutes
```
*/5 * * * * 	cd path to shibuser directory; ./create-shibuser.sh 2>&1
```


## Files needed
- shibuser.txt.pre
    - Containing information that needs to at the top of shibuser.txt
- shibuser.txt.post
    - Containing group and admin information
- shibuser.denied
    - Containg usernames to be blocked. One username per line

All files should have an empty line as the last line

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
#
# Add one user per line
# Last line should be an empty line
# You can add comments by having a # at the begining of the line.
#
user1@site
user2@site

```