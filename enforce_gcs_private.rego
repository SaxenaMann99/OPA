package terraform

import input.tfplan as tfplan

# Ensure GCS buckets are not public

# Check Bucket Access Control
deny[reason] {
    r := tfplan.resource_changes[_]
    r.mode == "managed"
    r.type == "google_storage_bucket_access_control"
    r.change.after.entity == "allUsers"
    r.change.after.role == "READER"

    reason := sprintf("%-40s :: GCS buckets must not be PUBLIC", [r.address])
}

# Check google_storage_bucket_acl for predefined ACL's
deny[reason] {
    r := tfplan.resource_changes[_]
    r.mode == "managed"
    r.type == "google_storage_bucket_acl"
    array_contains(r.change.after.role_entity, "READER:allUsers")

    reason := sprintf("%-40s :: GCS buckets must not use predefined ACL '%s'", [r.address, r.change.after.role_entity])
}

# Helper function to check if an array contains a specific element
array_contains(arr, elem) {
    some i
    arr[i] == elem
}
