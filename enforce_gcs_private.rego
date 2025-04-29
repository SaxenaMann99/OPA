package policy.gcp.terraform

# Define a list of required tags for resources
required_tags = {
    "environment": "production",
    "owner": "team-name"
}

# Check that all resources have the required tags
deny[msg] {
    resource := input.resources[_]
    missing_tags := {tag | required_tags[tag]; not resource.tags[tag]}
    count(missing_tags) > 0
    msg := sprintf("Resource %s is missing required tags: %v", [resource.name, missing_tags])
}

# Ensure that only allowed resource types are used
allowed_resource_types = {
    "google_compute_instance",
    "google_storage_bucket",
    "google_sql_database_instance"
}

deny[msg] {
    resource := input.resources[_]
    not allowed_resource_types[resource.type]
    msg := sprintf("Resource %s of type %s is not allowed", [resource.name, resource.type])
}

# Check for specific configurations, e.g., ensure all storage buckets have versioning enabled
deny[msg] {
    resource := input.resources[_]
    resource.type == "google_storage_bucket"
    not resource.versioning.enabled
    msg := sprintf("Storage bucket %s does not have versioning enabled", [resource.name])
}
