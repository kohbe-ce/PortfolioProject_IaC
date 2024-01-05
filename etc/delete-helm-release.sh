#!/bin/bash

release_name="aws-load-balancer-controller"
namespace="kube-system"

helm delete $release_name --namespace $namespace
