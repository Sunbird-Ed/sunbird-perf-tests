## Prepare test data to load test user-create v2 API

### Pre-requisites
1. Root organisations should have been created with the organisationIds of the format root-org-`count`
> example range: ```root-org-1 to root-org-28```

2. Sub organisations should have been created with the organisationIds of the format school-`rootOrgCount`-`subOrgCount`
> example range: ```school-1-1 to school-28-50000```

### Command to generate test data

```generate-test-data.sh <ROOT_ORG_COUNT> <SUB_ORG_COUNT> <NON_CUSTODIAN_USERS_COUNT> <CUSTODIAN_USERS_COUNT>```

example : ```generate-test-data.sh 28 50000 8 2```

### Sample CSV Data

|firstName|userName|email|organisationId|
|---|---|---|---|
|1556528849-1|1556528849-1|1556528849-1@domain.com|school-21-8842|
|1556528849-2|1556528849-2|1556528849-2@domain.com|school-16-30713|
|1556528849-3|1556528849-3|1556528849-3@domain.com|school-16-20210|
|1556528849-4|1556528849-4|1556528849-4@domain.com|school-1-518|
|1556528849-5|1556528849-5|1556528849-5@domain.com|school-8-27766|
|1556528849-6|1556528849-6|1556528849-6@domain.com|school-6-8625|
|1556528849-7|1556528849-7|1556528849-7@domain.com|school-5-30188|
|1556528849-8|1556528849-8|1556528849-8@domain.com|school-15-7974|
|1556528849-9|1556528849-9|1556528849-9@domain.com||
|1556528849-10|1556528849-10|1556528849-10@domain.com||
