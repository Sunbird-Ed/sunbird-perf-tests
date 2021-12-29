##  API Benchmarking with OPA and Envoy Sidecar

#### Jmeter Cluster
For benchmarking the APIs, a Jmeter cluster (1 master + 4 slaves in cluster) was setup to perform API testing and verifying improvements in parallel.

#### APIs invoked in this benchmarking
| API Name                          | API path                                           | Description                                                                                                                                                                                        |
|-----------------------------------|----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Update Batch                      | /api/course/v1/batch/update                        | PATCH API used to update batch details |
| List Course Enrollments           | /api/course/v1/user/enrollment/list                | GET API used to list user's course enrollments |
| Read Content State                | /api/course/v1/content/state/read                  | POST API used to read user's course progress details |
| Update Content State              | /api/course/v1/content/state/update                | PATCH API used to update user's course progress details |
| Course Enrollment                 | /api/course/v1/enroll                              | POST API used to enroll to a course |
| Course Un-Enrollment              | /api/course/v1/unenrol                             | POST API used to un-enroll from a course |
| Assign Role                       | /api/user/v1/role/assign                           | POST API used to assign roles to a user |
| Assign Role V2                    | /api/user/v2/role/assign                           | POST API used to assign roles to a user (v2 version) |
| Accept Terms and Conditions       | /api/user/v1/tnc/accept                            | POST API used to accept the terms and conditions |
| Update User                       | /api/v1/user/update                                | PATCH API used to update a user's details |
| Submit Data Exhaust Request       | /api/dataset/v1/request/submit                     | POST API used to submit request to obtain various type of reports |
| Get Data Exhaust Request          | /api/dataset/v1/request/read                       | GET API used to read the request submitted for report generation |
| List Data Exhaust Request         | /api/dataset/v1/request/list                       | GET API used to list the requests submitted for report generation |
| Private User Read                 | /private/user/v1/read                              | Private GET API used to read user details |
| Private User Lookup               | /private/user/v1/lookup                            | Private POST API used to search user |

### Run and Infra details
- Release 4.5.0 code
- Each run duration is approximately 20 - 30 minutes
- Each run was done twice
  - With OPA and Envoy
  - Without OPA and Envoy
- Some runs were done multiple times to verify throughput, latencies, errors are consistent across multiple runs
- OPA and Envoy were added as sidecars for the following services on Kubernetes
  - Analytics
  - CertRegistry
  - Content
  - KnowledgeMW
  - Learner
  - LMS
- Private APIs are invoked directly by calling the service endpoint since those apis are not available on API gateway (Kong API metrics are also not availble for these APIs)
- Only for certain high throughput APIs, the overall infra CPU usage is captured

### Benchmark details

<table dir="ltr" style="height: 1260px;" border="1" cellspacing="0" cellpadding="0"><colgroup><col width="212" /><col width="100" /><col width="100" /><col width="123" /><col width="100" /><col width="130" /><col width="100" /><col width="161" /><col width="123" /><col width="127" /><col width="100" /><col width="185" /></colgroup>
<tbody>
<tr style="height: 90px;">
<td style="width: 195.359px; height: 180px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;API&quot;}">
<div style="text-align: center;"><strong>API Name and URL</strong></div>
</td>
<td style="width: 59.1406px; height: 180px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Scenario&quot;}">
<div style="text-align: center;"><strong>Scenario</strong></div>
</td>
<td style="width: 64.3125px; height: 90px; text-align: center;" colspan="2" rowspan="1" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;API TPS\n(Positive is better)&quot;}"><strong>API TPS</strong></td>
<td style="width: 87.6562px; height: 90px; text-align: center;" colspan="2" rowspan="1" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Total Latency in ms\n(Negative is better)&quot;}"><strong>Total Latency (ms)</strong></td>
<td style="width: 87.6562px; height: 90px; text-align: center;" colspan="2" rowspan="1" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Upstream Latency in ms\n(Negative is better)&quot;}"><strong>Upstream Latency (ms)</strong></td>
<td style="width: 97.75px; height: 90px; text-align: center;" colspan="2" rowspan="1" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Jmeter&quot;}"><strong>Jmeter</strong></td>
<td style="width: 103.219px; height: 90px; text-align: center;" colspan="2" rowspan="1" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Overall CPU Usage in Cores\n(Negative is better)&quot;}"><strong>Overall CPU Usage in Cores</strong></td>
</tr>
<tr style="height: 90px;">
<td style="width: 31.1562px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;max&quot;}"><strong>max</strong></td>
<td style="width: 31.1562px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;avg&quot;}"><strong>avg</strong></td>
<td style="width: 42.8281px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;max&quot;}"><strong>max</strong></td>
<td style="width: 42.8281px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;avg&quot;}"><strong>avg</strong></td>
<td style="width: 42.8281px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;max&quot;}"><strong>max</strong></td>
<td style="width: 42.8281px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;avg&quot;}"><strong>avg</strong></td>
<td style="width: 42.8281px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;TPS\n(Positive is better)&quot;}"><strong>TPS</strong></td>
<td style="width: 52.9219px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Avg Latency in ms\n(Negative is better)&quot;}"><strong>Avg Latency (ms)</strong></td>
<td style="width: 50.6094px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;max&quot;}"><strong>max</strong></td>
<td style="width: 50.6094px; height: 90px; text-align: center;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;avg&quot;}"><strong>avg</strong></td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;updateBatch\n/course/v1/batch/update&quot;}">
<div>updateBatch<br />/course/v1/batch/update</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:72}">72</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:64}">64</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3500}">3500</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2880}">2880</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3500}">3500</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2880}">2880</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:66.6}">66.6</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2907}">2907</td>
<td style="width: 103.219px; height: 72px;" colspan="2" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:73}">73</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:62}">62</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3490}">3490</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2780}">2780</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3490}">3490</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2780}">2780</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:67.2}">67.2</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2824}">2824</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;listCourseEnrollments\n/course/v1/user/enrollment/list&quot;}">
<div>listCourseEnrollments<br />/course/v1/user/enrollment/list</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:417}">417</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:381}">381</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:517.54}">517.54</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:491.44}">491.44</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:516.52}">516.52</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:490.41}">490.41</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:399.5}">399.5</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:497}">497</td>
<td style="width: 103.219px; height: 72px;" colspan="2" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:411}">411</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:381}">381</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:510.37}">510.37</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:492.1}">492.1</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:509.37}">509.37</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:491.08}">491.08</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:398.3}">398.3</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:498}">498</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;readContentState\n/course/v1/content/state/read&quot;}">
<div>readContentState<br />/course/v1/content/state/read</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3563}">3563</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3296}">3296</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:64.53}">64.53</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:54.8}">54.8</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:64.16}">64.16</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:54.42}">54.42</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3496.4}">3496.4</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:56}">56</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:49.916799999999995}">49.92</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:39.7748}">39.77</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3624}">3624</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3365}">3365</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:59.43}">59.43</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:53.56}">53.56</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:59.02}">59.02</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:53.18}">53.18</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3558}">3558</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:55}">55</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:40.369200000000006}">40.37</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:29.286}">29.29</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;updateContentState\n/course/v1/content/state/update&quot;}">
<div>updateContentState<br />/course/v1/content/state/update</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1965}">1965</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1826}">1826</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:102.07}">102.07</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:97.57}">97.57</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:101.67}">101.67</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:97.07}">97.07</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1944.2}">1944.2</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:101}">101</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:40.03759999999999}">40.04</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:31.159999999999997}">31.16</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1979}">1979</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1826}">1826</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:101.1}">101.1</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:97.93}">97.93</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:100.72}">100.72</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:97.54}">97.54</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1960.7}">1960.7</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:100}">100</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:41.9836}">41.98</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:32.002}">32.00</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;courseUnEnrolment\n/course/v1/unenrol&quot;}">
<div>courseUnEnrolment<br />/course/v1/unenrol</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:69}">69</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:53}">53</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3910}">3910</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3470}">3470</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3910}">3910</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3470}">3470</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:55.7}">55.7</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3498}">3498</td>
<td style="width: 103.219px; height: 72px;" colspan="2" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:54}">54</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:52}">52</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3810}">3810</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3660}">3660</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3810}">3810</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3660}">3660</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:53.3}">53.3</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3678}">3678</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;courseEnrolment\n/course/v1/enroll&quot;}">
<div>courseEnrolment<br />/course/v1/enroll</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2108}">2108</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1901}">1901</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:97.34}">97.34</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:89.06}">89.06</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:96.98}">96.98</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:88.21}">88.21</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2079.9}">2079.9</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:94}">94</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:23.7536}">23.75</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:15.2416}">15.24</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2059}">2059</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1846}">1846</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:107.4}">107.4</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:97.77}">97.77</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:106.97}">106.97</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:97.4}">97.4</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1993.6}">1993.6</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:98}">98</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:28.1244}">28.12</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:18.0776}">18.08</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;assignRole\n/user/v1/role/assign&quot;}">
<div>assignRole<br />/user/v1/role/assign</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1910}">1910</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1058}">1058</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:281.78}">281.78</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:196.88}">196.88</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:281.33}">281.33</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:196.44}">196.44</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1088.3}">1088.3</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:180}">180</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:22.5656}">22.57</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:15.3412}">15.34</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1644}">1644</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1039}">1039</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:310.03}">310.03</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:188.36}">188.36</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:309.37}">309.37</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:187.94}">187.94</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1078.3}">1078.3</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:181}">181</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:25.992}">25.99</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:18.9188}">18.92</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;assignRoleV2\n/user/v2/role/assign&quot;}">
<div>assignRoleV2<br />/user/v2/role/assign</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2096}">2096</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1124}">1124</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:247.13}">247.13</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:176.58}">176.58</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:246.68}">246.68</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:176.15}">176.15</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1181.8}">1181.8</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:166}">166</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:34.7388}">34.74</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:22.312}">22.31</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1752}">1752</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1147}">1147</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:240.56}">240.56</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:173.06}">173.06</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:240.1}">240.1</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:172.63}">172.63</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1189.4}">1189.4</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:165}">165</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:36.4556}">36.46</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:24.322}">24.32</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;acceptTermsAndCondition\n/user/v1/tnc/accept&quot;}">
<div>acceptTermsAndCondition<br />/user/v1/tnc/accept</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:793}">793</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:709}">709</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:191.94}">191.94</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:28.93}">28.93</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:191.27}">191.27</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:28.54}">28.54</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:741.03}">741.03</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:27.88}">27.88</td>
<td style="width: 50.6094px; height: 72px;" colspan="2" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:761}">761</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:687}">687</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:266.98}">266.98</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:36.04}">36.04</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:264.16}">264.16</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:35.61}">35.61</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:726.48}">726.48</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:33.17}">33.17</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;updateUser\n/v1/user/update&quot;}">
<div>updateUser<br />/v1/user/update</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1300}">1300</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:950}">950</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:239.14}">239.14</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:188.21}">188.21</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:238.69}">238.69</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:187.78}">187.78</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1005.6}">1005.6</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:190}">190</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:40.0468}">40.05</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:24.4328}">24.43</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1330}">1330</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:936}">936</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:242.11}">242.11</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:190.72}">190.72</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:241.68}">241.68</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:190.29}">190.29</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:991}">991</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:190}">190</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:42.7624}">42.76</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:25.3552}">25.36</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Private User Read\n/private/user/v1/read&quot;}">
<div>Private User Read<br />/private/user/v1/read</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 243.625px; height: 72px;" colspan="6" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1237.5}">1237.5</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:153}">153</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:27.214}">27.21</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:21.1392}">21.14</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:1320.1}">1320.1</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:141}">141</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:29.2676}">29.27</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:22.6748}">22.67</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Private User Lookup\n/private/user/v1/lookup&quot;}">
<div>Private User Lookup<br />/private/user/v1/lookup</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 243.625px; height: 72px;" colspan="6" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2396.7}">2396.7</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:78}">78</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:23.2768}">23.28</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:18.9936}">18.99</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:2767.2}">2767.2</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:68}">68</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:28.578}">28.58</td>
<td style="width: 50.6094px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:22.5864}">22.59</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;submitDataExhaustRequest\n/dataset/v1/request/submit&quot;}">
<div>submitDataExhaustRequest<br />/dataset/v1/request/submit</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:236}">236</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:206}">206</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3350}">3350</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:939.22}">939.22</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:3340}">3340</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:938.4}">938.4</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:217}">217</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:889}">889</td>
<td style="width: 103.219px; height: 72px;" colspan="2" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:288}">288</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:260}">260</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:993.19}">993.19</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:699.74}">699.74</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:990.61}">990.61</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:699.08}">699.08</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:274.8}">274.8</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:708}">708</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;getDataExhaustRequest\n/dataset/v1/request/read&quot;}">
<div>getDataExhaustRequest<br />/dataset/v1/request/read</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:5545}">5545</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:5200}">5200</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:35.66}">35.66</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:34.52}">34.52</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:35.31}">35.31</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:34.18}">34.18</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:5490.9}">5490.9</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:35}">35</td>
<td style="width: 103.219px; height: 72px;" colspan="2" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:5334}">5334</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:4869}">4869</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:106.55}">106.55</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:37.6}">37.6</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:106.13}">106.13</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:37.25}">37.25</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:5230.6}">5230.6</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:37}">37</td>
</tr>
<tr style="height: 36px;">
<td style="width: 195.359px; height: 72px;" colspan="1" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;listDataExhaustRequest\n/dataset/v1/request/list&quot;}">
<div>listDataExhaustRequest<br />/dataset/v1/request/list</div>
</td>
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;Without OPA&quot;}">Without OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:332}">332</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:296}">296</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:732.66}">732.66</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:613.22}">613.22</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:731.66}">731.66</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:612.66}">612.66</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:312}">312</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:623}">623</td>
<td style="width: 103.219px; height: 72px;" colspan="2" rowspan="2" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;NA&quot;}">
<div style="text-align: center;"><strong>NA</strong></div>
</td>
</tr>
<tr style="height: 36px;">
<td style="width: 59.1406px; height: 36px;" data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;With OPA&quot;}">With OPA</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:332}">332</td>
<td style="width: 31.1562px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:307}">307</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:627.9}">627.9</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:597.27}">597.27</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:627.35}">627.35</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:596.6}">596.6</td>
<td style="width: 42.8281px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:325.2}">325.2</td>
<td style="width: 52.9219px; height: 36px;" data-sheets-value="{&quot;1&quot;:3,&quot;3&quot;:605}">605</td>
</tr>
</tbody>
</table>

### Conclusion
- After introducing OPA and Envoy we are getting similar _**average throughput**_ and _**average latency**_ for each API with a slight increase in the infra resources
- Some APIs performed better after introducing OPA and Envoy (_we ran multiple runs with / without OPA and Envoy to validate this and still got the same results_)
- In general, an increase of _5ms - 10ms_ in **_average_** latency is expected due to OPA and Envoy sidecars
- The overall infra CPU usage (_kubernetes cluster, databases and other VMs involved in the run_) also increased due to additional resources used by OPA and Envoy or due to better throughput
- In some cases the overall CPU usage decreased after introducing OPA and Envoy
- In general, an increase of _10% - 20%_ in **_average_** overall CPU usage is expected due to OPA and Envoy sidecars
- _The increase in overall memory usage is negligible, hence we have not taken it into consideration_
### Long Run Soak Test
- We ran a 60 hour benchmark on the APIs that are part of the soak test (top used APIs) and the results were as we expected
- Overall TPS
  - 22850 (with opa and envoy)
  - 16800 (without opa and envoy)
- There is an increase in API latencies and infra resource utilization as we expected due to -
  - Higher throughput
  - OPA and Envoy side cars

#### With OPA and Envoy
##### Jmeter Cluster 1
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                       | 2561300139 | 38439 | 0.00% | 49.45  | 0 | 30501 | 4  | 5  | 11 | 18     | 12714.29 | 13768.93 | 24417.97 |
| dialAssemble                | 35148980   | 376   | 0.00% | 66.45  | 0 | 15578 | 17 | 41 | 57 | 94.99  | 174.56   | 316.45   | 250.53   |
| getCourseHierarchy          | 45751717   | 4744  | 0.01% | 3.29   | 0 | 29808 | 1  | 2  | 3  | 11     | 227.22   | 1583.19  | 245.32   |
| readContent                 | 78248056   | 7413  | 0.01% | 3.33   | 0 | 30501 | 1  | 1  | 2  | 10     | 388.6    | 837.47   | 367.01   |
| readForm                    | 28499660   | 1269  | 0.00% | 432.08 | 0 | 23856 | 16 | 27 | 43 | 758.99 | 141.54   | 242.04   | 139.28   |
| refreshToken-to-accessToken | 209631562  | 494   | 0.00% | 111.82 | 0 | 15552 | 12 | 22 | 39 | 61     | 1041.08  | 1901.28  | 1335.91  |
| searchContent               | 77921394   | 22020 | 0.03% | 6.29   | 0 | 15434 | 1  | 7  | 15 | 41     | 386.98   | 2141.36  | 622.15   |
| sendTelemetry               | 2086098770 | 2123  | 0.00% | 42.03  | 0 | 15775 | 4  | 5  | 6  | 15     | 10355.4  | 6750.33  | 21459.14 |

##### Jmeter Cluster 2
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total             | 1067045559 | 5323 | 0.00% | 247.62 | 0 | 17766 | 18 | 24 | 29.95 | 49    | 5299.18 | 10336.62 | 12630.64 |
| getUserProfile    | 37435237   | 329  | 0.00% | 270.49 | 0 | 16592 | 26 | 88 | 96    | 115   | 185.91  | 477.93   | 445.46   |
| getUserProfileV2  | 37436204   | 376  | 0.00% | 270.45 | 0 | 16288 | 25 | 87 | 96    | 114   | 185.92  | 477.95   | 445.48   |
| getUserProfileV3  | 200735508  | 589  | 0.00% | 263.71 | 1 | 15746 | 19 | 25 | 31    | 54    | 996.9   | 2562.74  | 2388.45  |
| getUserProfileV4  | 211993666  | 607  | 0.00% | 259.36 | 1 | 16114 | 18 | 24 | 30    | 52    | 1052.81 | 2463.9   | 2522.39  |
| getUserProfileV5  | 210203687  | 609  | 0.00% | 261.58 | 1 | 16368 | 19 | 24 | 31    | 52.99 | 1043.92 | 2532.11  | 2501.08  |
| readUserConsent   | 135193272  | 900  | 0.00% | 296.59 | 0 | 16101 | 10 | 16 | 29    | 57    | 671.4   | 678.83   | 1768.09  |
| searchUser        | 40856041   | 436  | 0.00% | 147.33 | 0 | 15868 | 16 | 74 | 83    | 97    | 202.9   | 336.46   | 377.67   |
| updateUser        | 38110078   | 466  | 0.00% | 244.46 | 0 | 16113 | 24 | 89 | 98    | 126   | 189.26  | 153.16   | 407.29   |
| updateUserConsent | 35428348   | 554  | 0.00% | 353.86 | 0 | 17766 | 18 | 80 | 90    | 106   | 175.95  | 153.03   | 415.92   |
| userFeed          | 119653518  | 457  | 0.00% | 109.5  | 0 | 15785 | 12 | 37 | 52    | 72    | 594.23  | 500.54   | 1358.84  |

##### Jmeter Cluster 3
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                 | 753688224 | 4330 | 0.00% | 149.66  | 0 | 25998 | 15 | 69  | 92  | 113 | 3742.99 | 4572.6  | 7917.85 |
| getBatch              | 36676527  | 312  | 0.00% | 1.19    | 0 | 15362 | 1  | 1   | 2   | 11  | 182.15  | 204.58  | 352.37  |
| listCourseEnrollments | 37004452  | 2130 | 0.01% | 1473.99 | 1 | 25998 | 62 | 108 | 126 | 168 | 183.77  | 1304.85 | 382.89  |
| readContentState      | 331970043 | 751  | 0.00% | 80.34   | 0 | 15664 | 7  | 10  | 12  | 17  | 1648.64 | 1560.65 | 3512.76 |
| searchCourseBatches   | 45157049  | 385  | 0.00% | 19.16   | 0 | 15499 | 8  | 13  | 17  | 30  | 224.26  | 239.92  | 180.02  |
| updateContentState    | 302880153 | 752  | 0.00% | 101.27  | 0 | 15551 | 15 | 20  | 23  | 36  | 1504.17 | 1262.62 | 3489.83 |

##### Jmeter Cluster 4
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                  | 178827023 | 520 | 0.00% | 10.02 | 0 | 15516 | 5 | 8 | 12 | 18 | 888.1  | 814.09 | 763.35 |
| deviceProfile          | 88530862  | 170 | 0.00% | 10.64 | 0 | 15503 | 5 | 8 | 11 | 17 | 439.67 | 353.89 | 269.33 |
| deviceRegister         | 44992301  | 164 | 0.00% | 11.51 | 0 | 15516 | 6 | 9 | 13 | 19 | 223.44 | 188.59 | 321.7  |
| registerMobileDevicev2 | 45303860  | 186 | 0.00% | 7.32  | 0 | 15508 | 4 | 6 | 8  | 15 | 224.99 | 271.61 | 172.32 |

##### Jmeter Cluster 5
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                                             | 41307270 | 1589 | 0.00% | 810.07  | 0  | 122179 | 52  | 157     | 176   | 211    | 205.36 | 459.08 | 262.89 |
| /auth/realms/sunbird/protocol/openid-connect/auth | 5949387  | 265  | 0.00% | 433.01  | 1  | 85307  | 10  | 13      | 15    | 25     | 29.58  | 114.65 | 20.81  |
| /home                                             | 5949421  | 47   | 0.00% | 99.96   | 1  | 14929  | 52  | 58      | 61    | 76.99  | 29.58  | 40.63  | 11.44  |
| AuthCallBackRedirect                              | 5949263  | 227  | 0.00% | 59.61   | 0  | 13442  | 9   | 13      | 15    | 40     | 29.58  | 56.49  | 21.07  |
| keycloakloginaction                               | 5949312  | 532  | 0.01% | 2685.96 | 1  | 122179 | 200 | 279     | 310   | 688.98 | 29.58  | 124.56 | 105.15 |
| keycloakloginaction-0                             | 5863756  | 0    | 0.00% | 1451.27 | 2  | 74360  | 99  | 147     | 158   | 202    | 29.15  | 49.04  | 51.75  |
| keycloakloginaction-1                             | 5863756  | 505  | 0.01% | 855.23  | 1  | 84624  | 72  | 135     | 156   | 248    | 29.15  | 18.24  | 29.77  |
| keycloakloginaction-2                             | 5782360  | 13   | 0.00% | 74.68   | 1  | 60002  | 10  | 25      | 44    | 59     | 28.75  | 55.49  | 22.9   |
| keycloakloginaction-3                             | 15       | 0    | 0.00% | 3007.73 | 16 | 32414  | 34  | 20289.2 | 32414 | 32414  | 0      | 0      | 0      |

#### Without OPA and Envoy
##### Jmeter Cluster 1
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                       | 101131119 | 1597 | 0.00% | 45.59  | 0 | 30295 | 5  | 8  | 14 | 46     | 9389.78 | 10198.96 | 17959.81 |
| dialAssemble                | 1376044   | 91   | 0.01% | 68.82  | 0 | 30295 | 19 | 45 | 62 | 141    | 128     | 227.56   | 184.69   |
| getCourseHierarchy          | 1794291   | 84   | 0.00% | 2.96   | 0 | 7036  | 1  | 2  | 3  | 12     | 166.9   | 1157.61  | 181.49   |
| readContent                 | 3046244   | 77   | 0.00% | 8.29   | 0 | 7303  | 1  | 2  | 8  | 21     | 283.34  | 600.14   | 269.8    |
| readForm                    | 1167798   | 99   | 0.01% | 348.76 | 0 | 7239  | 17 | 30 | 41 | 699.99 | 108.63  | 185.37   | 107.74   |
| refreshToken-to-accessToken | 10346083  | 132  | 0.00% | 58.11  | 0 | 5882  | 6  | 8  | 10 | 16     | 962.26  | 1631.68  | 1242.28  |
| searchContent               | 3012650   | 948  | 0.03% | 16.21  | 0 | 6555  | 1  | 16 | 25 | 58     | 280.21  | 1539.69  | 452.77   |
| sendTelemetry               | 80388009  | 166  | 0.00% | 42.65  | 0 | 7376  | 5  | 8  | 13 | 48     | 7463.95 | 4866.41  | 15525.56 |
##### Jmeter Cluster 2
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total             | 49759212 | 963 | 0.00% | 191.38 | 0 | 7376 | 19 | 80  | 87     | 96  | 4627.65 | 8967.63 | 11031.99 |
| getUserProfile    | 1502452  | 82  | 0.01% | 236.54 | 0 | 7331 | 27 | 184 | 219    | 412 | 139.76  | 349.34  | 333.27   |
| getUserProfileV2  | 1502206  | 111 | 0.01% | 236.78 | 0 | 7304 | 27 | 185 | 222.95 | 406 | 139.74  | 349.3   | 333.21   |
| getUserProfileV3  | 9321593  | 101 | 0.00% | 220.9  | 1 | 7320 | 21 | 94  | 105    | 182 | 866.94  | 2167.04 | 2067.4   |
| getUserProfileV4  | 9930027  | 97  | 0.00% | 216.96 | 1 | 7146 | 20 | 95  | 103    | 179 | 923.52  | 2096.21 | 2202.35  |
| getUserProfileV5  | 9897625  | 109 | 0.00% | 217.67 | 1 | 7376 | 20 | 95  | 103    | 179 | 920.52  | 2134.05 | 2195.18  |
| readUserConsent   | 7768212  | 88  | 0.00% | 167.1  | 0 | 7260 | 10 | 83  | 95     | 185 | 722.48  | 705.72  | 1894.38  |
| searchUser        | 1679566  | 81  | 0.00% | 84.99  | 0 | 3050 | 14 | 106 | 183    | 292 | 156.23  | 239.81  | 289      |
| updateUser        | 1553572  | 95  | 0.01% | 189.27 | 0 | 3075 | 25 | 191 | 260    | 387 | 144.51  | 111.89  | 309.32   |
| updateUserConsent | 1521447  | 92  | 0.01% | 218.63 | 0 | 3843 | 17 | 172 | 207    | 390 | 141.52  | 118.12  | 332.91   |
| userFeed          | 5082512  | 107 | 0.00% | 74     | 0 | 7199 | 11 | 86  | 98     | 182 | 472.71  | 696.62  | 1075.57  |
##### Jmeter Cluster 3
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                 | 25463353 | 473 | 0.00% | 188.71  | 0 | 16240 | 14 | 78  | 86  | 121.99 | 2368.15 | 2287.59 | 4936.76 |
| getBatch              | 1438082  | 86  | 0.01% | 1.25    | 0 | 3681  | 1  | 1   | 2   | 12     | 133.77  | 145.98  | 257.26  |
| listCourseEnrollments | 2087628  | 94  | 0.00% | 1024.16 | 1 | 16240 | 50 | 119 | 146 | 217    | 194.15  | 355.37  | 403.07  |
| readContentState      | 10567790 | 99  | 0.00% | 118.8   | 0 | 3451  | 5  | 9   | 12  | 20     | 982.86  | 896.73  | 2083.11 |
| searchCourseBatches   | 1779958  | 93  | 0.01% | 12.8    | 0 | 3061  | 6  | 16  | 23  | 42     | 165.57  | 171.7   | 134.19  |
| updateContentState    | 9589895  | 101 | 0.00% | 144.64  | 0 | 3190  | 13 | 20  | 24  | 41     | 891.9   | 717.91  | 2059.3  |
##### Jmeter Cluster 4
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                  | 2514801 | 57284 | 2.28%  | 752.85  | 0 | 96574 | 6  | 62  | 90.95 | 1597.72  | 234.18 | 225.96 | 194.95 |
| deviceProfile          | 560376  | 29939 | 5.34%  | 1629.25 | 0 | 96574 | 6  | 88  | 101   | 9426.61  | 52.18  | 39.36  | 33.44  |
| deviceRegister         | 270504  | 27300 | 10.09% | 3369.64 | 0 | 70060 | 17 | 210 | 588   | 31560.99 | 25.19  | 19.26  | 36.98  |
| registerMobileDevicev2 | 1683921 | 45    | 0.00%  | 40.85   | 0 | 13043 | 5  | 7   | 9     | 16       | 156.81 | 167.35 | 124.54 |
##### Jmeter Cluster 5
| API                    | #Samples   | KO    | Error % | Average | Min | Max   | Median | 90th pct | 95th pct | 99th pct | Transactions/s | Received | Sent     |
|-----------------------------|------------|-------|-------|--------|---|-------|----|----|----|--------|----------|----------|----------|
| Total                                             | 1931486 | 32 | 0.00% | 282.49 | 3  | 70321 | 51  | 152 | 192    | 274.99 | 180.34 | 403.02 | 231.37 |
| /auth/realms/sunbird/protocol/openid-connect/auth | 275934  | 2  | 0.00% | 19.1   | 6  | 1662  | 10  | 14  | 18     | 27     | 25.77  | 99.88  | 18.13  |
| /home                                             | 275939  | 3  | 0.00% | 73.54  | 8  | 2911  | 53  | 61  | 65     | 76     | 25.77  | 35.39  | 9.96   |
| AuthCallBackRedirect                              | 275902  | 1  | 0.00% | 13.83  | 3  | 1020  | 9   | 14  | 17     | 27     | 25.76  | 49.72  | 18.36  |
| keycloakloginaction                               | 275933  | 15 | 0.01% | 935.54 | 30 | 70321 | 234 | 406 | 492    | 752.99 | 25.77  | 109.02 | 92.47  |
| keycloakloginaction-0                             | 275929  | 0  | 0.00% | 554.77 | 73 | 3146  | 125 | 230 | 261    | 314    | 25.77  | 43.58  | 45.74  |
| keycloakloginaction-1                             | 275929  | 9  | 0.00% | 363.18 | 17 | 70003 | 78  | 227 | 304.95 | 535    | 25.77  | 15.72  | 26.21  |
| keycloakloginaction-2                             | 275920  | 2  | 0.00% | 17.43  | 4  | 1089  | 9   | 17  | 27     | 51     | 25.76  | 49.73  | 20.52  |
