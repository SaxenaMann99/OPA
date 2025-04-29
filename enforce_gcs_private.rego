package terraform.analysis

import input as tfplan

# Define acceptable configurations
acceptable_machine_types := {"e2-micro", "e2-small"}
acceptable_bucket_locations := {"US", "EU"}

# Default authorization decision
default authz := false

# Authorization holds if all resources meet the acceptable configurations
authz if {
    all_resources := tfplan.resource_changes[_]

    # Check compute instances
    all_resources[_].type == "google_compute_instance"
    all_resources[_].change.after.machine_type in acceptable_machine_types

    # Check storage buckets
    all_resources[_].type == "google_storage_bucket"
    all_resources[_].change.after.location in acceptable_bucket_locations
}
