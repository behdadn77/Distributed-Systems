**Question:** Consider RPC and RMI and focus on message passing. Describe how parameter passing works in the two systems. Why passing parameters by reference is problematic in RPC, how RMI addresses this, and vice versa why passing by value is problematic for RPC.

**Answer:**

### Parameter Passing in RPC and RMI:

---

#### Remote Procedure Call (RPC):
- **Parameter Passing:** In RPC, parameter passing generally uses *pass-by-value*. When a procedure is called on a remote system, the parameters are serialized into a message, sent over the network, and then deserialized on the remote server. This means only a copy of the data is sent, and any changes made to parameters on the server side are not reflected on the client side.

---

#### Remote Method Invocation (RMI):
- **Parameter Passing:** RMI, used in object-oriented distributed systems (e.g., Java), supports both *pass-by-value* and *pass-by-reference*. Objects can be passed by value if they are serializable, meaning their state is copied and transmitted. Alternatively, *remote objects* can be passed by reference, allowing the client to invoke methods on the remote object as though it were local.

---

### Why Passing Parameters by Reference is Problematic in RPC:

- **Issue:** RPC aims to make remote calls appear as similar as possible to local calls, but it operates across a network. Passing parameters by reference in a remote context would require the remote server to have direct access to the client’s memory space, which is impossible over a network.
- **Implication:** Since the remote procedure cannot access the client’s memory directly, *pass-by-reference* doesn’t work as it does locally. Instead, RPC must rely on pass-by-value, which copies the data. However, this prevents the remote function from modifying the original data on the client side.

---

### How RMI Addresses This:

- **Solution in RMI:** RMI supports passing objects by reference if those objects are *remote objects* (i.e., objects that implement a remote interface). When passed by reference, the client and server interact with the object remotely, allowing method invocations to modify the object. Non-remote objects, however, are passed by value, meaning their state is copied and any changes are local to the remote object.
- **Advantages:** This flexibility in RMI enables better modeling of object-oriented interactions across distributed systems, allowing objects to be interacted with remotely without copying their entire state.

---

### Why Passing by Value is Problematic for RPC:

- **Issue:** Passing by value in RPC can lead to inefficiencies, especially with large data structures, as entire objects need to be copied and transmitted over the network. Additionally, any updates made to these values on the remote side are not reflected on the client side, potentially causing inconsistency or requiring additional mechanisms for synchronization.
- **Trade-offs:** While copying small amounts of data might be manageable, it becomes a performance bottleneck with large or complex data structures. RPC systems have to balance the overhead of data transfer with the simplicity of not maintaining shared memory states across distributed systems.
