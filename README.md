# kubeadm-ha-stacked-vagrant / Kubernetes v1.25.2

![](demo800x600.gif)

Kubernetes Cluster: kubeadm mgmt plane + (load balancer / 3 controller ctrl plane) + 3 executor data plane

## Vagrant Spin Up For 2 Load Balancers + 3 Controllers + 3 Executors

![](images/3x3-ha-stacked.png)

### K8S 1.25.2

```console
                            |
                            |
                            |
┌────────────┐              ▼               ┌───────────┐
│    lb01    |------------------------------│   lb02    │
└──────┬─────┘                              └─────┬─────┘
       |                                          |       
       ├────────────────────┬─────────────────────┤      
       │                    │                     │      
┌──────▼─────┐       ┌──────▼─────┐        ┌──────▼─────┐
│     c01    │       │     c02    │        │     c03    │
└──────┬─────┘       └──────┬─────┘        └──────┬─────┘
       │                    │                     │      
       ├────────────────────┼─────────────────────┤      
       │                    │                     │      
┌──────▼─────┐       ┌──────▼─────┐        ┌──────▼─────┐
│     e01    │       │     e02    │        │     e03    │
└────────────┘       └────────────┘        └────────────┘
```

[Logfile](./run.log)
