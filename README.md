# DigitLab OpsWorks Production Stack Cookbooks

These are the cookbooks for [DigitLab](http://digitlab.co.za) used in AWS OpsWorks

These cookbooks were taken from various sources across the web and modified to work with OpsWorks.

## Apache 2

Override the built-in Apache 2 recipies to install PHP 5.6.

## Composer

Install composer globally

## Deploy

Override the build-in deployment scripts to not create the ruby shared folders. This makes PHP deployment more sane.

## S3FS

Mount S3 buckets using custom JSON configuration:

```
"s3fs": {
    "config": {
        "id": "s3fs_deploy_key",
        "buckets": [ "my-bucket" ],
        "access_key_id": "my-access-key",
        "secret_access_key": "my-secret-key"
    }
}
```

## Supervisord

Install and configure supervisord. This is imported into deploy to allow hook scripts to use it.