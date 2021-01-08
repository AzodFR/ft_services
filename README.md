# **FT_SERVICES**

## **MINIKUBE**

### **Infos**

#### **Functionnalities**
- DNS
- NodePorts
- ConfigMap
- Dashboard
- Docker
- CNI
- Ingress

#### **Descritption**

<p><em>Easiest way to local execute Kubernetes.</em></p> 
<p><em>Works in Cluster with a single node in a virtual machine.</em></p>

### **Commands**

#### **Start Cluster**

>`minikube start`


#### **Dashboard Interraction**

>`minikube dashboard`

## **Kubernetes**

### **Commands**

#### **Install Cluster**

>`kubeadm`

#### **Launch Pods**

>`kubelet`

#### **Communicate w/ Cluster**

>`kubectl`

## **Step**

### **Deploy**

>`kubectl apply -f $PATH_TO_YAML`

#### **Check**
>`kubectl get deployments`

>`kubectl get pods`

>`kubectl get events`

>`kubectl get services`

### **Access**

<p><em>On Minikube, the LoadBalancer type make the service accesible with the command:</em></p>

>`minikube service $NAME`

### **Clean**

#### **Service**

>`kubectl delete service $NAME`

>`kubectl delete deployment $NAME`


#### **Stop Minikube**
>`minikube stop`

### **Delete Minikube's VM**
>`minikube delete`