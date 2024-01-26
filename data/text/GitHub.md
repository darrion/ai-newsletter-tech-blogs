
GitHub Availability Report: December 2023
=============================================

Incident Summary
---------------

On December 29, 2023, from 00:34 to 1:42 UTC, users experienced issues signing in or creating new accounts on GitHub.com. The incident was caused by a credential rotation that was not fully mirrored in our frontend caches, leading to a mismatch between signed-in and signed-out user experiences.

Impact
-----

During the affected time frame, users were unable to sign in or create new accounts on GitHub.com. Existing sessions were not impacted.

Resolution
-----------

We resolved the incident by deploying updated credentials to our cache service. Repair items are underway to improve our monitoring of signed-out user experiences and better manage updates to shared credentials in our systems moving forward.

Preventative Measures
--------------------

To prevent similar incidents from occurring, we will be implementing additional monitoring and repair processes for our frontend caches. We will also be improving our credential rotation procedures to ensure a smoother and more seamless transition between updates.

Conclusion
----------

In conclusion, the December 2023 availability report highlights an incident that affected user sign-in and creation of new accounts on GitHub.com. The issue was caused by a credential rotation not fully mirrored in our frontend caches, and we have since taken steps to resolve the incident and prevent similar incidents from occurring in the future.

Please follow our status page for real-time updates on status changes and post-incident recaps. To learn more about what we're working on, check out the GitHub Engineering Blog.