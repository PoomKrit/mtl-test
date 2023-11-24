# mtl-test

### Prerequisite
- command `terraform`
- command `kubectl`
- command `kubectx`
- command `helm`
- command `aws`

#### To deploy go-application, please follow steps below.

1. Create EKS cluster<br>
   1.1) Create new IAM access key & secret key with proper permissions for EKS, S3, SQS and EC2. Then configure the aws profile with command `aws configure --profile mtl-test` to get a profile for Terraform<br>
   1.2) Go to folder "iac/" and run `terraform init && terraform plan && terraform apply` then type "yes" to start applying Terraform script. Then wait until script finish deploying.<br>
   1.3) After finish creating EKS cluster, get kube config with command `aws eks --region ap-southeast-1 update-kubeconfig --name mtl-test-cluster --profile mtl-test` and run command `kubectx` one time to see name of cluster. Then run `kubectx <name-of-cluster>` to make sure we're in the created EKS cluster

2. Create ArgoCD app<br>
   2.1) Go to folder "charts/argo-cd" and run command `helm dep build .` to get helm dependencies.<br>
   2.2) Create namespace argocd with command `kubectl create ns argocd` Run command `helm install argo-cd . -n argocd`<br>
   2.3) When ArgoCD is up and running, please access by using command `kubectl port-forward svc/argo-cd-argocd-server 8080:8080 -n argocd` then you will be able to access through url `http://localhost:8080/` (keep in mind to not closing this session to keep the port forwarding turned on)<br>
   2.4) Get admin password by running `kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" -n argocd | base64 -d` then use this password to access web using username as "admin"

3. Now, go to folder "cd/" and run command `kubectl apply -f root-apps.yaml -n argocd` to create pattern app-of-apps on ArgoCD. Then, go-application will be lunched

To test accessing app, run command `kubectl port-forward svc/go-application 8081:8080 -n mtl-test-dev` or `kubectl port-forward svc/go-application 8081:8080 -n mtl-test-prod` to enable port forward of go-application. Then access through url `http://localhost:8081`
