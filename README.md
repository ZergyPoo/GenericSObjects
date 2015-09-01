# GenericSObjects

Hello! Welcome to Generic SObject Examples.

To install this package in your salesforce instance, follow these steps:

1. Install the Force.com Ant Migration Tool. (https://developer.salesforce.com/page/Force.com_Migration_Tool)

2. Clone this repository into a local directory.

3. Create a new file in the root directory of this repository called "build.properties"

4. Fill in this file with your salesforce credentials so that it looks like this:

```
sfdc.serverUrl=https://www.salesforce.com
sfdc.username=<your username>
sfdc.password=<your password><your security token>
```

4. Run "ant deploy" from the repository base directoy.

5. Enjoy!

There are a number of examples in this repository, and good examples of how to run the code are located in the relevant unit test files for each of the classes.
