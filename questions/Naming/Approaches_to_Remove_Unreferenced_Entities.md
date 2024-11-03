**Question:** Describe and compare the various approaches to remove unreferenced entities in distributed systems.

**Answer:**

### Overview of Unreferenced Entity Removal:
In distributed systems, unreferenced entities (like objects) may eventually become unreachable from any node and need removal. This is handled by identifying these objects through graph-based techniques that differentiate between reachable and non-reachable nodes. Distributed garbage collection is complicated by the lack of global knowledge and potential network failures.

---

### Approaches to Remove Unreferenced Entities:

#### 1. Reference Counting:
Every object maintains a reference counter. When an object is created, its counter starts at 1. When references are removed, the counter decreases, and the object is deleted when it hits zero.

**Problems:**
- Requires reliable message delivery (acknowledgments, duplicate detection).
- Prone to race conditions when references are passed between processes.
- Performance can suffer due to multiple message requirements, especially in large-scale systems.

---

#### 2. Weighted Reference Counting:
This approach assigns two equal weights (e.g., 128, 128) to an object. Each time a reference is created, the weight is halved and distributed. When the weights become equal again, the object can be collected.

**How Weighted Reference Counting Works:**
- **Initial Assignment:** When an object is created, it is assigned two equal initial weights, for example, 128 and 128.
- **Reference Creation:** When a new reference to the object is made, one of the weights (let’s call it the remaining weight) is halved and assigned to the new reference. The remaining weight is also updated, usually halved as well, to ensure proper bookkeeping.
- **Reference Removal and Weight Recombination:**  
  - When references are deleted, the weight that was associated with that reference is returned to the original weight pool of the object.
  - As references are destroyed and weights are returned, the weights that were distributed during reference creation are "merged" back, eventually restoring balance.
  - When all references are gone and all weights have been returned, the original two weights become equal again.

**Problems:**
- Only a limited number of references can be created due to the halving mechanism.
- Scalability issues arise as reference creation depletes the available weight.

---

#### 3. Reference Listing:
Instead of counting references, this method tracks the identities of proxies that hold references to the object.

**Advantages:**
- Insertion and deletion are idempotent, making communication more reliable and consistent.
- Easier to handle network failures by periodically pinging clients, although this may not scale well.
- Used in Java RMI with added mechanisms like leases for network failure management and UDP as the transport layer.

**Problems:**
- Still susceptible to race conditions when copying references.
- Leases must be refreshed by the client, which can be problematic for long network failures.

---

#### 4. Distributed Mark-and-Sweep:
Adapts traditional mark-and-sweep garbage collection for distributed systems. It requires marking accessible objects and sweeping non-reachable ones.

**Process:**
- **Mark Phase:** Objects reachable from a root are marked grey, proxies and objects are recursively marked, and acknowledgments are expected to complete marking.
- **Sweep Phase:** Unmarked (white) objects are collected once all are either black (marked) or confirmed white.

**Problems:**
- Requires a stable reachability graph, which is challenging in a dynamic distributed environment.
- Potential system-wide blocking if a distributed transaction occurs.
- Scalability issues as the process grows with the number of nodes.

---

### Comparison of Approaches:
- **Reference Counting:** Simple and intuitive but suffers from performance and reliability issues, especially under network failures or high messaging overhead.
- **Weighted Reference Counting:** Attempts to mitigate race conditions but is limited in scalability due to the finite number of references.
- **Reference Listing:** Offers better reliability and resilience to network failures but may still face race conditions and scalability constraints.
- **Distributed Mark-and-Sweep:** More comprehensive but introduces significant overhead, requiring a stable system and potentially blocking transactions. Scalability is inherently poor due to the need for global entity knowledge.

---

### Conclusion:
Each method has trade-offs. Reference Counting is lightweight but unreliable for large systems. Weighted Reference Counting improves reliability but with limited scalability. Reference Listing offers robustness against network issues but still faces challenges in large-scale environments. Mark-and-Sweep is thorough but complex, making it best suited for smaller or more stable distributed systems.
